#' @noRd
check_modifiers <- function(x, end) {
  rlang::check_required(end)
  if (S7::S7_inherits(x, ParamPDC)) {
    if (purrr::some(x, is_modifier)) {
      x <- unlist_(x[purrr::map_lgl(x, is_modifier)])
      if (any2(x %in% c("ends", "excludes"))) {
        cli::cli_abort(
          c(
            "x" = "Invalid query {.cls modifier} used in {.fn {end}}",
            ">" = "Modifiers that do not work with {.strong Provider Data Catalog} endpoints: ",
            "*" = "{.fn ends}",
            "*" = "{.fn excludes}"
          ),
          call = rlang::call2(end)
        )
      }
    }
  }
  invisible()
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
      cli::cli_abort("{.strong {.pkg PDC} Endpoint} `{.field {x}}` not found.")
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
end_pdc <- function(
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

  count(x)
}

#' @noRd
flatten_pdc <- function(url, query = NULL, ...) {
  flatten_url(
    base = url,
    query %0% NULL,
    opts_pdc(...)
  )
}
