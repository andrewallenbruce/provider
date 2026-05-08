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
    rc_bin(collapse::gvr(x, "_ind$", return = 2L)) |>
    rc_date_ymd2(collapse::gvr(x, "_date$", return = 2L)) |>
    rc_integer(collapse::gvr(x, "_cnt$", return = 2L)) |>
    combine_columns(main = "fac_name", other = "fac_2", sep = ", ") |>
    combine_columns(main = "address", other = "add_2", sep = ", ")

  RC_clia_term_type(x$term_type)
  RC_clia_cert_type(x$cert_type)
  RC_clia_own_type(x$own_type)
  RC_clia_fac_type(x$fac_type)
  RC_clia_act_type(x$act_type)

  credit_pivot(x)
}

#' @export
polish.clinicians <- function(x) {
  rename_with(x, "clinicians") |>
    combine_columns(main = "address", other = "add_2", sep = ", ") |>
    combine_columns(main = "specialty", other = "spec_other", sep = ", ") |>
    rc_integer(c("npi", "grad_year", "members"))
}

#' @export
polish.default <- function(x) {
  replace_nz(x) |>
    data_frame()
}

#' @export
polish.esrd <- function(x) {
  rename_with(x, "esrd") |>
    rc_integer(c("network", "rating")) |>
    rc_date_ymd("cert_date") |>
    combine_columns(main = "address", other = "add_2", sep = ", ")
}

#' @export
polish.fqhc_enroll <- function(x) {
  rename_with(x, "fqhc_enroll") |>
    combine_columns(main = "address", other = "add_2", sep = ", ") |>
    rc_integer("npi") |>
    rc_bin("multi") |>
    rc_date_ymd("inc_date") |>
    combine_columns(
      main = "org_type",
      other = "org_otxt",
      prefix = "Other: ",
      sep = ""
    ) |>
    collapse::roworderv(c("enid"))
}

#' @export
polish.hospice_enroll <- function(x) {
  rename_with(x, "hospice_enroll") |>
    combine_columns(main = "address", other = "add_2", sep = ", ") |>
    rc_integer("npi") |>
    rc_bin("multi") |>
    rc_date_ymd("inc_date") |>
    combine_columns(
      main = "org_type",
      other = "org_otxt",
      prefix = "Other: ",
      sep = ""
    ) |>
    collapse::roworderv(c("enid"))
}

#' @export
polish.rhc_enroll <- function(x) {
  rename_with(x, "rhc_enroll") |>
    combine_columns(main = "address", other = "add_2", sep = ", ") |>
    rc_integer("npi") |>
    rc_bin("multi") |>
    rc_date_ymd("inc_date") |>
    combine_columns(
      main = "org_type",
      other = "org_otxt",
      prefix = "Other: ",
      sep = ""
    ) |>
    collapse::roworderv(c("enid"))
}

#' @export
polish.snf_enroll <- function(x) {
  rename_with(x, "snf_enroll") |>
    combine_columns(main = "address", other = "add_2", sep = ", ") |>
    rc_integer("npi") |>
    rc_bin("multi") |>
    rc_date_ymd("inc_date") |>
    combine_columns(
      main = "org_type",
      other = "org_otxt",
      prefix = "Other: ",
      sep = ""
    ) |>
    collapse::roworderv(c("enid"))
}

#' @export
polish.snf_owner <- function(x) {
  rename_with(x, "snf_owner") |>
    combine_columns(x, main = "address", other = "add_2", sep = ", ") |>
    rc_double("percent") |>
    rc_bin(collapse::gvr(x, "_ind$", return = 2L)) |>
    rc_date_ymd("asc_date") |>
    owner_pivot() |>
    collapse::roworderv(c("pac", "org_enid"))
}

#' @export
polish.rhc_owner <- function(x) {
  rename_with(x, "rhc_owner") |>
    combine_columns(main = "address", other = "add_2", sep = ", ") |>
    rc_double("percent") |>
    rc_bin(collapse::gvr(x, "_ind$", return = 2L)) |>
    rc_date_ymd("asc_date") |>
    owner_pivot() |>
    collapse::roworderv(c("pac", "org_enid"))
}

#' @export
polish.fqhc_owner <- function(x) {
  rename_with(x, "fqhc_owner") |>
    combine_columns(main = "address", other = "add_2", sep = ", ") |>
    rc_double("percent") |>
    rc_bin(collapse::gvr(x, "_ind$", return = 2L)) |>
    rc_date_ymd("asc_date") |>
    owner_pivot() |>
    collapse::roworderv(c("pac", "org_enid"))
}

#' @export
polish.hospice_owner <- function(x) {
  rename_with(x, "hospice_owner") |>
    combine_columns(main = "address", other = "add_2", sep = ", ") |>
    rc_double("percent") |>
    rc_bin(collapse::gvr(x, "_ind$", return = 2L)) |>
    rc_date_ymd("asc_date") |>
    owner_pivot() |>
    collapse::roworderv(c("pac", "org_enid"))
}

#' @export
polish.hospital_owner <- function(x) {
  rename_with(x, "hospital_owner") |>
    combine_columns(main = "address", other = "add_2", sep = ", ") |>
    rc_double("percent") |>
    rc_bin(collapse::gvr(x, "_ind$", return = 2L)) |>
    rc_date_ymd("asc_date") |>
    owner_pivot() |>
    collapse::roworderv(c("pac", "org_enid"))
}

#' @export
polish.hospitals <- function(x) {
  rename_with(x, "hospitals") |>
    combine_columns(
      main = "org_type",
      other = "org_otxt",
      prefix = "OTHER: ",
      sep = ""
    ) |>
    combine_columns(
      main = "loc_type",
      other = "loc_otxt",
      prefix = "OTHER: ",
      sep = ""
    ) |>
    combine_columns(main = "address", other = "add_2", sep = ", ") |>
    rc_integer("npi") |>
    rc_date_ymd(collapse::gvr(x, "_date$", return = 2L)) |>
    rc_bin(collapse::gvr(x, "multi|^sub_", return = 2L)) |>
    subgroup_pivot()
}

#' @export
polish.hospitals2 <- function(x) {
  rename_with(x, "hospitals2") |>
    rc_integer_supp("rating")
}

#' @export
polish.integer <- function(x) {
  invisible(x)
}

#' @export
polish.opt_out <- function(x) {
  rename_with(x, "opt_out") |>
    combine_columns(main = "address", other = "add_2", sep = ", ") |>
    rc_integer("npi") |>
    rc_bin("order_refer") |>
    rc_date_mdy(c("start_date", "end_date", "updated"))
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
    rc_date_ymd(c("start_date", "end_date"))
}

#' @export
polish.transparency <- function(x) {
  rename_with(x, "transparency") |>
    rc_integer("case") |>
    rc_date_ymd("action_date")
}
