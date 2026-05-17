#' Facility Owners
#'
#' @description
#' Providers with pending Medicare enrollment applications.
#'
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
#' @param count `<lgl>` Return the total row count
#' @param set `<lgl>` Return the entire dataset
#'
#' @returns A [tibble][tibble::tibble-package]
#'
#' @name owners
#'
#' @examplesIf httr2::is_online()
#' fqhc_owner(count = TRUE)
#' hospital_owner(count = TRUE)
#' hospice_owner(count = TRUE)
#' rhc_owner(count = TRUE)
#' snf_owner(count = TRUE)
#' hha_owner(count = TRUE)
#'
#' fqhc_owner(state = c("GA", "FL")) |> str()
#'
#' hospital_owner(state = c("GA", "FL")) |> str()
#'
#' hospice_owner(state = c("GA", "FL")) |> str()
#'
#' rhc_owner(state = c("GA", "FL")) |> str()
#'
#' snf_owner(state = c("GA", "FL")) |> str()
#'
#' hha_owner(state = c("GA", "FL")) |> str()
NULL

#' @rdname owners
#' @export
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

#' @rdname owners
#' @export
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

#' @rdname owners
#' @export
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

#' @rdname owners
#' @export
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

#' @rdname owners
#' @export
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

#' @rdname owners
#' @export
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
