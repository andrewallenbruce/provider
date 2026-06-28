#' Facilities
#'
#' @description
#' Facilities enrolled in Medicare.
#'
#' @source
#' Medicare
#'
#' @param fac_type `<enum>` Facility type; if NULL (default), will search all:
#'    - `HHA` = Home Health Agency
#'    - `RHC` = Rural Health Clinic
#'    - `FQHC` = Federally Qualified Health Clinic
#'    - `SNF` = Skilled Nursing Facility
#'    - `Hospice` = Hospice
#' @param npi `<int>` National Provider Identifier
#' @param ccn `<int>` CMS Certification Number
#' @param pac `<chr>` PECOS Associate Control ID
#' @param enid `<chr>` Medicare Enrollment ID
#' @param org_name `<chr>` Legal business name
#' @param org_dba `<chr>` Doing-business-as name
#' @param city,state,zip `<chr>` Location city, state, zip
#' @param multi `<lgl>` Does facility have more than one NPI?
#' @param status `<enum>` Facility organization status
#'    - `P` = Proprietary
#'    - `N` = Non-Profit
#'    - `D` = Unknown
#' @param org_type `<enum>` Facility organization structure type
#'    - `corp` = Corporation
#'    - `other` = Other
#'    - `llc` = LLC
#'    - `part` = Partnership
#'    - `sole` = Sole Proprietor
#' @param count `<lgl>` Return the total row count
#' @returns A [tibble][tibble::tibble-package] containing the search results.
#' @examplesIf httr2::is_online()
#' facility(city = "Valdosta", state = "GA")
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
  check_numeric(npi)
  check_bool_(multi)
  check_char_(fac_type)
  check_char_(org_type)
  check_char_(status)

  if (!is.null(fac_type)) {
    fac_type <- rlang::arg_match(
      fac_type,
      c("HHA", "RHC", "FQHC", "SNF", "Hospice"),
      multiple = TRUE
    )
  }

  if (!is.null(status)) {
    status <- rlang::arg_match(
      status,
      c("P", "N", "D"),
      multiple = TRUE
    )
  }

  x <- end_cmslist(
    count = count,
    set = FALSE,
    select = fac_type,
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
