#' @noRd
params <- function(...) {
  purrr::compact(rlang::list2(...))
}

#' @noRd
flatten_opts <- function(x) {
  paste0(names(x), "=", unlist_(x), collapse = "&")
}

#' @noRd
flatten_url <- function(base, args = NULL, opts = NULL) {
  rlang::check_required(base)

  if (is.null(args) || length(args) == 0L) {
    return(paste0(base, opts))
  }
  paste(paste0(base, opts), args, sep = "&")
}

# nocov start
#' @noRd
PS <- function(x, qry = NULL) {
  RcppSimdJson::fparse(
    httr2::resp_body_string(x),
    query = qry
  )
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
# nocov end

# base_request <- function(url, query = NULL) {
#   httr2::request(url) |>
#     httr2::req_perform() |>
#     parse_string(query = query)
# }

# parallel_request <- function(x, query = NULL) {
#   purrr::map(x, httr2::request) |>
#     httr2::req_perform_parallel(on_error = "continue") |>
#     httr2::resps_successes() |>
#     httr2::resps_data(function(resp) parse_string(resp, query = query))
# }

# base_parallel <- function(url, n, limit, query = NULL) {
#   offset2(url, n, limit) |>
#     parallel_request(query = query)
# }

# multi_count <- function(url, nm, query = NULL) {
#   purrr::map_int(url, base_request, query = query) |>
#     set_names2(nm)
# }

#' @noRd
count <- S7::new_generic("count", "x")

#' @noRd
S7::method(count, EndpointCMS) <- function(x) {
  if (length(x@query) > 0L || x@action == "count") {
    N <- flatten_cms(
      S7::prop(x, "url"),
      S7::prop(x, "query"),
      "/stats?"
    ) |>
      httr2::request() |>
      httr2::req_perform() |>
      parse_string("found_rows")

    S7::prop(x, "count") <- N
  }
  return(x)
}

#' @noRd
S7::method(count, EndpointPDC) <- function(x) {
  if (length(x@query) > 0L || x@action == "count") {
    N <- flatten_pdc(
      S7::prop(x, "url"),
      S7::prop(x, "query"),
      results = "false"
    ) |>
      httr2::request() |>
      httr2::req_perform() |>
      parse_string("count")

    S7::prop(x, "count") <- N
  }
  return(x)
}

#' @noRd
S7::method(count, EndpointCMSList) <- function(x) {
  if (length(x@query) > 0L || x@action == "count") {
    U <- flatten_cms(
      S7::prop(x, "url"),
      S7::prop(x, "query"),
      "/stats?"
    )

    N <- purrr::map_int(U, function(x) {
      httr2::request(x) |>
        httr2::req_perform() |>
        parse_string("found_rows")
    }) |>
      set_names2(S7::prop(x, "url"))

    S7::prop(x, "count") <- N
  }
  return(x)
}

#' @noRd
preview <- S7::new_generic("preview", "x")

#' @noRd
S7::method(preview, EndpointCMS) <- function(x) {
  inform_preview()

  flatten_cms(
    S7::prop(x, "url"),
    NULL,
    size = 10L
  ) |>
    httr2::request() |>
    httr2::req_perform() |>
    parse_string() |>
    add_class(S7::prop(x, "end"))
}

#' @noRd
S7::method(preview, EndpointPDC) <- function(x) {
  inform_preview()

  flatten_pdc(
    S7::prop(x, "url"),
    NULL,
    limit = 10L
  ) |>
    httr2::request() |>
    httr2::req_perform() |>
    parse_string("results") |>
    add_class(S7::prop(x, "end"))
}

#' @noRd
S7::method(preview, EndpointCMSList) <- function(x) {
  inform_preview()

  flatten_cms(
    S7::prop(x, "url"),
    NULL,
    size = 10L
  ) |>
    purrr::map(httr2::request) |>
    httr2::req_perform_parallel(on_error = "continue") |>
    purrr::map(parse_string) |>
    set_names2(S7::prop(x, "url")) |>
    add_class2(S7::prop(x, "end"))
}

#' @noRd
request_single <- S7::new_generic("request_single", "x")

#' @noRd
S7::method(request_single, EndpointCMS) <- function(x) {
  inform_count(x)
  inform_pages(x)

  flatten_cms(
    S7::prop(x, "url"),
    S7::prop(x, "query")
  ) |>
    httr2::request() |>
    httr2::req_perform() |>
    parse_string() |>
    add_class(S7::prop(x, "end"))
}

#' @noRd
S7::method(request_single, EndpointPDC) <- function(x) {
  inform_count(x)
  inform_pages(x)

  flatten_pdc(
    S7::prop(x, "url"),
    S7::prop(x, "query")
  ) |>
    httr2::request() |>
    httr2::req_perform() |>
    parse_string("results") |>
    add_class(S7::prop(x, "end"))
}

#' @noRd
S7::method(request_single, EndpointCMSList) <- function(x) {
  inform_count(x)
  inform_pages(x)

  u <- S7::prop(x, "url")[rlang::names2(S7::prop(x, "count") > 0L)]

  flatten_cms(u, S7::prop(x, "query")) |>
    purrr::map(httr2::request) |>
    httr2::req_perform_parallel(on_error = "continue") |>
    purrr::map(parse_string) |>
    set_names2(S7::prop(x, "url")) |>
    add_class2(S7::prop(x, "end"))
}

#' @noRd
request_multi <- S7::new_generic("request_multi", "x")

#' @noRd
S7::method(request_multi, EndpointCMS) <- function(x) {
  inform_count(x)
  inform_pages(x)

  flatten_cms(x@url, x@query, offset = "<<i>>") |>
    offset2(x@count, x@limit) |>
    purrr::map(httr2::request) |>
    httr2::req_perform_parallel(on_error = "continue") |>
    purrr::map(parse_string) |>
    rowbind2() |>
    add_class(x@end)
}

#' @noRd
S7::method(request_multi, EndpointPDC) <- function(x) {
  inform_count(x)
  inform_pages(x)

  flatten_pdc(
    S7::prop(x, "url"),
    S7::prop(x, "query"),
    offset = "<<i>>"
  ) |>
    offset2(
      S7::prop(x, "count"),
      S7::prop(x, "limit")
    ) |>
    purrr::map(httr2::request) |>
    httr2::req_perform_parallel(on_error = "continue") |>
    purrr::map(parse_string, "results") |>
    rowbind2() |>
    add_class(S7::prop(x, "end"))
}

#' @noRd
S7::method(request_multi, EndpointCMSList) <- function(x) {
  inform_count(x)
  inform_pages(x)

  i <- rlang::names2(S7::prop(x, "count") > 0L)
  N <- unname(S7::prop(x, "count")[i])

  flatten_cms(
    S7::prop(x, "url")[i],
    S7::prop(x, "query"),
    offset = "<<i>>"
  ) |>
    offset3(N, S7::prop(x, "limit")) |>
    unlist_() |>
    purrr::map(httr2::request) |>
    httr2::req_perform_parallel(on_error = "continue") |>
    purrr::map(parse_string) |>
    add_class2(S7::prop(x, "end"))
}
