#' @include aaa-classes.R
NULL

#' @noRd
Result <- S7::new_class(
  "Result",
  package = NULL,
  properties = list(
    df = S7::new_S3_class("tbl_df"),
    key = S7::new_property(Key | S7::class_atomic)
  )
)

#' @noRd
as_result <- function(x) {
  Result(df = x, key = shave(x))
}

#' @noRd
chain <- S7::new_generic("chain", c("x", "end"))

#' @noRd
S7::method(chain, list(Result, S7::class_function)) <- function(x, end) {
  if (!is_key(x@key)) {
    if (is.null(x@key)) {
      return(x@df)
    }
    y <- end(x@key)

    if (no_rows(y)) {
      return(x@df)
    }

    return(link(x@df, y))
  }

  y <- rowbind2(purrr::map(x@key@split, end))

  if (no_rows(y)) {
    return(x@df)
  }

  link(x@df, y)
}

#' @noRd
keychain <- list(
  order_refer = rlang::as_function(~ order_refer(npi = .x)),
  hospital2 = rlang::as_function(~ hospital2(ccn = .x)),
  nppes = rlang::as_function(~ nppes(npi = .x))
)

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
S7::method(link, list(s3_hospital, s3_hospital2)) <- function(x, y) {
  i <- c("ccn", "rating", "county", "status")
  y <- collapse::ss(y, j = i, check = FALSE)
  x <- join2(x, y, on = "ccn")
  rc_replace(x, "status", "status_y")
}

#' @noRd
S7::method(link, list(s3_providers, s3_nppes)) <- function(x, y) {
  y <- collapse::get_elem(y, "taxonomy")

  if (!rlang::is_empty(collapse::list_elem(y))) {
    y <- collapse::rowbind(y)
  }

  y <- collapse::ss(y, y[["order"]] %==% 1L, c("npi", "code"), check = FALSE)

  collapse::setrename(y, "code" = "taxonomy", .nse = TRUE)

  x <- join2(x, y, "npi")

  collapse::colorderv(x, c("prov_type", "taxonomy"), pos = "after")
}
