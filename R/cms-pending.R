#' Pending Medicare Enrollments
#'
#' @description
#' Providers with pending Medicare enrollment applications.
#'
#' The Pending Initial Logging and Tracking (L & T) dataset provides a list of
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
#' @param count `<lgl>` Return the dataset's total row count
#' @returns A [tibble][tibble::tibble-package]
#' @examplesIf httr2::is_online()
#' pending(count = TRUE)
#' pending(first = "Victor", count = TRUE)
#' pending(first = starts_with("V"))
#' @autoglobal
#' @export
pending <- function(
  npi = NULL,
  first = NULL,
  last = NULL,
  count = FALSE
) {
  exec_cms2(
    END = call_name(call_match()),
    COUNT = count,
    ARG = param_cms(
      NPI = npi,
      LAST_NAME = last,
      FIRST_NAME = first
    ),
    .id = "prov_type"
  )
}
