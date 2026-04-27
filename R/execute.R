#' @noRd
END_EXP <- rlang::expr(rlang::call_name(rlang::call_match(
  call = rlang::caller_call(),
  fn = rlang::caller_fn()
)))

#' @noRd
URL_CMS <- c("https://data.cms.gov/data-api/v1/dataset/", "/data")

#' @noRd
URL_PROV <- c(
  "https://data.cms.gov/provider-data/api/1/datastore/query/",
  "/0?"
)

#' @noRd
S7::method(execute, base_cms | base_prov) <- function(x) {
  if (!length(x@arg)) {
    if (x@set) {
      return(polish(req_set(x), x@end))
    }

    if (x@count) {
      cli_total(x@N, x@end)
      return(invisible(x))
    }

    return(polish(req_empty(x), x@end))
  }

  if (x@N == 0L || x@count) {
    cli_results(x@N, x@end)
    return(invisible(x))
  }

  if (x@N <= x@limit) {
    return(polish(req_single(x), x@end))
  }
  polish(req_multi(x), x@end)
}

#' @noRd
S7::method(execute, list_cms) <- function(x) {
  if (!length(x@arg)) {
    if (x@set) {
      return(polish(req_set(x), x@end, x@id))
    }

    if (x@count) {
      cli_total2(x@N, x@end)
      return(invisible(x))
    }

    return(polish(req_empty(x), x@end, x@id))
  }

  if (sum2(x@N) == 0L || x@count) {
    cli_results2(x@N, x@end)
    return(invisible(x))
  }

  if (all2(x@N <= x@limit)) {
    return(polish(req_single(x), x@end, x@id))
  }
  polish(req_multi(x), x@end, x@id)
}
