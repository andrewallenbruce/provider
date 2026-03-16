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
to_string <- function(x) {
  purrr::map_chr(x, \(i) toString(unlist_(i), width = NULL))
}
