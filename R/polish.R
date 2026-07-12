#' @noRd
polish <- S7::new_generic("polish", "x")

#' @noRd
S7::method(polish, S7::class_integer | Endpoint) <- function(x) {
  invisible(x)
}

#' @noRd
S7::method(polish, S7::class_list) <- function(x) {
  cli::cli_alert_warning("Using default {.cls polish.list} method")
  x <- collapse::rowbind(x, fill = TRUE)
  polish(x)
}


#' @noRd
S7::method(polish, S7::class_data.frame) <- function(x) {
  cli::cli_alert_warning("Using default {.cls polish.data.frame} method")
  replace_nz(x)
  add_class(x)
}

#' @noRd
S7::method(polish, s3_affiliations) <- function(x) {
  collapse::settfmv(x, "npi", as.integer)
  collapse::recode_char(
    x[["facility_type"]],
    "Dialysis facility" = "ESRD",
    "Home health agency" = "HHA",
    "Hospice" = "Hospice",
    "Hospital" = "Hospital",
    "Inpatient rehabilitation facility" = "IRF",
    "Long-term care hospital" = "LTCH",
    "Nursing home" = "NH",
    "Skilled nursing facility" = "SNF",
    default = NA_character_,
    set = TRUE
  )
  set_rename(x)
  get_columns(x)
}

#' @noRd
S7::method(polish, s3_ambulatory) <- function(x) {
  collapse::settfmv(
    x,
    c(
      "number_of_sampled_patients",
      "number_of_completed_surveys",
      "patients_rating_of_the_facility_linear_mean_score"
    ),
    as.integer
  )
  set_rename(x)
  get_columns(x)
}

#' @noRd
S7::method(polish, s3_clia) <- function(x) {
  recode(x)
  set_rename(x)
  get_columns(x) |>
    rc_bin(collapse::gvr(x, "elig$|_multi$", return = 2L)) |>
    rc_ymd2(collapse::gvr(x, "_date$", return = 2L)) |>
    rc_combine("address", "add_2") |>
    rc_combine("name", "fac_2") |>
    pivot_multi_site() |>
    pivot_accredit()
}

#' @noRd
S7::method(polish, s3_clinician) <- function(x) {
  collapse::settfmv(x, c("npi", "grd_yr", "num_org_mem"), as.integer)
  set_rename(x)
  get_columns(x) |>
    rc_combine("address", "add_2") |>
    rc_combine("specialty", "spec_other")
}

#' @noRd
S7::method(polish, s3_dialysis) <- function(x) {
  collapse::settfmv(x, c("five_star", "network"), as.integer)
  set_rename(x)
  get_columns(x) |>
    rc_ymd("cert_date") |>
    rc_combine("address", "add_2")
}

#' @noRd
S7::method(polish, s3_enrolled) <- function(x) {
  collapse::settfmv(x, "NPI", as.integer)
  set_rename(x)
  get_columns(x) |>
    rc_bin("multi")
}

#' @noRd
S7::method(polish, s3_facility) <- function(x) {
  x <- rowbind2(x, "fac_type", fill = TRUE) |>
    add_class("facility")

  collapse::settfmv(x, "NPI", as.integer)

  set_rename(x)
  get_columns(x) |>
    rc_combine("address", "add_2") |>
    rc_bin("multi") |>
    rc_ymd("inc_date") |>
    rc_other("org_type", "org_otxt")
}

#' @noRd
S7::method(polish, s3_hospital) <- function(x) {
  recode(x)
  set_rename(x)
  get_columns(x) |>
    rc_combine("address", "add_2") |>
    rc_other("org_type", "org_otxt") |>
    rc_other("loc_type", "loc_otxt") |>
    rc_ymd(collapse::gvr(x, "_date$", return = 2L)) |>
    rc_bin(collapse::gvr(x, "multi|_ind$", return = 2L)) |>
    pivot_subgroup() |>
    rc_ptype()
}

#' @noRd
S7::method(polish, s3_hospital2) <- function(x) {
  collapse::setv(x[["hospital_overall_rating"]], "Not Available", NA)
  collapse::settfmv(x, "hospital_overall_rating", as.integer)
  set_rename(x)
  get_columns(x)
}

#' @noRd
S7::method(polish, s3_long_term) <- function(x) {
  collapse::settfmv(x, "total_number_of_beds", as.integer)
  set_rename(x)
  get_columns(x) |>
    rc_combine("address", "add_2") |>
    rc_mdy("cert_date")
}

