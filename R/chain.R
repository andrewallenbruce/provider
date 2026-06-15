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
S7::method(chain, list(s3_opt_out, S7::class_function)) <- function(
  x,
  endpoint
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
    y <- endpoint(k)

    if (no_rows(y)) {
      return(x)
    }

    return(finish(x, y))
  }

  y <- rowbind2(purrr::map(k@split, endpoint))

  if (no_rows(y)) {
    return(x)
  }

  finish(x, y)
}

#' @noRd
fn_hospitals2 <- rlang::as_function(~ hospitals2(ccn = .x))

#' @noRd
S7::method(key, s3_hospitals) <- function(x) {
  x <- collapse::funique(collapse::na_rm(x[["ccn"]]))
  k <- Key(x, 200L)

  if (!k@length) {
    return(NULL)
  }
  if (k@chunks == 1L) {
    return(S7::S7_data(k))
  }
  return(k)
}

#' @noRd
S7::method(chain, list(s3_hospitals, S7::class_function)) <- function(
  x,
  endpoint
) {
  k <- key(x)

  if (!is_key(k)) {
    if (is.null(k)) {
      return(x)
    }
    y <- hospitals2(ccn = k)

    if (no_rows(y)) {
      return(x)
    }
    y <- collapse::ss(
      y,
      j = c("ccn", "rating", "county", "status"),
      check = FALSE
    )

    x <- join2(x, y, on = "ccn") |>
      rc_combine("status", "status_y")

    return(x)
  }

  y <- purrr::map(k@split, \(x) hospitals2(ccn = x)) |>
    rowbind2()

  if (no_rows(y)) {
    return(x)
  }

  y <- collapse::ss(
    y,
    j = c("ccn", "rating", "county", "status"),
    check = FALSE
  )

  join2(x, y, on = "ccn") |>
    rc_combine("status", "status_y")
}
