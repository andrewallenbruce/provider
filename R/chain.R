#' @include aaa-classes.R
#' @include aaa-generics.R
#' @noRd
S7::method(key, s3_opt_out) <- function(x) {
  i <- cheapr::which_val(x[["order_refer"]], 1L)
  x <- unlist_(cheapr::sset(x, i, "npi"))
  x <- as.character(collapse::funique(x))
  Key(x)
}

#' @noRd
S7::method(chain, list(s3_opt_out, s3_order_refer)) <- function(x, y) {
  key(x)
}
