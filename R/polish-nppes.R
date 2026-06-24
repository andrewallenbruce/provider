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
    type_1 = nppes_by_type(x, 1L),
    type_2 = nppes_by_type(x, 2L)
  )
}

#' @noRd
nppes_by_type <- function(x, type) {
  x <- collapse::ss(x, x[["entity"]] %==% type)

  if (no_rows(x)) {
    return(NULL)
  }

  # KEY
  k <- nppes_key(x)

  # BASIC
  k <- nppes_basic(x, k, type)

  # OTHER NAMES
  k <- nppes_other(x, k, type)

  # IDENTIFIERS
  k <- nppes_identifiers(x, k)

  # TAXONOMY
  k <- nppes_taxonomy(x, k)

  # ADDRESSES
  k <- nppes_addresses(x, k)

  nppes_colorder(k)
}

#' @noRd
nppes_colorder <- function(x) {
  cheapr::col_c(
    collapse::gv(x, c("npi", "entity")),
    collapse::gvr(x, "^org_"),
    collapse::gv(x, c("first", "last", "cred", "sub_type")),
    collapse::gvr(x, "^sex$"),
    collapse::gv(x, c("address", "location", "city", "state", "zip")),
    collapse::gvr(x, "^id_"),
    collapse::gvr(x, "^tax_"),
    collapse::gvr(x, "^other_"),
    collapse::date_vars(x)
  )
}

#' @noRd
nppes_key <- function(x) {
  collapse::ss(x, j = c("npi", "entity"), check = FALSE)
}

#' @noRd
nppes_basic <- function(x, key, type) {
  b <- rlang::set_names(x[["basic"]], x[["npi"]]) |>
    collapse::unlist2d(idcols = c("npi", "var"))

  if (!no_rows(b)) {
    collapse::recode_char(
      b,
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
      "parent_organization_legal_business_name" = "org_dba",
      set = TRUE
    )

    remove <- c(
      "status",
      "name_prefix",
      "name_suffix",
      "middle_name",
      "authorized_official_name_prefix",
      "authorized_official_name_suffix",
      "authorized_official_middle_name",
      "authorized_official_telephone_number"
    )

    b <- collapse::ss(b, b[["var"]] %!iin% remove) |>
      collapse::pivot(
        ids = "npi",
        how = "w",
        names = "var",
        values = "V1",
        check.dups = TRUE
      ) |>
      rc_bin("sub_type") |>
      rc_ymd(c("enum_date", "cert_date", "last_update"))

    collapse::settransformv(b, "npi", as.integer)
    collapse::settransformv(b, "sub_type", as.character)

    if (type == 1L) {
      collapse::setv(b[["sub_type"]], "1", "Sole Proprietor")
    }

    if (type == 2L) {
      collapse::setv(b[["sub_type"]], "1", "Org Subpart")

      collapse::gv(b, "cred") <- glue::glue(
        "{b$cred} {b$title}",
        .na = ""
      ) |>
        as.character() |>
        stringr::str_squish()

      collapse::gv(b, "title") <- NULL
    }

    b[["sub_type"]] <- cheapr::val_replace(
      b[["sub_type"]],
      "0",
      NA_character_
    )

    key <- join2(key, b, on = "npi")
  }
  return(key)
}

#' @noRd
nppes_other <- function(x, key, type) {
  o <- rlang::set_names(x[["other"]], x[["npi"]]) |>
    cheapr::list_drop_null()

  if (!rlang::is_empty(o)) {
    o <- collapse::rowbind(o, idcol = "npi", fill = TRUE) |>
      collapse::recode_char("--" = NA_character_)

    if (type == 1L) {
      collapse::setrename(
        o,
        "code" = "type",
        "credential" = "cred",
        "first_name" = "first",
        "middle_name" = "middle",
        "last_name" = "last",
        .nse = FALSE
      )

      o[["name"]] <- glue::glue(
        "{o$first} {o$middle} {o$last} {o$cred}",
        .na = ""
      ) |>
        as.character() |>
        stringr::str_squish()
    }

    if (type == 2L) {
      collapse::setrename(
        o,
        "code" = "type",
        "organization_name" = "name",
        .nse = FALSE
      )
    }

    o <- collapse::gv(o, c("npi", "type", "name")) |>
      collapse::add_stub(stub = "other_", cols = -1)

    collapse::settransformv(o, "other_type", as.integer)
    collapse::settransformv(o, "npi", as.character)
    collapse::settransformv(o, "npi", as.integer)

    key <- join2(key, o, on = "npi")
  }
  return(key)
}

