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
S7::method(polish, S7::new_S3_class("affiliations")) <- function(x) {
  collapse::settfmv(x, "npi", as.integer)
  collapse::setrename(x, RE_NAME[["affiliations"]], .nse = FALSE)
  replace_nz(x)
  collapse::gv(x, unlist_(RE_NAME[["affiliations"]]))
}

#' @noRd
S7::method(polish, S7::new_S3_class("clia")) <- function(x) {
  rc_clia(x, "CLIA_TRMNTN_CD")
  rc_clia(x, "CRTFCT_TYPE_CD")
  rc_clia(x, "GNRL_FAC_TYPE_CD")
  rc_clia(x, "GNRL_CNTL_TYPE_CD")
  rc_clia(x, "CRTFCTN_ACTN_TYPE_CD")

  collapse::settfmv(
    x,
    c("CHOW_CNT", "DRCTLY_AFLTD_LAB_CNT", "LAB_SITE_CNT"),
    as.integer
  )

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
  collapse::settfmv(x, c("npi", "grd_yr", "num_org_mem"), as.integer)

  rename_with(x, "clinicians") |>
    rc_address() |>
    rc_address("specialty", "spec_other")
}

#' @noRd
S7::method(polish, S7::new_S3_class("dialysis")) <- function(x) {
  collapse::settfmv(x, c("five_star", "network"), as.integer)

  rename_with(x, "dialysis") |>
    rc_ymd("cert_date") |>
    rc_address()
}

#' @noRd
S7::method(polish, S7::new_S3_class("facility")) <- function(x) {
  x <- rowbind2(x, "fac_type", fill = TRUE)
  collapse::settfmv(x, "NPI", as.integer)

  rename_with(x, "facility") |>
    rc_address() |>
    rc_bin("multi") |>
    rc_ymd("inc_date") |>
    rc_other(stub = "org")
}

#' @noRd
S7::method(polish, S7::new_S3_class("hospitals")) <- function(x) {
  rc_hospitals(x, "PROVIDER TYPE CODE")
  rc_hospitals(x, "PROPRIETARY NONPROFIT")
  rc_hospitals(x, "PRACTICE LOCATION TYPE")
  collapse::settfmv(x, "NPI", as.integer)

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
  suppressWarnings(collapse::settfmv(x, "hospital_overall_rating", as.integer))
  collapse::setrename(x, RE_NAME[["hospitals2"]], .nse = FALSE)
  replace_nz(x)
  collapse::gv(x, unlist_(RE_NAME[["hospitals2"]]))
}

#' @noRd
S7::method(polish, S7::new_S3_class("opt_out")) <- function(x) {
  collapse::settfmv(x, "NPI", as.integer)
  rename_with(x, "opt_out") |>
    rc_address() |>
    rc_bin("order_refer") |>
    rc_mdy(c("start_date", "end_date", "updated"))
}

#' @noRd
S7::method(polish, S7::new_S3_class("order_refer")) <- function(x) {
  collapse::settfmv(x, "NPI", as.integer)
  collapse::setrename(x, RE_NAME[["order_refer"]], .nse = FALSE)
  replace_nz(x)

  rc_bin(x, c("ptb", "dme", "hha", "pmd", "hospice")) |>
    collapse::gv(unlist_(RE_NAME[["order_refer"]]))
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
S7::method(polish, S7::new_S3_class("pending")) <- function(x) {
  x <- rowbind2(x, "prov_type", fill = TRUE)
  collapse::setrename(x, RE_NAME[["pending"]], .nse = FALSE)
  collapse::settfmv(x, "npi", as.integer)
  replace_nz(x)
  collapse::gv(x, unlist_(RE_NAME[["pending"]]))
}

#' @noRd
S7::method(polish, S7::new_S3_class("providers")) <- function(x) {
  collapse::settfmv(x, "NPI", as.integer)
  collapse::setrename(x, RE_NAME[["providers"]], .nse = FALSE)
  replace_nz(x)
  rc_bin(x, "multi") |>
    collapse::gv(unlist_(RE_NAME[["pending"]]))
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

  collapse::settfmv(
    x,
    c(
      "year",
      "npi",
      "size",
      "years",
      "patients",
      "charges",
      "services",
      "ia_score",
      "pi_score"
    ),
    as.integer
  )
  collapse::settfmv(
    x,
    c(
      "adjustment",
      "final_score",
      "complex_bonus",
      "qa_score",
      "cost_score",
      "qi_score"
    ),
    as.double
  )

  add_class(x, "quality") |>
    collapse::roworderv(c("year", "npi"))
}

#' @noRd
S7::method(polish, S7::new_S3_class("reassignments")) <- function(x) {
  collapse::settfmv(
    x,
    c(
      "Individual NPI",
      "Individual Total Employer Associations",
      "Group Reassignments and Physician Assistants"
    ),
    as.integer
  )
  rename_with(x, "reassignments")
}

#' @noRd
S7::method(polish, S7::new_S3_class("revocations")) <- function(x) {
  collapse::settfmv(x, "NPI", as.integer)
  rename_with(x, "revocations") |>
    rc_bin("multi") |>
    rc_trim() |>
    rc_ymd(c("start_date", "end_date"))
}

#' @noRd
S7::method(polish, S7::new_S3_class("transparency")) <- function(x) {
  collapse::settfmv(x, "Case_ID", as.integer)
  rename_with(x, "transparency") |>
    rc_ymd("action_date") |>
    rc_trim()
}
