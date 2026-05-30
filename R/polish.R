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
  rename_with(x, "affiliations") |>
    rc_integer("npi")
}

#' @noRd
S7::method(polish, S7::new_S3_class("clia")) <- function(x) {
  rc_clia(x, "CLIA_TRMNTN_CD")
  rc_clia(x, "CRTFCT_TYPE_CD")
  rc_clia(x, "GNRL_FAC_TYPE_CD")
  rc_clia(x, "GNRL_CNTL_TYPE_CD")
  rc_clia(x, "CRTFCTN_ACTN_TYPE_CD")

  rename_with(x, "clia") |>
    rc_bin(collapse::gvr(x, "_ind$|_multi$", return = 2L)) |>
    rc_ymd2(collapse::gvr(x, "_date$", return = 2L)) |>
    rc_integer(c("chows", "labs", "sites")) |>
    rc_address() |>
    rc_address(add1 = "fac_name", add2 = "fac_2") |>
    pivot_multi_site() |>
    pivot_acr_org()
}

#' @noRd
S7::method(polish, S7::new_S3_class("clinicians")) <- function(x) {
  rename_with(x, "clinicians") |>
    rc_address() |>
    rc_address(add1 = "specialty", add2 = "spec_other") |>
    rc_integer(c("npi", "grad_year", "members")) |>
    collapse::roworderv(c("npi"))
}

#' @noRd
S7::method(polish, S7::new_S3_class("dialysis")) <- function(x) {
  rename_with(x, "dialysis") |>
    rc_integer(c("network", "rating")) |>
    rc_ymd("cert_date") |>
    rc_address()
}

#' @noRd
S7::method(polish, S7::new_S3_class("facility")) <- function(x) {
  rename_with(x, "facility") |>
    rc_address() |>
    rc_integer("npi") |>
    rc_bin("multi") |>
    rc_ymd("inc_date") |>
    rc_other(stub = "org") |>
    collapse::roworderv(c("enid"))
}

#' @noRd
S7::method(polish, S7::new_S3_class("owner")) <- function(x) {
  rename_with(x, "owner") |>
    rc_address() |>
    rc_double("percent") |>
    rc_bin(collapse::gvr(x, "_ind$", return = 2L)) |>
    rc_ymd("asc_date") |>
    pivot_owner() |>
    collapse::roworderv(c("pac", "org_enid"))
}

#' @noRd
S7::method(polish, S7::new_S3_class("hospitals")) <- function(x) {
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
S7::method(polish, S7::new_S3_class("hospitals2")) <- function(x) {
  rename_with(x, "hospitals2") |>
    rc_integer("rating")
}

#' @noRd
S7::method(polish, S7::new_S3_class("opt_out")) <- function(x) {
  rename_with(x, "opt_out") |>
    rc_address() |>
    rc_integer("npi") |>
    rc_bin("order_refer") |>
    rc_mdy(c("start_date", "end_date", "updated"))
}

#' @noRd
S7::method(polish, S7::new_S3_class("order_refer")) <- function(x) {
  rename_with(x, "order_refer") |>
    rc_integer("npi") |>
    rc_bin(c("ptb", "dme", "hha", "pmd", "hospice"))
}

#' @noRd
S7::method(polish, S7::new_S3_class("pending")) <- function(x) {
  rename_with(x, "pending") |>
    rc_integer("npi")
}

#' @noRd
S7::method(polish, S7::new_S3_class("providers")) <- function(x) {
  rename_with(x, "providers") |>
    rc_integer("npi") |>
    rc_bin("multi") |>
    collapse::roworderv(c("pac", "npi"))
}

#' @noRd
S7::method(polish, S7::new_S3_class("reassignments")) <- function(x) {
  rename_with(x, "reassignments") |>
    rc_integer(c("npi", "employers", "employees")) |>
    collapse::roworderv(c("npi"))
}

#' @noRd
S7::method(polish, S7::new_S3_class("revocations")) <- function(x) {
  rename_with(x, "revocations") |>
    rc_integer("npi") |>
    rc_bin("multi") |>
    rc_trim() |>
    rc_ymd(c("start_date", "end_date"))
}

#' @noRd
S7::method(polish, S7::new_S3_class("transparency")) <- function(x) {
  rename_with(x, "transparency") |>
    rc_integer("case") |>
    rc_ymd("action_date") |>
    rc_trim() |>
    collapse::roworderv(c("fac_name", "case"))
}
