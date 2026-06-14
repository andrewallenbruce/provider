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
S7::method(chain, list(s3_opt_out, S7::class_function)) <- function(x, fn) {
  k <- key(x)

  if (!k@length) {
    return(x)
  }

  if (k@chunks == 1L) {
    y <- fn(npi = S7::S7_data(k))

    if (nrow0(y)) {
      return(x)
    }
    y <- collapse::ss(
      pivot_order_refer(y),
      j = c("npi", "order_refer")
    )

    collapse::gv(x, "order_refer") <- NULL

    return(join2(x, y, "npi"))
  }

  y <- k@split |>
    purrr::map(\(x) fn(npi = x)) |>
    rowbind2(NULL)

  if (nrow0(y)) {
    return(x)
  }
  y <- collapse::ss(
    pivot_order_refer(y),
    j = c("npi", "order_refer")
  )
  collapse::gv(x, "order_refer") <- NULL

  join2(x, y, "npi")
}
