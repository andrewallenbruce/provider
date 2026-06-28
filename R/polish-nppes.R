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

  x <- list(
    ind = nppes_by_type(x, 1L),
    org = nppes_by_type(x, 2L)
  )

  collapse::gv(
    x[["ind"]],
    c("on_name", "on_type")
  ) <- NULL

  collapse::gv(
    x[["org"]],
    c("sub_type", "on_type")
  ) <- NULL

  collapse::setrename(
    x[["org"]],
    "on_name" = "org_dba",
    .nse = FALSE
  )

  x[["org"]] <- collapse::colorderv(
    x[["org"]],
    "^org_",
    regex = TRUE,
    pos = "after"
  )

  list(
    ind = list(
      base = collapse::ss(
        x$ind,
        j = c(1:6, 12:22),
        check = FALSE
      ) |>
        collapse::funique(),
      address = collapse::ss(
        x$ind,
        j = c(1L, 7:11),
        check = FALSE
      ) |>
        collapse::funique()
    ),
    org = list(
      base = collapse::ss(
        x$org,
        j = c(1:8, 14:21),
        check = FALSE
      ) |>
        collapse::funique(),
      address = collapse::ss(
        x$org,
        j = c(1L, 9:13),
        check = FALSE
      ) |>
        collapse::funique()
    )
  )
}

#' @noRd
nppes_by_type <- function(x, type) {
  x <- collapse::ss(
    x,
    x[["entity"]] %==% type,
    check = FALSE
  )

  if (collapse::fnrow(x) == 0L) {
    return(NULL)
  }

  # KEY
  k <- collapse::ss(x, j = c("npi", "entity"), check = FALSE)

  # BASIC
  k <- nppes_basic(x, k, type)

  # OTHER NAMES
  k <- nppes_other(x, k, type)

  # IDENTIFIERS
  k <- nppes_identifier(x, k)

  # TAXONOMY
  k <- nppes_taxonomy(x, k)

  # ADDRESSES
  k <- nppes_address(x, k)

  nppes_colorder(k)
}

#' @noRd
nppes_colorder <- function(x) {
  cheapr::col_c(
    collapse::gv(x, c("npi", "entity")),
    collapse::gvr(x, "^org_"),
    collapse::gv(x, c("first", "last", "cred", "sub_type")),
    # collapse::gvr(x, "^sex$"),
    collapse::gv(x, c("address", "loc_type", "city", "state", "zip")),
    collapse::gvr(x, "^id_"),
    collapse::gvr(x, "^tx_"),
    collapse::gvr(x, "^on_"),
    collapse::date_vars(x)
  )
}

#' @noRd
nppes_basic <- function(x, key, type) {
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
    "sole_proprietor" = "sub_type",
    "credential" = "cred",
    "first_name" = "first",
    "last_name" = "last",
    "authorized_official_credential" = "cred",
    "authorized_official_title_or_position" = "title",
    "authorized_official_first_name" = "first",
    "authorized_official_last_name" = "last",
    "organization_name" = "org_name",
    "organizational_subpart" = "sub_type",
    "parent_organization_legal_business_name" = "org_par",
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
        "authorized_official_telephone_number"
      )
  ) |>
    collapse::pivot(
      ids = "npi",
      how = "w",
      names = "var",
      values = "V1",
      check.dups = TRUE
    ) |>
    rc_bin("sub_type") |>
    rc_ymd(c("enum_date", "cert_date", "last_update"))

  collapse::settransformv(x, "npi", as.integer)
  collapse::settransformv(x, "sub_type", as.character)

  if (type == 1L) {
    collapse::setv(x[["sub_type"]], "1", "Sole Proprietor")
  }

  if (type == 2L) {
    collapse::setv(x[["sub_type"]], "1", "Org Subpart")

    collapse::gv(x, "cred") <- glue::glue(
      "{x$cred} {x$title}",
      .na = ""
    ) |>
      as.character() |>
      stringr::str_squish()

    collapse::gv(x, "title") <- NULL

    if ("org_par" %!in_% colnames(x)) {
      x <- add_empty(x, "org_par")
    }
  }

  x[["sub_type"]] <- cheapr::val_replace(
    x[["sub_type"]],
    "0",
    NA_character_
  )

  join2(key, x, "npi")
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

  if (type == 1L) {
    collapse::setrename(
      x,
      "code" = "type",
      "credential" = "cred",
      "first_name" = "first",
      "middle_name" = "middle",
      "last_name" = "last",
      .nse = FALSE
    )

    x[["name"]] <- glue::glue(
      "{x$first} {x$middle} {x$last} {x$cred}",
      .na = ""
    ) |>
      as.character() |>
      stringr::str_squish()
  }

  if (type == 2L) {
    collapse::setrename(
      x,
      "code" = "type",
      "organization_name" = "name",
      .nse = FALSE
    )
  }

  # TODO change "on_name" -> "org_dba"
  # when entity == 2
  # remove "on_type"

  # TODO possibly remove
  # "on_name" and "on_type"
  # for entity == 1

  x <- collapse::gv(x, c("npi", "type", "name")) |>
    collapse::add_stub(stub = "on_", cols = -1)

  collapse::settransformv(x, "on_type", as.integer)
  collapse::settransformv(x, "npi", as.integer)

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
