#' Owners
#'
#' @description
#' Owners of facilities enrolled in Medicare.
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
#'    - `Hospital` = Hospital
#' @param enid `<chr>` National Provider Identifier
#' @param pac `<chr>` Provider's name
#' @param org_name `<chr>` Provider's name
#' @param own_pac `<chr>` Provider's name
#' @param own_org `<chr>` Provider's name
#' @param own_dba `<chr>` Provider's name
#' @param own_pct `<dbl>` Provider's name
#' @param own_role `<chr>` Provider's name
#' @param own_entity `<enum>` Provider's name
#' @param own_title `<chr>` Provider's name
#' @param own_first,own_last `<chr>` Provider's name
#' @param city,state,zip `<chr>` Provider's name
#' @param count `<lgl>` Return the total row count
#' @returns A [tibble][tibble::tibble-package] containing the search results.
#' @examplesIf httr2::is_online()
#' owner(count = TRUE)
#' owner(city = "Valdosta", state = "GA")
#' @export
owner <- function(
  fac_type = NULL,
  fac_enid = NULL,
  fac_pac = NULL,
  fac_name = NULL,
  own_pac = NULL,
  own_org = NULL,
  own_dba = NULL,
  own_pct = NULL,
  own_role = NULL,
  own_entity = NULL,
  own_first = NULL,
  own_last = NULL,
  own_title = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  count = FALSE
) {
  if (!is.null(fac_type)) {
    fac_type <- rlang::arg_match(
      fac_type,
      c("HHA", "RHC", "FQHC", "SNF", "Hospice", "Hospital"),
      multiple = TRUE
    )
  }

  x <- end_cmslist(
    count = count,
    set = FALSE,
    select = fac_type,
    `ENROLLMENT ID` = fac_enid,
    `ASSOCIATE ID` = fac_pac,
    `ORGANIZATION NAME` = fac_name,
    `ASSOCIATE ID - OWNER` = own_pac,
    `ORGANIZATION NAME - OWNER` = own_org,
    `DOING BUSINESS AS NAME - OWNER` = own_dba,
    `PERCENTAGE OWNERSHIP` = own_pct,
    `ROLE CODE - OWNER` = own_role,
    `TYPE - OWNER` = own_entity,
    `FIRST NAME - OWNER` = own_first,
    `LAST NAME - OWNER` = own_last,
    `TITLE - OWNER` = own_title,
    `CITY - OWNER` = city,
    `STATE - OWNER` = state,
    `ZIP CODE - OWNER` = zip
  )

  x <- execute(x)

  polish(x)
}
