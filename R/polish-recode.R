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

#' @noRd
RC_clia <- function(x) {
  x <- collapse::av(
    x,
    facility_name = combine_cols(x$fac_name_1, x$fac_name_2),
    address = combine_cols(x$add_1, x$add_2),
    phone = combine_cols(x$phone_1, x$phone_1),
    cert_type = clia_cert_type(x$cert_type),
    own_type = clia_own_type(x$own_type),
    fac_type = clia_fac_type(x$fac_type),
    act_type = clia_act_type(x$act_type)
  )

  collapse::gvr(x, "fac_name_|add_|phone_") <- NULL

  rc_bin(x, collapse::gvr(x, "_ind$", return = 3L)) |>
    rc_date_ymd2(collapse::gvr(x, "_date$", return = 3L)) |>
    rc_integer(
      c(
        "chown",
        "sites",
        "alabs",
        "srv_vol",
        "acr_vol",
        "cmp_vol",
        "ppm_vol",
        "wvd_vol"
      )
    )
}

#' @noRd
RC_esrd <- function(x) {
  x <- collapse::av(x, address = combine_cols(x$add_1, x$add_2))
  collapse::gvr(x, "add_") <- NULL

  rc_integer(x, c("network", "stars")) |>
    rc_date_ymd("cert_date")
}

#' @noRd
RC_clinicians <- function(x) {
  x <- collapse::av(
    x,
    org_add = combine_cols(x$add_1, x$add_2),
    specialty = combine_cols(x$specialty, x$spec_other)
  )
  collapse::gvr(x, "add_|spec_") <- NULL

  rc_integer(x, c("npi", "grad_year", "org_mem"))
}

#' @noRd
RC_hospitals <- function(x) {
  x <- collapse::av(x, address = combine_cols(x$add_1, x$add_2))
  collapse::gvr(x, "add_") <- NULL

  rc_integer(x, "npi") |>
    rc_date_ymd(collapse::gvr(x, "_date$", return = 3L)) |>
    rc_bin(collapse::gvr(x, "multi|^sub_", return = 3L))
}

#' @noRd
RC_opt_out <- function(x) {
  x <- collapse::av(x, address = combine_cols(x$add_1, x$add_2))
  collapse::gvr(x, "add_") <- NULL

  rc_integer(x, "npi") |>
    rc_bin("order_refer") |>
    rc_date_mdy(c("start_date", "end_date", "updated"))
}

#' @noRd
RC_rhc_enroll <- function(x) {
  x <- collapse::av(x, address = combine_cols(x$add_1, x$add_2))
  collapse::gvr(x, "add_") <- NULL

  rc_integer(x, "npi") |>
    rc_bin("multi") |>
    rc_date_ymd("inc_date")
}

#' @noRd
RC_rhc_owner <- function(x) {
  x <- collapse::av(x, own_add = combine_cols(x$own_add_1, x$own_add_2))
  collapse::gvr(x, "own_add_") <- NULL

  rc_integer(x, "own_code") |>
    rc_double("own_pct") |>
    rc_bin(collapse::gvr(x, "multi|_ind$", return = 3L)) |>
    rc_date_ymd("own_date")
}

#' @noRd
RC_fqhc_enroll <- function(x) {
  x <- collapse::av(x, address = combine_cols(x$add_1, x$add_2))
  collapse::gvr(x, "add_") <- NULL

  rc_integer(x, "npi") |>
    rc_bin("multi") |>
    rc_date_ymd("inc_date")
}

#' @noRd
RC_fqhc_owner <- function(x) {
  x <- collapse::av(x, own_add = combine_cols(x$own_add_1, x$own_add_2))
  collapse::gvr(x, "own_add_") <- NULL

  rc_integer(x, "own_code") |>
    rc_double("own_pct") |>
    rc_bin(collapse::gvr(x, "multi|_ind$", return = 3L)) |>
    rc_date_ymd("own_date")
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
    return(x)
  }

  y <- collapse::ss(y, y$ind %==% 1L)

  collapse::gvr(y, "var") <- cheapr::val_match(
    collapse::gvr(y, "var"),
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
  return(y)
}
