#' Facilities
#'
#' @description
#' Facilities enrolled in Medicare.
#'
#' @source
#' Medicare
#'
#' @inheritParams provider_common_params
#' @param fac_type `<enum>` Facility type
#'    - `hha` = Home Health Agency
#'    - `rhc` = Rural Health Clinic
#'    - `fqhc` = Federally Qualified Health Clinic
#'    - `snf` = Skilled Nursing Facility
#'    - `hospice` = Hospice
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
#' @examplesIf httr2::is_online()
#' facility(count = TRUE)
#'
#' facility(state = c("GA", "FL"), count = TRUE)
#'
#' facility(city = "Valdosta", state = "GA")
#'
#' @export
facility <- function(
  fac_type = NULL,
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
  count = FALSE
) {
  check_bool_(multi)
  check_char_(status)
  check_char_(org_type)
  check_char_(fac_type)

  x <- cms_list(
    count = count,
    set = FALSE,
    idcol = "fac_type",
    NPI = npi,
    CCN = ccn,
    `ASSOCIATE ID` = pac,
    `ENROLLMENT ID` = enid,
    `ORGANIZATION NAME` = org_name,
    `DOING BUSINESS AS NAME` = org_dba,
    CITY = city,
    STATE = state,
    `ZIP CODE` = zip,
    `MULTIPLE NPI FLAG` = tag_bool(multi),
    PROPRIETARY_NONPROFIT = status,
    `ORGANIZATION TYPE STRUCTURE` = tag_enum(org_type)
  )

  x <- execute(x)

  polish(x)
}
