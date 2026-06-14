#' @include aaa-classes.R
#' @include aaa-generics.R
#' @noRd
S7::method(key, s3_opt_out) <- function(x) {
  x <- unlist_(collapse::ss(x, x[["order_refer"]] %==% 1L, "npi"))
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
S7::method(chain, list(s3_opt_out, S7::class_function)) <- function(x, fn) {
  k <- key(x)

  if (!is_key(k)) {
    if (is.null(k)) {
      return(x)
    }
    y <- fn(k)

    if (nrow0(y)) {
      return(x)
    }

    y <- pivot_order_refer(y)
    y <- collapse::ss(y, j = c("npi", "order_refer"))
    collapse::gv(x, "order_refer") <- NULL
    return(join2(x, y, "npi"))
  }

  y <- rowbind2(purrr::map(k@split, fn))

  if (nrow0(y)) {
    return(x)
  }

  y <- pivot_order_refer(y)
  y <- collapse::ss(y, j = c("npi", "order_refer"))
  collapse::gv(x, "order_refer") <- NULL
  join2(x, y, "npi")
}
