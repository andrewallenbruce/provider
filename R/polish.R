#' @noRd
polish <- S7::new_generic("polish", "x")

#' @noRd
ResultAffiliations <- S7::new_S3_class("affiliations")

#' @noRd
ResultCLIA <- S7::new_S3_class("clia")

#' @noRd
ResultClinicians <- S7::new_S3_class("clinicians")

#' @noRd
ResultDialysis <- S7::new_S3_class("dialysis")

#' @noRd
ResultFacility <- S7::new_S3_class("facility")

#' @noRd
ResultOwner <- S7::new_S3_class("owner")

#' @noRd
ResultHospitals <- S7::new_S3_class("hospitals")

#' @noRd
ResultHospitals2 <- S7::new_S3_class("hospitals2")

#' @noRd
ResultOptOut <- S7::new_S3_class("opt_out")

#' @noRd
ResultOrderRefer <- S7::new_S3_class("order_refer")

#' @noRd
ResultPending <- S7::new_S3_class("pending")

#' @noRd
ResultProviders <- S7::new_S3_class("providers")

#' @noRd
ResultReassignments <- S7::new_S3_class("reassignments")

#' @noRd
ResultRevocations <- S7::new_S3_class("revocations")

#' @noRd
ResultTransparency <- S7::new_S3_class("transparency")

#' @noRd
ResultQuality <- S7::new_S3_class("quality")

#' @noRd
S7::method(polish, ResultQuality) <- function(x) {
  x1 <- collapse::get_elem(x, as.character(2017:2021))

  if (!rlang::is_empty(x1)) {
    x1 <- purrr::map(x1, function(x) {
      collapse::frename(x, QPP$`_17`, .nse = FALSE) |>
        collapse::gv(unlist_(QPP$`_17`))
    }) |>
      rowbind2("year")
  }

  x2 <- collapse::get_elem(x, as.character(2022))

  if (!rlang::is_empty(x2)) {
    x2 <- collapse::frename(x2, QPP$`_22`, .nse = FALSE) |>
      collapse::gv(unlist_(QPP$`_22`)) |>
      cheapr::df_modify(list(year = 2022L))
  }

  x4 <- collapse::get_elem(x, as.character(2023:2024))

  if (!rlang::is_empty(x4)) {
    x4 <- purrr::map(x4, function(x) {
      collapse::frename(x, QPP$`_24`, .nse = FALSE) |>
        collapse::gv(unlist_(QPP$`_24`))
    }) |>
      rowbind2("year")
  }

  x <- collapse::rowbind(x1, x2, x4, fill = TRUE)

  x <- replace_nz(x) |>
    rc_bin(collapse::gvr(x, "_ind$", return = 3L)) |>
    rc_integer(c("year", "npi", "size", "years", "patients", "charges", "services"))

  collapse::settfmv(x, "adjustment", as.double)
  collapse::settfmv(x, "dual_ratio", as.double)
  collapse::settfmv(x, "final_score", as.double)
  collapse::settfmv(x, "qa_score", as.double)
  collapse::settfmv(x, "pi_score", as.double)
  collapse::settfmv(x, "ia_score", as.double)
  collapse::settfmv(x, "cost_score", as.double)
  collapse::settfmv(x, "complex_bonus", as.double)
  collapse::settfmv(x, "qi_bonus", as.double)
  collapse::settfmv(x, "small_bonus", as.double)

  pivot_quality(x)
}


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
S7::method(polish, ResultAffiliations) <- function(x) {
  rename_with(x, "affiliations") |>
    rc_integer("npi")
}

#' @noRd
S7::method(polish, ResultCLIA) <- function(x) {
  rc_clia(x, "CLIA_TRMNTN_CD")
  rc_clia(x, "CRTFCT_TYPE_CD")
  rc_clia(x, "GNRL_FAC_TYPE_CD")
  rc_clia(x, "GNRL_CNTL_TYPE_CD")
  rc_clia(x, "CRTFCTN_ACTN_TYPE_CD")
  collapse::settfmv(x, "CHOW_CNT", as.integer)
  collapse::settfmv(x, "DRCTLY_AFLTD_LAB_CNT", as.integer)
  collapse::settfmv(x, "LAB_SITE_CNT", as.integer)

  rename_with(x, "clia") |>
    rc_bin(collapse::gvr(x, "_ind$|_multi$", return = 2L)) |>
    rc_ymd2(collapse::gvr(x, "_date$", return = 2L)) |>
    rc_address() |>
    rc_address("fac_name", "fac_2") |>
    pivot_multi_site() |>
    pivot_acr_org()
}

