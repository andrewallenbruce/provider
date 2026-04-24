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
    x
  )
}

#' @noRd
RC_affiliations <- function(x) {
  rc_as_integer(x, "npi")
}

#' @noRd
RC_pending <- function(x) {
  rc_as_integer(x, "npi")
}

#' @noRd
RC_providers <- function(x) {
  rc_as_integer(x, "npi") |>
    rc_as_bin("multi")
}

#' @noRd
#' @autoglobal
RC_clinicians <- function(x) {
  rc_as_integer(x, c("npi", "grad_year", "org_mem")) |>
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
  rc_as_integer(x, "npi") |>
    rc_as_bin(
      c(
        "multi",
        paste0(
          "sub_",
          c(
            "gen",
            "acute",
            "adu",
            "child",
            "ltc",
            "psy",
            "irf",
            "stc",
            "sba",
            "psu",
            "iru",
            "spec",
            "oth"
          )
        )
      )
    ) |>
    rc_as_date_ymd(c("inc_date", "reh_date")) |>
    collapse::mtt(
      address = combine_cols(add_1, add_2),
      add_1 = NULL,
      add_2 = NULL
    )
}

#' @noRd
#' @autoglobal
RC_opt_out <- function(x) {
  rc_as_integer(x, "npi") |>
    rc_as_bin("order_refer") |>
    rc_as_date_mdy(c("start_date", "end_date", "updated")) |>
    collapse::mtt(
      address = combine_cols(add_1, add_2),
      add_1 = NULL,
      add_2 = NULL
    )
}

#' @noRd
RC_order_refer <- function(x) {
  rc_as_integer(x, "npi") |>
    rc_as_bin(c("ptb", "dme", "hha", "pmd", "hospice"))
}

#' @noRd
RC_reassignments <- function(x) {
  rc_as_integer(x, c("npi", "employers", "employees"))
}

#' @noRd
RC_revocations <- function(x) {
  rc_as_integer(x, "npi") |>
    rc_as_bin("multi") |>
    collapse::tfmv(c("start_date", "end_date"), as_date_ymd)
}

#' @noRd
#' @autoglobal
RC_rhc_enroll <- function(x) {
  rc_as_integer(x, "npi") |>
    rc_as_bin("multi") |>
    rc_as_date_ymd("inc_date") |>
    collapse::mtt(
      address = combine_cols(add_1, add_2),
      add_1 = NULL,
      add_2 = NULL
    )
}

#' @noRd
RC_transparency <- function(x) {
  collapse::tfmv(x, "id", as.integer) |>
    collapse::tfmv("action_date", as_date_ymd)
}
