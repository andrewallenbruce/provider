#' @noRd
add_class <- function(x, endpoint) {
  structure(x, class = c(endpoint, "tbl_df", "tbl", "data.frame"))
}

#' @noRd
rename_with <- function(x, endpoint) {
  if (rlang::is_null(RE_NAME[[endpoint]])) {
    return(x)
  }
  rlang::inject(collapse::recode_char(
    colnames(x),
    !!!RE_NAME[[endpoint]],
    set = TRUE
  ))
  collapse::gv(x, unlist_(RE_NAME[[endpoint]])) |>
    replace_nz() |>
    data_frame()
}

#' @noRd
replace_nz <- function(i) {
  purrr::modify_if(i, is.character, function(x) {
    vctrs::vec_assign(
      x,
      i = vctrs::vec_in(x, haystack = ""),
      value = NA_character_,
      slice_value = TRUE
    )
  })
}

#' @noRd
rc_ <- function(.f) {
  function(x, v) {
    collapse::tfmv(.data = x, vars = v, FUN = .f)
  }
}

#' @noRd
rc_integer <- rc_(as.integer)

#' @noRd
rc_integer_supp <- rc_(as_integer_supp)

#' @noRd
rc_double <- rc_(as.double)

#' @noRd
rc_bin <- rc_(bin_col)

#' @noRd
rc_date_ymd <- rc_(as_date_ymd)

#' @noRd
rc_date_ymd2 <- rc_(as_date_ymd2)

#' @noRd
rc_date_mdy <- rc_(as_date_mdy)

#' @noRd
combine_cols <- function(e1, e2, sep = ", ") {
  cheapr::if_else_(cheapr::is_na(e2), e1, cheapr::paste_(e1, e2, sep = sep))
}

#' @noRd
bin_col <- function(x) {
  cheapr::case(
    x %in_% c("Y", "Yes") ~ 1L,
    x %in_% c("N", "No") ~ 0L,
    .default = NA_integer_
  )
}

#' @noRd
as_integer_supp <- function(x, ...) {
  suppressWarnings(as.integer(x, ...))
}

#' @noRd
as_date_ymd <- function(x, ...) {
  as.Date(x, ..., format = "%Y-%m-%d")
}

#' @noRd
as_date_ymd2 <- function(x, ...) {
  as.Date(x, ..., format = "%Y%m%d")
}

#' @noRd
as_date_mdy <- function(x, ...) {
  as.Date(x, ..., format = "%m/%d/%Y")
}

#' @autoglobal
#' @noRd
owner_pivot <- function(x) {
  y <- collapse::gvr(x, "own_pac|_ind$") |>
    collapse::pivot(
      ids = "own_pac",
      factor = FALSE,
      names = list(variable = "own_ind", value = "bin"),
      na.rm = TRUE
    ) |>
    collapse::funique() |>
    collapse::roworderv("own_pac")

  if (nrow(y) == 0L) {
    collapse::gvr(x, "_ind$") <- NULL
    x <- collapse::av(x, own_ind = rep.int(NA_character_, nrow(x)))
    return(x)
  }

  y <- collapse::ss(y, y$bin %==% 1L)

  if (nrow(y) == 0L) {
    collapse::gvr(x, "_ind$") <- NULL
    x <- collapse::av(x, own_ind = rep.int(NA_character_, nrow(x)))
    return(x)
  }

  collapse::recode_char(
    y$own_ind,
    "acq_ind" = "Created for Aquisition",
    "corp_ind" = "Corporation",
    "llc_ind" = "LLC",
    "mps_ind" = "Medical Provider/Supplier",
    "msr_ind" = "Management Services Company",
    "mst_ind" = "Medical Staffing Company",
    "hld_ind" = "Holding Company",
    "inv_ind" = "Investment Firm",
    "fin_ind" = "Financial Institution",
    "con_ind" = "Consulting Firm",
    "fp_ind" = "For-Profit",
    "np_ind" = "Non-Profit",
    "pe_ind" = "Private Equity",
    "reit_ind" = "REIT",
    "cho_ind" = "Chain Home Office",
    "oth_ind" = "Other",
    "ano_ind" = "Owned by Another Org/Ind",
    default = NA_character_,
    set = TRUE
  )

  collapse::gv(y, "bin") <- NULL
  collapse::gvr(x, "_ind$") <- NULL

  y <- collapse::roworderv(y, "own_pac") |>
    collapse::gby(own_pac) |>
    collapse::mtt(own_ind = paste0(own_ind, collapse = ", ")) |>
    collapse::fungroup() |>
    collapse::funique()

  collapse::join(x, y, on = "own_pac", verbose = 0L)
}

