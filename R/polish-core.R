#' @noRd
add_class <- function(x, endpoint = NULL) {
  `class<-`(
    cheapr::as_df(x),
    c(
      if (!is.null(endpoint)) endpoint,
      "tbl_df",
      "tbl",
      "data.frame"
    )
  )
}

#' @noRd
add_class2 <- function(x, endpoint) {
  `class<-`(x, c(endpoint, class(x)))
}

#' @noRd
set_rename <- function(x) {
  collapse::setrename(x, RE_NAME[[class(x)[1]]], .nse = FALSE)
  replace_nz(x)
}

#' @noRd
get_columns <- function(x) {
  collapse::gv(x, unlist_(RE_NAME[[class(x)[1]]]))
}

#' @noRd
set_nz <- function(x) {
  collapse::setv(x, "", NA_character_)
}

#' @noRd
replace_nz <- function(x) {
  collapse::settfmv(x, is.character, set_nz)
}

#' @noRd
rc_trim <- function(x) {
  purrr::modify_if(x, is.character, trimws)
}

#' @noRd
recoder <- function(.f) {
  function(x, v) {
    collapse::tfmv(.data = x, vars = v, FUN = .f)
  }
}

#' @noRd
rc_bin <- recoder(bin_col)

#' @noRd
rc_ymd <- recoder(as_date_ymd)

#' @noRd
rc_ymd2 <- recoder(as_date_ymd2)

#' @noRd
rc_mdy <- recoder(as_date_mdy)

#' @noRd
bin_col <- function(x) {
  cheapr::case(
    x %in_% c("YES", "Y", "Yes", "True") ~ 1L,
    x %in_% c("NO", "N", "No", "False") ~ 0L,
    .default = NA_integer_
  )
}

#' @noRd
as_date_ymd <- function(x, ...) {
  as.Date.character(x, format = "%Y-%m-%d", ...)
}

#' @noRd
as_date_ymd2 <- function(x, ...) {
  as.Date.character(x, format = "%Y%m%d", ...)
}

#' @noRd
as_date_mdy <- function(x, ...) {
  as.Date.character(x, format = "%m/%d/%Y", ...)
}
