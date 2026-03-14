#' @noRd
exec_prov <- function(END, ARG, BASE, LIMIT, NM, COUNT) {
  # NO INTERNET --> Abort
  cli_online()
  check_bool(COUNT)

  # COUNT --> Return Invisibly
  if (!length(ARG)) {
    if (COUNT) {
      N <- request_count(url_(
        BASE,
        opts(count = "true", results = "false", schema = "false")
      ))
      cli_results(N, END)
      return(invisible(N))
    }

    # EMPTY QUERY --> First 10 Rows
    cli_no_query()

    URL <- url_(
      BASE,
      opts(
        count = "false",
        results = "true",
        schema = "false",
        limit = 10
      )
    )

    res <- request_results(URL) |>
      polish(NM)

    return(res)
  }

  # QUERY --> Request Count
  URL <- url_(
    BASE,
    opts(
      count = "true",
      results = "false",
      schema = "false",
      limit = LIMIT
    ),
    query(ARG)
  )

  N <- request_count(URL)

  # NO RESULTS or COUNT --> Return Invisibly
  if (N == 0L || COUNT) {
    cli_results(N, END)
    return(invisible(N))
  }

  # COUNT BELOW LIMIT --> Single Request
  if (N <= LIMIT) {
    cli_results(N, END)

    URL <- url_(
      BASE,
      opts(
        count = "false",
        results = "true",
        schema = "false",
        limit = LIMIT
      ),
      query(ARG)
    )

    res <- request_results(URL) |>
      polish(NM)

    return(res)
  }

  # COUNT ABOVE LIMIT --> Multiple Requests
  cli_pages(N, LIMIT, END)

  URL <- create_offset(
    N,
    LIMIT,
    url_(
      BASE,
      opts(
        count = "false",
        results = "true",
        schema = "false",
        limit = LIMIT,
        offset = "<<i>>"
      ),
      query(ARG)
    )
  )

  parallel_results(URL) |>
    polish(NM)
}

#' @noRd
exec_cms <- function(END, ARG, BASE, LIMIT, NM, COUNT) {
  # NO INTERNET --> Abort
  cli_online()
  check_bool(COUNT)

  # COUNT --> Return Invisibly
  if (!length(ARG)) {
    if (COUNT) {
      N <- request_rows(paste0(BASE, "/stats?"))
      cli_results(N, END)
      return(invisible(N))
    }

    # EMPTY QUERY --> First 10 Rows
    cli_no_query()

    res <- request_bare(url_(paste0(BASE, "?"), opts(size = 10))) |>
      polish(NM)

    return(res)
  }

  # QUERY --> Request Count
  N <- request_rows(url_(
    paste0(BASE, "/stats?"),
    opts(size = LIMIT),
    query2(ARG)
  ))

  # NO RESULTS or COUNT --> Return Invisibly
  if (N == 0L || COUNT) {
    cli_results(N, END)
    return(invisible(N))
  }

  # COUNT BELOW LIMIT --> Single Request
  if (N <= LIMIT) {
    cli_results(N, END)

    URL <- url_(
      paste0(BASE, "?"),
      opts(size = LIMIT),
      query2(ARG)
    )

    res <- request_bare(URL) |>
      polish(NM)

    return(res)
  }

  # COUNT ABOVE LIMIT --> Multiple Requests
  cli_pages(N, LIMIT, END)

  URL <- create_offset(
    N,
    LIMIT,
    url_(
      paste0(BASE, "?"),
      opts(size = LIMIT, offset = "<<i>>"),
      query2(ARG)
    )
  )

  parallel_request(URL) |>
    polish(NM)
}
