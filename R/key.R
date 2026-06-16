#' @include aaa-classes.R
#' @include aaa-generics.R
NULL

#' @noRd
extract_key <- function(x) {
  check_key(x)
  if (x@length == 0L) {
    return(NULL)
  }
  if (x@chunks == 1L) {
    return(S7::S7_data(x))
  }
  return(x)
}

#' @noRd
S7::method(key, s3_opt_out) <- function(x) {
  x <- collapse::ss(
    x = x,
    i = x[["order_refer"]] %==% 1L,
    j = "npi",
    check = FALSE
  )
  x <- unlist_(x)
  x <- collapse::funique(collapse::na_rm(x))
  x <- as.character(x)
  k <- Key(x, 150L)
  extract_key(k)
}

#' @noRd
S7::method(key, s3_hospitals) <- function(x) {
  x <- collapse::funique(collapse::na_rm(x[["ccn"]]))
  k <- Key(x, 200L)
  extract_key(k)
}
