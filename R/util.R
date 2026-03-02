#' @noRd
has_letter <- function(x) {
  grepl("[A-Z]", x, ignore.case = TRUE, perl = TRUE)
}

#' @noRd
is_numeric <- function(x) {
  !has_letter(x)
}

#' @noRd
search_in <- function(x, column, what) {
  if (is.null(what)) {
    return(x)
  }
  search_in_impl(x, column, what)
}

#' @noRd
search_in_impl <- function(x, column, what) {
  vctrs::vec_slice(x, vctrs::vec_in(x[[column]], collapse::funique(what)))
}

#' @noRd
`%0%` <- function(x, y) {
  if (vctrs::vec_is_empty(x)) y else x
}

#' @noRd
`%|%` <- function(x, default = x) {
  if (is.null(x)) NULL else default
}

#' @noRd
yank <- function(x, ..., .def = NULL) {
  purrr::pluck(x, 1, ..., .default = .def)
}


#' @noRd
`yank<-` <- function(x, value) {
  purrr::pluck(x, 1) <- value
  x
}

# subset_detect <- function(i, j, p, n = FALSE, ci = FALSE) {
#   collapse::sbt(
#     i,
#     pdetect(
#       x = i[[rlang::ensym(j)]],
#       p = p,
#       n = n,
#       ci = ci
#     )
#   )
# }

#' @noRd
date_year <- function(x) {
  strtoi(substr(x, 1, 4))
}

#' @autoglobal
#' @noRd
this_year <- function() {
  strtoi(substr(Sys.Date(), 1, 4))
}

#' @noRd
join_on <- function(x, y, on) {
  collapse::join(x, y, on, verbose = 0, multiple = TRUE)
}

#' @noRd
unlist_ <- function(x) {
  unlist(x, use.names = FALSE)
}
