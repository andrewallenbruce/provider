#' @noRd
uuid_pdc <- function(endpoint) {
  switch(
    endpoint,
    affiliations = "27ea-46a8",
    clinicians = "mj5m-pzi6",
    hospitals2 = "xubh-q36u",
    esrd = "23ew-n7w9",
    cli::cli_abort("{.arg endpoint} {.val {endpoint}} is invalid.")
  )
}

#' @noRd
opts_pdc <- function(
  results = "true",
  limit = 1500L,
  offset = 0L
) {
  flatten_opts(params(
    count = "true",
    results = results,
    limit = limit,
    offset = offset,
    format = "json",
    rowIds = "false",
    schema = "false",
    keys = "true"
  ))
}

#' @noRd
URL_PDC <- function(x) {
  paste0(
    "https://data.cms.gov/provider-data/api/1/datastore/query/",
    uuid_pdc(x),
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
    purrr::imap(\(x, n) query("pdc", x, n)) |>
    flatten_query()
}

#' @noRd
pdc <- function(
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
flatten_pdc <- function(url, query = NULL, ...) {
  flatten_url(
    base = url,
    query %0% NULL,
    opts_pdc(...)
  )
}

#' @noRd
method(request_preview, PDC) <- function(x) {
  cli_empty(x@end)
  flatten_pdc(x@url, NULL, limit = 10L) |>
    base_request("results") |>
    add_class(x@end)
}

#' @noRd
method(request_single, PDC) <- function(x) {
  report_count(x)
  flatten_pdc(x@url, x@query) |>
    base_request("results") |>
    add_class(x@end)
}

#' @noRd
method(request_multi, PDC) <- function(x) {
  cli_pages(x@count, x@limit, x@end)
  flatten_pdc(x@url, x@query, offset = "<<i>>") |>
    base_parallel(x@count, x@limit, "results") |>
    add_class(x@end)
}