#' @noRd
S7::method(polish, s3_nursing) <- function(x) {
  collapse::settfmv(
    x,
    c(
      "number_of_certified_beds",
      "number_of_facilities_in_chain",
      "overall_rating",
      "number_of_fines",
      "number_of_payment_denials",
      "total_number_of_penalties"
    ),
    as.integer
  )
  collapse::settfmv(
    x,
    c(
      "average_number_of_residents_per_day",
      "chain_average_overall_5star_rating",
      "total_amount_of_fines_in_dollars",
      "latitude",
      "longitude"
    ),
    as.double
  )
  set_rename(x)
  get_columns(x) |>
    rc_ymd("cert_date")
}

#' @noRd
S7::method(polish, s3_opted_out) <- function(x) {
  collapse::settfmv(x, "NPI", as.integer)
  set_rename(x)
  get_columns(x) |>
    rc_combine("address", "add_2") |>
    rc_bin("order_refer") |>
    rc_mdy(c("start_date", "end_date", "updated"))
}

#' @noRd
S7::method(polish, s3_order_refer) <- function(x) {
  collapse::settfmv(x, "NPI", as.integer)
  set_rename(x)
  get_columns(x) |>
    rc_bin(collapse::gvr(x, "_ind$", return = 2L))
}

#' @noRd
S7::method(polish, s3_owner) <- function(x) {
  x <- rowbind2(x, "fac_type", fill = TRUE) |>
    add_class("owner")

  recode(x)
  set_rename(x)
  get_columns(x) |>
    rc_combine("address", "add_2") |>
    rc_bin(collapse::gvr(x, "_ind$", return = 2L)) |>
    rc_ymd("own_date") |>
    pivot_owner()
}

#' @noRd
S7::method(polish, s3_pending) <- function(x) {
  x <- rowbind2(x, "prov_type", fill = TRUE) |>
    add_class("pending") |>
    rc_trim()

  collapse::settfmv(x, "NPI", as.integer)
  set_rename(x)
  get_columns(x)
}

#' @noRd
S7::method(polish, s3_psych) <- function(x) {
  set_rename(x)
  get_columns(x)
}

#' @noRd
S7::method(polish, s3_reassigned) <- function(x) {
  collapse::settfmv(
    x,
    c(
      "Individual NPI",
      "Individual Total Employer Associations",
      "Group Reassignments and Physician Assistants"
    ),
    as.integer
  )
  set_rename(x)
  get_columns(x)
}

#' @noRd
S7::method(polish, s3_rehab) <- function(x) {
  set_rename(x)
  get_columns(x) |>
    rc_combine("address", "add_2") |>
    rc_mdy("cert_date")
}

#' @noRd
S7::method(polish, s3_revoked) <- function(x) {
  collapse::settfmv(x, "NPI", as.integer)
  set_rename(x)
  get_columns(x) |>
    rc_bin("multi") |>
    rc_trim() |>
    rc_ymd(c("start_date", "end_date"))
}

#' @noRd
S7::method(polish, s3_spending) <- function(x) {
  collapse::setv(x[["score"]], "Not Available", NA)
  collapse::settfmv(x, "score", as.double)
  set_rename(x)
  get_columns(x)
}

#' @noRd
S7::method(polish, s3_spending2) <- function(x) {
  x[["percent_of_spndg_hospital"]] <- gsub(
    "%",
    "",
    x[["percent_of_spndg_hospital"]],
    fixed = TRUE
  )
  x[["percent_of_spndg_state"]] <- gsub(
    "%",
    "",
    x[["percent_of_spndg_state"]],
    fixed = TRUE
  )
  x[["percent_of_spndg_national"]] <- gsub(
    "%",
    "",
    x[["percent_of_spndg_national"]],
    fixed = TRUE
  )
  collapse::settfmv(
    x,
    c(
      "percent_of_spndg_hospital",
      "percent_of_spndg_state",
      "percent_of_spndg_national"
    ),
    as.double
  )

  collapse::settfmv(
    x,
    c(
      "avg_spndg_per_ep_hospital",
      "avg_spndg_per_ep_state",
      "avg_spndg_per_ep_national"
    ),
    as.integer
  )
  set_rename(x)
  get_columns(x)
}

#' @noRd
S7::method(polish, s3_supplier) <- function(x) {
  collapse::settfmv(x, "provider_id", as.integer)
  collapse::settfmv(x, c("latitude", "longitude"), as.double)
  set_rename(x)
  get_columns(x) |>
    rc_bin(c("par", "cba")) |>
    rc_combine("address", "add_2") |>
    rc_ymd("start_date")
}

#' @noRd
S7::method(polish, s3_transparency) <- function(x) {
  collapse::settfmv(x, "Case_ID", as.integer)
  set_rename(x)
  get_columns(x) |>
    rc_ymd("action_date") |>
    rc_trim()
}

