#' Quality Payment Program
#'
#' The Quality Payment Program (QPP) Experience dataset provides participation
#' and performance information in the Merit-based Incentive Payment System
#' (MIPS) during each performance year. They cover eligibility and
#' participation, performance categories, and final score and payment
#' adjustments.
#'
#' The dataset provides additional details at the TIN/NPI level on what was
#' published in the previous performance year. You can sort the data by
#' variables like clinician type, practice size, scores, and payment
#' adjustments.
#'
#' @inheritParams provider_common_params
#' @param year `<int>` A vector of years; for `quality()`, 2013-2024; for
#'   `metrics()` 2018-2025
#' @param npi `<int>` National Provider Identifier. Multiple rows for the same
#'   NPI indicate that an individual clinician has reassigned billing rights to
#'   multiple TINs and was identified as a MIPS eligible clinician under
#'   multiple TIN/NPI combinations.
#' @param state `<chr>` The practice state of the TIN associated with the
#'   clinician.
#' @param size `<int>` Number of clinicians associated with the TIN through
#'   Medicare Part B claims for the performance year.
#' @param specialty `<chr>` Derived from the specialty codes in Medicare Part B
#'   claims.
#' @param years `<int>` Number of years since NPI's first approved enrollment
#'   date across all enrollments in PECOS.
#' @param patients `<int>` Number of Medicare patients who received covered
#'   professional services during MIPS eligibility determination period.
#' @param services `<int>` Number of covered professional services provided to
#'   Medicare Part B patients with a service date during MIPS eligibility
#'   determination period.
#' @param charges `<int>` Allowed charges under the PFS on Medicare Part B
#'   claims with a service date during MIPS eligibility determination period.
#' @param final_score `<int>` The MIPS final score attributed to the clinician
#'   (identified by TIN/NPI combination).
#' @param adjustment `<dbl>` Determined by comparing the `final_score` to
#'   performance thresholds and scaling to ensure budget neutrality.
#'    - The **Maximum negative** adjustment is `-9%`. (`final_score` = 0 - 18.75)
#'    - A **negative** adjustment is between `-9%` and`0%`. (`final_score` = 18.76 - 74.99)
#'    - A **neutral** adjustment is `0%`. (`final_score` = 75)
#'    - A **positive** adjustment is greater than `0%`. (`final_score` = 75.01 - 100)
#' @returns A [tibble][tibble::tibble-package]
#' @examplesIf httr2::is_online()
#' quality(year = c(2021, 2024), state = "GA", count = TRUE)
#'
#' quality(npi = c(1003026055, 1316939655))
#'
#' metrics()
#'
#' @export
quality <- function(
  year = NULL,
  npi = NULL,
  state = NULL,
  size = NULL,
  specialty = NULL,
  years = NULL,
  patients = NULL,
  services = NULL,
  charges = NULL,
  final_score = NULL,
  adjustment = NULL,
  count = FALSE
) {
  x <- cms_list(
    count = count,
    set = FALSE,
    select = year,
    npi = npi,
    `practice state or us territory` = state,
    `practice size` = size,
    `clinician specialty` = specialty,
    `years in medicare` = years,
    `medicare patients` = patients,
    services = services,
    `allowed charges` = charges,
    `final score` = final_score,
    `payment adjustment percentage` = adjustment
  )

  x <- execute(x)

  polish(x)
}

#' @rdname quality
#' @export
metrics <- function(year = NULL) {
  check_numeric(year)

  if (is.null(year)) {
    year <- 2018:2025
  }

  x <- purrr::map(year, \(y) {
    httr2::request("https://qpp.cms.gov/api/eligibility/stats") |>
      httr2::req_url_query(year = y)
  }) |>
    httr2::req_perform_parallel(on_error = "continue") |>
    purrr::map(\(x) parse_string(x)$data) |>
    set_names(year) |>
    collapse::unlist2d(idcols = c("year", "category", "metric")) |>
    collapse::rnm(c("V1" = "mean"), .nse = FALSE) |>
    collapse::qTBL()

  collapse::recode_char(
    x,
    "individual" = "Individual",
    "group" = "Group",
    "dualEligibilityAverage" = "Dual Eligible Ratio",
    "hccRiskScoreAverage" = "HCC Risk Score",
    set = TRUE
  )

  collapse::settfmv(x, "year", as.integer)
  collapse::settfmv(x, "mean", as.numeric)
  collapse::roworderv(x, c("metric", "category", "year"))
}

# QPP Submissions API
# https://preview.qpp.cms.gov/api/submissions/public/docs/
# https://data.cms.gov/resources/quality-payment-program-experience-data-dictionary
