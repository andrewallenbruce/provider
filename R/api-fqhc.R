#' Federally Qualified Healthcare Clinics
#'
#' @description
#' Providers with pending Medicare enrollment applications.
#'
#' @param npi `<int>` National Provider Identifier
#' @param ccn `<int>` CMS Certification Number
#' @param pac `<chr>` PECOS Associate Control ID
#' @param enid,enid_state `<chr>` Medicare Enrollment ID, Enrollment state
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
#' @examplesIf httr2::is_online()
#' fqhc_enroll(count = TRUE)
#'
#' fqhc_enroll() |> str()
#'
#' @export
fqhc_enroll <- function(
  npi = NULL,
  ccn = NULL,
  pac = NULL,
  enid = NULL,
  enid_state = NULL,
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
  polish(
    execute(
      cms(
        NPI = npi,
        CCN = ccn,
        `ASSOCIATE ID` = pac,
        `ENROLLMENT ID` = enid,
        `ENROLLMENT STATE` = enid_state,
        `ORGANIZATION NAME` = org_name,
        `DOING BUSINESS AS NAME` = org_dba,
        CITY = city,
        STATE = state,
        `ZIP CODE` = zip,
        `MULTIPLE NPI FLAG` = bool_(multi),
        PROPRIETARY_NONPROFIT = status,
        `ORGANIZATION TYPE STRUCTURE` = enum_(org_type),
        .count = count,
        .set = set,
      )
    )
  )
}

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
#' @examplesIf httr2::is_online()
#' rhc_enroll(count = TRUE)
#'
#' rhc_enroll() |> str()
#'
#' @export
rhc_enroll <- function(
  npi = NULL,
  ccn = NULL,
  pac = NULL,
  enid = NULL,
  enid_state = NULL,
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
  polish(
    execute(
      cms(
        NPI = npi,
        CCN = ccn,
        `ASSOCIATE ID` = pac,
        `ENROLLMENT ID` = enid,
        `ENROLLMENT STATE` = enid_state,
        `ORGANIZATION NAME` = org_name,
        `DOING BUSINESS AS NAME` = org_dba,
        CITY = city,
        STATE = state,
        `ZIP CODE` = zip,
        `MULTIPLE NPI FLAG` = bool_(multi),
        PROPRIETARY_NONPROFIT = status,
        `ORGANIZATION TYPE STRUCTURE` = enum_(org_type),
        .count = count,
        .set = set,
      )
    )
  )
}

#' Rural Health Clinic Owners
#'
#' @description
#' Providers with pending Medicare enrollment applications.
#'
#' @param enid `<chr>` National Provider Identifier
#' @param pac `<chr>` Provider's name
#' @param org_name `<chr>` Provider's name
#' @param own_pac `<chr>` Provider's name
#' @param own_type `<chr>` Provider's name
#' @param own_role `<chr>` Provider's name
#' @param own_first `<chr>` Provider's name
#' @param own_middle `<chr>` Provider's name
#' @param own_last `<chr>` Provider's name
#' @param own_title `<chr>` Provider's name
#' @param own_org `<chr>` Provider's name
#' @param own_dba `<chr>` Provider's name
#' @param own_address `<chr>` Provider's name
#' @param own_city `<chr>` Provider's name
#' @param own_state `<chr>` Provider's name
#' @param own_zip `<chr>` Provider's name
#' @param own_pct `<chr>` Provider's name
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
#' @export
rhc_owner <- function(
  enid = NULL,
  pac = NULL,
  org_name = NULL,
  own_pac = NULL,
  own_type = NULL,
  own_role = NULL,
  own_first = NULL,
  own_middle = NULL,
  own_last = NULL,
  own_title = NULL,
  own_org = NULL,
  own_dba = NULL,
  own_address = NULL,
  own_city = NULL,
  own_state = NULL,
  own_zip = NULL,
  own_pct = NULL,
  count = FALSE,
  set = FALSE
) {
  polish(
    execute(
      cms(
        `ENROLLMENT ID` = enid,
        `ASSOCIATE ID` = pac,
        `ORGANIZATION NAME` = org_name,
        `ASSOCIATE ID - OWNER` = own_pac,
        `TYPE - OWNER` = own_type,
        `ROLE TEXT - OWNER` = own_role,
        `FIRST NAME - OWNER` = own_first,
        `MIDDLE NAME - OWNER` = own_middle,
        `LAST NAME - OWNER` = own_last,
        `TITLE - OWNER` = own_title,
        `ORGANIZATION NAME - OWNER` = own_org,
        `DOING BUSINESS AS NAME - OWNER` = own_dba,
        `ADDRESS LINE 1 - OWNER` = own_address,
        `CITY - OWNER` = own_city,
        `STATE - OWNER` = own_state,
        `ZIP CODE - OWNER` = own_zip,
        `PERCENTAGE OWNERSHIP` = own_pct,
        .count = count,
        .set = set,
      )
    )
  )
}

