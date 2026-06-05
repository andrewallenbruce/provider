#' @noRd
check_modifiers <- function(x, end) {
  if (any2(purrr::map_lgl(x, is_modifier))) {
    mods <- unlist_(x[purrr::map_lgl(x, is_modifier)])
    if (any2(mods %in% c("ends", "excludes"))) {
      cli::cli_abort(
        c(
          "Invalid {.cls modifier} used in {.fn {end}}: ",
          "x" = "{.fn ends} & {.fn excludes} do not work with the underlying API."
        ),
        call = call2(end)
      )
    }
  }
}

#' @noRd
uuid_pdc <- function(endpoint) {
  switch(
    endpoint,
    affiliations = "27ea-46a8",
    clinicians = "mj5m-pzi6",
    hospitals2 = "xubh-q36u",
    dialysis = "23ew-n7w9",
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
pdc <- function(
  count = FALSE,
  set = FALSE,
  ...,
  end = call_name(call_match(call = caller_call(), fn = caller_fn()))
) {
  x <- param_pdc(...)

  check_modifiers(x, end)

  PDC(
    end = end,
    url = URL_PDC(end),
    query = build(x) %||% character(0),
    action = count_set(count, set)
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
  report_empty()
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
  report_pages(x)
  flatten_pdc(x@url, x@query, offset = "<<i>>") |>
    base_parallel(x@count, x@limit, "results") |>
    add_class(x@end)
}
