#' @noRd
request_count <- S7::new_generic("request_count", "x")

#' @noRd
request_preview <- S7::new_generic("request_preview", "x")

#' @noRd
request_single <- S7::new_generic("request_single", "x")

#' @noRd
request_multi <- S7::new_generic("request_multi", "x")

#' @noRd
build <- S7::new_generic("build", "x")

#' @noRd
key <- S7::new_generic("key", "x")

#' @noRd
chain <- S7::new_generic("chain", c("x", "y"))

#' @noRd
polish <- S7::new_generic("polish", "x")

#' @noRd
execute <- S7::new_generic("execute", "x")

#' @noRd
S7::method(execute, Endpoint) <- function(x) {
  check_online()

  if (length(x@query) == 0L) {
    switch(
      x@action,
      count = return(report_total(x)),
      set = return(request_multi(x)),
      return(request_preview(x))
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
      return(request_preview(x))
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
