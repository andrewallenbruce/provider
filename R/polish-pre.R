#' @noRd
quality_get <- function(x, y) {
  y <- match.arg(as.character(y), c("2017", "2022", "2023"))
  z <- switch(
    y,
    "2017" = as.character(2017:2021),
    "2022" = "2022",
    "2023" = as.character(2023:2024)
  )

  if (!collapse::has_elem(x, z)) {
    return(list())
  }

  x <- collapse::get_elem(x, z, keep.tree = TRUE) |>
    rowbind2("year", fill = TRUE)

  NMS <- RE_NAME[["quality"]][[y]]

  collapse::setrename(x, NMS, .nse = FALSE)
  replace_nz(x)

  x <- collapse::gv(x, unlist_(NMS)) |>
    rc_bin(collapse::gvr(x, "_ind$", return = 2L)) |>
    pivot_quality()

  if (y == "2017") {
    x <- collapse::av(
      x,
      cred = vec_na(x),
      dual_ratio = vec_na(x, "double"),
      small_bonus = vec_na(x, "integer")
    )
  }

  if (y %in% c("2017", "2022")) {
    x <- collapse::av(
      x,
      reporting = vec_na(x),
      mvp = vec_na(x),
      ci_score = vec_na(x, "double")
    )
  }
  return(x)
}

