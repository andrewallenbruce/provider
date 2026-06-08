#' @noRd
polish <- S7::new_generic("polish", "x")

#' @noRd
S7::method(polish, S7::class_integer | API) <- function(x) {
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
  set_rename(x)
  get_columns(x)
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

  set_rename(x)
  get_columns(x) |>
    rc_bin(collapse::gvr(x, "eligible$|_multi$", return = 2L)) |>
    rc_ymd2(collapse::gvr(x, "_date$", return = 2L)) |>
    rc_address() |>
    rc_address("fac_name", "fac_2") |>
    pivot_multi_site() |>
    pivot_acr_org()
}

#' @noRd
S7::method(polish, S7::new_S3_class("clinicians")) <- function(x) {
  collapse::settfmv(x, c("npi", "grd_yr", "num_org_mem"), as.integer)
  set_rename(x)
  get_columns(x) |>
    rc_address() |>
    rc_address("specialty", "spec_other")
}

#' @noRd
S7::method(polish, S7::new_S3_class("dialysis")) <- function(x) {
  collapse::settfmv(x, c("five_star", "network"), as.integer)
  set_rename(x)
  get_columns(x) |>
    rc_ymd("cert_date") |>
    rc_address()
}

#' @noRd
S7::method(polish, S7::new_S3_class("facility")) <- function(x) {
  x <- rowbind2(x, "fac_type", fill = TRUE) |>
    add_class("facility")

  collapse::settfmv(x, "NPI", as.integer)

  set_rename(x)
  get_columns(x) |>
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
  set_rename(x)
  get_columns(x) |>
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
  set_rename(x)
  get_columns(x)
}

#' @noRd
S7::method(polish, S7::new_S3_class("opt_out")) <- function(x) {
  collapse::settfmv(x, "NPI", as.integer)
  set_rename(x)
  get_columns(x) |>
    rc_address() |>
    rc_bin("order_refer") |>
    rc_mdy(c("start_date", "end_date", "updated"))
}

#' @noRd
S7::method(polish, S7::new_S3_class("order_refer")) <- function(x) {
  collapse::settfmv(x, "NPI", as.integer)
  set_rename(x)
  get_columns(x) |>
    rc_bin(collapse::gvr(x, "_ind$", return = 2L))
}

#' @noRd
S7::method(polish, S7::new_S3_class("owner")) <- function(x) {
  x <- rowbind2(x, "fac_type", fill = TRUE) |>
    add_class("owner")

  collapse::settfmv(x, "PERCENTAGE OWNERSHIP", as.double)
  rc_owner(x, "ROLE CODE - OWNER")

  set_rename(x)
  get_columns(x) |>
    rc_address() |>
    rc_bin(collapse::gvr(x, "_ind$", return = 2L)) |>
    rc_ymd("asc_date") |>
    pivot_owner()
}

#' @noRd
S7::method(polish, S7::new_S3_class("pending")) <- function(x) {
  x <- rowbind2(x, "prov_type", fill = TRUE) |>
    add_class("pending") |>
    rc_trim()

  collapse::settfmv(x, "NPI", as.integer)
  set_rename(x)
  get_columns(x)
}

#' @noRd
S7::method(polish, S7::new_S3_class("providers")) <- function(x) {
  collapse::settfmv(x, "NPI", as.integer)
  set_rename(x)
  get_columns(x) |>
    rc_bin("multi")
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
  set_rename(x)
  get_columns(x)
}

#' @noRd
S7::method(polish, S7::new_S3_class("revocations")) <- function(x) {
  collapse::settfmv(x, "NPI", as.integer)
  set_rename(x)
  get_columns(x) |>
    rc_bin("multi") |>
    rc_trim() |>
    rc_ymd(c("start_date", "end_date"))
}

#' @noRd
S7::method(polish, S7::new_S3_class("transparency")) <- function(x) {
  collapse::settfmv(x, "Case_ID", as.integer)
  set_rename(x)
  get_columns(x) |>
    rc_ymd("action_date") |>
    rc_trim()
}

#' @noRd
S7::method(polish, S7::new_S3_class("utilization")) <- function(x) {
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
      "Bene_Ndual_Cnt",
      "Bene_Feml_Cnt",
      "Bene_Male_Cnt"
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
    rc_bin("participating") |>
    rc_address() |>
    collapse::roworderv(c("year", "npi"))
}
