#' @noRd
add_class <- function(x, endpoint) {
  structure(x, class = c(endpoint, "tbl_df", "tbl", "data.frame"))
}

#' @noRd
rename_with <- function(x, endpoint) {
  if (rlang::is_null(RE_NAME[[endpoint]])) {
    return(x)
  }
  rlang::inject(collapse::recode_char(
    colnames(x),
    !!!RE_NAME[[endpoint]],
    set = TRUE
  ))
  collapse::gv(x, unlist_(RE_NAME[[endpoint]])) |>
    replace_nz() |>
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
rc_ <- function(.f) {
  function(x, v) {
    collapse::tfmv(.data = x, vars = v, FUN = .f)
  }
}

#' @noRd
rc_integer <- rc_(as.integer)

#' @noRd
rc_integer_supp <- rc_(as_integer_supp)

#' @noRd
rc_double <- rc_(as.double)

#' @noRd
rc_bin <- rc_(bin_col)

#' @noRd
rc_date_ymd <- rc_(as_date_ymd)

#' @noRd
rc_date_ymd2 <- rc_(as_date_ymd2)

#' @noRd
rc_date_mdy <- rc_(as_date_mdy)

#' @noRd
combine_cols <- function(e1, e2, sep = ", ") {
  cheapr::if_else_(cheapr::is_na(e2), e1, cheapr::paste_(e1, e2, sep = sep))
}

#' @noRd
combine_columns <- function(
  x,
  main,
  otxt,
  prefix = NULL,
  sep = ", "
) {
  i <- cheapr::which_not_na(x[[otxt]])

  if (rlang::is_empty(i)) {
    collapse::gv(x, otxt) <- NULL
    return(x)
  }

  COL <- paste0(prefix, paste(x[i, otxt, drop = TRUE], sep = sep))

  collapse::gv(x[i, ], main) <- COL
  collapse::gv(x, otxt) <- NULL
  x
}

#' @noRd
bin_col <- function(x) {
  cheapr::case(
    x %in_% c("Y", "Yes") ~ 1L,
    x %in_% c("N", "No") ~ 0L,
    .default = NA_integer_
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
as_date_ymd2 <- function(x, ...) {
  as.Date(x, ..., format = "%Y%m%d")
}

#' @noRd
as_date_mdy <- function(x, ...) {
  as.Date(x, ..., format = "%m/%d/%Y")
}
