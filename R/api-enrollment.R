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
        `MULTIPLE NPI FLAG` = convert_bool(multi),
        PROPRIETARY_NONPROFIT = status,
        `ORGANIZATION TYPE STRUCTURE` = tag_enum(org_type),
        .count = count,
        .set = set,
      )
    )
  )
}

#' Hospice Facilities
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
#' hospice_enroll(count = TRUE)
#'
#' hospice_enroll() |> str()
#'
#' @export
hospice_enroll <- function(
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
        `MULTIPLE NPI FLAG` = convert_bool(multi),
        PROPRIETARY_NONPROFIT = status,
        `ORGANIZATION TYPE STRUCTURE` = tag_enum(org_type),
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
        `MULTIPLE NPI FLAG` = convert_bool(multi),
        PROPRIETARY_NONPROFIT = status,
        `ORGANIZATION TYPE STRUCTURE` = tag_enum(org_type),
        .count = count,
        .set = set,
      )
    )
  )
}

#' Skilled Nursing Facilities
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
#' snf_enroll(count = TRUE)
#'
#' snf_enroll() |> str()
#'
#' @export
snf_enroll <- function(
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
        `MULTIPLE NPI FLAG` = convert_bool(multi),
        PROPRIETARY_NONPROFIT = status,
        `ORGANIZATION TYPE STRUCTURE` = tag_enum(org_type),
        .count = count,
        .set = set,
      )
    )
  )
}
