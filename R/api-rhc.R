#' Rural Health Clinics
#'
#' @description
#' Providers with pending Medicare enrollment applications.
#'
#' @param npi `<int>` National Provider Identifier
#' @param ccn `<int>` CMS Certification Number
#' @param pac `<chr>` PECOS Associate Control ID
#' @param enid,enid_state `<chr>` Medicare Enrollment ID, Enrollment state
#' @param org_name `<chr>` Legal business name
#' @param dba_name `<chr>` Doing-business-as name
#' @param city,state,zip `<chr>` Location city, state, zip
#' @param multi `<lgl>` Does hospital have more than one NPI?
#' @param status `<enum>` Organization status
#'    - `P` = Proprietary
#'    - `N` = Non-Profit
#'    - `D` = Unknown
#' @param org_type `<enum>` Organization structure type
#'    - `corp` = Corporation
#'    - `other` = Other
#'    - `llc` = LLC
#'    - `part` = Partnership
#'    - `sole` = Sole Proprietor
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
  ccn = NULL,
  pac = NULL,
  enid = NULL,
  enid_state = NULL,
  org_name = NULL,
  dba_name = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  multi = NULL,
  status = NULL,
  org_type = NULL,
  count = FALSE,
  set = FALSE
) {
  check_count_set(count, set)
  check_bool(multi, allow_null = TRUE)
  check_character(status, allow_null = TRUE)
  check_character(org_type, allow_null = TRUE)

  exec_cms(
    COUNT = count,
    SET = set,
    ARG = param_cms(
      NPI = npi,
      CCN = ccn,
      `ASSOCIATE ID` = pac,
      `ENROLLMENT ID` = enid,
      `ENROLLMENT STATE` = enid_state,
      `ORGANIZATION NAME` = org_name,
      `DOING BUSINESS AS NAME` = dba_name,
      CITY = city,
      STATE = state,
      `ZIP CODE` = zip,
      `MULTIPLE NPI FLAG` = bool_(multi),
      PROPRIETARY_NONPROFIT = status,
      `ORGANIZATION TYPE STRUCTURE` = enum_(org_type)
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
  check_count_set(count, set)
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
