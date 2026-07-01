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

  cheapr::list_drop_null(list(
    ind = nppes_sections(x, 1L),
    org = nppes_sections(x, 2L)
  ))
}

#' @noRd
nppes_sections <- function(x, type) {
  x <- collapse::ss(x, x[["entity"]] %==% type, check = FALSE)

  if (collapse::fnrow(x) == 0L) {
    return(NULL)
  }

  k <- collapse::ss(x, j = c("npi", "entity"), check = FALSE)

  cheapr::list_drop_null(
    list(
      basic = nppes_basic(x, k, type),
      taxonomy = nppes_taxonomy(x),
      location = nppes_address(x)
    )
  )
}

#' @noRd
nppes_basic <- function(x, key, ind = TRUE) {
  o <- nppes_other(x, ind)

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
# 1 [Former]
# 2 [Professional]
# 3 [Doing Business As]
# 5 [Other]
#' @noRd
nppes_other <- function(x, ind = TRUE) {
  x <- cheapr::list_drop_null(
    rlang::set_names(
      x[["other"]],
      x[["npi"]]
    )
  )

  if (rlang::is_empty(x)) {
    return(NULL)
  }

  x <- rowbind2(x, "npi", fill = TRUE)

  collapse::recode_char(
    x,
    "--" = NA_character_,
    set = TRUE
  )

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

  if (ind) {
    x <- rc_combine(x, "first", "middle", sep = " ")
    x <- rc_combine(x, "first", "last", sep = " ")
    x <- rc_combine(x, "first", "cred")
    x <- rlang::set_names(x, c("npi", "other"))
  }

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

  x <- rowbind2(x, "npi", fill = TRUE)
  x <- rc_trim(x)
  replace_nz(x)

  collapse::recode_char(
    colnames(x),
    "npi" = "npi",
    "primary" = "order",
    "code" = "code",
    "desc" = "desc",
    "taxonomy_group" = "group",
    "license" = "license",
    "state" = "state",
    set = TRUE
  )

  collapse::settransformv(x, "order", as.integer)
  collapse::setv(x[["order"]], 0L, 2L)
  collapse::settransformv(x, "npi", as.integer)
  collapse::gv(x, c("desc", "license", "state")) <- NULL

  x[["group"]] <- purrr::map_chr(
    strsplit(x[["group"]], " - ", fixed = TRUE),
    function(x) purrr::pluck(x, 1L)
  )

  i <- cheapr::which_not_na(x[["group"]])
  g <- cheapr::col_c(
    npi = x[["npi"]][i],
    code = x[["group"]][i],
    order = 0L
  )

  x <- cheapr::c_(x, collapse::funique(g))

  collapse::gv(x, c("group")) <- NULL

  collapse::roworderv(
    x,
    c("npi", "order"),
    decreasing = c(TRUE, FALSE)
  ) |>
    collapse::colorderv(c("npi", "order")) |>
    collapse::funique(cols = c("npi", "code"))
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

  x <- rowbind2(x, "npi", fill = TRUE)
  i <- c("npi", "address_1", "city", "state", "postal_code")
  x <- collapse::ss(x, j = i, check = FALSE)

  collapse::setrename(
    x,
    "address" = "address_1",
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

  x <- cheapr::list_drop_null(
    rlang::set_names(
      x[["address"]],
      x[["npi"]]
    )
  )

  if (rlang::is_empty(x)) {
    if (rlang::is_empty(loc)) {
      return(NULL)
    }
    return(loc)
  }

  x <- rowbind2(x, "npi", fill = TRUE)
  i <- c("npi", "address_1", "address_purpose", "city", "state", "postal_code")
  x <- collapse::ss(x, j = i, check = FALSE)

  collapse::setrename(
    x,
    "address" = "address_1",
    "loc" = "address_purpose",
    "zip" = "postal_code",
    .nse = FALSE
  )

  collapse::settfmv(x, "npi", as.integer)
  collapse::settfmv(x, "loc", tolower)
  collapse::setv(x[["loc"]], "location", "primary")

  if (!rlang::is_empty(loc)) {
    x <- collapse::rowbind(x, loc)
  }

  x[["loc"]] <- loc_rank(x[["loc"]])

  collapse::roworderv(x, c("npi", "loc")) |>
    collapse::funique(cols = c("npi", "address", "city", "state", "zip")) |>
    collapse::colorderv(c("npi", "loc", "city", "state"))
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

  x <- rowbind2(x, "npi", fill = TRUE)

  collapse::recode_char(
    x,
    "--" = NA_character_,
    set = TRUE
  )

  collapse::recode_char(
    colnames(x),
    "npi" = "npi",
    "identifier" = "id",
    "issuer" = "issuer",
    "state" = "state",
    set = TRUE
  )

  collapse::settransformv(x, "npi", as.integer)
  collapse::setv(x[["issuer"]], NA, "Medicaid")
  collapse::gv(x, c("npi", "id", "issuer", "state"))
}
