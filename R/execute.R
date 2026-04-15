#' @noRd
#' @autoglobal
exec_prov <- function(END, COUNT, ARG, LIMIT = 1500L) {
  check_online()
  check_bool(COUNT)
  check_modifiers(ARG, END)

  BASE <- uuid_prov(END)

  # COUNT --> Return Invisibly
  if (!length(ARG)) {
    if (COUNT) {
      N <- request_count(BASE)

      cli_total(N, END)

      return(invisible(N))
    }

    # EMPTY QUERY --> First 10 Rows
    cli_no_query(END)

    res <- polish(request_pro(BASE), END)

    return(res)
  }

  # QUERY --> Request Count
  N <- request_count(BASE, build(ARG))

  # NO RESULTS or COUNT --> Return Invisibly
  if (N == 0L || COUNT) {
    cli_results(N, END)
    return(invisible(N))
  }

  # COUNT BELOW LIMIT --> Single Request
  if (N <= LIMIT) {
    cli_results(N, END)

    res <- request_pro(BASE, LIMIT, build(ARG)) |>
      polish(END)

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
  URL <- url_str(BASE, OPT, build(ARG))
  URL <- create_offset(N, LIMIT, URL)

  parallel_results(URL) |>
    polish(END)
}

#' @noRd
#' @autoglobal
exec_cms <- function(END, COUNT, SET, ARG, LIMIT = 5000L) {
  check_online()
  check_bool(COUNT)
  check_bool(SET)

  BASE <- uuid_cms(END)

  # COUNT --> Return Invisibly
  if (!length(ARG)) {
    if (SET) {
      # SET --> Return Entire Dataset
      N <- request_rows(BASE)
      cli_pages(N, LIMIT, END)

      URL <- create_offset(
        N,
        LIMIT,
        url_str(
          paste0(BASE, "?"),
          opts(size = LIMIT, offset = "<<i>>")
        )
      )

      return(polish(parallel_request(URL), END))
    }

    if (COUNT) {
      N <- request_rows(BASE)
      cli_total(N, END)
      return(invisible(N))
    }

    # EMPTY QUERY --> First 10 Rows
    cli_no_query(END)

    res <- polish(request_cms(BASE), END)

    return(res)
  }

  # QUERY --> Request Count
  N <- request_rows(BASE, build(ARG))

  # NO RESULTS or COUNT --> Return Invisibly
  if (N == 0L || COUNT) {
    cli_results(N, END)
    return(invisible(N))
  }

  # COUNT BELOW LIMIT --> Single Request
  if (N <= LIMIT) {
    cli_results(N, END)

    res <- request_cms(BASE, LIMIT, build(ARG)) |>
      polish(END)

    return(res)
  }

  # COUNT ABOVE LIMIT --> Multiple Requests
  cli_pages(N, LIMIT, END)

  URL <- url_str(
    paste0(BASE, "?"),
    opts(size = LIMIT, offset = "<<i>>"),
    build(ARG)
  )
  URL <- create_offset(N, LIMIT, URL)

  parallel_request(URL) |>
    polish(END)
}

#' @noRd
#' @autoglobal
exec_cms2 <- function(END, COUNT, ARG, .id, LIMIT = 5000L) {
  check_online()
  check_bool(COUNT)

  BASE <- uuid_cms(END)

  # COUNT --> Return Invisibly
  if (!length(ARG)) {
    if (COUNT) {
      N <- purrr::map_int(BASE, \(x, nm) request_rows(x))
      cli_total2(N, END)
      return(invisible(N))
    }

    # EMPTY QUERY --> First 10 Rows
    cli_no_query(END)

    res <- purrr::imap(BASE, \(x, i) request_cms(x)) |>
      collapse::rowbind(idcol = .id, id.factor = FALSE, return = 4L) |>
      polish(END, .id = .id)

    return(res)
  }

  # QUERY --> Request Count
  N <- purrr::imap_vec(BASE, \(x, n) request_rows(x, build(ARG)))

  # NO RESULTS or COUNT --> Return Invisibly
  if (sum2(N) == 0L || COUNT) {
    cli_results2(N, END)
    return(invisible(N))
  }

  # COUNT BELOW LIMIT --> Single Request
  if (all2(N <= LIMIT)) {
    cli_results2(N, END)

    res <- purrr::imap(BASE, \(x, nm) {
      request_cms(x, LIMIT, build(ARG))
    }) |>
      collapse::rowbind(idcol = .id, id.factor = FALSE, return = 4L) |>
      polish(END, .id = .id)

    return(res)
  }

  # COUNT ABOVE LIMIT --> Multiple Requests
  cli_pages2(N, LIMIT, END)

  URL <- url_str(
    paste0(BASE, "?"),
    opts(size = LIMIT, offset = "<<i>>"),
    build(ARG)
  )

  URL <- purrr::map2_chr(URL, N, \(x, n) {
    create_offset(
      n = n,
      limit = LIMIT,
      url = x
    )
  })

  purrr::imap(URL, \(x, nm) parallel_request(x)) |>
    collapse::rowbind(idcol = .id, id.factor = FALSE, return = 4L) |>
    polish(END, .id = .id)
}
