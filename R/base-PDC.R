#' @noRd
add_class <- function(x, endpoint) {
  structure(x, class = c(endpoint, "tbl_df", "tbl", "data.frame"))
}

#' @noRd
URL_PDC <- function(x) {
  paste0(
    "https://data.cms.gov/provider-data/api/1/datastore/query/",
    uuid_prov(x),
    "/0?"
  )
}

#' @noRd
param_pdc <- function(...) {
  ParamPDC(params(...))
}

#' @noRd
method(build, ParamPDC) <- function(x) {
  S7_data(x) %0% return(NULL)

  S7_data(x) |>
    purrr::imap(\(x, n) query(api = "prov", x, n)) |>
    flatten_query()
}

#' @noRd
as_pdc <- function(
  ...,
  .count = FALSE,
  .set = FALSE,
  end = call_name(call_match(
    call = caller_call(),
    fn = caller_fn()
  ))
) {
  check_bool_(.count)
  check_bool_(.set)
  check_count_set(.count, .set)

  PDC(
    end = end,
    query = build(param_pdc(...)) %||% character(0),
    action = if (.count) {
      "count"
    } else if (.set) {
      "set"
    } else {
      ""
    }
  )
}

#' @noRd
method(request_preview, PDC) <- function(x) {
  cli_empty(x@end)
  flatten_url(x@url, NULL, opts_prov(limit = 10L)) |>
    base_request("results") |>
    add_class(x@end)
}

#' @noRd
method(req_single, PDC) <- function(x) {
  cli_results(x@results, x@end)
  flatten_url(x@url, x@query, opts_prov()) |>
    base_request("results") |>
    add_class(x@end)
}

#' @noRd
method(req_multi, PDC) <- function(x) {
  cli_pages(x@results, x@limit, x@end)
  flatten_url(x@url, x@query %0% NULL, opts_prov(offset = "<<i>>")) |>
    base_parallel(x@results, x@limit, "results") |>
    add_class(x@end)
}

#' @noRd
method(execute, API) <- function(x) {
  if (empty(x)) {
    cli_total(x@results, x@end)
    if (x@action == "set") {
      return(req_multi(x))
    }

    if (x@action == "count") {
      return(x@results)
    }

    return(request_preview(x))
  }

  if (x@results == 0L || x@action == "count") {
    cli_results(x@results, x@end)
    return(x@results)
  }

  if (x@results <= x@limit) {
    return(req_single(x))
  }
  req_multi(x)
}
