#' @noRd
build <- S7::new_generic("build", "x")

#' @noRd
count <- S7::new_generic("count", "x")

#' @noRd
preview <- S7::new_generic("preview", "x")

#' @noRd
request_single <- S7::new_generic("request_single", "x")

#' @noRd
request_multi <- S7::new_generic("request_multi", "x")

#' @noRd
execute <- S7::new_generic("execute", "x")

#' @noRd
polish <- S7::new_generic("polish", "x")

#' @noRd
recode <- S7::new_generic("recode", "x")

#' @noRd
key <- S7::new_generic("key", "x")

#' @noRd
chain <- S7::new_generic("chain", c("x", "end"))

#' @noRd
link <- S7::new_generic("link", c("x", "y"))

#' @noRd
S7::method(execute, Endpoint) <- function(x) {
  check_online()

  if (length(x@query) == 0L) {
    switch(
      x@action,
      count = return(report_total(x)),
      set = return(request_multi(x)),
      return(preview(x))
    )
  }

  if (x@pages == 0L || x@action == "count") {
    report_count(x)
    return(x@count)
  }

  if (x@pages == 1L) {
    return(request_single(x))
  }
  request_multi(x)
}

#' @noRd
S7::method(execute, EndpointCMSList) <- function(x) {
  check_online()

  if (length(x@query) == 0L) {
    switch(
      x@action,
      count = return(report_total(x)),
      set = return(request_multi(x)),
      return(preview(x))
    )
  }

  if (x@pages == 0L || x@action == "count") {
    report_count(x)
    return(x@count)
  }

  if (x@pages <= length(x@url)) {
    return(request_single(x))
  }
  request_multi(x)
}

#' @noRd
S7::method(chain, list(Result, S7::class_function)) <- function(x, end) {
  x <- x@df
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

  y <- rowbind2(purrr::map(k@split, end))

  if (no_rows(y)) {
    return(x)
  }

  link(x, y)
}
