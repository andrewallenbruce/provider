#' @noRd
RC_npi <- function(x) {
  collapse::tfmv(x, "npi", as.integer)
}

#' @noRd
RC_npi_multi <- function(x) {
  RC_npi(x) |>
    collapse::tfmv("multi", bin_col)
}

#' @noRd
#' @autoglobal
RC_clinicians <- function(x) {
  collapse::tfmv(x, c("npi", "grad_year", "org_mem"), as.integer) |>
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
  RC_npi(x) |>
    collapse::tfmv(
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
      ),
      bin_col
    ) |>
    collapse::tfmv(c("inc_date", "reh_date"), as_date_ymd) |>
    collapse::mtt(
      address = combine_cols(add_1, add_2),
      add_1 = NULL,
      add_2 = NULL
    )
}

#' @noRd
#' @autoglobal
RC_opt_out <- function(x) {
  RC_npi(x) |>
    collapse::tfmv("order_refer", bin_col) |>
    collapse::tfmv(c("start_date", "end_date", "updated"), as_date_mdy) |>
    collapse::mtt(
      address = combine_cols(add_1, add_2),
      add_1 = NULL,
      add_2 = NULL
    )
}

#' @noRd
RC_order_refer <- function(x) {
  RC_npi(x) |>
    collapse::tfmv(c("ptb", "dme", "hha", "pmd", "hospice"), bin_col)
}

#' @noRd
RC_reassignments <- function(x) {
  collapse::tfmv(x, c("npi", "employers", "employees"), as.integer)
}

#' @noRd
RC_revocations <- function(x) {
  RC_npi_multi(x) |>
    collapse::tfmv(c("start_date", "end_date"), as_date_ymd)
}

#' @noRd
RC_transparency <- function(x) {
  collapse::tfmv(x, "id", as.integer) |>
    collapse::tfmv("action_date", as_date_ymd)
}
