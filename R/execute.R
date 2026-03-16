#' @noRd
exec_prov <- function(END, COUNT, ARG) {
  # NO INTERNET --> Abort
  check_online()
  check_bool(COUNT)

  if (
    any(purrr::map_lgl(ARG, is_modifier)) &&
      any(unlist_(ARG) %in% c("ENDS WITH"))
  ) {
    cli::cli_abort("{.fn ends_with} cannot be used with {.fn {END}}.")
  }

  .c(BASE, LIMIT, NM) %=% constants(END)

  # COUNT --> Return Invisibly
  if (!length(ARG)) {
    if (COUNT) {
      N <- request_count(BASE)

      cli_results(N, END)

      return(invisible(N))
    }

    # EMPTY QUERY --> First 10 Rows
    cli_no_query()

    res <- request_pro(BASE, limit = 10) |>
      polish(NM)

    return(res)
  }

  # QUERY --> Request Count
  N <- request_count(BASE, query(END, ARG))

  # NO RESULTS or COUNT --> Return Invisibly
  if (N == 0L || COUNT) {
    cli_results(N, END)
    return(invisible(N))
  }

  # COUNT BELOW LIMIT --> Single Request
  if (N <= LIMIT) {
    cli_results(N, END)

    res <- request_pro(BASE, LIMIT, query(END, ARG)) |>
      polish(NM)

    return(res)
  }

  # COUNT ABOVE LIMIT --> Multiple Requests
  cli_pages(N, LIMIT, END)

  OPT <- opts(
    count = "false",
    results = "true",
    schema = "false",
    limit = LIMIT,
    offset = "<<i>>"
  )
  URL <- url_str(BASE, OPT, query(END, ARG))
  URL <- create_offset(N, LIMIT, URL)

  parallel_results(URL) |>
    polish(NM)
}

#' @noRd
exec_cms <- function(END, COUNT, ARG) {
  # NO INTERNET --> Abort
  check_online()
  check_bool(COUNT)

  .c(BASE, LIMIT, NM) %=% constants(END)

  # COUNT --> Return Invisibly
  if (!length(ARG)) {
    if (COUNT) {
      N <- request_rows(BASE)
      cli_results(N, END)
      return(invisible(N))
    }

    # EMPTY QUERY --> First 10 Rows
    cli_no_query()

    res <- request_cms(BASE) |>
      polish(NM)

    return(res)
  }

  # QUERY --> Request Count
  N <- request_rows(BASE, LIMIT, query(END, ARG))

  # NO RESULTS or COUNT --> Return Invisibly
  if (N == 0L || COUNT) {
    cli_results(N, END)
    return(invisible(N))
  }

  # COUNT BELOW LIMIT --> Single Request
  if (N <= LIMIT) {
    cli_results(N, END)

    res <- request_cms(BASE, LIMIT, query(END, ARG)) |>
      polish(NM)

    return(res)
  }

  # COUNT ABOVE LIMIT --> Multiple Requests
  cli_pages(N, LIMIT, END)

  URL <- url_str(
    paste0(BASE, "?"),
    opts(size = LIMIT, offset = "<<i>>"),
    query(END, ARG)
  )
  URL <- create_offset(N, LIMIT, URL)

  parallel_request(URL) |>
    polish(NM)
}