#' @autoglobal
#' @noRd
credit_pivot <- function(x) {
  col_acr <- c("a2la_", "aabb_", "aoa_", "ashi_", "cap_", "cola_", "jcaho_")

  y <- collapse::gvr(x, c("fac_ccn", col_acr)) |>
    collapse::roworderv("fac_ccn")

  i <- collapse::gvr(y, c("fac_ccn", "_ind")) |>
    collapse::pivot(
      ids = "fac_ccn",
      factor = FALSE,
      names = list(variable = "acr_org", value = "bin"),
      na.rm = TRUE
    ) |>
    collapse::funique()

  if (nrow(i) == 0L) {
    collapse::gvr(x, col_acr) <- NULL
    n <- rep.int(NA_character_, nrow(x))
    x <- collapse::av(x, acr_org = n, acr_date = n)
    return(x)
  }

  i <- collapse::ss(i, i$bin %==% 1L, 1:2)

  if (nrow(i) == 0L) {
    collapse::gvr(x, col_acr) <- NULL
    n <- rep.int(NA_character_, nrow(x))
    x <- collapse::av(x, acr_org = n, acr_date = n)
    return(x)
  }

  d <- collapse::gvr(y, c("fac_ccn", "_date")) |>
    collapse::pivot(
      ids = "fac_ccn",
      factor = FALSE,
      names = list(value = "acr_date"),
      na.rm = TRUE
    ) |>
    collapse::funique()

  d <- collapse::ss(d, j = c(1L, 3L))

  y <- collapse::join(i, d, on = "fac_ccn", verbose = 0L)

  collapse::recode_char(
    y$acr_org,
    "a2la_ind" = "A2LA",
    "aabb_ind" = "AABB",
    "aoa_ind" = "AOA",
    "ashi_ind" = "ASHI-HLA",
    "cap_ind" = "CAP",
    "cola_ind" = "COLA",
    "jcaho_ind" = "JCAHO",
    default = NA_character_,
    set = TRUE
  )

  collapse::gvr(x, col_acr) <- NULL

  collapse::join(x, y, on = "fac_ccn", verbose = 0L, multiple = TRUE)
}

#' @autoglobal
#' @noRd
subgroup_pivot <- function(x) {
  y <- collapse::gvr(x, "^enid$|sub_") |>
    collapse::roworderv("enid") |>
    collapse::pivot(
      ids = c("enid", "sub_otxt"),
      factor = FALSE,
      names = list("subgroup", "ind"),
      na.rm = TRUE
    )

  y <- collapse::ss(y, y$ind %==% 1L, -4L)

  collapse::recode_char(
    y$subgroup,
    "sub_acute" = "Acute",
    "sub_gen" = "General",
    "sub_spec" = "Specialty",
    "sub_adu" = "ADH",
    "sub_child" = "Child",
    "sub_ltc" = "LTC",
    "sub_psy" = "Psych",
    "sub_irf" = "IRF",
    "sub_stc" = "STC",
    "sub_sba" = "Swing-Bed",
    "sub_psu" = "Psych Unit",
    "sub_iru" = "IRF Unit",
    "sub_oth" = "Other",
    default = NA_character_,
    set = TRUE
  )

  # o <- cheapr::which_(
  #   y$subgroup %==% "Other" &
  #   cheapr::which_not_na(y$sub_otxt)
  # )

  # if (empty(o)) {
  # Handle Other Text
  # }

  collapse::gvr(x, "sub_") <- NULL

  y <- collapse::ss(y, j = c(1, 3)) |>
    collapse::funique() |>
    collapse::roworderv(c("enid", "subgroup")) |>
    collapse::fcountv("enid", add = TRUE)

  z <- cheapr::sset(y, cheapr::which_(y$N > 1L), 1:2)
  y <- cheapr::sset(y, cheapr::which_(y$N == 1L), 1:2)

  g <- collapse::GRP(z$enid)
  y <- collapse::gsplit(z$subgroup, g) |>
    set_names(collapse::GRPnames(g)) |>
    purrr::map_chr(\(x) paste0(x, collapse = ", ")) |>
    cheapr::as_df() |>
    set_names(c("enid", "subgroup")) |>
    collapse::rowbind(y) |>
    collapse::roworderv(c("enid", "subgroup"))

  collapse::join(x, y, on = "enid", verbose = 0L)
}
