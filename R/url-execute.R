#' @noRd
EndPoint <- expr(call_name(call_match(call = caller_call(), fn = caller_fn())))

#' @noRd
#' @autoglobal
exec_prov <- function(COUNT, SET, ARG) {
  x <- base_prov(eval_bare(EndPoint))

  check_online()
  check_bool(COUNT)
  check_modifiers(ARG, x@end)
  # |==============
  # | EMPTY QUERY |
  # |==============
  if (!length(ARG)) {
    # TODO: more clearly defined empty query behavior
    if (SET) {
      # SET: Return entire dataset
      N <- req_count(x)
      cli_pages(N, x@limit, x@end)

      return(
        req_multi(x, count = N) |>
          polish(x@end)
      )
    }

    # COUNT: Return count invisibly
    if (COUNT) {
      N <- req_count(x)
      cli_total(N, x@end)
      return(invisible(N))
    }

    # |========================================
    # | END EMPTY QUERY: Return First 10 Rows |
    # |========================================
    return(req_empty(x) |> polish(x@end))
  }

  # |============
  # | HAS QUERY |
  # |============

  # 1. Build query
  ARG <- build(ARG)
  # 2. Request count
  N <- req_count(x, ARG)

  # 0 RESULTS or COUNT: Return Invisibly
  if (N == 0L || COUNT) {
    cli_results(N, x@end)
    return(invisible(N))
  }

  # COUNT below LIMIT: Single Request
  if (N <= x@limit) {
    cli_results(N, x@end)
    return(req_single(x, ARG) |> polish(x@end))
  }

  # COUNT above LIMIT: Multiple Requests
  cli_pages(N, x@limit, x@end)

  req_multi(x, ARG, N) |>
    polish(x@end)
}

#' @noRd
#' @autoglobal
exec_cms <- function(COUNT, SET, ARG) {
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

      return(
        req_multi(x, count = N) |>
          polish(x@end)
      )
    }

    # COUNT --> Return Invisibly
    if (COUNT) {
      N <- req_count(x)
      cli_total(N, x@end)
      return(invisible(N))
    }

    # EMPTY QUERY --> First 10 Rows
    return(req_empty(x) |> polish(x@end))
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
exec_cms2 <- function(COUNT, SET, ARG, .id) {
  x <- base_cms(eval_bare(EndPoint))

  check_online()
  check_bool(COUNT)
  check_bool(SET)

  # N0 QUERY
  if (!length(ARG)) {
    if (SET) {
      # SET --> Return Entire Dataset
      N <- req_count(x)
      cli_pages2(N, x@limit, x@end)
      return(
        req_multi(x, count = N, id = .id) |>
          polish(x@end, id = .id)
      )
    }

    # COUNT --> Return Invisibly
    if (COUNT) {
      N <- req_count(x)
      cli_total2(N, x@end)
      return(invisible(N))
    }

    # EMPTY QUERY --> First 10 Rows
    return(
      req_empty(x, .id) |>
        polish(x@end, .id)
    )
  }

  # QUERY --> Request Count
  ARG <- build(ARG)
  N <- req_count(x, ARG)

  # NO RESULTS or COUNT --> Return Invisibly
  if (sum2(N) == 0L || COUNT) {
    cli_results2(N, x@end)
    return(invisible(N))
  }

  # COUNT BELOW LIMIT --> Single Request
  if (all2(N <= x@limit)) {
    cli_results2(N, x@end)
    return(
      req_single(x, ARG, .id) |>
        polish(x@end, .id)
    )
  }

  # COUNT ABOVE LIMIT --> Multiple Requests
  cli_pages2(N, x@limit, x@end)

  req_multi(x, ARG, N, .id) |>
    polish(x@end, .id)
}
