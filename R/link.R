#' @include aaa-classes.R
NULL

#' @noRd
Result <- S7::new_class(
  "Result",
  package = NULL,
  properties = list(
    df = S7::new_S3_class("tbl_df")
  )
)

#' @noRd
chain <- S7::new_generic("chain", c("x", "end"))

#' @noRd
S7::method(chain, list(Result, S7::class_function)) <- function(x, end) {
  x <- S7::prop(x, "df")
  k <- key(x)

  if (!is_key(k)) {
    if (is.null(k)) {
      return(x)
    }
    y <- end(k)

    if (no_rows(y)) {
      return(x)
    }

    return(link(x, y))
  }

  y <- rowbind2(purrr::map(S7::prop(k, "split"), end))

  if (no_rows(y)) {
    return(x)
  }

  link(x, y)
}

#' @noRd
fn_order_refer <- rlang::as_function(~ order_refer(npi = .x))

#' @noRd
fn_hospitals2 <- rlang::as_function(~ hospitals2(ccn = .x))

#' @noRd
link <- S7::new_generic("link", c("x", "y"))

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
  rc_replace(x, "status", "status_y")
}
