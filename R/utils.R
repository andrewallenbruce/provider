#' @noRd
df_tbl_ <- function(x) {
  `class<-`(cheapr::as_df(x), c("tbl_df", "tbl", "data.frame"))
}

#' @noRd
set_args <- function(fn) {
  invisible(
    list2env(
      as.list(
        rlang::fn_fmls(fn)
      ),
      envir = .GlobalEnv
    )
  )
}

#' @noRd
combine_ <- function(a, b, sep = "") {
  cheapr::if_else_(
    !cheapr::is_na(b),
    cheapr::paste_(a, b, sep = sep),
    a
  )
}

#' @noRd
bin_ <- function(x) {
  cheapr::val_match(
    x,
    "Y" ~ 1L,
    "N" ~ 0L,
    .default = NA_integer_
  )
}

#' @noRd
unlist_ <- function(x) {
  unlist(x, use.names = FALSE)
}

#' @noRd
has_letter <- function(x) {
  grepl("[A-Z]", x, ignore.case = TRUE, perl = TRUE)
}

#' @noRd
is_numeric <- function(x) {
  !has_letter(x)
}

#' @noRd
as_date <- function(x, ..., fmt = "%Y-%m-%d") {
  as.Date(x, ..., format = fmt)
}

#' @noRd
to_string <- function(x) {
  purrr::map_chr(x, \(i) toString(unlist_(i), width = NULL))
}
