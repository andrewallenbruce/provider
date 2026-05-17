#' Facility Enrollment
#'
#' @description
#' Providers with pending Medicare enrollment applications.
#'
#' @param npi `<int>` National Provider Identifier
#' @param ccn `<int>` CMS Certification Number
#' @param pac `<chr>` PECOS Associate Control ID
#' @param enid `<chr>` Medicare Enrollment ID
#' @param org_name `<chr>` Legal business name
#' @param org_dba `<chr>` Doing-business-as name
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
#' @name enrollment
#'
#' @examplesIf httr2::is_online()
#' fqhc_enroll(count = TRUE)
#' hospice_enroll(count = TRUE)
#' rhc_enroll(count = TRUE)
#' snf_enroll(count = TRUE)
#' hha_enroll(count = TRUE)
#'
#' fqhc_enroll(state = c("GA", "FL")) |> str()
#'
#' hha_enroll(state = c("GA", "FL")) |> str()
#'
#' hospice_enroll(state = c("GA", "FL")) |> str()
#'
#' rhc_enroll(state = c("GA", "FL")) |> str()
#'
#' snf_enroll(state = c("GA", "FL")) |> str()
NULL

#' @rdname enrollment
#' @export
fqhc_enroll <- function(
  npi = NULL,
  ccn = NULL,
  pac = NULL,
  enid = NULL,
  org_name = NULL,
  org_dba = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  multi = NULL,
  status = NULL,
  org_type = NULL,
  count = FALSE,
  set = FALSE
) {
  check_bool_(multi)
  check_char_(status)
  check_char_(org_type)

  x <- cms(
    count = count,
    set = set,
    NPI = npi,
    CCN = ccn,
    `ASSOCIATE ID` = pac,
    `ENROLLMENT ID` = enid,
    `ORGANIZATION NAME` = org_name,
    `DOING BUSINESS AS NAME` = org_dba,
    CITY = city,
    STATE = state,
    `ZIP CODE` = zip,
    `MULTIPLE NPI FLAG` = convert_bool(multi),
    PROPRIETARY_NONPROFIT = status,
    `ORGANIZATION TYPE STRUCTURE` = tag_enum(org_type)
  )

  x <- execute(x)

  polish(x)
}

#' @rdname enrollment
#' @export
hha_enroll <- function(
  npi = NULL,
  ccn = NULL,
  pac = NULL,
  enid = NULL,
  org_name = NULL,
  org_dba = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  multi = NULL,
  status = NULL,
  org_type = NULL,
  count = FALSE,
  set = FALSE
) {
  check_bool_(multi)
  check_char_(status)
  check_char_(org_type)

  x <- cms(
    count = count,
    set = set,
    NPI = npi,
    CCN = ccn,
    `ASSOCIATE ID` = pac,
    `ENROLLMENT ID` = enid,
    `ORGANIZATION NAME` = org_name,
    `DOING BUSINESS AS NAME` = org_dba,
    CITY = city,
    STATE = state,
    `ZIP CODE` = zip,
    `MULTIPLE NPI FLAG` = convert_bool(multi),
    PROPRIETARY_NONPROFIT = status,
    `ORGANIZATION TYPE STRUCTURE` = tag_enum(org_type)
  )

  x <- execute(x)

  polish(x)
}

#' @rdname enrollment
#' @export
hospice_enroll <- function(
  npi = NULL,
  ccn = NULL,
  pac = NULL,
  enid = NULL,
  org_name = NULL,
  org_dba = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  multi = NULL,
  status = NULL,
  org_type = NULL,
  count = FALSE,
  set = FALSE
) {
  check_bool_(multi)
  check_char_(status)
  check_char_(org_type)

  x <- cms(
    count = count,
    set = set,
    NPI = npi,
    CCN = ccn,
    `ASSOCIATE ID` = pac,
    `ENROLLMENT ID` = enid,
    `ORGANIZATION NAME` = org_name,
    `DOING BUSINESS AS NAME` = org_dba,
    CITY = city,
    STATE = state,
    `ZIP CODE` = zip,
    `MULTIPLE NPI FLAG` = convert_bool(multi),
    PROPRIETARY_NONPROFIT = status,
    `ORGANIZATION TYPE STRUCTURE` = tag_enum(org_type)
  )

  x <- execute(x)

  polish(x)
}

#' @rdname enrollment
#' @export
rhc_enroll <- function(
  npi = NULL,
  ccn = NULL,
  pac = NULL,
  enid = NULL,
  org_name = NULL,
  org_dba = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  multi = NULL,
  status = NULL,
  org_type = NULL,
  count = FALSE,
  set = FALSE
) {
  check_bool_(multi)
  check_char_(status)
  check_char_(org_type)

  x <- cms(
    count = count,
    set = set,
    NPI = npi,
    CCN = ccn,
    `ASSOCIATE ID` = pac,
    `ENROLLMENT ID` = enid,
    `ORGANIZATION NAME` = org_name,
    `DOING BUSINESS AS NAME` = org_dba,
    CITY = city,
    STATE = state,
    `ZIP CODE` = zip,
    `MULTIPLE NPI FLAG` = convert_bool(multi),
    PROPRIETARY_NONPROFIT = status,
    `ORGANIZATION TYPE STRUCTURE` = tag_enum(org_type)
  )

  x <- execute(x)

  polish(x)
}

#' @rdname enrollment
#' @export
snf_enroll <- function(
  npi = NULL,
  ccn = NULL,
  pac = NULL,
  enid = NULL,
  org_name = NULL,
  org_dba = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  multi = NULL,
  status = NULL,
  org_type = NULL,
  count = FALSE,
  set = FALSE
) {
  check_bool_(multi)
  check_char_(status)
  check_char_(org_type)

  x <- cms(
    count = count,
    set = set,
    NPI = npi,
    CCN = ccn,
    `ASSOCIATE ID` = pac,
    `ENROLLMENT ID` = enid,
    `ORGANIZATION NAME` = org_name,
    `DOING BUSINESS AS NAME` = org_dba,
    CITY = city,
    STATE = state,
    `ZIP CODE` = zip,
    `MULTIPLE NPI FLAG` = convert_bool(multi),
    PROPRIETARY_NONPROFIT = status,
    `ORGANIZATION TYPE STRUCTURE` = tag_enum(org_type)
  )

  x <- execute(x)

  polish(x)
}
