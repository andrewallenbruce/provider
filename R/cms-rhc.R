#' Rural Health Clinics
#'
#' @description
#' Providers with pending Medicare enrollment applications.
#'
#' @param npi `<int>` National Provider Identifier
#' @param first,last `<chr>` Provider's name
#' @param count `<lgl>` Return the total row count
#' @param set `<lgl>` Return the entire dataset
#'
#' @returns A [tibble][tibble::tibble-package]
#'
#' @examplesIf httr2::is_online()
#' rhc_enroll(count = TRUE)
#'
#' rhc_enroll() |> str()
#'
#' @autoglobal
#' @export
rhc_enroll <- function(
  npi = NULL,
  first = NULL,
  last = NULL,
  count = FALSE,
  set = FALSE
) {
  exec_cms(
    COUNT = count,
    SET = set,
    ARG = param_cms(
      NPI = npi,
      LAST_NAME = last,
      FIRST_NAME = first
    )
  )
}

#' Rural Health Clinic Owners
#'
#' @description
#' Providers with pending Medicare enrollment applications.
#'
#' @param npi `<int>` National Provider Identifier
#' @param first,last `<chr>` Provider's name
#' @param count `<lgl>` Return the total row count
#' @param set `<lgl>` Return the entire dataset
#'
#' @returns A [tibble][tibble::tibble-package]
#'
#' @examplesIf httr2::is_online()
#' rhc_owner(count = TRUE)
#'
#' rhc_owner() |> str()
#'
#' @autoglobal
#' @export
rhc_owner <- function(
  npi = NULL,
  first = NULL,
  last = NULL,
  count = FALSE,
  set = FALSE
) {
  exec_cms(
    COUNT = count,
    SET = set,
    ARG = param_cms(
      NPI = npi,
      LAST_NAME = last,
      FIRST_NAME = first
    )
  )
}