#' @noRd
nppes_entity_1 <- function(x) {
  x <- collapse::ss(x, x[["entity"]] == 1L)

  if (no_rows(x)) {
    return(NULL)
  }

  # KEY
  k <- collapse::ss(x, j = c("npi", "entity"))

  # BASIC
  b <- rlang::set_names(x$basic, x$npi) |>
    collapse::unlist2d(idcols = c("npi", "var"))

  if (!no_rows(b)) {
    collapse::recode_char(
      b,
      "--" = NA_character_,
      "certification_date" = "cert_date",
      "enumeration_date" = "enum_date",
      "last_updated" = "updated",
      "sole_proprietor" = "type",
      "credential" = "cred",
      "first_name" = "first",
      "last_name" = "last",
      fixed = TRUE,
      set = TRUE
    )

    remove <- c(
      "status",
      "name_prefix",
      "name_suffix",
      "middle_name"
      )

    b <- collapse::ss(b, b[["var"]] %!iin% remove) |>
      collapse::pivot(
        ids = "npi",
        how = "w",
        names = "var",
        values = "V1",
        check.dups = TRUE
      ) |>
      rc_bin("type") |>
      rc_ymd(c("enum_date", "cert_date", "updated"))

    collapse::settransformv(b, "npi", as.integer)

    b$type <- cheapr::if_else_(b$type == 1L, "Sole Proprietor", NA_character_)

    k <- collapse::join(k, b, on = "npi", multiple = TRUE, verbose = 0L)
  }

  # OTHER NAMES
  o <- rlang::set_names(x$other, x$npi) |>
    cheapr::list_drop_null()

  if (!rlang::is_empty(o)) {
    o <- collapse::rowbind(o, idcol = "npi", fill = TRUE) |>
      collapse::recode_char("--" = NA_character_) |>
      collapse::rnm(
        "code" = "type",
        "credential" = "cred",
        "first_name" = "first",
        "middle_name" = "middle",
        "last_name" = "last",
        .nse = FALSE
      )

    o$name <- glue::glue("{o$first} {o$middle} {o$last} {o$cred}", .na = "") |>
      as.character() |>
      stringr::str_squish()

    o <- collapse::gv(o, c("npi", "type", "name")) |>
      collapse::add_stub(stub = "oth_", cols = -1)

    collapse::settransformv(o, "oth_type", as.integer)
    collapse::settransformv(o, "npi", as.character)
    collapse::settransformv(o, "npi", as.integer)

    k <- collapse::join(k, o, on = "npi", verbose = 0L)
  }

  # IDENTIFIERS
  i <- rlang::set_names(x$id, x$npi) |>
    cheapr::list_drop_null()

  if (!rlang::is_empty(i)) {
    i <- collapse::rowbind(i, idcol = "npi", fill = TRUE) |>
      collapse::recode_char("--" = NA_character_) |>
      collapse::rnm(
        "code" = "type",
        "identifier" = "code",
        .nse = FALSE
      ) |>
      collapse::gv(c("npi", "type", "code", "issuer", "state")) |>
      collapse::add_stub(stub = "id_", cols = -1)

    collapse::settransformv(i, "id_type", as.integer)
    collapse::settransformv(i, "npi", as.character)
    collapse::settransformv(i, "npi", as.integer)

    k <- collapse::join(k, i, on = "npi", multiple = TRUE, verbose = 0L)
  }

  # TAXONOMY
  t <- rlang::set_names(x$taxonomy, x$npi) |>
    cheapr::list_drop_null()

  if (!rlang::is_empty(t)) {
    t <- collapse::rowbind(t, idcol = "npi", fill = TRUE) |>
      collapse::recode_char("--" = NA_character_) |>
      provider:::replace_nz() |>
      provider:::rc_trim() |>
      collapse::qTBL() |>
      collapse::rnm(
        "group" = "taxonomy_group",
        "prim" = "primary",
        .nse = FALSE
      ) |>
      collapse::add_stub(stub = "tax_", cols = -1)

    collapse::settransformv(t, "tax_prim", as.integer)
    collapse::settransformv(t, "npi", as.character)
    collapse::settransformv(t, "npi", as.integer)

    k <- collapse::join(k, t, on = "npi", multiple = TRUE, verbose = 0L)
  }

  # PRACTICE LOCATIONS
  l <- rlang::set_names(x$location, x$npi) |>
    cheapr::list_drop_null()

  if (!rlang::is_empty(l)) {
    l <- collapse::rowbind(
      l,
      idcol = "npi",
      fill = TRUE,
      id.factor = TRUE,
      return = 4L
    ) |>
      collapse::recode_char("--" = NA_character_) |>
      collapse::gvr("^npi$|^address_[1p]|^city$|^state$|postal") |>
      collapse::rnm(
        "address" = "address_1",
        "purpose" = "address_purpose",
        "zip" = "postal_code",
        .nse = FALSE
      )

    collapse::settfmv(l, "npi", as.character)
    collapse::settfmv(l, "npi", as.integer)
    collapse::settfmv(l, "purpose", tolower)
  }

  # ADDRESSES
  a <- rlang::set_names(x$address, x$npi) |>
    collapse::rowbind(
      idcol = "npi",
      fill = TRUE,
      id.factor = TRUE,
      return = 4L
    )

  if (!no_rows(a)) {
    a <- collapse::gvr(a, "^npi$|^address_[1p]|^city$|^state$|postal") |>
      collapse::rnm(
        "address" = "address_1",
        "purpose" = "address_purpose",
        "zip" = "postal_code",
        .nse = FALSE
      )

    collapse::settfmv(a, "npi", as.character)
    collapse::settfmv(a, "npi", as.integer)
    collapse::settfmv(a, "purpose", tolower)

    if (!rlang::is_empty(l)) {
      a <- collapse::rowbind(a, l)
    }
    k <- collapse::join(k, a, on = "npi", multiple = TRUE, verbose = 0L)
  }
  return(k)
}

