#' @autoglobal
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
    count = PS(resp) |> _$count,
    results = PS(resp) |> _$results,
    found_rows = PS(resp) |> _$found_rows,
    total_rows = PS(resp) |> _$total_rows,
    PS(resp, qry = query)
  )
}

#' @autoglobal
#' @noRd
request_bare <- function(x, query = NULL) {
  httr2::request(x) |>
    httr2::req_error(body = function(resp) httr2::resp_body_json(resp)$message) |>
    # httr2::req_user_agent("provider (https://andrewallenbruce.github.io/provider)") |>
    httr2::req_perform() |>
    parse_string(query = query)
}

#' @autoglobal
#' @noRd
request_results <- function(x) {
  request_bare(x, query = "results")
}

#' @autoglobal
#' @noRd
request_count <- function(x) {
  request_bare(x, query = "count")
}

#' @autoglobal
#' @noRd
request_rows <- function(x) {
  request_bare(x, query = "found_rows")
}

#' @autoglobal
#' @noRd
parallel_request <- function(x, query = NULL) {
  purrr::map(x, httr2::request) |>
    httr2::req_perform_parallel(on_error = "continue") |>
    httr2::resps_successes() |>
    httr2::resps_data(function(resp) parse_string(resp, query = query))
}

#' @autoglobal
#' @noRd
parallel_results <- function(x) {
  parallel_request(x, query = "results")
}
