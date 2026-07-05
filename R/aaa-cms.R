#' @noRd
url_cms <- function(x) {
  paste0(
    "https://data.cms.gov/data-api/v1/dataset/",
    switch(
      x,
      clia = "d3eb38ac-d8e9-40d3-b7b7-6205d3d1dc16",
      hospital = "f6f6505c-e8b0-4d57-b258-e2b94133aaf2",
      opt_out = "9887a515-7552-4693-bf58-735c77af46d7",
      order_refer = "c99b5865-1119-4436-bb80-c5af2773ea1f",
      providers = "2457ea29-fc82-48b0-86ec-3b0755de7515",
      reassignments = "20f51cff-4137-4f3a-b6b7-bfc9ad57983b",
      revocations = "a6496a7d-4e19-479a-a9ad-d4c0a49e07c3",
      transparency = "6a3aa708-3c9d-411a-a1a4-e046d3ade7ef",
      cli::cli_abort("{.strong {.pkg CMS} Endpoint} `{.field {x}}` not found.")
    ),
    "/data"
  )
}

#' @noRd
param_cms <- function(...) {
  x <- ParamCMS(params(...))
  check_named(x)
  return(x)
}

#' @noRd
end_cms <- function(
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

  x <- param_cms(...)

  x <- EndpointCMS(
    end = end,
    url = url_cms(end),
    query = build(x) %||% character(0),
    action = count_set(count, set)
  )

  count(x)
}

#' @noRd
opts_cms <- function(size = 5000L, offset = 0L) {
  flatten_opts(params(size = size, offset = offset))
}

#' @noRd
flatten_cms <- function(url, query = NULL, append = "?", ...) {
  flatten_url(
    base = paste0(url, append),
    query %0% NULL,
    opts_cms(...)
  )
}
