#' Polish generic
#' Defines data cleaning methods for results
#' @param x data.frame
#' @returns data.frame
#' @export
#' @keywords internal
polish <- function(x) {
  UseMethod("polish")
}

#' @export
polish.affiliations <- function(x) {
  rename_with(x, "affiliations") |>
    rc_integer("npi")
}

#' @export
polish.clia <- function(x) {
  x <- rename_with(x, "clia") |>
    rc_bin(collapse::gvr(x, "_ind$|_multi$", return = 2L)) |>
    rc_ymd2(collapse::gvr(x, "_date$", return = 2L)) |>
    rc_integer(c("chows", "labs", "sites")) |>
    rc_address() |>
    rc_address(main = "fac_name", other = "fac_2")

  RC_clia_term(x$term)
  RC_clia_cert(x$cert)
  RC_clia_own(x$owner)
  RC_clia_fac(x$facility)
  RC_clia_act(x$action)

  pivot_multi(x) |>
    pivot_compliance() |>
    pivot_credit()
}

#' @export
polish.clinicians <- function(x) {
  rename_with(x, "clinicians") |>
    rc_address() |>
    rc_address(main = "specialty", other = "spec_other") |>
    rc_integer(c("npi", "grad_year", "members"))
}

#' @export
polish.default <- function(x) {
  cli::cli_alert_warning("Using {.cls polish.default} method")
  replace_nz(x) |>
    as_data_frame()
}

#' @export
polish.esrd <- function(x) {
  rename_with(x, "esrd") |>
    rc_integer(c("network", "rating")) |>
    rc_ymd("cert_date") |>
    rc_address()
}

#' @export
polish.fqhc_enroll <- function(x) {
  rename_with(x, "fqhc_enroll") |>
    rc_address() |>
    rc_integer("npi") |>
    rc_bin("multi") |>
    rc_ymd("inc_date") |>
    rc_other(stub = "org") |>
    collapse::roworderv(c("enid"))
}

#' @export
polish.hospice_enroll <- function(x) {
  rename_with(x, "hospice_enroll") |>
    rc_address() |>
    rc_integer("npi") |>
    rc_bin("multi") |>
    rc_ymd("inc_date") |>
    rc_other(stub = "org") |>
    collapse::roworderv(c("enid"))
}

#' @export
polish.rhc_enroll <- function(x) {
  rename_with(x, "rhc_enroll") |>
    rc_address() |>
    rc_integer("npi") |>
    rc_bin("multi") |>
    rc_ymd("inc_date") |>
    rc_other(stub = "org") |>
    collapse::roworderv(c("enid"))
}

#' @export
polish.snf_enroll <- function(x) {
  rename_with(x, "snf_enroll") |>
    rc_address() |>
    rc_integer("npi") |>
    rc_bin("multi") |>
    rc_ymd("inc_date") |>
    rc_other(stub = "org") |>
    collapse::roworderv(c("enid"))
}

#' @export
polish.snf_owner <- function(x) {
  rename_with(x, "snf_owner") |>
    rc_address() |>
    rc_double("percent") |>
    rc_bin(collapse::gvr(x, "_ind$", return = 2L)) |>
    rc_ymd("asc_date") |>
    pivot_owner() |>
    collapse::roworderv(c("pac", "org_enid"))
}

#' @export
polish.rhc_owner <- function(x) {
  rename_with(x, "rhc_owner") |>
    rc_address() |>
    rc_double("percent") |>
    rc_bin(collapse::gvr(x, "_ind$", return = 2L)) |>
    rc_ymd("asc_date") |>
    pivot_owner() |>
    collapse::roworderv(c("pac", "org_enid"))
}

#' @export
polish.fqhc_owner <- function(x) {
  rename_with(x, "fqhc_owner") |>
    rc_address() |>
    rc_double("percent") |>
    rc_bin(collapse::gvr(x, "_ind$", return = 2L)) |>
    rc_ymd("asc_date") |>
    pivot_owner() |>
    collapse::roworderv(c("pac", "org_enid"))
}

#' @export
polish.hospice_owner <- function(x) {
  rename_with(x, "hospice_owner") |>
    rc_address() |>
    rc_double("percent") |>
    rc_bin(collapse::gvr(x, "_ind$", return = 2L)) |>
    rc_ymd("asc_date") |>
    pivot_owner() |>
    collapse::roworderv(c("pac", "org_enid"))
}

#' @export
polish.hospital_owner <- function(x) {
  rename_with(x, "hospital_owner") |>
    rc_address() |>
    rc_double("percent") |>
    rc_bin(collapse::gvr(x, "_ind$", return = 2L)) |>
    rc_ymd("asc_date") |>
    pivot_owner() |>
    collapse::roworderv(c("pac", "org_enid"))
}

#' @export
polish.hospitals <- function(x) {
  rename_with(x, "hospitals") |>
    rc_other(stub = "org") |>
    rc_other(stub = "loc") |>
    rc_address() |>
    rc_integer("npi") |>
    rc_ymd(collapse::gvr(x, "_date$", return = 2L)) |>
    rc_bin(collapse::gvr(x, "multi|^sub_", return = 2L)) |>
    pivot_subgroup()
}

#' @export
polish.hospitals2 <- function(x) {
  rename_with(x, "hospitals2") |>
    rc_integer("rating")
}

#' @export
polish.integer <- function(x) {
  invisible(x)
}

#' @export
polish.opt_out <- function(x) {
  rename_with(x, "opt_out") |>
    rc_address() |>
    rc_integer("npi") |>
    rc_bin("order_refer") |>
    rc_mdy(c("start_date", "end_date", "updated"))
}

#' @export
polish.order_refer <- function(x) {
  rename_with(x, "order_refer") |>
    rc_integer("npi") |>
    rc_bin(c("ptb", "dme", "hha", "pmd", "hospice"))
}

#' @export
polish.pending <- function(x) {
  rename_with(x, "pending") |>
    rc_integer("npi")
}

#' @export
polish.providers <- function(x) {
  rename_with(x, "providers") |>
    rc_integer("npi") |>
    rc_bin("multi") |>
    collapse::roworderv(c("pac", "npi"))
}

#' @export
polish.reassignments <- function(x) {
  rename_with(x, "reassignments") |>
    rc_integer(c("npi", "employers", "employees"))
}

#' @export
polish.revocations <- function(x) {
  rename_with(x, "revocations") |>
    rc_integer("npi") |>
    rc_bin("multi") |>
    rc_ymd(c("start_date", "end_date"))
}

#' @export
polish.transparency <- function(x) {
  rename_with(x, "transparency") |>
    rc_integer("case") |>
    rc_ymd("action_date")
}
