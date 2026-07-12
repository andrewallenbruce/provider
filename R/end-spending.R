#' Medicare Spending Per Beneficiary - Hospital
#'
#' @description The Medicare Spending Per Beneficiary (MSPB) Measure shows
#'   whether Medicare spends more, less, or about the same for an episode of
#'   care (episode) at a specific hospital compared to all hospitals nationally.
#'   An MSPB episode includes Medicare Part A and Part B payments for services
#'   provided by hospitals and other healthcare providers the 3 days prior to,
#'   during, and 30 days following a patient's inpatient stay. This measure
#'   evaluates hospitals' costs compared to the costs of the national median (or
#'   midpoint) hospital. This measure takes into account important factors like
#'   patient age and health status (risk adjustment) and geographic payment
#'   differences (payment-standardization).
#'
#' @source
#'    * [API: Medicare Spending Per Beneficiary - Hospital](https://data.cms.gov/provider-data/dataset/rrqw-56er)
#'
#' @param ccn `<chr>` desc
#' @param name `<chr>` desc
#' @param score `<dbl>` desc
#' @param city,state,zip,county `<chr>` desc
#' @param count `<lgl>` Return the total row count
#' @returns A [tibble][tibble::tibble-package] containing the search results.
#' @examplesIf httr2::is_online()
#' spending(count = TRUE)
#' spending(state = "GA")
#' @export
spending <- function(
  ccn = NULL,
  name = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  county = NULL,
  score = NULL,
  count = FALSE
) {
  x <- end_pdc(
    count = count,
    set = FALSE,
    facility_id = ccn,
    facility_name = name,
    score = score,
    citytown = city,
    state = state,
    zip_code = zip,
    countyparish = county
  )

  x <- execute(x)

  polish(x)
}

#' Medicare Hospital Spending by Claim
#'
#' @description Access information concerning individual providers'
#'    affiliations with organizations/facilities.
#'
#' @source
#'    * [API: Physician Facility Affiliations](https://data.cms.gov/provider-data/dataset/27ea-46a8)
#'
#' @param ccn `<chr>` desc
#' @param name `<chr>` desc
#' @param state `<chr>` desc
#' @param claim `<chr>` desc
#' @param count `<lgl>` Return the total row count
#' @returns A [tibble][tibble::tibble-package] containing the search results.
#' @examplesIf httr2::is_online()
#' spending2(count = TRUE)
#' spending2(name = starts("SGMC"), state = "GA")
#' @export
#' @rdname spending
spending2 <- function(
  ccn = NULL,
  name = NULL,
  state = NULL,
  claim = NULL,
  count = FALSE
) {
  x <- end_pdc(
    count = count,
    set = FALSE,
    facility_id = ccn,
    facility_name = name,
    state = state,
    claim_type = claim
  )

  x <- execute(x)

  polish(x)
}
