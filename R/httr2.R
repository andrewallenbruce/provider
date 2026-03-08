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
bare_request <- function(x, query = NULL) {
  httr2::request(x) |>
    httr2::req_error(body = function(resp) {
      httr2::resp_body_json(resp)$message
    }) |>
    httr2::req_perform() |>
    parse_string(query = query)
}

#' @autoglobal
#' @noRd
parallel_request <- function(x, query = NULL) {
  purrr::map(x, httr2::request) |>
    httr2::req_perform_parallel(on_error = "continue") |>
    httr2::resps_successes() |>
    purrr::map(function(x) {
      parse_string(x, query = query)
    })
}
