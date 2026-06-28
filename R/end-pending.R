#' Pending Medicare Enrollments
#'
#' @description
#' Providers with pending Medicare enrollment applications.
#'
#' The _Pending Initial Logging and Tracking (L & T)_ dataset provides a list of
#' pending applications for both Physicians and Non-Physicians that have not
#' been processed by CMS contractors.
#'
#' @source
#' Medicare Pending Initial Logging and Tracking:
#'    - [API: Physicians](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/pending-initial-logging-and-tracking-physicians)
#'    - [API: Non-Physicians](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/pending-initial-logging-and-tracking-non-physicians)
#'
#' @param npi `<int>` National Provider Identifier
#' @param first,last `<chr>` Provider's name
#' @param prov_type `<chr>` `"Physician"` or `"Non-Physician"`
#' @param count `<lgl>` Return the total row count
#' @returns A [tibble][tibble::tibble-package] containing the search results.
#' @examplesIf httr2::is_online()
#' pending(count = TRUE)
#'
#' pending(first = starts("V"))
#'
#' @export
pending <- function(
  prov_type = NULL,
  npi = NULL,
  first = NULL,
  last = NULL,
  count = FALSE
) {
  x <- end_cmslist(
    count = count,
    set = FALSE,
    select = prov_type,
    NPI = npi,
    LAST_NAME = last,
    FIRST_NAME = first
  )

  x <- execute(x)

  polish(x)
}
