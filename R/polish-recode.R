#' @noRd
RC_esrd <- function(x) {
  x <- collapse::av(x, address = combine_cols(x$add_1, x$add_2))
  collapse::gvr(x, "add_") <- NULL

  rc_integer(x, c("network", "rating")) |>
    rc_date_ymd("cert_date")
}

#' @noRd
RC_clinicians <- function(x) {
  x <- collapse::av(
    x,
    org_add = combine_cols(x$add_1, x$add_2),
    specialty = combine_cols(x$specialty, x$spec_other)
  )
  collapse::gvr(x, "add_|spec_") <- NULL

  rc_integer(x, c("npi", "grad_year", "org_mem"))
}

#' @noRd
RC_hospitals <- function(x) {
  x <- collapse::av(x, address = combine_cols(x$add_1, x$add_2))
  collapse::gvr(x, "add_") <- NULL

  rc_integer(x, "npi") |>
    rc_date_ymd(collapse::gvr(x, "_date$", return = 3L)) |>
    rc_bin(collapse::gvr(x, "multi|^sub_", return = 3L))
}

#' @noRd
RC_opt_out <- function(x) {
  x <- collapse::av(x, address = combine_cols(x$add_1, x$add_2))
  collapse::gvr(x, "add_") <- NULL

  rc_integer(x, "npi") |>
    rc_bin("order_refer") |>
    rc_date_mdy(c("start_date", "end_date", "updated"))
}

#' @noRd
RC_rhc_enroll <- function(x) {
  x <- collapse::av(x, address = combine_cols(x$add_1, x$add_2))
  collapse::gvr(x, "add_") <- NULL

  rc_integer(x, "npi") |>
    rc_bin("multi") |>
    rc_date_ymd("inc_date")
}

#' @noRd
RC_rhc_owner <- function(x) {
  x <- collapse::av(x, own_add = combine_cols(x$own_add_1, x$own_add_2))
  collapse::gvr(x, "own_add_") <- NULL

  rc_integer(x, "own_code") |>
    rc_double("own_pct") |>
    rc_bin(collapse::gvr(x, "multi|_ind$", return = 3L)) |>
    rc_date_ymd("own_date") |>
    fqhc_owner_pivot()
}

#' @noRd
RC_fqhc_enroll <- function(x) {
  x <- collapse::av(x, address = combine_cols(x$add_1, x$add_2))
  collapse::gvr(x, "add_") <- NULL

  rc_integer(x, "npi") |>
    rc_bin("multi") |>
    rc_date_ymd("inc_date")
}

#' @noRd
RC_fqhc_owner <- function(x) {
  x <- collapse::av(x, own_add = combine_cols(x$own_add_1, x$own_add_2))
  collapse::gvr(x, "own_add_") <- NULL

  rc_integer(x, "own_code") |>
    rc_double("own_pct") |>
    rc_bin(collapse::gvr(x, "multi|_ind$", return = 3L)) |>
    rc_date_ymd("own_date") |>
    fqhc_owner_pivot()
}
