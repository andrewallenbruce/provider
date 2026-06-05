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
#' @param year `<int>` A vector of years from 2018 to 2025
#' @param npi `<int>` description
#' @param state description
#' @param size `<int>` description
#' @param specialty description
#' @param years `<int>` description
#' @param patients `<int>` description
#' @param charges `<int>` description
#' @param services `<int>` description
#' @param final_score `<int>` description
#' @param adjustment `<int>` description
#' @param years `<int>` description
#' @returns A [tibble][tibble::tibble-package]
#'
#' @examplesIf httr2::is_online()
#' quality(count = TRUE)
#'
#' quality(year = c(2021, 2024), state = "GA", count = TRUE)
#'
#' quality(npi = 1043245657)
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
  charges = NULL,
  services = NULL,
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
    `allowed charges` = charges,
    services = services,
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

# x <- purrr::map(x, httr2::request) |>
#   httr2::req_perform_parallel(on_error = "continue") |>
#   purrr::map(function(resp) parse_string(resp) |> collapse::qTBL()) |>
#   set_names2(x)
