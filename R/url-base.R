#' @noRd
uuid_cms2 <- function(endpoint) {
  switch(
    endpoint,
    clia = "d3eb38ac-d8e9-40d3-b7b7-6205d3d1dc16",
    hospitals = "f6f6505c-e8b0-4d57-b258-e2b94133aaf2",
    opt_out = "9887a515-7552-4693-bf58-735c77af46d7",
    order_refer = "c99b5865-1119-4436-bb80-c5af2773ea1f",
    pending = list(
      Physician = "6bd6b1dd-208c-4f9c-88b8-b15fec6db548",
      `Non-Physician` = "261b83b6-b89f-43ad-ae7b-0d419a3bc24b"
    ),
    providers = "2457ea29-fc82-48b0-86ec-3b0755de7515",
    reassignments = "20f51cff-4137-4f3a-b6b7-bfc9ad57983b",
    revocations = "a6496a7d-4e19-479a-a9ad-d4c0a49e07c3",
    transparency = "6a3aa708-3c9d-411a-a1a4-e046d3ade7ef",
    cli::cli_abort("{.arg endpoint} {.val {endpoint}} is invalid.")
  )
}

#' @noRd
uuid_prov2 <- function(endpoint) {
  switch(
    endpoint,
    affiliations = "27ea-46a8",
    clinicians = "mj5m-pzi6",
    hospitals2 = "xubh-q36u",
    cli::cli_abort("{.arg endpoint} {.val {endpoint}} is invalid.")
  )
}

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
base_cms <- S7::new_class(
  "base_cms",
  package = NULL,
  properties = list(
    end = S7::class_character,
    url = S7::new_property(
      S7::class_character,
      getter = function(self) {
        paste0(
          "https://data.cms.gov/data-api/v1/dataset/",
          uuid_cms2(self@end),
          "/data"
        )
      }
    ),
    limit = S7::new_property(
      S7::class_integer,
      default = 5000L
    )
  )
)

#' @noRd
base_prov <- S7::new_class(
  "base_prov",
  package = NULL,
  properties = list(
    end = S7::class_character,
    url = S7::new_property(
      S7::class_character,
      getter = function(self) {
        paste0(
          "https://data.cms.gov/provider-data/api/1/datastore/query/",
          uuid_prov2(self@end),
          "/0?"
        )
      }
    ),
    limit = S7::new_property(
      S7::class_integer,
      default = 1500L
    )
  )
)

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
req_count <- S7::new_generic("req_count", "x")

#' @noRd
req_ten <- S7::new_generic("req_ten", "x")

#' @noRd
req_single <- S7::new_generic("req_single", "x")

#' @noRd
req_multi <- S7::new_generic("req_multi", "x")

#' @noRd
S7::method(req_count, base_cms) <- function(x, args = NULL) {
  flatten_url(paste0(x@url, "/stats?"), args) |>
    base_request(query = "found_rows")
}

#' @noRd
S7::method(req_count, base_prov) <- function(x, args = NULL) {
  flatten_url(x@url, args, opts_prov(count = "true", results = "false")) |>
    base_request(query = "count")
}

#' @noRd
S7::method(req_ten, base_cms) <- function(x) {
  cli_no_query(x@end)
  flatten_url(paste0(x@url, "?"), opts = opts_cms(size = 10L)) |>
    base_request()
}

#' @noRd
S7::method(req_ten, base_prov) <- function(x) {
  cli_no_query(x@end)
  flatten_url(x@url, opts = opts_prov(limit = 10L)) |>
    base_request(query = "results")
}

#' @noRd
S7::method(req_single, base_cms) <- function(x, args = NULL) {
  flatten_url(paste0(x@url, "?"), args, opts_cms()) |>
    base_request()
}

#' @noRd
S7::method(req_single, base_prov) <- function(x, args = NULL) {
  flatten_url(x@url, args, opts_prov()) |>
    base_request(query = "results")
}

#' @noRd
S7::method(req_multi, base_cms) <- function(x, args = NULL, count) {
  flatten_url(paste0(x@url, "?"), args, opts_cms(offset = "<<i>>")) |>
    offset2(count, x@limit) |>
    parallel_request()
}

#' @noRd
S7::method(req_multi, base_prov) <- function(x, args = NULL, count) {
  flatten_url(x@url, args, opts_prov(offset = "<<i>>")) |>
    offset2(count, x@limit) |>
    parallel_request(query = "results")
}

#' @noRd
#' @autoglobal
exec_prov2 <- function(COUNT = FALSE, ARG = arg_prov()) {
  x <- base_prov(eval_bare(EndPoint))

  check_online()
  check_bool(COUNT)
  check_modifiers(ARG, x@end)

  # COUNT --> Return Invisibly
  if (!length(ARG)) {
    if (COUNT) {
      N <- req_count(x)
      cli_total(N, x@end)
      return(invisible(N))
    }

    # EMPTY QUERY --> First 10 Rows
    return(req_ten(x) |> polish(x@end))
  }

  # QUERY --> Request Count
  ARG <- build(ARG)
  N <- req_count(x, ARG)

  # NO RESULTS or COUNT --> Return Invisibly
  if (N == 0L || COUNT) {
    cli_results(N, x@end)
    return(invisible(N))
  }

  # COUNT BELOW LIMIT --> Single Request
  if (N <= x@limit) {
    cli_results(N, x@end)
    return(req_single(x, ARG) |> polish(x@end))
  }

  # COUNT ABOVE LIMIT --> Multiple Requests
  cli_pages(N, x@limit, x@end)

  req_multi(x, ARG, N) |>
    polish(x@end)
}

#' @noRd
#' @autoglobal
exec_cms3 <- function(COUNT = FALSE, SET = FALSE, ARG = arg_cms()) {
  x <- base_cms(eval_bare(EndPoint))

  check_online()
  check_bool(COUNT)
  check_bool(SET)

  # N0 QUERY
  if (!length(ARG)) {
    if (SET) {
      # SET --> Return Entire Dataset
      N <- req_count(x)
      cli_pages(N, x@limit, x@end)

      req_multi(x, ARG, N) |>
        polish(x@end)
    }

    # COUNT --> Return Invisibly
    if (COUNT) {
      N <- req_count(x)
      cli_total(N, x@end)
      return(invisible(N))
    }

    # EMPTY QUERY --> First 10 Rows
    return(req_ten(x) |> polish(x@end))
  }

  # QUERY --> Request Count
  ARG <- build(ARG)
  N <- req_count(x, ARG)

  # NO RESULTS or COUNT --> Return Invisibly
  if (N == 0L || COUNT) {
    cli_results(N, x@end)
    return(invisible(N))
  }

  # COUNT BELOW LIMIT --> Single Request
  if (N <= x@limit) {
    cli_results(N, x@end)
    return(req_single(x, ARG) |> polish(x@end))
  }

  # COUNT ABOVE LIMIT --> Multiple Requests
  cli_pages(N, x@limit, x@end)

  req_multi(x, ARG, N) |>
    polish(x@end)
}
