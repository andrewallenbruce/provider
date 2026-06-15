#' @noRd
check_modifiers <- S7::new_generic("check_modifiers", "x")

#' @noRd
S7::method(check_modifiers, ParamPDC) <- function(x, end) {
  mods <- purrr::map_lgl(x, is_modifier)

  if (any2(mods)) {
    mods <- unlist_(x[mods])
    if (any2(mods %in% c("ends", "excludes"))) {
      cli::cli_abort(
        c(
          "Invalid {.cls modifier} used in {.fn {end}}: ",
          "x" = "{.fn ends} & {.fn excludes} do not work with the Provider Data Catalog API."
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

#' @include aaa-classes.R
#' @noRd
param_pdc <- function(...) {
  x <- ParamPDC(params(...))
  check_named(x)
  return(x)
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

  x <- EndpointPDC(
    end = end,
    url = url_pdc(end),
    query = build(x) %||% character(0),
    action = count_set(count, set)
  )

  x <- count(x)

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

#' @include aaa-generics.R
#' @noRd
S7::method(count, EndpointPDC) <- function(x) {
  if (length(x@query) > 0L || x@action == "count") {
    S7::prop(x, "count") <- base_request(
      flatten_pdc(x@url, x@query, results = "false"),
      "count"
    )
  }
  return(x)
}

#' @noRd
S7::method(preview, EndpointPDC) <- function(x) {
  report_preview()

  x <- flatten_pdc(x@url, NULL, limit = 10L) |>
    base_request("results") |>
    add_class(x@end)

  return(x)
}

#' @noRd
S7::method(request_single, EndpointPDC) <- function(x) {
  report_count(x)
  report_pages(x)

  x <- flatten_pdc(x@url, x@query) |>
    base_request("results") |>
    add_class(x@end)

  return(x)
}

#' @noRd
S7::method(request_multi, EndpointPDC) <- function(x) {
  report_count(x)
  report_pages(x)

  x <- flatten_pdc(x@url, x@query, offset = "<<i>>") |>
    base_parallel(x@count, x@limit, "results") |>
    add_class(x@end)

  return(x)
}
