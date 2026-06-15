#' @noRd
collapse_rows <- function(x, key, var) {
  collapse::rsplit(x[[var]], x[[key]]) |>
    purrr::map(\(x) paste0(x, collapse = ", ")) |>
    collapse::unlist2d() |>
    rlang::set_names(c(key, var))
}

#' @noRd
pivot2 <- function(
  x,
  key_column,
  regex_column,
  new_column,
  other_column = NULL
) {
  rlang::check_required(key_column)
  rlang::check_required(regex_column)
  rlang::check_required(new_column)

  keys <- c(key_column, other_column)

  x <- cheapr::col_c(
    collapse::gvr(x, keys),
    collapse::gvr(x, regex_column)
  )

  x <- collapse::pivot(
    data = x,
    ids = keys,
    names = list(variable = new_column, value = "ind"),
    na.rm = TRUE
  ) |>
    collapse::funique() |>
    collapse::roworderv(key_column)

  collapse::settfmv(x, new_column, as.character)

  return(x)
}

#' @noRd
pivot_order_refer <- function(x) {
  y <- pivot2(x, "npi", "_ind$", "order_refer")

  collapse::gvr(x, "_ind$") <- NULL

  if (nrow0(y)) {
    return(add_empty(x, "order_refer"))
  }

  y <- collapse::ss(
    y,
    y[["ind"]] %==% 1L,
    c("npi", "order_refer"),
    check = FALSE
  )

  if (nrow0(y)) {
    return(add_empty(x, "order_refer"))
  }

  collapse::recode_char(
    y[["order_refer"]],
    "ptb_ind" = "Part B",
    "dme_ind" = "DME",
    "hha_ind" = "HHA",
    "pmd_ind" = "PMD",
    "hsp_ind" = "Hospice",
    default = NA_character_,
    set = TRUE
  )

  if (is_unique(y[["npi"]])) {
    return(join2(x, y, on = "npi"))
  }
  join2(x, collapse_rows(y, "npi", "order_refer"), on = "npi")
}

#' @noRd
pivot_multi_site <- function(x) {
  y <- pivot2(x, "npi", "_multi$", "multi")

  collapse::gvr(x, "_multi$") <- NULL

  if (nrow0(y)) {
    return(add_empty(x, "multi"))
  }

  y <- collapse::ss(y, y$ind %==% 1L, 1:2)

  if (nrow0(y)) {
    return(add_empty(x, "multi"))
  }

  collapse::recode_char(
    x[["multi"]],
    "site_multi" = "Applied",
    "hosp_multi" = "Campus",
    "non_multi" = "Non-profit",
    "tmp_multi" = "Temporary",
    default = NA_character_,
    set = TRUE
  )

  if (is_unique(y$fac_ccn)) {
    return(join2(x, y, on = "fac_ccn"))
  }

  join2(x, collapse_rows(y, "fac_ccn", "multi"), on = "fac_ccn")
}

#' @noRd
pivot_acr_org <- function(x) {
  y <- pivot2(x, "fac_ccn", "^acr_", "acr_org")

  collapse::gvr(x, "^acr_") <- NULL

  y <- collapse::ss(y, j = 1:2)

  if (nrow0(y)) {
    return(add_empty(x, "acr_org"))
  }

  collapse::recode_char(
    x[["acr_org"]],
    "acr_a2la_date" = "A2LA",
    "acr_aabb_date" = "AABB",
    "acr_aoa_date" = "AOA",
    "acr_ashi_date" = "ASHI-HLA",
    "acr_cap_date" = "CAP",
    "acr_cola_date" = "COLA",
    "acr_jcaho_date" = "JCAHO",
    default = NA_character_,
    set = TRUE
  )

  if (is_unique(y$fac_ccn)) {
    return(join2(x, y, on = "fac_ccn"))
  }

  join2(x, collapse_rows(y, "fac_ccn", "acr_org"), on = "fac_ccn")
}

