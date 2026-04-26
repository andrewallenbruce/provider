#' @noRd
flatten_opts <- function(x) {
  paste0(names(x), "=", unlist_(x), collapse = "&")
}

#' @noRd
flatten_url <- function(base, args = NULL, opts = NULL) {
  check_required(base)

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
    httr2::req_retry(retry_on_failure = TRUE, max_tries = 2) |>
    httr2::req_error(body = \(resp) httr2::resp_body_json(resp)$message) |>
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

#' @noRd
multi_count <- function(url, nm, qry) {
  purrr::map_int(url, base_request, query = qry) |>
    set_names2(nm)
}

#' @noRd
multi_base <- function(url, nm, id) {
  purrr::map(url, base_request) |>
    set_names2(nm) |>
    rowbind2(id, fill = TRUE)
}

#' @noRd
base_parallel <- function(url, cnt, lmt) {
  offset2(url, cnt, lmt) |>
    parallel_request()
}

#' @noRd
multi_parallel <- function(url, cnt, lmt, nm, id) {
  offset3(url, cnt, lmt) |>
    purrr::map(parallel_request) |>
    set_names2(nm) |>
    rowbind2(id)
}
