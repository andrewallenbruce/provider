#' @include aaa-classes.R
#' @include aaa-generics.R
NULL

#' @noRd
fn_order_refer <- rlang::as_function(~ order_refer(npi = .x))

#' @noRd
fn_hospitals2 <- rlang::as_function(~ hospitals2(ccn = .x))

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
  x <- unlist_(ss_key(x, "npi", "order_refer"))
  x <- as.character(collapse::funique(x))
  k <- Key(x, 150L)
  extract_key(k)
}

#' @noRd
S7::method(key, s3_hospitals) <- function(x) {
  x <- collapse::funique(collapse::na_rm(x[["ccn"]]))
  k <- Key(x, 200L)
  extract_key(k)
}

#' @noRd
S7::method(link, list(s3_opt_out, s3_order_refer)) <- function(x, y) {
  y <- pivot_order_refer(y)
  y <- collapse::ss(y, j = c("npi", "order_refer"), check = FALSE)
  collapse::gv(x, "order_refer") <- NULL
  join2(x, y, "npi")
}

#' @noRd
S7::method(link, list(s3_hospitals, s3_hospitals2)) <- function(x, y) {
  y <- collapse::ss(
    y,
    j = c("ccn", "rating", "county", "status"),
    check = FALSE
  )
  x <- join2(x, y, on = "ccn")
  rc_combine(x, "status", "status_y")
}