#' @noRd
nppes_identifiers <- function(x, key) {
  i <- rlang::set_names(x[["id"]], x[["npi"]]) |>
    cheapr::list_drop_null()

  if (!rlang::is_empty(i)) {
    i <- collapse::rowbind(
      i,
      idcol = "npi",
      fill = TRUE,
      id.factor = FALSE
    ) |>
      collapse::recode_char("--" = NA_character_) |>
      collapse::rnm(
        "code" = "type",
        "identifier" = "code",
        .nse = FALSE
      ) |>
      collapse::gv(c("npi", "type", "code", "issuer", "state")) |>
      collapse::add_stub(stub = "id_", cols = -1)

    collapse::settransformv(i, "id_type", as.integer)
    collapse::settransformv(i, "npi", as.integer)

    key <- join2(key, i, on = "npi")
  }
  return(key)
}

#' @noRd
nppes_taxonomy <- function(x, key) {
  t <- rlang::set_names(x[["taxonomy"]], x[["npi"]]) |>
    cheapr::list_drop_null()

  if (!rlang::is_empty(t)) {
    t <- rowbind2(t, "npi", fill = TRUE) |>
      collapse::recode_char("--" = NA_character_) |>
      replace_nz() |>
      rc_trim() |>
      collapse::rnm(
        "group" = "taxonomy_group",
        "prim" = "primary",
        .nse = FALSE
      ) |>
      collapse::add_stub(stub = "tx_", cols = -1)

    collapse::settransformv(t, "tx_prim", as.integer)
    collapse::settransformv(t, "npi", as.integer)

    key <- join2(key, t, on = "npi")
  }
  return(key)
}

#' @noRd
nppes_locations <- function(x) {
  l <- rlang::set_names(x[["location"]], x[["npi"]]) |>
    cheapr::list_drop_null()

  if (rlang::is_empty(l)) {
    return(NULL)
  }

  l <- rowbind2(l, "npi", fill = TRUE) |>
    collapse::recode_char("--" = NA_character_) |>
    collapse::gvr("^npi$|^address_[1p]|^city$|^state$|postal")

  collapse::setrename(
    l,
    "address" = "address_1",
    "location" = "address_purpose",
    "zip" = "postal_code",
    .nse = FALSE
  )

  collapse::settfmv(l, "npi", as.integer)

  l[["location"]] <- "secondary"

  return(l)
}

#' @noRd
nppes_addresses <- function(x, key) {
  l <- nppes_locations(x)

  a <- rlang::set_names(x[["address"]], x[["npi"]]) |>
    cheapr::list_drop_null() |>
    rowbind2("npi", fill = TRUE)

  if (!no_rows(a)) {
    a <- collapse::gvr(a, "^npi$|^address_[1p]|^city$|^state$|postal")

    collapse::setrename(
      a,
      "address" = "address_1",
      "location" = "address_purpose",
      "zip" = "postal_code",
      .nse = FALSE
    )

    collapse::settfmv(a, "npi", as.integer)
    collapse::settfmv(a, "location", tolower)

    a[a[["location"]] == "location", ][["location"]] <- "primary"

    if (!rlang::is_empty(l)) {
      a <- collapse::rowbind(a, l)
    }
    key <- join2(key, collapse::funique(a), on = "npi")
  }
  return(key)
}