#' FQHC Owners
#'
#' @description
#' Providers with pending Medicare enrollment applications.
#'
#' @param enid `<chr>` National Provider Identifier
#' @param pac `<chr>` Provider's name
#' @param org_name `<chr>` Provider's name
#' @param own_pac `<chr>` Provider's name
#' @param own_type `<chr>` Provider's name
#' @param own_role `<chr>` Provider's name
#' @param own_first `<chr>` Provider's name
#' @param own_middle `<chr>` Provider's name
#' @param own_last `<chr>` Provider's name
#' @param own_title `<chr>` Provider's name
#' @param own_org `<chr>` Provider's name
#' @param own_dba `<chr>` Provider's name
#' @param own_address `<chr>` Provider's name
#' @param own_city `<chr>` Provider's name
#' @param own_state `<chr>` Provider's name
#' @param own_zip `<chr>` Provider's name
#' @param own_pct `<chr>` Provider's name
#' @param count `<lgl>` Return the total row count
#' @param set `<lgl>` Return the entire dataset
#'
#' @returns A [tibble][tibble::tibble-package]
#'
#' @examplesIf httr2::is_online()
#' fqhc_owner(count = TRUE)
#'
#' fqhc_owner() |> str()
#'
#' @export
fqhc_owner <- function(
  enid = NULL,
  pac = NULL,
  org_name = NULL,
  own_pac = NULL,
  own_type = NULL,
  own_role = NULL,
  own_first = NULL,
  own_middle = NULL,
  own_last = NULL,
  own_title = NULL,
  own_org = NULL,
  own_dba = NULL,
  own_address = NULL,
  own_city = NULL,
  own_state = NULL,
  own_zip = NULL,
  own_pct = NULL,
  count = FALSE,
  set = FALSE
) {
  polish(
    execute(
      cms(
        `ENROLLMENT ID` = enid,
        `ASSOCIATE ID` = pac,
        `ORGANIZATION NAME` = org_name,
        `ASSOCIATE ID - OWNER` = own_pac,
        `TYPE - OWNER` = own_type,
        `ROLE TEXT - OWNER` = own_role,
        `FIRST NAME - OWNER` = own_first,
        `MIDDLE NAME - OWNER` = own_middle,
        `LAST NAME - OWNER` = own_last,
        `TITLE - OWNER` = own_title,
        `ORGANIZATION NAME - OWNER` = own_org,
        `DOING BUSINESS AS NAME - OWNER` = own_dba,
        `ADDRESS LINE 1 - OWNER` = own_address,
        `CITY - OWNER` = own_city,
        `STATE - OWNER` = own_state,
        `ZIP CODE - OWNER` = own_zip,
        `PERCENTAGE OWNERSHIP` = own_pct,
        .count = count,
        .set = set,
      )
    )
  )
}
