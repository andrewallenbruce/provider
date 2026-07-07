#' @include aaa-classes.R
NULL

#' @noRd
KeyFrame <- S7::new_class(
  "KeyFrame",
  package = NULL,
  properties = list(
    frame = S7::new_S3_class("tbl_df"),
    key = S7::new_property(Key | S7::class_atomic)
  )
)

#' @noRd
as_keyframe <- function(x, key, threshold) {
  KeyFrame(
    frame = x,
    key = carve(
      x = x,
      key = key,
      threshold = threshold
      )
    )
}

#' @noRd
chain <- S7::new_generic("chain", c("x", "end"))

#' @noRd
S7::method(chain, list(KeyFrame, S7::class_function)) <- function(x, end) {
  if (!is_key(x@key)) {
    if (is.null(x@key)) {
      return(x@frame)
    }
    y <- end(x@key)

    if (no_rows(y)) {
      return(x@frame)
    }

    return(link(x@frame, y))
  }

  y <- rowbind2(purrr::map(x@key@split, end))

  if (no_rows(y)) {
    return(x@frame)
  }

  link(x@frame, y)
}

#' @noRd
KeyChain <- list(
  order_refer = rlang::as_function(~ order_refer(npi = .x)),
  hospital2 = rlang::as_function(~ hospital2(ccn = .x)),
  nppes = rlang::as_function(~ nppes(npi = .x))
)

#' @noRd
link <- S7::new_generic("link", c("x", "y"))

#' @noRd
S7::method(link, list(s3_opted_out, s3_order_refer)) <- function(x, y) {
  y <- pivot_order_refer(y)
  y <- ss_cols(y, c("npi", "order_refer"))
  collapse::gv(x, "order_refer") <- NULL
  join2(x, y, "npi")
}

#' @noRd
S7::method(link, list(s3_hospital, s3_hospital2)) <- function(x, y) {
  y <- ss_cols(y, c("ccn", "rating", "county", "status"))
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
  join2(x, y, "npi")
}
