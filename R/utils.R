#' @autoglobal
rename_ <- function(x, NM) {
  if (is.null(NM)) {
    return(x)
  }
  collapse::setrename(x, NM, .nse = FALSE)
  collapse::gv(x, unlist_(NM))
}

# set_args(providers)
#' @noRd
set_args <- function(fn) {
  rlang::fn_fmls(fn) |>
    as.list() |>
    list2env(envir = .GlobalEnv)
}

#' @noRd
map_na_if <- function(i) {
  purrr::modify_if(i, is.character, function(x) {
    vctrs::vec_slice(x, vctrs::vec_in(x, haystack = "")) <- NA_character_
    x
  })
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

#' @autoglobal
#' @noRd
as_date <- function(x, ..., fmt = "%Y-%m-%d") {
  as.Date(x, ..., format = fmt)
}

#' @autoglobal
#' @noRd
to_string <- function(x) {
  purrr::map_chr(x, \(i) toString(unlist_(i), width = NULL))
}
