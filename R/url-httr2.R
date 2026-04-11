#' @noRd
parse_string <- function(resp, query = NULL) {
  PS <- function(x, qry = NULL) {
    RcppSimdJson::fparse(httr2::resp_body_string(x), query = qry)
  }

  if (is.null(query)) {
    return(PS(resp))
  }

  switch(
    query,
    results = PS(resp)$results,
    count = PS(resp)$count,
    found_rows = PS(resp)$found_rows,
    PS(resp, qry = query)
  )
}

#' @noRd
request_bare <- function(base, opts = NULL, args = NULL, query = NULL) {
  url_str(base = base, opts = opts, args = args) |>
    httr2::request() |>
    httr2::req_error(body = function(resp) {
      httr2::resp_body_json(resp)$message
    }) |>
    # httr2::req_user_agent("provider (https://andrewallenbruce.github.io/provider)") |>
    httr2::req_perform() |>
    parse_string(query = query)
}

#' @noRd
request_count <- function(base, args = NULL) {
  request_bare(
    base = base,
    opts = opts(
      count = "true",
      results = "false",
      schema = "false"
    ),
    args = args,
    query = "count"
  )
}

#' @noRd
request_rows <- function(base, args = NULL) {
  request_bare(
    base = paste0(base, "/stats?"),
    args = args,
    query = "found_rows"
  )
}

#' @noRd
request_pro <- function(base, limit = 10, args = NULL) {
  request_bare(
    base = base,
    opts = opts(
      count = "false",
      results = "true",
      schema = "false",
      limit = limit
    ),
    args = args,
    query = "results"
  )
}

#' @noRd
request_cms <- function(base, limit = 10, args = NULL) {
  request_bare(
    base = paste0(base, "?"),
    opts = opts(size = limit),
    args = args
  )
}

#' @noRd
parallel_request <- function(x, query = NULL) {
  purrr::map(x, httr2::request) |>
    httr2::req_perform_parallel(on_error = "continue") |>
    httr2::resps_successes() |>
    httr2::resps_data(function(resp) parse_string(resp, query = query))
}

#' @noRd
parallel_results <- function(x) {
  parallel_request(x, query = "results")
}
