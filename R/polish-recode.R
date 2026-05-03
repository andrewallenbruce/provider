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

    # region = combine_cols(x$reg_cd, x$reg_st),
    # ssa = combine_cols(x$ssa_st, x$ssa_cty),
    # fips = combine_cols(x$fips_st, x$fips_cty),
    # cbsa = combine_cols(x$cbsa_1, x$cbsa_2)
  )

  collapse::gv(
    x,
    c(
      "fac_name_1",
      "fac_name_2",
      "add_1",
      "add_2",
      "phone_1",
      "phone_2"
      # "reg_cd",
      # "reg_st",
      # "ssa_st",
      # "ssa_cty",
      # "fips_st",
      # "fips_cty",
      # "cbsa_1",
      # "cbsa_2"
    )
  ) <- NULL

  rc_bin(x, collapse::gvr(x, "_ind$", return = 2L)) |>
    rc_date_ymd2(collapse::gvr(x, "_date$", return = 2L)) |>
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
  collapse::gv(x, c("add_1", "add_2")) <- NULL

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
  collapse::gv(x, c("add_1", "add_2", "spec_other")) <- NULL

  rc_integer(x, c("npi", "grad_year", "org_mem"))
}

#' @noRd
RC_hospitals <- function(x) {
  x <- collapse::av(x, address = combine_cols(x$add_1, x$add_2))
  collapse::gv(x, c("add_1", "add_2")) <- NULL

  rc_integer(x, "npi") |>
    rc_date_ymd(c("inc_date", "reh_date")) |>
    rc_bin(collapse::gvr(x, "multi|^sub_", return = 2L))
}

#' @noRd
RC_opt_out <- function(x) {
  x <- collapse::av(x, address = combine_cols(x$add_1, x$add_2))
  collapse::gv(x, c("add_1", "add_2")) <- NULL

  rc_integer(x, "npi") |>
    rc_bin("order_refer") |>
    rc_date_mdy(c("start_date", "end_date", "updated"))
}

#' @noRd
RC_rhc_enroll <- function(x) {
  x <- collapse::av(x, address = combine_cols(x$add_1, x$add_2))
  collapse::gv(x, c("add_1", "add_2")) <- NULL

  rc_integer(x, "npi") |>
    rc_bin("multi") |>
    rc_date_ymd("inc_date")
}

#' @noRd
RC_rhc_owner <- function(x) {
  x <- collapse::av(x, own_add = combine_cols(x$own_add_1, x$own_add_2))
  collapse::gv(x, c("own_add_1", "own_add_2")) <- NULL

  rc_integer(x, "own_code") |>
    rc_double("own_pct") |>
    rc_bin(collapse::gvr(x, "multi|_ind$", return = 2L)) |>
    rc_date_ymd("own_date")
}

#' @noRd
RC_fqhc_enroll <- function(x) {
  x <- collapse::av(x, address = combine_cols(x$add_1, x$add_2))
  collapse::gv(x, c("add_1", "add_2")) <- NULL

  rc_integer(x, "npi") |>
    rc_bin("multi") |>
    rc_date_ymd("inc_date")
}

#' @noRd
RC_fqhc_owner <- function(x) {
  x <- collapse::av(x, own_add = combine_cols(x$own_add_1, x$own_add_2))
  collapse::gv(x, c("own_add_1", "own_add_2")) <- NULL

  rc_integer(x, "own_code") |>
    rc_double("own_pct") |>
    rc_bin(collapse::gvr(x, "multi|_ind$", return = 2L)) |>
    rc_date_ymd("own_date")
}
