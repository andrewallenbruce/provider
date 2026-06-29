#' @include polish.R
#' @noRd
S7::method(polish, s3_nppes) <- function(x) {
  collapse::gvr(x, "_epoch$|^endpoints$") <- NULL
  collapse::setv(x[["enumeration_type"]], "NPI-1", "1")
  collapse::setv(x[["enumeration_type"]], "NPI-2", "2")
  collapse::settfmv(x, c("number", "enumeration_type"), as.integer)

  collapse::recode_char(
    colnames(x),
    "number" = "npi",
    "enumeration_type" = "entity",
    "practiceLocations" = "location",
    "identifiers" = "id",
    "other_names" = "other",
    "taxonomies" = "taxonomy",
    "addresses" = "address",
    set = TRUE
  )

  list(
    ind = nppes_sections(x, 1L),
    org = nppes_sections(x, 2L)
  )
}

#' @noRd
nppes_sections <- function(x, type) {
  x <- collapse::ss(
    x,
    x[["entity"]] %==% type,
    check = FALSE
  )

  if (collapse::fnrow(x) == 0L) {
    return(NULL)
  }

  k <- collapse::ss(x, j = c("npi", "entity"), check = FALSE)

  list(
    basic = nppes_basic(x, k),
    other = nppes_other(x, k, type),
    id = nppes_identifier(x, k),
    tax = nppes_taxonomy(x, k),
    loc = nppes_address(x, k)
  )
}

#' @noRd
nppes_basic <- function(x, key) {
  x <- rlang::set_names(
    x[["basic"]],
    x[["npi"]]
  ) |>
    collapse::unlist2d(c("npi", "var"))

  if (collapse::fnrow(x) == 0L) {
    return(key)
  }

  collapse::recode_char(
    x,
    "--" = NA_character_,
    "certification_date" = "cert_date",
    "enumeration_date" = "enum_date",
    "last_updated" = "last_update",
    "sole_proprietor" = "sole",
    "credential" = "cred",
    "first_name" = "first",
    "last_name" = "last",
    "authorized_official_credential" = "cred",
    "authorized_official_title_or_position" = "title",
    "authorized_official_first_name" = "first",
    "authorized_official_last_name" = "last",
    "organization_name" = "org_name",
    "organizational_subpart" = "subpart",
    "parent_organization_legal_business_name" = "org_parent",
    set = TRUE
  )

  x <- collapse::ss(
    x,
    x[["var"]] %!iin%
      c(
        "status",
        "name_prefix",
        "name_suffix",
        "middle_name",
        "authorized_official_name_prefix",
        "authorized_official_name_suffix",
        "authorized_official_middle_name",
        "authorized_official_telephone_number",
        "subpart"
      ),
    check = FALSE
  ) |>
    collapse::pivot(
      ids = "npi",
      how = "w",
      names = "var",
      values = "V1",
      check.dups = TRUE
    ) |>
    rc_ymd(c("enum_date", "cert_date", "last_update"))

  collapse::settransformv(x, "npi", as.integer)

  key <- join2(key, x, "npi")

  if (all2(key[["entity"]] == 2L)) {
    if ("org_parent" %!in_% colnames(key)) {
      key <- add_empty(key, "org_parent")
    }
  }

  cheapr::col_c(
    collapse::num_vars(key),
    collapse::get_vars(key, is.character),
    collapse::date_vars(key)
  ) |>
    collapse::roworderv(c("npi"))
}

# TBL 3: OTHER NAMES
# 1 = Former
# 2 = Professional
# 3 = Doing Business As
# 5 = Other
#' @noRd
nppes_other <- function(x, key, type) {
  x <- rlang::set_names(
    x[["other"]],
    x[["npi"]]
  ) |>
    cheapr::list_drop_null()

  if (rlang::is_empty(x)) {
    return(key)
  }

  x <- rowbind2(x, "npi", fill = TRUE) |>
    collapse::recode_char("--" = NA_character_)

  collapse::recode_char(
    colnames(x),
    "credential" = "cred",
    "first_name" = "first",
    "middle_name" = "middle",
    "last_name" = "last",
    "organization_name" = "org_dba",
    set = TRUE
  )

  collapse::settransformv(x, "npi", as.integer)
  i <- c("npi", "first", "middle", "last", "cred", "org_dba")
  x <- collapse::ss(x, j = colnames(x) %iin% i, check = FALSE)

  if (type == 1L) {
    x <- rc_combine(x, "first", "middle", sep = " ")
    x <- rc_combine(x, "first", "last", sep = " ")
    x <- rc_combine(x, "first", "cred", sep = ": ")
    x <- rlang::set_names(x, c("npi", "other"))
  }

  join2(key, x, "npi")
}

