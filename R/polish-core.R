#' @noRd
add_class <- function(x, endpoint) {
  structure(x, class = c(endpoint, "tbl_df", "tbl", "data.frame"))
}

#' @noRd
rename_with <- function(x, nm) {
  if (rlang::is_null(nm)) {
    return(x)
  }
  collapse::rnm(x, nm, .nse = FALSE) |>
    collapse::gv(unlist_(nm))
  # collapse::setrename(x, nm, .nse = FALSE)
  # collapse::gv(x, unlist_(nm))
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

#' @noRd
fqhc_owner_pivot <- function(x) {
  y <- collapse::gvr(x, "own_pac|_ind$") |>
    collapse::pivot(
      ids = "own_pac",
      factor = FALSE,
      names = list(variable = "var", value = "ind"),
      na.rm = TRUE
    )

  if (nrow(x) == 0L) {
    collapse::gvr(x, "_ind$") <- NULL
    x <- collapse::av(x, var = rep.int(NA_character_, nrow(x)))
    return(x)
  }

  y <- collapse::ss(y, y$ind %==% 1L)

  y$var <- cheapr::val_match(
    y$var,
    "acq_ind" ~ "Created for Aquisition",
    "corp_ind" ~ "Corporation",
    "llc_ind" ~ "LLC",
    "mps_ind" ~ "Medical Provider/Supplier",
    "msr_ind" ~ "Management Services Company",
    "mst_ind" ~ "Medical Staffing Company",
    "hld_ind" ~ "Holding Company",
    "inv_ind" ~ "Investment Firm",
    "fin_ind" ~ "Financial Institution",
    "con_ind" ~ "Consulting Firm",
    "fp_ind" ~ "For Profit",
    "np_ind" ~ "Non Profit",
    "pe_ind" ~ "Private Equity",
    "reit_ind" ~ "REIT",
    "cho_ind" ~ "Chain Home Office",
    "oth_ind" ~ "Other",
    "ano_ind" ~ "Owned by Another Org/Ind",
    .default = NA_character_
  )

  collapse::gv(y, "ind") <- NULL
  collapse::gvr(x, "_ind$") <- NULL
  y <- collapse::funique(y)
  x <- collapse::join(x, y, on = "own_pac", verbose = 0L)
  return(x)
}

#' @noRd
clia_fac_type <- function(x) {
  cheapr::val_match(
    x,
    "01" ~ "Ambulance",
    "02" ~ "ASC",
    "03" ~ "Ancillary Site",
    "04" ~ "ALF",
    "05" ~ "Blood Bank",
    "06" ~ "Community Clinic",
    "07" ~ "CORF",
    "08" ~ "ESRD",
    "09" ~ "FQHC",
    "10" ~ "Health Fair",
    "11" ~ "HMO",
    "12" ~ "HHA",
    "13" ~ "Hospice",
    "14" ~ "Hospital",
    "15" ~ "Independent",
    "16" ~ "Industrial",
    "17" ~ "Insurance",
    "18" ~ "ICF-IID",
    "19" ~ "Mobile Lab",
    "20" ~ "Pharmacy",
    "21" ~ "Physician",
    "22" ~ "Other Practitioner",
    "23" ~ "Prison",
    "24" ~ "Public Health",
    "25" ~ "RHC",
    "26" ~ "SHS",
    "27" ~ "SNF",
    "28" ~ "Tissue Bank",
    "29" ~ "Other",
    .default = NA_character_
  )
}

#' @noRd
clia_cert_type <- function(x) {
  cheapr::val_match(
    x,
    "1" ~ "Compliance",
    "2" ~ "Waiver",
    "3" ~ "Accreditation",
    "4" ~ "PPM",
    "9" ~ "Registration",
    .default = NA_character_
  )
}

#' @noRd
clia_act_type <- function(x) {
  cheapr::val_match(
    x,
    "1" ~ "Initial",
    "2" ~ "Recertification",
    "3" ~ "Termination",
    "4" ~ "Change of Ownership",
    "5" ~ "Validation",
    "8" ~ "Full Survey After Complaint",
    .default = NA_character_
  )
}

#' @noRd
clia_own_type <- function(x) {
  cheapr::val_match(
    x,
    "01" ~ "Religious Affiliation",
    "02" ~ "Private",
    "03" ~ "Other",
    "04" ~ "Proprietary",
    "05" ~ "Validation",
    "05" ~ "Govt-City",
    "06" ~ "Govt-County",
    "07" ~ "Govt-State",
    "08" ~ "Govt-Federal",
    "09" ~ "Govt-Other",
    "10" ~ "Unknown",
    .default = NA_character_
  )
}