#' @noRd
S7::method(polish, ResultClinicians) <- function(x) {
  rename_with(x, "clinicians") |>
    rc_address() |>
    rc_address("specialty", "spec_other") |>
    rc_integer(c("npi", "grad_year", "members")) |>
    collapse::roworderv(c("npi"))
}

#' @noRd
S7::method(polish, ResultDialysis) <- function(x) {
  rename_with(x, "dialysis") |>
    rc_integer(c("network", "rating")) |>
    rc_ymd("cert_date") |>
    rc_address()
}

#' @noRd
S7::method(polish, ResultFacility) <- function(x) {
  rowbind2(x, "fac_type", fill = TRUE) |>
    rename_with("facility") |>
    rc_address() |>
    rc_integer("npi") |>
    rc_bin("multi") |>
    rc_ymd("inc_date") |>
    rc_other(stub = "org") |>
    collapse::roworderv(c("enid"))
}

#' @noRd
S7::method(polish, ResultOwner) <- function(x) {
  rowbind2(x, "fac_type", fill = TRUE) |>
    rename_with("owner") |>
    rc_address() |>
    rc_double("percent") |>
    rc_bin(collapse::gvr(x, "_ind$", return = 2L)) |>
    rc_ymd("asc_date") |>
    pivot_owner() |>
    collapse::roworderv(c("pac", "org_enid"))
}

#' @noRd
S7::method(polish, ResultHospitals) <- function(x) {
  rc_hospitals(x, "PROVIDER TYPE CODE")
  rc_hospitals(x, "PROPRIETARY NONPROFIT")
  rc_hospitals(x, "PRACTICE LOCATION TYPE")

  rename_with(x, "hospitals") |>
    rc_other(stub = "org") |>
    rc_other(stub = "loc") |>
    rc_address() |>
    rc_integer("npi") |>
    rc_ymd(collapse::gvr(x, "_date$", return = 2L)) |>
    rc_bin(collapse::gvr(x, "multi|^sub_", return = 2L)) |>
    pivot_subgroup()
}

#' @noRd
S7::method(polish, ResultHospitals2) <- function(x) {
  rename_with(x, "hospitals2") |>
    rc_integer("rating")
}

#' @noRd
S7::method(polish, ResultOptOut) <- function(x) {
  rename_with(x, "opt_out") |>
    rc_address() |>
    rc_integer("npi") |>
    rc_bin("order_refer") |>
    rc_mdy(c("start_date", "end_date", "updated"))
}

#' @noRd
S7::method(polish, ResultOrderRefer) <- function(x) {
  rename_with(x, "order_refer") |>
    rc_integer("npi") |>
    rc_bin(c("ptb", "dme", "hha", "pmd", "hospice"))
}

#' @noRd
S7::method(polish, ResultPending) <- function(x) {
  rowbind2(x, "prov_type", fill = TRUE) |>
    rename_with("pending") |>
    rc_integer("npi")
}

#' @noRd
S7::method(polish, ResultProviders) <- function(x) {
  rename_with(x, "providers") |>
    rc_integer("npi") |>
    rc_bin("multi") |>
    collapse::roworderv(c("pac", "npi"))
}

#' @noRd
S7::method(polish, ResultReassignments) <- function(x) {
  rename_with(x, "reassignments") |>
    rc_integer(c("npi", "employers", "employees")) |>
    collapse::roworderv(c("npi"))
}

#' @noRd
S7::method(polish, ResultRevocations) <- function(x) {
  rename_with(x, "revocations") |>
    rc_integer("npi") |>
    rc_bin("multi") |>
    rc_trim() |>
    rc_ymd(c("start_date", "end_date"))
}

#' @noRd
S7::method(polish, ResultTransparency) <- function(x) {
  rename_with(x, "transparency") |>
    rc_integer("case") |>
    rc_ymd("action_date") |>
    rc_trim() |>
    collapse::roworderv(c("fac_name", "case"))
}
