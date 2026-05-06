#' @noRd
RC_esrd <- function(x) {
  x <- collapse::av(x, address = combine_cols(x$add_1, x$add_2))
  collapse::gvr(x, "add_") <- NULL
  x
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
    rc_date_ymd("own_date") |>
    fqhc_owner_pivot()
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
    rc_date_ymd("own_date") |>
    fqhc_owner_pivot()
}

#' @noRd
RC_clia_term_type <- function(xcol) {
  collapse::recode_char(
    xcol,
    "00" = "Active",
    "01" = "Voluntary-Merger/Closure",
    "02" = "Voluntary-Reimbursement Dissatisfaction",
    "03" = "Voluntary-Termination Risk",
    "04" = "Voluntary-Other",
    "05" = "Involuntary-Health/Safety Failure",
    "06" = "Involuntary-Agreement Failure",
    "07" = "Other Status Change",
    "08" = "Fee Nonpayment (CLIA)",
    "09" = "Unsuccessful PT (CLIA)",
    "10" = "Other (CLIA)",
    "11" = "Incomplete Application (CLIA)",
    "12" = "Not Performing Tests (CLIA)",
    "13" = "Multiple to Single Site (CLIA)",
    "14" = "Shared Laboratory (CLIA)",
    "15" = "Failure to Renew Waiver PPM (CLIA)",
    "16" = "Duplicate CLIA (CLIA)",
    "17" = "Mail Returned Cert Ended (CLIA)",
    "20" = "Bankruptcy (CLIA)",
    "33" = "Accreditation Unconfirmed (CLIA)",
    "80" = "Awaiting State Approval",
    "99" = "OIG Do Not Activate (CLIA)",
    default = NA_character_,
    set = TRUE
  )
}

#' @noRd
RC_clia_cert_type <- function(xcol) {
  collapse::recode_char(
    xcol,
    "1" = "Compliance",
    "2" = "Waiver",
    "3" = "Accreditation",
    "4" = "PPM",
    "9" = "Registration",
    default = NA_character_,
    set = TRUE
  )
}

#' @noRd
RC_clia_own_type <- function(xcol) {
  collapse::recode_char(
    xcol,
    "01" = "Religious Affiliation",
    "02" = "Private",
    "03" = "Other",
    "04" = "Proprietary",
    "05" = "Validation",
    "05" = "Govt-City",
    "06" = "Govt-County",
    "07" = "Govt-State",
    "08" = "Govt-Federal",
    "09" = "Govt-Other",
    "10" = "Unknown",
    default = NA_character_,
    set = TRUE
  )
}

#' @noRd
RC_clia_fac_type <- function(xcol) {
  collapse::recode_char(
    xcol,
    "01" = "Ambulance",
    "02" = "ASC",
    "03" = "Ancillary Site",
    "04" = "ALF",
    "05" = "Blood Bank",
    "06" = "Community Clinic",
    "07" = "CORF",
    "08" = "ESRD",
    "09" = "FQHC",
    "10" = "Health Fair",
    "11" = "HMO",
    "12" = "HHA",
    "13" = "Hospice",
    "14" = "Hospital",
    "15" = "Independent",
    "16" = "Industrial",
    "17" = "Insurance",
    "18" = "ICF-IID",
    "19" = "Mobile Lab",
    "20" = "Pharmacy",
    "21" = "Physician",
    "22" = "Other Practitioner",
    "23" = "Prison",
    "24" = "Public Health",
    "25" = "RHC",
    "26" = "SHS",
    "27" = "SNF",
    "28" = "Tissue Bank",
    "29" = "Other",
    default = NA_character_,
    set = TRUE
  )
}

#' @noRd
RC_clia_act_type <- function(xcol) {
  collapse::recode_char(
    xcol,
    "1" = "Initial",
    "2" = "Recertification",
    "3" = "Termination",
    "4" = "Change of Ownership",
    "5" = "Validation",
    "8" = "Full Survey After Complaint",
    default = NA_character_,
    set = TRUE
  )
}
