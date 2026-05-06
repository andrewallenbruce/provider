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
  rename_with(x, "affiliations")
  collapse::gv(x, unlist_(RE_NAME$affiliations)) |>
    replace_nz() |>
    rc_integer("npi") |>
    data_frame()
}

#' @export
polish.clia <- function(x) {
  rename_with(x, "clia")
  x <- collapse::gv(x, unlist_(RE_NAME$clia)) |>
    replace_nz() |>
    rc_bin(collapse::gvr(x, "_ind$", return = 2L)) |>
    rc_date_ymd2(collapse::gvr(x, "_date$", return = 2L)) |>
    rc_integer(collapse::gvr(x, "_cnt$", return = 2L)) |>
    data_frame()

  x <- collapse::av(
    x,
    fac_name = combine_cols(x$fac_1, x$fac_2),
    address = combine_cols(x$add_1, x$add_2)
  )

  collapse::gvr(x, "_[12]$") <- NULL

  RC_clia_term_type(x$term_type)
  RC_clia_cert_type(x$cert_type)
  RC_clia_cert_type(x$app_type)
  RC_clia_own_type(x$own_type)
  RC_clia_fac_type(x$fac_type)
  RC_clia_act_type(x$act_type)

  x <- clia_acr_pivot(x)

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
  rename_with(x, "clinicians")
  collapse::gv(x, unlist_(RE_NAME$clinicians)) |>
    replace_nz() |>
    RC_clinicians() |>
    data_frame()
}

#' @export
polish.default <- function(x) {
  replace_nz(x) |>
    data_frame()
}

#' @export
polish.esrd <- function(x) {
  rename_with(x, "esrd")
  collapse::gv(x, unlist_(RE_NAME$esrd)) |>
    replace_nz() |>
    rc_integer(c("network", "rating")) |>
    rc_date_ymd("cert_date") |>
    RC_esrd() |>
    data_frame()
}

#' @export
polish.fqhc_enroll <- function(x) {
  rename_with(x, "fqhc_enroll")
  collapse::gv(x, unlist_(RE_NAME$fqhc_enroll)) |>
    replace_nz() |>
    RC_fqhc_enroll() |>
    data_frame()
}

#' @export
polish.fqhc_owner <- function(x) {
  rename_with(x, "fqhc_owner")
  collapse::gv(x, unlist_(RE_NAME$fqhc_owner)) |>
    replace_nz() |>
    RC_fqhc_owner() |>
    data_frame()
}

#' @export
polish.hospice_enroll <- function(x) {
  rename_with(x, "hospice_enroll")
  collapse::gv(x, unlist_(RE_NAME$hospice_enroll)) |>
    replace_nz() |>
    RC_rhc_enroll() |>
    data_frame()
}

#' @export
polish.hospice_owner <- function(x) {
  rename_with(x, "hospice_owner")
  collapse::gv(x, unlist_(RE_NAME$hospice_owner)) |>
    replace_nz() |>
    RC_rhc_owner() |>
    data_frame()
}

#' @export
polish.hospital_owner <- function(x) {
  rename_with(x, "hospital_owner")
  collapse::gv(x, unlist_(RE_NAME$hospital_owner)) |>
    replace_nz() |>
    RC_rhc_owner() |>
    data_frame()
}

#' @export
polish.hospitals <- function(x) {
  rename_with(x, "hospitals")
  collapse::gv(x, unlist_(RE_NAME$hospitals)) |>
    replace_nz() |>
    RC_hospitals() |>
    data_frame()
}

#' @export
polish.hospitals2 <- function(x) {
  rename_with(x, "hospitals2")
  collapse::gv(x, unlist_(RE_NAME$hospitals2)) |>
    replace_nz() |>
    rc_integer_supp("rating") |>
    data_frame()
}

#' @export
polish.integer <- function(x) {
  invisible(x)
}

#' @export
polish.opt_out <- function(x) {
  rename_with(x, "opt_out")
  collapse::gv(x, unlist_(RE_NAME$opt_out)) |>
    replace_nz() |>
    RC_opt_out() |>
    data_frame()
}

#' @export
polish.order_refer <- function(x) {
  rename_with(x, "order_refer")
  collapse::gv(x, unlist_(RE_NAME$order_refer)) |>
    replace_nz() |>
    rc_integer("npi") |>
    rc_bin(c("ptb", "dme", "hha", "pmd", "hospice")) |>
    data_frame()
}

#' @export
polish.pending <- function(x) {
  rename_with(x, "pending")
  collapse::gv(x, unlist_(RE_NAME$pending)) |>
    replace_nz() |>
    rc_integer("npi") |>
    data_frame()
}

#' @export
polish.providers <- function(x) {
  rename_with(x, "providers")
  collapse::gv(x, unlist_(RE_NAME$providers)) |>
    replace_nz() |>
    rc_integer("npi") |>
    rc_bin("multi") |>
    data_frame()
}

#' @export
polish.reassignments <- function(x) {
  rename_with(x, "reassignments")
  collapse::gv(x, unlist_(RE_NAME$reassignments)) |>
    replace_nz() |>
    rc_integer(c("npi", "employers", "employees")) |>
    data_frame()
}

#' @export
polish.rhc_enroll <- function(x) {
  rename_with(x, "rhc_enroll")
  collapse::gv(x, unlist_(RE_NAME$rhc_enroll)) |>
    replace_nz() |>
    RC_rhc_enroll() |>
    data_frame()
}

#' @export
polish.rhc_owner <- function(x) {
  rename_with(x, "rhc_owner")
  collapse::gv(x, unlist_(RE_NAME$rhc_owner)) |>
    replace_nz() |>
    RC_rhc_owner() |>
    data_frame()
}

#' @export
polish.revocations <- function(x) {
  rename_with(x, "revocations")
  collapse::gv(x, unlist_(RE_NAME$revocations)) |>
    replace_nz() |>
    rc_integer("npi") |>
    rc_bin("multi") |>
    rc_date_ymd(c("start_date", "end_date")) |>
    data_frame()
}

#' @export
polish.snf_enroll <- function(x) {
  rename_with(x, "snf_enroll")
  collapse::gv(x, unlist_(RE_NAME$snf_enroll)) |>
    replace_nz() |>
    RC_rhc_enroll() |>
    data_frame()
}

#' @export
polish.snf_owner <- function(x) {
  rename_with(x, "snf_owner")
  collapse::gv(x, unlist_(RE_NAME$snf_owner)) |>
    replace_nz() |>
    RC_rhc_owner() |>
    data_frame()
}

#' @export
polish.transparency <- function(x) {
  rename_with(x, "transparency")
  collapse::gv(x, unlist_(RE_NAME$transparency)) |>
    replace_nz() |>
    rc_integer("case") |>
    rc_date_ymd("action_date") |>
    data_frame()
}