#' @noRd
S7::method(polish, s3_veteran) <- function(x) {
  collapse::setv(x[["hospital_overall_rating"]], "Not Available", NA)
  collapse::settfmv(x, "hospital_overall_rating", as.integer)
  set_rename(x)
  get_columns(x) |>
    rc_bin("emergency")
}

#' @noRd
S7::method(polish, s3_utilization) <- function(x) {
  x <- rowbind2(x, "year", fill = TRUE) |>
    add_class("utilization")

  collapse::settfmv(
    x,
    c(
      "year",
      "Rndrng_NPI",
      "Tot_HCPCS_Cds",
      "Tot_Benes",
      "Tot_Srvcs",
      "Tot_Sbmtd_Chrg",
      "Bene_Avg_Age",
      "Bene_Dual_Cnt",
      "Bene_Ndual_Cnt"
    ),
    as.integer
  )
  collapse::settfmv(
    x,
    c(
      "Bene_Avg_Risk_Scre",
      "Tot_Mdcr_Alowd_Amt",
      "Tot_Mdcr_Pymt_Amt"
    ),
    as.double
  )

  set_rename(x)
  get_columns(x) |>
    rc_bin("par") |>
    rc_combine("address", "add_2") |>
    collapse::roworderv(c("year", "npi"))
}

#' @noRd
S7::method(polish, s3_services) <- function(x) {
  x <- rowbind2(x, "year", fill = TRUE) |>
    add_class("services")

  collapse::settfmv(
    x,
    c(
      "year",
      "Rndrng_NPI",
      "Tot_Benes",
      "Tot_Srvcs",
      "Tot_Bene_Day_Srvcs",
      "Avg_Sbmtd_Chrg"
    ),
    as.integer
  )
  collapse::settfmv(
    x,
    c(
      "Avg_Mdcr_Alowd_Amt",
      "Avg_Mdcr_Pymt_Amt",
      "Avg_Mdcr_Stdzd_Amt"
    ),
    as.double
  )

  set_rename(x)
  get_columns(x) |>
    rc_bin("drug") |>
    collapse::roworderv(
      c("hcpcs", "year"),
      decreasing = c(TRUE, FALSE)
    )
}

#' @noRd
S7::method(polish, s3_geography) <- function(x) {
  x <- rowbind2(x, "year", fill = TRUE) |>
    add_class("geography")

  collapse::settfmv(
    x,
    c(
      "year",
      "Tot_Rndrng_Prvdrs",
      "Tot_Benes",
      "Tot_Srvcs"
    ),
    as.integer
  )
  collapse::settfmv(
    x,
    c(
      "Avg_Sbmtd_Chrg",
      "Avg_Mdcr_Alowd_Amt",
      "Avg_Mdcr_Pymt_Amt"
    ),
    as.double
  )

  set_rename(x)
  get_columns(x) |>
    rc_bin("drug") |>
    collapse::roworderv(
      c("year", "hcpcs"),
      decreasing = c(TRUE, FALSE)
    )
}

#' @noRd
S7::method(polish, s3_inpatient) <- function(x) {
  x <- rowbind2(x, "year", fill = TRUE) |>
    add_class("inpatient")

  collapse::settfmv(
    x,
    c(
      "year",
      "Tot_Benes",
      "Tot_Dschrgs",
      "Tot_Cvrd_Days",
      "Tot_Days",
      "Bene_Dual_Cnt",
      "Bene_Ndual_Cnt"
    ),
    as.integer
  )
  collapse::settfmv(
    x,
    c(
      "Bene_Avg_Age",
      "Bene_Avg_Risk_Scre",
      "Tot_Submtd_Cvrd_Chrg",
      "Tot_Pymt_Amt",
      "Tot_Mdcr_Pymt_Amt"
    ),
    as.double
  )

  set_rename(x)
  get_columns(x) |>
    collapse::roworderv(c("year", "ccn"))
}

#' @noRd
S7::method(polish, s3_outpatient) <- function(x) {
  x <- rowbind2(x, "year", fill = TRUE) |>
    add_class("outpatient")

  collapse::settfmv(
    x,
    c(
      "year",
      "Bene_Cnt",
      "CAPC_Srvcs",
      "Outlier_Srvcs"
    ),
    as.integer
  )
  collapse::settfmv(
    x,
    c(
      "Avg_Tot_Sbmtd_Chrgs",
      "Avg_Mdcr_Pymt_Amt",
      "Avg_Mdcr_Alowd_Amt",
      "Avg_Mdcr_Outlier_Amt"
    ),
    as.double
  )

  set_rename(x)
  get_columns(x) |>
    collapse::roworderv(c("year", "ccn"))
}
