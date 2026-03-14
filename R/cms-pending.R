#' Pending Medicare Enrollments
#'
#' @description
#' Providers with pending Medicare enrollment applications.
#'
#' @references
#'    * [Medicare Pending Initial Logging and Tracking Physicians API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/pending-initial-logging-and-tracking-physicians)
#'    * [Medicare Pending Initial Logging and Tracking Non-Physicians API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/pending-initial-logging-and-tracking-non-physicians)
#'
#' @param npi `<int>` National Provider Identifier
#' @param first,last `<chr>` Provider's name
#' @param count `<lgl>` Return the dataset's total row count
#' @returns A [tibble][tibble::tibble-package]
#' @examplesIf httr2::is_online()
#' pending(first = "John")
#' @autoglobal
#' @export
pending <- function(
  npi = NULL,
  first = NULL,
  last = NULL,
  count = FALSE
) {
  .c(BASE, LIMIT, NM) %=% constants(rlang::call_name(rlang::call_match()))

  exec_cms(
    ARG = params(
      NPI = npi,
      LAST_NAME = last,
      FIRST_NAME = first
      ),
    BASE = BASE$phys,
    LIMIT = LIMIT,
    NM = NM,
    COUNT = count
  )
}
