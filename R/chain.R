#' @include aaa-classes.R
#' @include aaa-generics.R
NULL

#' @noRd
fn_order_refer <- rlang::as_function(~ order_refer(npi = .x))

#' @noRd
S7::method(key, s3_opt_out) <- function(x) {
  x <- unlist_(ss_key(x, "npi", "order_refer"))
  x <- as.character(collapse::funique(x))
  k <- Key(x, 150L)

  if (!k@length) {
    return(NULL)
  }
  if (k@chunks == 1L) {
    return(S7::S7_data(k))
  }
  return(k)
}

#' @noRd
is_key <- function(x) {
  S7::S7_inherits(x, Key)
}

#' @noRd
S7::method(chain, list(s3_opt_out, S7::class_function)) <- function(
  x,
  endpoint_fn
) {
  finish <- function(x, y) {
    y <- pivot_order_refer(y)
    y <- collapse::ss(y, j = c("npi", "order_refer"))
    collapse::gv(x, "order_refer") <- NULL
    join2(x, y, "npi")
  }

  k <- key(x)

  if (!is_key(k)) {
    if (is.null(k)) {
      return(x)
    }
    y <- endpoint_fn(k)

    if (nrow0(y)) {
      return(x)
    }

    return(finish(x, y))
  }

  y <- rowbind2(purrr::map(k@split, endpoint_fn))

  if (nrow0(y)) {
    return(x)
  }

  finish(x, y)
}
