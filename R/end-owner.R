#' Owners
#'
#' @description
#' Owners of facilities enrolled in Medicare.
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
#'    - `hospital` = Hospital
#' @param org_enid `<chr>` National Provider Identifier
#' @param org_pac `<chr>` Provider's name
#' @param org_name `<chr>` Provider's name
#' @param pac `<chr>` Provider's name
#' @param owner `<chr>` Provider's name
#' @param dba `<chr>` Provider's name
#' @param percent `<chr>` Provider's name
#' @param role `<chr>` Provider's name
#' @param entity `<chr>` Provider's name
#' @param title `<chr>` Provider's name
#' @param first,middle,last `<chr>` Provider's name
#' @param address,city,state,zip `<chr>` Provider's name
#' @examplesIf httr2::is_online()
#' owner(count = TRUE)
#'
#' owner(state = c("GA", "FL"), count = TRUE)
#'
#' owner(city = "Valdosta", state = "GA")
#'
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
  middle = NULL,
  last = NULL,
  title = NULL,
  address = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  count = FALSE
) {
  check_char_(fac_type)

  x <- cms_list(
    count = count,
    set = FALSE,
    idcol = "fac_type",
    `ENROLLMENT ID` = org_enid,
    `ASSOCIATE ID` = org_pac,
    `ORGANIZATION NAME` = org_name,
    `ASSOCIATE ID - OWNER` = pac,
    `ORGANIZATION NAME - OWNER` = owner,
    `DOING BUSINESS AS NAME - OWNER` = dba,
    `PERCENTAGE OWNERSHIP` = percent,
    `ROLE TEXT - OWNER` = role,
    `TYPE - OWNER` = entity,
    `FIRST NAME - OWNER` = first,
    `MIDDLE NAME - OWNER` = middle,
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

#' @noRd
fqhc_owner <- function(
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
  middle = NULL,
  last = NULL,
  title = NULL,
  address = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  count = FALSE,
  set = FALSE
) {
  x <- cms(
    count = count,
    set = set,
    `ENROLLMENT ID` = org_enid,
    `ASSOCIATE ID` = org_pac,
    `ORGANIZATION NAME` = org_name,
    `ASSOCIATE ID - OWNER` = pac,
    `ORGANIZATION NAME - OWNER` = owner,
    `DOING BUSINESS AS NAME - OWNER` = dba,
    `PERCENTAGE OWNERSHIP` = percent,
    `ROLE TEXT - OWNER` = role,
    `TYPE - OWNER` = entity,
    `FIRST NAME - OWNER` = first,
    `MIDDLE NAME - OWNER` = middle,
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

#' @noRd
hha_owner <- function(
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
  middle = NULL,
  last = NULL,
  title = NULL,
  address = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  count = FALSE,
  set = FALSE
) {
  x <- cms(
    count = count,
    set = set,
    `ENROLLMENT ID` = org_enid,
    `ASSOCIATE ID` = org_pac,
    `ORGANIZATION NAME` = org_name,
    `ASSOCIATE ID - OWNER` = pac,
    `ORGANIZATION NAME - OWNER` = owner,
    `DOING BUSINESS AS NAME - OWNER` = dba,
    `PERCENTAGE OWNERSHIP` = percent,
    `ROLE TEXT - OWNER` = role,
    `TYPE - OWNER` = entity,
    `FIRST NAME - OWNER` = first,
    `MIDDLE NAME - OWNER` = middle,
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

#' @noRd
hospital_owner <- function(
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
  middle = NULL,
  last = NULL,
  title = NULL,
  address = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  count = FALSE,
  set = FALSE
) {
  x <- cms(
    count = count,
    set = set,
    `ENROLLMENT ID` = org_enid,
    `ASSOCIATE ID` = org_pac,
    `ORGANIZATION NAME` = org_name,
    `ASSOCIATE ID - OWNER` = pac,
    `ORGANIZATION NAME - OWNER` = owner,
    `DOING BUSINESS AS NAME - OWNER` = dba,
    `PERCENTAGE OWNERSHIP` = percent,
    `ROLE TEXT - OWNER` = role,
    `TYPE - OWNER` = entity,
    `FIRST NAME - OWNER` = first,
    `MIDDLE NAME - OWNER` = middle,
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

#' @noRd
hospice_owner <- function(
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
  middle = NULL,
  last = NULL,
  title = NULL,
  address = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  count = FALSE,
  set = FALSE
) {
  x <- cms(
    count = count,
    set = set,
    `ENROLLMENT ID` = org_enid,
    `ASSOCIATE ID` = org_pac,
    `ORGANIZATION NAME` = org_name,
    `ASSOCIATE ID - OWNER` = pac,
    `ORGANIZATION NAME - OWNER` = owner,
    `DOING BUSINESS AS NAME - OWNER` = dba,
    `PERCENTAGE OWNERSHIP` = percent,
    `ROLE TEXT - OWNER` = role,
    `TYPE - OWNER` = entity,
    `FIRST NAME - OWNER` = first,
    `MIDDLE NAME - OWNER` = middle,
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

#' @noRd
rhc_owner <- function(
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
  middle = NULL,
  last = NULL,
  title = NULL,
  address = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  count = FALSE,
  set = FALSE
) {
  x <- cms(
    count = count,
    set = set,
    `ENROLLMENT ID` = org_enid,
    `ASSOCIATE ID` = org_pac,
    `ORGANIZATION NAME` = org_name,
    `ASSOCIATE ID - OWNER` = pac,
    `ORGANIZATION NAME - OWNER` = owner,
    `DOING BUSINESS AS NAME - OWNER` = dba,
    `PERCENTAGE OWNERSHIP` = percent,
    `ROLE TEXT - OWNER` = role,
    `TYPE - OWNER` = entity,
    `FIRST NAME - OWNER` = first,
    `MIDDLE NAME - OWNER` = middle,
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

#' @noRd
snf_owner <- function(
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
  middle = NULL,
  last = NULL,
  title = NULL,
  address = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  count = FALSE,
  set = FALSE
) {
  x <- cms(
    count = count,
    set = set,
    `ENROLLMENT ID` = org_enid,
    `ASSOCIATE ID` = org_pac,
    `ORGANIZATION NAME` = org_name,
    `ASSOCIATE ID - OWNER` = pac,
    `ORGANIZATION NAME - OWNER` = owner,
    `DOING BUSINESS AS NAME - OWNER` = dba,
    `PERCENTAGE OWNERSHIP` = percent,
    `ROLE TEXT - OWNER` = role,
    `TYPE - OWNER` = entity,
    `FIRST NAME - OWNER` = first,
    `MIDDLE NAME - OWNER` = middle,
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
