#' @noRd
polish <- function(x, endpoint, id = NULL) {
  replace_nz(x) |>
    rename_with(nm = c(id %&&% set_names(id), column_renames(endpoint))) |>
    recode_with(endpoint) |>
    data_frame()
}

#' @noRd
rename_with <- function(x, nm) {
  if (rlang::is_null(nm)) {
    return(x)
  }
  collapse::setrename(x, nm, .nse = FALSE)
  collapse::gv(x, unlist_(nm))
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
rc_integer <- function(x, v) {
  collapse::tfmv(.data = x, vars = v, FUN = as.integer)
}

#' @noRd
rc_integer_supp <- function(x, v) {
  collapse::tfmv(.data = x, vars = v, FUN = as_integer_supp)
}

#' @noRd
rc_double <- function(x, v) {
  collapse::tfmv(.data = x, vars = v, FUN = as.double)
}

#' @noRd
rc_bin <- function(x, v) {
  collapse::tfmv(.data = x, vars = v, FUN = bin_col)
}

#' @noRd
rc_date_ymd <- function(x, v) {
  collapse::tfmv(.data = x, vars = v, FUN = as_date_ymd)
}

#' @noRd
rc_date_mdy <- function(x, v) {
  collapse::tfmv(.data = x, vars = v, FUN = as_date_mdy)
}

#' @noRd
combine_cols <- function(e1, e2, sep = ", ") {
  cheapr::if_else_(cheapr::is_na(e2), e1, cheapr::paste_(e1, e2, sep = sep))
}

#' @noRd
bin_col <- function(x) {
  cheapr::case(
    x %in_% c("Y", "Yes") ~ 1L,
    x %in_% c("N", "No") ~ 0L,
    .default = NA_integer_
  )
  # cheapr::val_match(
  #   x,
  #   "Y" ~ 1L,
  #   "N" ~ 0L,
  #   "Yes" ~ 1L,
  #   "No" ~ 0L,
  #   .default = NA_integer_
  # )
}

#' @noRd
entity_ <- function(x, type = c("int", "chr")) {
  switch(
    match.arg(type, c("int", "chr")),
    int = cheapr::val_match(x, 1 ~ 1L, 2 ~ 2L, .default = NA_integer_),
    chr = cheapr::val_match(
      x,
      "NPI-1" ~ 1L,
      "NPI-2" ~ 2L,
      .default = NA_integer_
    )
  )
}

#' @noRd
as_integer_supp <- function(x, ...) {
  suppressWarnings(as.integer(x, ...))
}

#' @noRd
as_date_ymd <- function(x, ...) {
  as.Date(x, ..., format = "%Y-%m-%d")
}

#' @noRd
as_date_mdy <- function(x, ...) {
  as.Date(x, ..., format = "%m/%d/%Y")
}
