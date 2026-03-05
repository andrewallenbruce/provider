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
compact_list <- function(...) {
  purrr::compact(list(...))
}

#' @autoglobal
#' @noRd
flatten_opts <- function(x) {
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
  f <- function(x, qry = NULL) {
    RcppSimdJson::fparse(httr2::resp_body_string(x), query = qry)
  }

  if (!is.null(query)) {
    switch(
      query,
      count = return(f(resp) |> _[["count"]]),
      found_rows = return(f(resp) |> _[["found_rows"]]),
      names = return(f(resp) |> rlang::names2()),
      results = return(f(resp) |> _[["results"]]),
      total_rows = return(f(resp) |> _[["total_rows"]]),
      return(f(resp, qry = query))
    )
  }
  f(resp)
}

#' @autoglobal
#' @noRd
map_perform_parallel <- function(x, query = NULL) {
  purrr::map(x, httr2::request) |>
    httr2::req_perform_parallel(on_error = "continue") |>
    httr2::resps_successes() |>
    purrr::map(function(x) parse_string(x, query = query))
}
