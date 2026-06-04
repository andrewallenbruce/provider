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
  a <- b <- c <- list()

  if (collapse::has_elem(x, as.character(2017:2021))) {
    a <- collapse::get_elem(x, as.character(2017:2021), keep.tree = TRUE) |>
      purrr::map(\(x) {
        collapse::frename(x, QPP$`_17`, .nse = FALSE) |>
          collapse::gv(unlist_(QPP$`_17`))
      }) |>
      rowbind2("year")
  }

  if (collapse::has_elem(x, as.character(2022))) {
    b <- collapse::get_elem(x, as.character(2022), keep.tree = TRUE) |>
      purrr::map(\(x) {
        collapse::frename(x, QPP$`_22`, .nse = FALSE) |>
          collapse::gv(unlist_(QPP$`_22`))
      }) |>
      rowbind2("year")
    collapse::settfmv(b, "dual_ratio", as.numeric)
  }

  if (collapse::has_elem(x, as.character(2023:2024))) {
    c <- collapse::get_elem(x, as.character(2022), keep.tree = TRUE) |>
      purrr::map(\(x) {
        collapse::frename(x, QPP$`_22`, .nse = FALSE) |>
          collapse::gv(unlist_(QPP$`_22`))
      }) |>
      rowbind2("year")
    collapse::settfmv(c, "dual_ratio", as.numeric)
  }

  x <- collapse::rowbind(a, b, c, fill = TRUE)

  if (is.null(x)) {
    return(NULL)
  }

  x <- replace_nz(x) |>
    rc_bin(collapse::gvr(x, "_ind$", return = 3L))

  collapse::settfmv(x, "year", as.integer)
  collapse::settfmv(x, "npi", as.integer)
  collapse::settfmv(x, "size", as.integer)
  collapse::settfmv(x, "years", as.integer)
  collapse::settfmv(x, "patients", as.integer)
  collapse::settfmv(x, "charges", as.integer)
  collapse::settfmv(x, "services", as.integer)

  collapse::settfmv(x, "adjustment", as.numeric)
  collapse::settfmv(x, "final_score", as.numeric)
  collapse::settfmv(x, "complex_bonus", as.numeric)
  collapse::settfmv(x, "qa_score", as.numeric)
  collapse::settfmv(x, "pi_score", as.numeric)
  collapse::settfmv(x, "ia_score", as.numeric)
  collapse::settfmv(x, "cost_score", as.numeric)
  collapse::settfmv(x, "qi_bonus", as.numeric)

  pivot_quality(x) |>
    add_class("quality")
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
  collapse::settfmv(x, "npi", as.integer)
  rename_with(x, "affiliations")
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
  collapse::settfmv(x, "npi", as.integer)
  collapse::settfmv(x, "grd_yr", as.integer)
  collapse::settfmv(x, "num_org_mem", as.integer)

  rename_with(x, "clinicians") |>
    rc_address() |>
    rc_address("specialty", "spec_other")
}

#' @noRd
S7::method(polish, ResultDialysis) <- function(x) {
  collapse::settfmv(x, "five_star", as.integer)
  collapse::settfmv(x, "network", as.integer)

  rename_with(x, "dialysis") |>
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
    rc_other(stub = "org")
}

#' @noRd
S7::method(polish, ResultOwner) <- function(x) {
  rowbind2(x, "fac_type", fill = TRUE) |>
    rename_with("owner") |>
    rc_address() |>
    rc_double("percent") |>
    rc_bin(collapse::gvr(x, "_ind$", return = 2L)) |>
    rc_ymd("asc_date") |>
    pivot_owner()
}

#' @noRd
S7::method(polish, ResultHospitals) <- function(x) {
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
S7::method(polish, ResultHospitals2) <- function(x) {
  collapse::settfmv(x, "hospital_overall_rating", as.integer)
  rename_with(x, "hospitals2")
}

#' @noRd
S7::method(polish, ResultOptOut) <- function(x) {
  collapse::settfmv(x, "NPI", as.integer)

  rename_with(x, "opt_out") |>
    rc_address() |>
    rc_bin("order_refer") |>
    rc_mdy(c("start_date", "end_date", "updated"))
}

#' @noRd
S7::method(polish, ResultOrderRefer) <- function(x) {
  collapse::settfmv(x, "NPI", as.integer)

  rename_with(x, "order_refer") |>
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
  collapse::settfmv(x, "NPI", as.integer)

  rename_with(x, "providers") |>
    rc_bin("multi")
}

#' @noRd
S7::method(polish, ResultReassignments) <- function(x) {
  collapse::settfmv(x, "Individual NPI", as.integer)
  collapse::settfmv(x, "Individual Total Employer Associations", as.integer)
  collapse::settfmv(
    x,
    "Group Reassignments and Physician Assistants",
    as.integer
  )
  rename_with(x, "reassignments")
}

#' @noRd
S7::method(polish, ResultRevocations) <- function(x) {
  collapse::settfmv(x, "NPI", as.integer)

  rename_with(x, "revocations") |>
    rc_bin("multi") |>
    rc_trim() |>
    rc_ymd(c("start_date", "end_date"))
}

#' @noRd
S7::method(polish, ResultTransparency) <- function(x) {
  collapse::settfmv(x, "Case_ID", as.integer)

  rename_with(x, "transparency") |>
    rc_ymd("action_date") |>
    rc_trim()
}
