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
    rc_integer(collapse::gvr(x, "_cnt$", return = 2L))

  x <- collapse::av(
    x,
    fac_name = combine_cols(x$fac_1, x$fac_2),
    address = combine_cols(x$add_1, x$add_2)
  )

  collapse::gvr(x, "_[12]$") <- NULL

  RC_clia_term_type(x$term_type)
  RC_clia_cert_type(x$cert_type)
  RC_clia_own_type(x$own_type)
  RC_clia_fac_type(x$fac_type)
  RC_clia_act_type(x$act_type)

  x <- credit_pivot(x)

  collapse::colorderv(
    x,
    c(
      "^fac_name$",
      "_ccn$",
      "acr_org",
      "_ind$",
      "_type$",
      "_date$",
      "_cnt$"
    ),
    regex = TRUE
  )
}

#' @export
polish.clinicians <- function(x) {
  rename_with(x, "clinicians") |>
    RC_clinicians()
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
    RC_esrd()
}

#' @export
polish.fqhc_enroll <- function(x) {
  rename_with(x, "fqhc_enroll") |>
    RC_fqhc_enroll()
}

#' @export
polish.fqhc_owner <- function(x) {
  rename_with(x, "fqhc_owner") |>
    RC_fqhc_owner()
}

#' @export
polish.hospice_enroll <- function(x) {
  rename_with(x, "hospice_enroll") |>
    RC_rhc_enroll()
}

#' @export
polish.hospice_owner <- function(x) {
  rename_with(x, "hospice_owner") |>
    RC_rhc_owner()
}

#' @export
polish.hospital_owner <- function(x) {
  rename_with(x, "hospital_owner") |>
    RC_rhc_owner()
}

#' @export
polish.hospitals <- function(x) {
  rename_with(x, "hospitals") |>
    RC_hospitals()
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
    RC_opt_out()
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
    rc_bin("multi")
}

#' @export
polish.reassignments <- function(x) {
  rename_with(x, "reassignments") |>
    rc_integer(c("npi", "employers", "employees"))
}

#' @export
polish.rhc_enroll <- function(x) {
  rename_with(x, "rhc_enroll") |>
    RC_rhc_enroll()
}

#' @export
polish.rhc_owner <- function(x) {
  rename_with(x, "rhc_owner") |>
    RC_rhc_owner()
}

#' @export
polish.revocations <- function(x) {
  rename_with(x, "revocations") |>
    rc_integer("npi") |>
    rc_bin("multi") |>
    rc_date_ymd(c("start_date", "end_date"))
}

#' @export
polish.snf_enroll <- function(x) {
  rename_with(x, "snf_enroll") |>
    RC_rhc_enroll()
}

#' @export
polish.snf_owner <- function(x) {
  rename_with(x, "snf_owner") |>
    RC_rhc_owner()
}

#' @export
polish.transparency <- function(x) {
  rename_with(x, "transparency") |>
    rc_integer("case") |>
    rc_date_ymd("action_date")
}
