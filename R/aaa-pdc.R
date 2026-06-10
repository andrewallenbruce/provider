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
        call = rlang::call2(end)
      )
    }
  }
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
url_pdc <- function(x) {
  paste0(
    "https://data.cms.gov/provider-data/api/1/datastore/query/",
    switch(
      x,
      affiliations = "27ea-46a8",
      clinicians = "mj5m-pzi6",
      hospitals2 = "xubh-q36u",
      dialysis = "23ew-n7w9",
      cli::cli_abort("{.arg endpoint} {.val {x}} is invalid.")
    ),
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
  end = NULL
) {
  if (is.null(end)) {
    end <- rlang::eval_bare(
      rlang::call_name(rlang::caller_call()),
      parent.frame(3)
    )
  }

  x <- param_pdc(...)

  check_modifiers(x, end)

  x <- PDC(
    end = end,
    url = url_pdc(end),
    query = build(x) %||% character(0),
    action = count_set(count, set)
  )

  x@count <- request_count(x)

  return(x)
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
S7::method(request_count, PDC) <- function(x) {
  if (length(x@query) > 0L || x@action == "count") {
    x <- flatten_pdc(x@url, x@query, results = "false")
    x <- base_request(x, "count")
    return(x)
  }
  return(0L)
}

#' @noRd
S7::method(request_preview, PDC) <- function(x) {
  report_preview()

  res <- flatten_pdc(x@url, NULL, limit = 10L) |>
    base_request("results")

  report_cleanup()

  add_class(res, x@end)
}

#' @noRd
S7::method(request_single, PDC) <- function(x) {
  report_count(x)

  res <- flatten_pdc(x@url, x@query) |>
    base_request("results")

  report_cleanup()

  add_class(res, x@end)
}

#' @noRd
S7::method(request_multi, PDC) <- function(x) {
  report_count(x)
  report_pages(x)

  res <- flatten_pdc(x@url, x@query, offset = "<<i>>") |>
    base_parallel(x@count, x@limit, "results")

  report_cleanup()

  add_class(res, x@end)
}
