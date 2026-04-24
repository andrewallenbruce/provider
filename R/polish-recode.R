#' @noRd
recode_with <- function(x, endpoint) {
  switch(
    endpoint,
    affiliations = RC_affiliations(x),
    clinicians = RC_clinicians(x),
    hospitals = RC_hospitals(x),
    opt_out = RC_opt_out(x),
    order_refer = RC_order_refer(x),
    pending = RC_pending(x),
    providers = RC_providers(x),
    reassignments = RC_reassignments(x),
    revocations = RC_revocations(x),
    transparency = RC_transparency(x),
    rhc_enroll = RC_rhc_enroll(x),
    rhc_owner = RC_rhc_owner(x),
    x
  )
}

#' @noRd
RC_affiliations <- function(x) {
  rc_integer(x, "npi")
}
#' @noRd
#' @autoglobal
RC_clinicians <- function(x) {
  rc_integer(x, c("npi", "grad_year", "org_mem")) |>
    collapse::mtt(
      specialty = combine_cols(specialty, spec_other),
      org_add = combine_cols(add_1, add_2),
      spec_other = NULL,
      add_1 = NULL,
      add_2 = NULL
    )
}

#' @noRd
#' @autoglobal
RC_hospitals <- function(x) {
  rc_integer(x, "npi") |>
    rc_date_ymd(c("inc_date", "reh_date")) |>
    rc_bin(collapse::gvr(x, "multi|^sub_", return = 2L)) |>
    collapse::mtt(
      address = combine_cols(add_1, add_2),
      add_1 = NULL,
      add_2 = NULL
    )
}

#' @noRd
#' @autoglobal
RC_opt_out <- function(x) {
  rc_integer(x, "npi") |>
    rc_bin("order_refer") |>
    rc_date_mdy(c("start_date", "end_date", "updated")) |>
    collapse::mtt(
      address = combine_cols(add_1, add_2),
      add_1 = NULL,
      add_2 = NULL
    )
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
#' @autoglobal
RC_rhc_enroll <- function(x) {
  rc_integer(x, "npi") |>
    rc_bin("multi") |>
    rc_date_ymd("inc_date") |>
    collapse::mtt(
      address = combine_cols(add_1, add_2),
      add_1 = NULL,
      add_2 = NULL
    )
}

#' @noRd
#' @autoglobal
RC_rhc_owner <- function(x) {
  rc_integer(x, "own_code") |>
    rc_double("own_pct") |>
    rc_bin(collapse::gvr(x, "multi|_ind$", return = 2L)) |>
    rc_date_ymd("own_date") |>
    collapse::mtt(
      own_add = combine_cols(own_add_1, own_add_2),
      own_add_1 = NULL,
      own_add_2 = NULL
    )
}

#' @noRd
RC_transparency <- function(x) {
  rc_integer(x, "id") |>
    rc_date_ymd("action_date")
}
