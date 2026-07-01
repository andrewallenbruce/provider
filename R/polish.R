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
S7::method(polish, s3_clia) <- function(x) {
  recode(x)
  set_rename(x)
  get_columns(x) |>
    rc_bin(collapse::gvr(x, "eligible$|_multi$", return = 2L)) |>
    rc_ymd2(collapse::gvr(x, "_date$", return = 2L)) |>
    rc_combine("address", "add_2") |>
    rc_combine("fac_name", "fac_2") |>
    pivot_multi_site() |>
    pivot_acr_org()
}

#' @noRd
S7::method(polish, s3_clinicians) <- function(x) {
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
S7::method(polish, s3_hospitals) <- function(x) {
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
S7::method(polish, s3_hospitals2) <- function(x) {
  collapse::setv(x[["hospital_overall_rating"]], "Not Available", NA)
  collapse::settfmv(x, "hospital_overall_rating", as.integer)
  set_rename(x)
  get_columns(x)
}

#' @noRd
S7::method(polish, s3_opt_out) <- function(x) {
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
    rc_ymd("asc_date") |>
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
S7::method(polish, s3_providers) <- function(x) {
  collapse::settfmv(x, "NPI", as.integer)
  set_rename(x)
  get_columns(x) |>
    rc_bin("multi")
}

#' @noRd
S7::method(polish, s3_reassignments) <- function(x) {
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
S7::method(polish, s3_revocations) <- function(x) {
  collapse::settfmv(x, "NPI", as.integer)
  set_rename(x)
  get_columns(x) |>
    rc_bin("multi") |>
    rc_trim() |>
    rc_ymd(c("start_date", "end_date"))
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
  collapse::gv(
    x,
    c(
      "year",
      "npi",
      "hcpcs",
      "description",
      "drug",
      "pos",
      "patients",
      "services",
      "charge",
      "allowed",
      "payment"
    )
  ) |>
    rc_bin("drug") |>
    collapse::roworderv(
      c("hcpcs", "year"),
      decreasing = c(TRUE, FALSE)
    )
}
