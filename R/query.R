#' Generate API Offset Sequence & Size
#'
#' @param n  `<int>` Number of results in an API request
#' @param limit `<int>` API rate limit
#' @param which `<chr>` Return type, `"seq"` or `"size"` (default)
#' @returns Depending on inputs:
#'    * if `n` == `0`: returns `0`
#'    * if `n` <= `limit`: returns `n`
#'    * if `n` > `limit` and:
#'       * `which` = `"seq"`: sequence `0:n` by `limit`, of length `ceiling(n / limit)`.
#'       * `which` = `"size"`: length of sequence.
#'
#' @examplesIf interactive()
#' offset(n = 100, limit = 10, which = "size")
#' offset(n = 100, limit = 10, which = "seq")
#'
#' offset(n = 10, limit = 100, which = "size")
#' offset(n = 10, limit = 100, which = "seq")
#'
#' offset(n = 47984, limit = 5000, which = "size")
#' offset(n = 47984, limit = 5000, which = "seq")
#'
#' offset(n = 147984, limit = 1500, which = "size")
#' offset(n = 147984, limit = 1500, which = "seq")
#' @autoglobal
#' @noRd
offset <- function(n, limit, which = "size") {
  if (n == 0L) {
    return(0L)
  }

  switch(
    which,
    size = cheapr::seq_size(from = 0L, to = n, by = limit),
    seq = cheapr::seq_(from = 0L, to = n, by = limit)
  )
}

#' @noRd
plus <- function(x) {
  gsub(" ", "+", x, fixed = TRUE)
}

#' @autoglobal
#' @noRd
format_query <- function(x, N) {
  V <- plus(unlist_(x))

  c(
    paste0("conditions[<<i>>][property]=", plus(N)),
    paste0("conditions[<<i>>][operator]=", if (length(V) > 1L) "IN" else "="),
    paste0("conditions[<<i>>][value]", if (length(V) > 1L) "[]=" else "=", V)
  )
}

#' @autoglobal
#' @noRd
flatten_query <- function(args) {
  purrr::imap(args, format_query) |>
    unname() |>
    purrr::imap_chr(function(x, idx) {
      gsub(x = x, pattern = "<<i>>", replacement = idx - 1, fixed = TRUE) |>
        paste0(collapse = "&")
    }) |>
    (\(x) paste0(x, collapse = "&"))()
}

#' @autoglobal
#' @noRd
parameters <- function(...) {
  purrr::compact(rlang::list2(...))
}

#' @autoglobal
#' @noRd
set_opts <- function(...) {
  x <- rlang::list2(...)
  paste0(names(x), "=", unlist_(x), collapse = "&")
}

#' @autoglobal
#' @noRd
flatten_url <- function(base, opts, query = NULL) {
  if (is.null(query)) {
    paste0(base, opts)
  } else {
    paste(paste0(base, opts), query, sep = "&")
  }
}

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
    names = rlang::names2(PS(resp)),
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