#' @noRd
nppes_entity_2 <- function(x) {
  x <- collapse::ss(x, x[["entity"]] == 2L)

  if (no_rows(x)) {
    return(NULL)
  }

  # KEY
  k <- collapse::ss(x, j = c("npi", "entity"))

  # BASIC
  b <- rlang::set_names(x$basic, x$npi) |>
    collapse::unlist2d(idcols = c("npi", "var")) |>
    collapse::qTBL()

  if (!no_rows(b)) {
    collapse::recode_char(
      b,
      "--" = NA_character_,
      "certification_date" = "cert_date",
      "enumeration_date" = "enum_date",
      "last_updated" = "updated",
      "authorized_official_credential" = "cred",
      "authorized_official_title_or_position" = "title",
      "authorized_official_first_name" = "first",
      "authorized_official_last_name" = "last",
      "organization_name" = "org_name",
      "organizational_subpart" = "subpart",
      fixed = TRUE,
      set = TRUE
    )

    remove <- c(
      "status",
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
      rc_bin("subpart") |>
      rc_ymd(c("enum_date", "cert_date", "updated"))

    collapse::settransformv(b, "npi", as.integer)

    k <- collapse::join(k, b, on = "npi", multiple = TRUE, verbose = 0L)
  }

  # OTHER NAMES
  o <- rlang::set_names(x$other, x$npi) |>
    cheapr::list_drop_null()

  if (!rlang::is_empty(o)) {
    o <- collapse::rowbind(o, idcol = "npi", fill = TRUE) |>
      collapse::recode_char("--" = NA_character_) |>
      collapse::qTBL() |>
      collapse::rnm("name" = "organization_name", .nse = FALSE) |>
      collapse::gv(c("npi", "code", "name")) |>
      collapse::add_stub(stub = "o_", cols = -1)

    collapse::settransformv(o, "o_code", as.integer)
    collapse::settransformv(o, "npi", as.character)
    collapse::settransformv(o, "npi", as.integer)

    k <- collapse::join(k, o, on = "npi", verbose = 0L)
  }

  # IDENTIFIERS
  i <- rlang::set_names(x$id, x$npi) |>
    cheapr::list_drop_null()

  if (!rlang::is_empty(i)) {
    i <- collapse::rowbind(i, idcol = "npi", fill = TRUE) |>
      collapse::recode_char("--" = NA_character_) |>
      collapse::qTBL() |>
      collapse::gv(c("npi", "code", "identifier", "issuer", "state")) |>
      collapse::add_stub(stub = "id_", cols = -1)

    collapse::settransformv(i, "id_code", as.integer)
    collapse::settransformv(i, "npi", as.character)
    collapse::settransformv(i, "npi", as.integer)

    k <- collapse::join(k, i, on = "npi", multiple = TRUE, verbose = 0L)
  }

  # TAXONOMY
  t <- rlang::set_names(x$taxonomy, x$npi) |>
    cheapr::list_drop_null()

  if (!rlang::is_empty(t)) {
    t <- collapse::rowbind(t, idcol = "npi", fill = TRUE) |>
      collapse::recode_char("--" = NA_character_) |>
      provider:::replace_nz() |>
      provider:::rc_trim() |>
      collapse::qTBL() |>
      collapse::rnm(
        "group" = "taxonomy_group",
        "prime" = "primary",
        .nse = FALSE
      ) |>
      collapse::add_stub(stub = "tax_", cols = -1)

    collapse::settransformv(t, "tax_prime", as.integer)
    collapse::settransformv(t, "npi", as.character)
    collapse::settransformv(t, "npi", as.integer)

    k <- collapse::join(k, t, on = "npi", multiple = TRUE, verbose = 0L)
  }

  # PRACTICE LOCATIONS
  l <- rlang::set_names(x$location, x$npi) |>
    cheapr::list_drop_null()

  if (!rlang::is_empty(l)) {
    l <- collapse::rowbind(
      l,
      idcol = "npi",
      fill = TRUE,
      id.factor = TRUE,
      return = 4L
    ) |>
      collapse::recode_char("--" = NA_character_) |>
      collapse::gvr("^npi$|^address_[1p]|^city$|^state$|postal") |>
      collapse::rnm(
        "address" = "address_1",
        "purpose" = "address_purpose",
        "zip" = "postal_code",
        .nse = FALSE
      )

    collapse::settfmv(l, "npi", as.character)
    collapse::settfmv(l, "npi", as.integer)
    collapse::settfmv(l, "purpose", tolower)
  }

  # ADDRESSES
  a <- rlang::set_names(x$address, x$npi) |>
    collapse::rowbind(
      idcol = "npi",
      fill = TRUE,
      id.factor = TRUE,
      return = 4L
    )

  if (!no_rows(a)) {
    a <- collapse::gvr(a, "^npi$|^address_[1p]|^city$|^state$|postal") |>
      collapse::rnm(
        "address" = "address_1",
        "purpose" = "address_purpose",
        "zip" = "postal_code",
        .nse = FALSE
      )

    collapse::settfmv(a, "npi", as.character)
    collapse::settfmv(a, "npi", as.integer)
    collapse::settfmv(a, "purpose", tolower)

    if (!rlang::is_empty(l)) {
      a <- collapse::rowbind(a, l)
    }
    k <- collapse::join(k, a, on = "npi", multiple = TRUE, verbose = 0L)
  }
  return(k)
}
