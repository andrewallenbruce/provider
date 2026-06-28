#' @noRd
execute <- S7::new_generic("execute", "x")

#' @noRd
S7::method(execute, Endpoint) <- function(x) {
  check_online()

  if (length(x@query) == 0L) {
    switch(
      x@action,
      count = return(inform_summary(x)),
      set = return(request_multi(x)),
      return(preview(x))
    )
  }

  if (x@pages == 0L || x@action == "count") {
    inform_count(x)
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
      count = return(inform_summary(x)),
      set = return(request_multi(x)),
      return(preview(x))
    )
  }

  if (x@pages == 0L || x@action == "count") {
    inform_count(x)
    return(x@count)
  }

  if (x@pages <= length(x@url)) {
    return(request_single(x))
  }
  request_multi(x)
}