#' @noRd
nppes_identifier <- function(x, key) {
  x <- rlang::set_names(
    x[["id"]],
    x[["npi"]]
  ) |>
    cheapr::list_drop_null()

  if (rlang::is_empty(x)) {
    return(key)
  }

  x <- rowbind2(x, "npi", fill = TRUE) |>
    collapse::recode_char("--" = NA_character_) |>
    collapse::rnm(
      "code" = "type",
      "identifier" = "code",
      .nse = FALSE
    ) |>
    collapse::gv(c("npi", "code", "issuer", "state")) |>
    collapse::add_stub(stub = "id_", cols = -1)

  collapse::settransformv(x, "npi", as.integer)
  collapse::setv(x[["id_issuer"]], NA, "Medicaid")
  join2(key, x, "npi")
}

#' @noRd
nppes_taxonomy <- function(x, key) {
  x <- rlang::set_names(
    x[["taxonomy"]],
    x[["npi"]]
  ) |>
    cheapr::list_drop_null()

  if (rlang::is_empty(x)) {
    return(key)
  }

  x <- rowbind2(x, "npi", fill = TRUE) |>
    collapse::recode_char("--" = NA_character_) |>
    replace_nz() |>
    rc_trim() |>
    collapse::rnm(
      "grp" = "taxonomy_group",
      "prim" = "primary",
      "lic" = "license",
      .nse = FALSE
    ) |>
    collapse::add_stub(stub = "tx_", cols = -1)

  collapse::settransformv(x, "tx_prim", as.integer)
  collapse::settransformv(x, "npi", as.integer)

  x <- rc_combine(x, "tx_code", "tx_desc", sep = " - ")

  join2(key, x, "npi")
}

#' @noRd
nppes_location <- function(x) {
  x <- rlang::set_names(
    x[["location"]],
    x[["npi"]]
  ) |>
    cheapr::list_drop_null()

  if (rlang::is_empty(x)) {
    return(NULL)
  }

  x <- rowbind2(x, "npi", fill = TRUE) |>
    collapse::recode_char("--" = NA_character_) |>
    collapse::gvr("^npi$|^address_[1p]|^city$|^state$|postal")

  collapse::setrename(
    x,
    "address" = "address_1",
    "loc_type" = "address_purpose",
    "zip" = "postal_code",
    .nse = FALSE
  )

  collapse::settfmv(x, "npi", as.integer)

  x[["loc_type"]] <- "secondary"

  return(x)
}

#' @noRd
nppes_address <- function(x, key) {
  # TODO remove "mailing" location
  # unless the only address for an npi

  sec <- nppes_location(x)

  x <- rlang::set_names(
    x[["address"]],
    x[["npi"]]
  ) |>
    cheapr::list_drop_null() |>
    rowbind2("npi", fill = TRUE)

  if (collapse::fnrow(x) == 0L) {
    if (rlang::is_empty(sec)) {
      return(key)
    }
    return(join2(key, sec, "npi"))
  }

  x <- collapse::gvr(x, "^npi$|^address_[1p]|^city$|^state$|postal")

  collapse::setrename(
    x,
    "address" = "address_1",
    "loc_type" = "address_purpose",
    "zip" = "postal_code",
    .nse = FALSE
  )

  collapse::settfmv(x, "npi", as.integer)
  collapse::settfmv(x, "loc_type", tolower)

  x <- collapse::roworderv(x, c("npi", "loc_type")) |>
    collapse::funique(cols = c("npi", "address", "city", "state", "zip"))

  collapse::setv(x[["loc_type"]], "location", "primary")

  if (!rlang::is_empty(sec)) {
    x <- collapse::rowbind(x, sec)
  }
  join2(key, collapse::funique(x), "npi")
}
