#' @noRd
exec_prov <- function(ARG, BASE, LIMIT, NM, COUNT) {
  # COUNT --> Return Invisibly
  if (!length(ARG)) {
    if (COUNT) {
      N <- request_count(url_(
        BASE,
        opts(count = "true", results = "false", schema = "false")
      ))
      cli_results(N)
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
      fastplyr::as_tbl() |>
      map_na_if() |>
      rename_(NM)

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
    cli_results(N)
    return(invisible(N))
  }

  # COUNT BELOW LIMIT --> Single Request
  if (N <= LIMIT) {
    cli_results(N)

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
      fastplyr::as_tbl() |>
      map_na_if() |>
      rename_(NM)

    return(res)
  }

  # COUNT ABOVE LIMIT --> Multiple Requests
  cli_pages(N, LIMIT)

  URL <- url_(
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

  URL <- offset(N, LIMIT, "seq") |>
    purrr::map_chr(\(x) {
      gsub(x = URL, pattern = "<<i>>", replacement = x, fixed = TRUE)
    })

  parallel_results(URL) |>
    fastplyr::as_tbl() |>
    map_na_if() |>
    rename_(NM)
}

#' @noRd
exec_cms <- function(ARG, BASE, LIMIT, NM, COUNT) {
  # COUNT --> Return Invisibly
  if (!length(ARG)) {
    if (COUNT) {
      N <- request_rows(paste0(BASE, "/stats?"))
      cli_results(N)
      return(invisible(N))
    }

    # EMPTY QUERY --> First 10 Rows
    cli_no_query()

    res <- request_bare(url_(paste0(BASE, "?"), opts(size = 10))) |>
      fastplyr::as_tbl() |>
      map_na_if() |>
      rename_(NM)

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
    cli_results(N)
    return(invisible(N))
  }

  # COUNT BELOW LIMIT --> Single Request
  if (N <= LIMIT) {
    cli_results(N)

    URL <- url_(
      paste0(BASE, "?"),
      opts(size = LIMIT),
      query2(ARG)
    )

    res <- request_bare(URL) |>
      fastplyr::as_tbl() |>
      map_na_if() |>
      rename_(NM)

    return(res)
  }

  # COUNT ABOVE LIMIT --> Multiple Requests
  cli_pages(N, LIMIT)

  URL <- url_(
    paste0(BASE, "?"),
    opts(size = LIMIT, offset = "<<i>>"),
    query2(ARG)
  )

  URL <- offset(N, LIMIT, "seq") |>
    purrr::map_chr(\(x) {
      gsub(x = URL, pattern = "<<i>>", replacement = x, fixed = TRUE)
    })

  parallel_request(URL) |>
    fastplyr::as_tbl() |>
    map_na_if() |>
    rename_(NM)
}
