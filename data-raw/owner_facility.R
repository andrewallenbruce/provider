#' @noRd
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
    `MULTIPLE NPI FLAG` = tag_bool(multi),
    PROPRIETARY_NONPROFIT = status,
    `ORGANIZATION TYPE STRUCTURE` = tag_enum(org_type)
  )

  x <- execute(x)

  polish(x)
}

#' @noRd
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
    `MULTIPLE NPI FLAG` = tag_bool(multi),
    PROPRIETARY_NONPROFIT = status,
    `ORGANIZATION TYPE STRUCTURE` = tag_enum(org_type)
  )

  x <- execute(x)

  polish(x)
}

#' @noRd
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
    `MULTIPLE NPI FLAG` = tag_bool(multi),
    PROPRIETARY_NONPROFIT = status,
    `ORGANIZATION TYPE STRUCTURE` = tag_enum(org_type)
  )

  x <- execute(x)

  polish(x)
}

#' @noRd
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
    `MULTIPLE NPI FLAG` = tag_bool(multi),
    PROPRIETARY_NONPROFIT = status,
    `ORGANIZATION TYPE STRUCTURE` = tag_enum(org_type)
  )

  x <- execute(x)

  polish(x)
}

#' @noRd
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
    `MULTIPLE NPI FLAG` = tag_bool(multi),
    PROPRIETARY_NONPROFIT = status,
    `ORGANIZATION TYPE STRUCTURE` = tag_enum(org_type)
  )

  x <- execute(x)

  polish(x)
}


#' @noRd
S7::method(polish, S7::new_S3_class("fqhc_enroll")) <- function(x) {
  rename_with(x, "fqhc_enroll") |>
    polish_enroll()
}

#' @noRd
S7::method(polish, S7::new_S3_class("hha_enroll")) <- function(x) {
  rename_with(x, "hha_enroll") |>
    polish_enroll()
}

#' @noRd
S7::method(polish, S7::new_S3_class("hospice_enroll")) <- function(x) {
  rename_with(x, "hospice_enroll") |>
    polish_enroll()
}

#' @noRd
S7::method(polish, S7::new_S3_class("rhc_enroll")) <- function(x) {
  rename_with(x, "rhc_enroll") |>
    polish_enroll()
}

#' @noRd
S7::method(polish, S7::new_S3_class("snf_enroll")) <- function(x) {
  rename_with(x, "snf_enroll") |>
    polish_enroll()
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


#' @noRd
S7::method(polish, S7::new_S3_class("fqhc_owner")) <- function(x) {
  rename_with(x, "fqhc_owner") |>
    polish_owner()
}

#' @noRd
S7::method(polish, S7::new_S3_class("hha_owner")) <- function(x) {
  rename_with(x, "hha_owner") |>
    polish_owner()
}

#' @noRd
S7::method(polish, S7::new_S3_class("hospice_owner")) <- function(x) {
  rename_with(x, "hospice_owner") |>
    polish_owner()
}

#' @noRd
S7::method(polish, S7::new_S3_class("hospital_owner")) <- function(x) {
  rename_with(x, "hospital_owner") |>
    polish_owner()
}

#' @noRd
S7::method(polish, S7::new_S3_class("rhc_owner")) <- function(x) {
  rename_with(x, "rhc_owner") |>
    polish_owner()
}

#' @noRd
S7::method(polish, S7::new_S3_class("snf_owner")) <- function(x) {
  rename_with(x, "snf_owner") |>
    polish_owner()
}
