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

  k <- collapse::ss(
    x,
    j = c("npi", "entity"),
    check = FALSE
  )

  cheapr::list_drop_null(list(
    basic = nppes_basic(x, k, type),
    taxonomy = nppes_taxonomy(x),
    identifier = nppes_identifier(x),
    location = nppes_address(x)
  ))
}

#' @noRd
nppes_basic <- function(x, key, type) {
  o <- nppes_other(x, type)

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
    if ("org_par" %!in_% colnames(key)) {
      key <- add_empty(key, "org_par")
    }
  }

  if (!is.null(o)) {
    key <- join2(key, o, "npi")
  }

  cheapr::col_c(
    collapse::num_vars(key),
    collapse::get_vars(key, is.character),
    collapse::date_vars(key)
  ) |>
    collapse::roworderv(c("npi"))
}

# OTHER NAMES
# 1 = Former
# 2 = Professional
# 3 = Doing Business As
# 5 = Other
#' @noRd
nppes_other <- function(x, type) {
  x <- cheapr::list_drop_null(
    rlang::set_names(
      x[["other"]],
      x[["npi"]]
    )
  )

  if (rlang::is_empty(x)) {
    return(NULL)
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

  return(x)
}

#' @noRd
nppes_identifier <- function(x) {
  x <- cheapr::list_drop_null(
    rlang::set_names(
      x[["id"]],
      x[["npi"]]
    )
  )

  if (rlang::is_empty(x)) {
    return(NULL)
  }

  x <- rowbind2(x, "npi", fill = TRUE) |>
    collapse::recode_char("--" = NA_character_) |>
    collapse::rnm("code" = "type", "identifier" = "code", .nse = FALSE) |>
    collapse::gv(c("npi", "code", "issuer", "state"))

  collapse::settransformv(x, "npi", as.integer)
  collapse::setv(x[["issuer"]], NA, "Medicaid")

  return(x)
}

#' @noRd
nppes_taxonomy <- function(x) {
  x <- cheapr::list_drop_null(
    rlang::set_names(
      x[["taxonomy"]],
      x[["npi"]]
    )
  )

  if (rlang::is_empty(x)) {
    return(NULL)
  }

  x <- rowbind2(x, "npi", fill = TRUE) |>
    collapse::recode_char("--" = NA_character_) |>
    replace_nz() |>
    rc_trim() |>
    collapse::rnm("group" = "taxonomy_group", "order" = "primary", .nse = FALSE)

  collapse::settransformv(x, "order", as.integer)
  collapse::setv(x[["order"]], 0, 2)
  collapse::settransformv(x, "npi", as.integer)
  collapse::gv(x, "desc") <- NULL

  x[["group"]] <- purrr::map_chr(
    strsplit(x[["group"]], " - ", fixed = TRUE),
    function(x) purrr::pluck(x, 1L)
  )

  x <- rc_combine(x, "code", "group", sep = ":")

  collapse::roworderv(x, c("npi", "order")) |>
    collapse::colorderv(c("npi", "order")) |>
    collapse::funique(cols = c("npi", "code", "license", "state"))
}

#' @noRd
nppes_location <- function(x) {
  x <- cheapr::list_drop_null(
    rlang::set_names(
      x[["location"]],
      x[["npi"]]
    )
  )

  if (rlang::is_empty(x)) {
    return(NULL)
  }

  x <- rowbind2(x, "npi", fill = TRUE) |>
    collapse::recode_char("--" = NA_character_) |>
    collapse::gvr("^npi$|^address_[1p]|^city$|^state$|postal")

  collapse::setrename(
    x,
    "address" = "address_1",
    "loc" = "address_purpose",
    "zip" = "postal_code",
    .nse = FALSE
  )

  collapse::settfmv(x, "npi", as.integer)

  x[["loc"]] <- "secondary"

  return(x)
}

#' @noRd
nppes_address <- function(x, key) {
  # TODO remove "mailing" location
  # unless the only address for an npi

  loc <- nppes_location(x)

  x <- rlang::set_names(
    x[["address"]],
    x[["npi"]]
  ) |>
    cheapr::list_drop_null() |>
    rowbind2("npi", fill = TRUE)

  if (collapse::fnrow(x) == 0L) {
    if (rlang::is_empty(loc)) {
      return(NULL)
    }
    return(loc)
  }

  x <- collapse::gvr(x, "^npi$|^address_[1p]|^city$|^state$|postal")

  collapse::setrename(
    x,
    "address" = "address_1",
    "loc" = "address_purpose",
    "zip" = "postal_code",
    .nse = FALSE
  )

  collapse::settfmv(x, "npi", as.integer)
  collapse::settfmv(x, "loc", tolower)

  x <- collapse::roworderv(x, c("npi", "loc")) |>
    collapse::funique(cols = c("npi", "address", "city", "state", "zip"))

  collapse::setv(x[["loc"]], "location", "primary")

  if (!rlang::is_empty(loc)) {
    x <- collapse::rowbind(x, loc)
  }

  x[["loc"]] <- loc_rank(x[["loc"]])

  return(x)
}

#' @noRd
loc_rank <- function(x) {
  cheapr::val_match(
    x,
    "primary" ~ 1L,
    "secondary" ~ 2L,
    "mailing" ~ 3L,
    .default = NA_integer_
  ) |>
    as.integer()
}
