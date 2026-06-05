#' @noRd
polish <- S7::new_generic("polish", "x")

#' @noRd
S7::method(polish, S7::class_integer) <- function(x) {
  invisible(x)
}

#' @noRd
S7::method(polish, S7::class_data.frame) <- function(x) {
  cli::cli_alert_warning("Using default {.cls polish} method")
  add_class(x) |>
    replace_nz()
}

#' @noRd
S7::method(polish, S7::new_S3_class("quality")) <- function(x) {
  a <- b <- c <- list()

  if (quality_has(x, 2017)) {
    a <- quality_get(x, 2017)
  }
  if (quality_has(x, 2022)) {
    b <- quality_get(x, 2022)
  }
  if (quality_has(x, 2023)) {
    c <- quality_get(x, 2023)
  }

  x <- collapse::rowbind(a, b, c, fill = TRUE)

  set_integer(x, "year")
  set_integer(x, "npi")
  set_integer(x, "size")
  set_integer(x, "years")
  set_integer(x, "patients")
  set_integer(x, "charges")
  set_integer(x, "services")
  collapse::settfmv(x, "adjustment", as.numeric)
  collapse::settfmv(x, "final_score", as.numeric)
  collapse::settfmv(x, "complex_bonus", as.numeric)
  collapse::settfmv(x, "qa_score", as.numeric)
  collapse::settfmv(x, "pi_score", as.numeric)
  collapse::settfmv(x, "ia_score", as.numeric)
  collapse::settfmv(x, "cost_score", as.numeric)
  collapse::settfmv(x, "qi_bonus", as.numeric)

  add_class(x, "quality") |>
    collapse::roworderv(c("year", "npi"))
}

#' @noRd
S7::method(polish, S7::new_S3_class("affiliations")) <- function(x) {
  set_integer(x, "npi")
  rename_with(x, "affiliations")
}

#' @noRd
S7::method(polish, S7::new_S3_class("clia")) <- function(x) {
  rc_clia(x, "CLIA_TRMNTN_CD")
  rc_clia(x, "CRTFCT_TYPE_CD")
  rc_clia(x, "GNRL_FAC_TYPE_CD")
  rc_clia(x, "GNRL_CNTL_TYPE_CD")
  rc_clia(x, "CRTFCTN_ACTN_TYPE_CD")
  set_integer(x, "CHOW_CNT")
  set_integer(x, "DRCTLY_AFLTD_LAB_CNT")
  set_integer(x, "LAB_SITE_CNT")
  rename_with(x, "clia") |>
    rc_bin(collapse::gvr(x, "_ind$|_multi$", return = 2L)) |>
    rc_ymd2(collapse::gvr(x, "_date$", return = 2L)) |>
    rc_address() |>
    rc_address("fac_name", "fac_2") |>
    pivot_multi_site() |>
    pivot_acr_org()
}

#' @noRd
S7::method(polish, S7::new_S3_class("clinicians")) <- function(x) {
  set_integer(x, "npi")
  set_integer(x, "grd_yr")
  set_integer(x, "num_org_mem")
  rename_with(x, "clinicians") |>
    rc_address() |>
    rc_address("specialty", "spec_other")
}

#' @noRd
S7::method(polish, S7::new_S3_class("dialysis")) <- function(x) {
  set_integer(x, "five_star")
  set_integer(x, "network")
  rename_with(x, "dialysis") |>
    rc_ymd("cert_date") |>
    rc_address()
}

#' @noRd
S7::method(polish, S7::new_S3_class("facility")) <- function(x) {
  rowbind2(x, "fac_type", fill = TRUE) |>
    rename_with("facility") |>
    rc_address() |>
    rc_integer("npi") |>
    rc_bin("multi") |>
    rc_ymd("inc_date") |>
    rc_other(stub = "org")
}

#' @noRd
S7::method(polish, S7::new_S3_class("owner")) <- function(x) {
  rowbind2(x, "fac_type", fill = TRUE) |>
    rename_with("owner") |>
    rc_address() |>
    rc_double("percent") |>
    rc_bin(collapse::gvr(x, "_ind$", return = 2L)) |>
    rc_ymd("asc_date") |>
    pivot_owner()
}

#' @noRd
S7::method(polish, S7::new_S3_class("hospitals")) <- function(x) {
  rc_hospitals(x, "PROVIDER TYPE CODE")
  rc_hospitals(x, "PROPRIETARY NONPROFIT")
  rc_hospitals(x, "PRACTICE LOCATION TYPE")
  set_integer(x, "NPI")

  rename_with(x, "hospitals") |>
    rc_other(stub = "org") |>
    rc_other(stub = "loc") |>
    rc_address() |>
    rc_ymd(collapse::gvr(x, "_date$", return = 2L)) |>
    rc_bin(collapse::gvr(x, "multi|^sub_", return = 2L)) |>
    pivot_subgroup()
}

#' @noRd
S7::method(polish, S7::new_S3_class("hospitals2")) <- function(x) {
  suppressWarnings(set_integer(x, "hospital_overall_rating"))
  rename_with(x, "hospitals2")
}

#' @noRd
S7::method(polish, S7::new_S3_class("opt_out")) <- function(x) {
  set_integer(x, "NPI")
  rename_with(x, "opt_out") |>
    rc_address() |>
    rc_bin("order_refer") |>
    rc_mdy(c("start_date", "end_date", "updated"))
}

#' @noRd
S7::method(polish, S7::new_S3_class("order_refer")) <- function(x) {
  set_integer(x, "NPI")
  rename_with(x, "order_refer") |>
    rc_bin(c("ptb", "dme", "hha", "pmd", "hospice"))
}

#' @noRd
S7::method(polish, S7::new_S3_class("pending")) <- function(x) {
  rowbind2(x, "prov_type", fill = TRUE) |>
    rename_with("pending") |>
    rc_integer("npi")
}

#' @noRd
S7::method(polish, S7::new_S3_class("providers")) <- function(x) {
  set_integer(x, "NPI")
  rename_with(x, "providers") |>
    rc_bin("multi")
}

#' @noRd
S7::method(polish, S7::new_S3_class("reassignments")) <- function(x) {
  set_integer(x, "Individual NPI")
  set_integer(x, "Individual Total Employer Associations")
  set_integer(x, "Group Reassignments and Physician Assistants")
  rename_with(x, "reassignments")
}

#' @noRd
S7::method(polish, S7::new_S3_class("revocations")) <- function(x) {
  set_integer(x, "NPI")
  rename_with(x, "revocations") |>
    rc_bin("multi") |>
    rc_trim() |>
    rc_ymd(c("start_date", "end_date"))
}

#' @noRd
S7::method(polish, S7::new_S3_class("transparency")) <- function(x) {
  set_integer(x, "Case_ID")
  rename_with(x, "transparency") |>
    rc_ymd("action_date") |>
    rc_trim()
}
