#' @noRd
recode_with <- function(x, endpoint) {
  switch(
    endpoint,
    affiliations = RC_affiliations(x),
    clia = RC_clia(x),
    clinicians = RC_clinicians(x),
    esrd = RC_esrd(x),
    hospitals = RC_hospitals(x),
    hospitals2 = RC_hospitals2(x),
    opt_out = RC_opt_out(x),
    order_refer = RC_order_refer(x),
    pending = RC_pending(x),
    providers = RC_providers(x),
    reassignments = RC_reassignments(x),
    revocations = RC_revocations(x),
    transparency = RC_transparency(x),
    rhc_enroll = RC_rhc_enroll(x),
    rhc_owner = RC_rhc_owner(x),
    fqhc_enroll = RC_fqhc_enroll(x),
    fqhc_owner = RC_fqhc_owner(x),
    x
  )
}

#' @noRd
RC_clia <- function(x) {
  x <- collapse::av(
    x,
    facility_name = combine_cols(x$fac_name_1, x$fac_name_2),
    address = combine_cols(x$add_1, x$add_2),
    phone = combine_cols(x$phone_1, x$phone_1),
    region = combine_cols(x$reg_cd, x$reg_st),
    ssa = combine_cols(x$ssa_st, x$ssa_cty),
    fips = combine_cols(x$fips_st, x$fips_cty),
    cbsa = combine_cols(x$cbsa_1, x$cbsa_2)
  )

  collapse::gv(
    x,
    c(
      "fac_name_1",
      "fac_name_2",
      "add_1",
      "add_2",
      "phone_1",
      "phone_2",
      "reg_cd",
      "reg_st",
      "ssa_st",
      "ssa_cty",
      "fips_st",
      "fips_cty",
      "cbsa_1",
      "cbsa_2"
    )
  ) <- NULL

  rc_bin(x, collapse::gvr(x, "_ind$", return = 2L)) |>
    rc_date_ymd2(collapse::gvr(x, "_date$", return = 2L))
}

#' @noRd
RC_esrd <- function(x) {
  x <- collapse::av(x, address = combine_cols(x$add_1, x$add_2))
  collapse::gv(x, c("add_1", "add_2")) <- NULL

  rc_integer(x, c("network", "stars")) |>
    rc_date_ymd("cert_date")
}

#' @noRd
RC_affiliations <- function(x) {
  rc_integer(x, "npi")
}

#' @noRd
#' @autoglobal
RC_clinicians <- function(x) {
  x <- collapse::av(
    x,
    org_add = combine_cols(x$add_1, x$add_2),
    specialty = combine_cols(x$specialty, x$spec_other)
  )
  collapse::gv(x, c("add_1", "add_2", "spec_other")) <- NULL

  rc_integer(x, c("npi", "grad_year", "org_mem"))
}

#' @noRd
RC_hospitals <- function(x) {
  x <- collapse::av(x, address = combine_cols(x$add_1, x$add_2))
  collapse::gv(x, c("add_1", "add_2")) <- NULL

  rc_integer(x, "npi") |>
    rc_date_ymd(c("inc_date", "reh_date")) |>
    rc_bin(collapse::gvr(x, "multi|^sub_", return = 2L))
}

#' @noRd
RC_hospitals2 <- function(x) {
  rc_integer_supp(x, "rating")
}

#' @noRd
RC_opt_out <- function(x) {
  x <- collapse::av(x, address = combine_cols(x$add_1, x$add_2))
  collapse::gv(x, c("add_1", "add_2")) <- NULL

  rc_integer(x, "npi") |>
    rc_bin("order_refer") |>
    rc_date_mdy(c("start_date", "end_date", "updated"))
}

#' @noRd
RC_order_refer <- function(x) {
  rc_integer(x, "npi") |>
    rc_bin(c("ptb", "dme", "hha", "pmd", "hospice"))
}

#' @noRd
RC_pending <- function(x) {
  rc_integer(x, "npi")
}

#' @noRd
RC_providers <- function(x) {
  rc_integer(x, "npi") |>
    rc_bin("multi")
}

#' @noRd
RC_reassignments <- function(x) {
  rc_integer(x, c("npi", "employers", "employees"))
}

#' @noRd
RC_revocations <- function(x) {
  rc_integer(x, "npi") |>
    rc_bin("multi") |>
    rc_date_ymd(c("start_date", "end_date"))
}

#' @noRd
RC_rhc_enroll <- function(x) {
  x <- collapse::av(x, address = combine_cols(x$add_1, x$add_2))
  collapse::gv(x, c("add_1", "add_2")) <- NULL

  rc_integer(x, "npi") |>
    rc_bin("multi") |>
    rc_date_ymd("inc_date")
}

#' @noRd
RC_rhc_owner <- function(x) {
  x <- collapse::av(x, own_add = combine_cols(x$own_add_1, x$own_add_2))
  collapse::gv(x, c("own_add_1", "own_add_2")) <- NULL

  rc_integer(x, "own_code") |>
    rc_double("own_pct") |>
    rc_bin(collapse::gvr(x, "multi|_ind$", return = 2L)) |>
    rc_date_ymd("own_date")
}

#' @noRd
RC_fqhc_enroll <- function(x) {
  x <- collapse::av(x, address = combine_cols(x$add_1, x$add_2))
  collapse::gv(x, c("add_1", "add_2")) <- NULL

  rc_integer(x, "npi") |>
    rc_bin("multi") |>
    rc_date_ymd("inc_date")
}

#' @noRd
RC_fqhc_owner <- function(x) {
  x <- collapse::av(x, own_add = combine_cols(x$own_add_1, x$own_add_2))
  collapse::gv(x, c("own_add_1", "own_add_2")) <- NULL

  rc_integer(x, "own_code") |>
    rc_double("own_pct") |>
    rc_bin(collapse::gvr(x, "multi|_ind$", return = 2L)) |>
    rc_date_ymd("own_date")
}

#' @noRd
RC_transparency <- function(x) {
  rc_integer(x, "case") |>
    rc_date_ymd("action_date")
}