#' @noRd
pivot_owner <- function(x) {
  y <- pivot2(x, "pac", "_ind$", "own_type", "own_otxt")

  collapse::gvr(x, "_ind$|_otxt$") <- NULL

  if (nrow0(y)) {
    return(add_empty(x, "own_type"))
  }

  y <- collapse::ss(y, y$ind %==% 1L, 1:3)

  if (nrow0(y)) {
    return(add_empty(x, "own_type"))
  }

  collapse::recode_char(
    x[["own_type"]],
    "acq_ind" = "Acquisition",
    "corp_ind" = "Corp",
    "llc_ind" = "LLC",
    "mps_ind" = "Prov/Supp",
    "msr_ind" = "Mgmt",
    "mst_ind" = "Staff",
    "hld_ind" = "Holding",
    "inv_ind" = "Investment",
    "fin_ind" = "Bank",
    "con_ind" = "Consult",
    "fp_ind" = "For-Profit",
    "np_ind" = "Non-Profit",
    "pe_ind" = "PE",
    "reit_ind" = "Real Estate",
    "cho_ind" = "Chain",
    "oth_ind" = "Other",
    "ano_ind" = "Another Org/Ind",
    default = NA_character_,
    set = TRUE
  )

  y <- rc_other(y, "own_type", "own_otxt")
  y <- collapse::funique(y)

  if (is_unique(y$pac)) {
    return(join2(x, y, on = "pac"))
  }

  join2(x, collapse_rows(y, "pac", "own_type"), on = "pac")
}

#' @noRd
pivot_subgroup <- function(x) {
  y <- pivot2(x, "enid", "^sub_", "sub_group", "sg_otxt")

  collapse::gvr(x, "^sub_|^sg_") <- NULL

  if (nrow0(y)) {
    return(add_empty(x, "sub_group"))
  }

  y <- collapse::ss(y, y$ind %==% 1L, c("enid", "sg_otxt", "sub_group"))

  if (nrow0(y)) {
    return(add_empty(x, "sub_group"))
  }

  collapse::recode_char(
    x[["sub_group"]],
    "sub_acute" = "Acute",
    "sub_gen" = "General",
    "sub_spec" = "Specialty",
    "sub_adu" = "ADH",
    "sub_child" = "Children's",
    "sub_ltc" = "Long-Term",
    "sub_psy" = "Psychiatric",
    "sub_irf" = "IRF",
    "sub_stc" = "Short-Term",
    "sub_sba" = "Swing-Bed Unit",
    "sub_psu" = "Psychiatric Unit",
    "sub_iru" = "Rehab Unit",
    "sub_oth" = "Other",
    default = NA_character_,
    set = TRUE
  )

  y <- rc_other(y, "sub_group", "sg_otxt")
  y <- collapse::funique(y)

  if (is_unique(y$enid)) {
    return(join2(x, y, on = "enid"))
  }

  join2(x, collapse_rows(y, "enid", "sub_group"), on = "enid")
}

#' @noRd
pivot_quality <- function(x) {
  y <- pivot2(x, "npi", "_ind$", "indicators", "year")

  collapse::gvr(x, "_ind$") <- NULL

  y <- collapse::ss(y, y$ind %==% 1L, 1:3)

  if (nrow0(y)) {
    return(add_empty(x, "indicators"))
  }

  collapse::recode_char(
    x[["indicators"]],
    "asc_ind" = "ASC-Based",
    "extreme_ind" = "Extreme Hardship",
    "engaged_ind" = "Engaged",
    "facility_ind" = "Facility-Based",
    "fac_score_ind" = "Received Facility Score",
    "hospital_ind" = "Hospital-Based",
    "hpsa_ind" = "HPSA Clinician",
    "non_patient_ind" = "Non-Patient Facing",
    "non_report_ind" = "Non-Reporting",
    "opted_ind" = "Opted Into MIPS",
    "rural_ind" = "Rural Clinician",
    "safety_ind" = "Safety Net",
    "small_ind" = "Small Practice",
    default = NA_character_,
    set = TRUE
  )

  if (is_unique(y$npi)) {
    return(join2(x, y, on = c("year", "npi")))
  }

  y <- collapse::ss(y, collapse::whichNA(y$indicators, invert = TRUE))

  y <- collapse::rsplit(y, y$year) |>
    purrr::map(\(x) collapse_rows(x, "npi", "indicators")) |>
    rowbind2("year") |>
    collapse::qTBL()

  join2(x, y, on = c("year", "npi"))
}
