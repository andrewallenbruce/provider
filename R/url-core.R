#' @noRd
flatten_opts <- function(x) {
  paste0(names(x), "=", unlist_(x), collapse = "&")
}

#' @noRd
flatten_url <- function(base, args = NULL, opts = NULL) {
  if (is.null(args) || length(args) == 0L) {
    return(paste0(base, opts))
  }
  paste(paste0(base, opts), args, sep = "&")
}

#' @noRd
opts_cms <- function(size = 5000L, offset = 0L) {
  flatten_opts(params(size = size, offset = offset))
}

#' @noRd
opts_prov <- function(
  count = "false",
  results = "true",
  limit = 1500L,
  offset = 0L
) {
  flatten_opts(params(
    count = count,
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
offset2 <- function(url, n, limit) {
  purrr::map_chr(
    offset(n, limit, "seq"),
    function(x) {
      sub_idx(url, x)
    }
  )
}

#' @noRd
PS <- function(x, qry = NULL) {
  RcppSimdJson::fparse(httr2::resp_body_string(x), query = qry)
}

#' @noRd
parse_string <- function(resp, query = NULL) {
  if (is.null(query)) {
    return(PS(resp))
  }

  switch(
    query,
    results = PS(resp)$results,
    count = PS(resp)$count,
    found_rows = PS(resp)$found_rows,
    total_rows = PS(resp)$total_rows,
    names = rlang::names2(PS(resp)),
    PS(resp, qry = query)
  )
}

#' @noRd
base_request <- function(url, query = NULL) {
  httr2::request(url) |>
    httr2::req_error(body = function(resp) {
      httr2::resp_body_json(resp)$message
    }) |>
    httr2::req_perform() |>
    parse_string(query = query)
}

#' @noRd
parallel_request <- function(x, query = NULL) {
  purrr::map(x, httr2::request) |>
    httr2::req_perform_parallel(on_error = "continue") |>
    httr2::resps_successes() |>
    httr2::resps_data(function(resp) parse_string(resp, query = query))
}
