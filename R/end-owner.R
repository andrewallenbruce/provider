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
#' @param org_enid `<chr>` National Provider Identifier
#' @param org_pac `<chr>` Provider's name
#' @param org_name `<chr>` Provider's name
#' @param pac `<chr>` Provider's name
#' @param owner `<chr>` Provider's name
#' @param dba `<chr>` Provider's name
#' @param percent `<dbl>` Provider's name
#' @param role `<chr>` Provider's name
#' @param entity `<enum>` Provider's name
#' @param title `<chr>` Provider's name
#' @param first,last `<chr>` Provider's name
#' @param address,city,state,zip `<chr>` Provider's name
#' @param count `<lgl>` Return the total row count
#' @returns A [tibble][tibble::tibble-package] containing the search results.
#' @examplesIf httr2::is_online()
#' owner(count = TRUE)
#' owner(city = "Valdosta", state = "GA")
#' @export
owner <- function(
  fac_type = NULL,
  org_enid = NULL,
  org_pac = NULL,
  org_name = NULL,
  pac = NULL,
  owner = NULL,
  dba = NULL,
  percent = NULL,
  role = NULL,
  entity = NULL,
  first = NULL,
  last = NULL,
  title = NULL,
  address = NULL,
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
    `ENROLLMENT ID` = org_enid,
    `ASSOCIATE ID` = org_pac,
    `ORGANIZATION NAME` = org_name,
    `ASSOCIATE ID - OWNER` = pac,
    `ORGANIZATION NAME - OWNER` = owner,
    `DOING BUSINESS AS NAME - OWNER` = dba,
    `PERCENTAGE OWNERSHIP` = percent,
    `ROLE CODE - OWNER` = role,
    `TYPE - OWNER` = entity,
    `FIRST NAME - OWNER` = first,
    `LAST NAME - OWNER` = last,
    `TITLE - OWNER` = title,
    `ADDRESS LINE 1 - OWNER` = address,
    `CITY - OWNER` = city,
    `STATE - OWNER` = state,
    `ZIP CODE - OWNER` = zip
  )

  x <- execute(x)

  polish(x)
}
