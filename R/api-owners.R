#' FQHC Owners
#'
#' @description
#' Providers with pending Medicare enrollment applications.
#'
#' @param org_enid `<chr>` National Provider Identifier
#' @param org_pac `<chr>` Provider's name
#' @param org_name `<chr>` Provider's name
#' @param own_pac `<chr>` Provider's name
#' @param own_org `<chr>` Provider's name
#' @param own_dba `<chr>` Provider's name
#' @param own_pct `<chr>` Provider's name
#' @param own_role `<chr>` Provider's name
#' @param entity `<chr>` Provider's name
#' @param title `<chr>` Provider's name
#' @param first,middle,last `<chr>` Provider's name
#' @param address,city,state,zip `<chr>` Provider's name
#' @param count `<lgl>` Return the total row count
#' @param set `<lgl>` Return the entire dataset
#'
#' @returns A [tibble][tibble::tibble-package]
#'
#' @examplesIf httr2::is_online()
#' fqhc_owner(count = TRUE)
#'
#' fqhc_owner(state = c("GA", "FL"))
#'
#' @export
fqhc_owner <- function(
  org_enid = NULL,
  org_pac = NULL,
  org_name = NULL,
  own_pac = NULL,
  own_org = NULL,
  own_dba = NULL,
  own_pct = NULL,
  own_role = NULL,
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
    `ENROLLMENT ID` = org_enid,
    `ASSOCIATE ID` = org_pac,
    `ORGANIZATION NAME` = org_name,
    `ASSOCIATE ID - OWNER` = own_pac,
    `ORGANIZATION NAME - OWNER` = own_org,
    `DOING BUSINESS AS NAME - OWNER` = own_dba,
    `PERCENTAGE OWNERSHIP` = own_pct,
    `ROLE TEXT - OWNER` = own_role,
    `TYPE - OWNER` = entity,
    `FIRST NAME - OWNER` = first,
    `MIDDLE NAME - OWNER` = middle,
    `LAST NAME - OWNER` = last,
    `TITLE - OWNER` = title,
    `ADDRESS LINE 1 - OWNER` = address,
    `CITY - OWNER` = city,
    `STATE - OWNER` = state,
    `ZIP CODE - OWNER` = zip,
    .count = count,
    .set = set,
  )

  x <- execute(x)

  polish(x)
}

#' Hospital Owners
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
#' hospital_owner(count = TRUE)
#'
#' hospital_owner(own_state = c("GA", "FL")) |> str()
#'
#' @export
hospital_owner <- function(
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

#' Hospice Owners
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
#' hospice_owner(count = TRUE)
#'
#' hospice_owner(own_state = c("GA", "FL")) |> str()
#'
#' @export
hospice_owner <- function(
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

#' Rural Health Clinic Owners
#'
#' @description
#' Providers with pending Medicare enrollment applications.
#'
#' @param org_enid `<chr>` National Provider Identifier
#' @param org_pac `<chr>` Provider's name
#' @param org_name `<chr>` Provider's name
#' @param own_pac `<chr>` Provider's name
#' @param own_org `<chr>` Provider's name
#' @param own_dba `<chr>` Provider's name
#' @param own_pct `<chr>` Provider's name
#' @param own_role `<chr>` Provider's name
#' @param entity `<chr>` Provider's name
#' @param title `<chr>` Provider's name
#' @param first,middle,last `<chr>` Provider's name
#' @param address,city,state,zip `<chr>` Provider's name
#' @param count `<lgl>` Return the total row count
#' @param set `<lgl>` Return the entire dataset
#'
#' @returns A [tibble][tibble::tibble-package]
#'
#' @examplesIf httr2::is_online()
#' rhc_owner(count = TRUE)
#'
#' rhc_owner(state = c("GA", "FL")) |> str()
#'
#' @export
rhc_owner <- function(
  org_enid = NULL,
  org_pac = NULL,
  org_name = NULL,
  own_pac = NULL,
  own_org = NULL,
  own_dba = NULL,
  own_pct = NULL,
  own_role = NULL,
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
    `ENROLLMENT ID` = org_enid,
    `ASSOCIATE ID` = org_pac,
    `ORGANIZATION NAME` = org_name,
    `ASSOCIATE ID - OWNER` = own_pac,
    `ORGANIZATION NAME - OWNER` = own_org,
    `DOING BUSINESS AS NAME - OWNER` = own_dba,
    `PERCENTAGE OWNERSHIP` = own_pct,
    `ROLE TEXT - OWNER` = own_role,
    `TYPE - OWNER` = entity,
    `FIRST NAME - OWNER` = first,
    `MIDDLE NAME - OWNER` = middle,
    `LAST NAME - OWNER` = last,
    `TITLE - OWNER` = title,
    `ADDRESS LINE 1 - OWNER` = address,
    `CITY - OWNER` = city,
    `STATE - OWNER` = state,
    `ZIP CODE - OWNER` = zip,
    .count = count,
    .set = set,
  )

  x <- execute(x)
  polish(x)
}

#' Skilled Nursing Facility Owners
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
#' snf_owner(count = TRUE)
#'
#' snf_owner(own_state = c("GA", "FL")) |> str()
#'
#' @export
snf_owner <- function(
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
  x <- cms(
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
  x <- execute(x)
  polish(x)
}
