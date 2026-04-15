#' @noRd
polish <- function(x, endpoint, .id = NULL) {
  replace_nz(x) |>
    rename_with(c(.id %&&% set_names(.id), column_renames(endpoint))) |>
    recode_with(endpoint) |>
    data_frame()
}

#' @noRd
replace_nz <- function(i) {
  purrr::modify_if(i, is.character, function(x) {
    vctrs::vec_assign(
      x,
      i = vctrs::vec_in(x, haystack = ""),
      value = NA_character_,
      slice_value = TRUE
    )
  })
}

#' @noRd
rename_with <- function(x, nm) {
  collapse::setrename(x, nm, .nse = FALSE)
  collapse::gv(x, unlist_(nm))
}

#' @noRd
recode_with <- function(x, endpoint) {
  switch(
    endpoint,
    clinicians = RC_clinicians(x),
    opt_out = RC_opt_out(x),
    order_refer = RC_order_refer(x),
    pending = RC_pending(x),
    providers = RC_providers(x),
    reassignments = RC_reassignments(x),
    revocations = RC_revocations(x),
    transparency = RC_transparency(x),
    x
  )
}

#' @noRd
combine_cols <- function(e1, e2, sep = ", ") {
  cheapr::if_else_(cheapr::is_na(e2), e1, cheapr::paste_(e1, e2, sep = sep))
}

#' @noRd
bin_col <- function(x) {
  cheapr::val_match(
    x,
    "Y" ~ 1L,
    "N" ~ 0L,
    .default = NA_integer_
  )
}

#' @noRd
as_date_ymd <- function(x, ...) {
  as.Date(x, ..., format = "%Y-%m-%d")
}

#' @noRd
as_date_mdy <- function(x, ...) {
  as.Date(x, ..., format = "%m/%d/%Y")
}
