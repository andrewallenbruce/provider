#' @noRd
#' @autoglobal
exec_prov <- function(END, COUNT, ARG, call) {
  check_online()
  check_bool(COUNT)
  check_modifiers(ARG, END, call = call)

  .c(BASE, LIMIT, NM) %=% constants(END)

  # COUNT --> Return Invisibly
  if (!length(ARG)) {
    if (COUNT) {
      N <- request_count(BASE)

      cli_results(N, END)

      return(invisible(N))
    }

    # EMPTY QUERY --> First 10 Rows
    cli_no_query(END)

    res <- polish(request_pro(BASE), NM)

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
#' @autoglobal
exec_cms <- function(END, COUNT, SET, ARG) {
  check_online()
  check_bool(COUNT)
  check_bool(SET)

  .c(BASE, LIMIT, NM) %=% constants(END)

  # COUNT --> Return Invisibly
  if (!length(ARG)) {
    if (COUNT) {
      N <- request_rows(BASE)
      cli_results(N, END)
      return(invisible(N))
    }

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

      parallel_request(URL) |>
        polish(NM)
    }

    # EMPTY QUERY --> First 10 Rows
    cli_no_query(END)

    res <- polish(request_cms(BASE), NM)

    return(res)
  }

  # QUERY --> Request Count
  N <- request_rows(BASE, query(END, ARG))

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

#' @noRd
#' @autoglobal
exec_cms2 <- function(END, COUNT, ARG, .id) {
  check_online()
  check_bool(COUNT)

  .c(BASE, LIMIT, NM) %=% constants(END)

  # COUNT --> Return Invisibly
  if (!length(ARG)) {
    if (COUNT) {
      N <- purrr::map_int(BASE, \(x, nm) request_rows(x))
      cli_results2(N, END)
      return(invisible(N))
    }

    # EMPTY QUERY --> First 10 Rows
    cli_no_query(END)

    res <- purrr::imap(BASE, \(x, i) request_cms(x)) |>
      collapse::rowbind(idcol = .id, return = 4L) |>
      polish(c(rlang::set_names(.id), NM))

    return(res)
  }

  # QUERY --> Request Count
  N <- purrr::imap_vec(BASE, \(x, n) request_rows(x, query(END, ARG)))

  # NO RESULTS or COUNT --> Return Invisibly
  if (sum2(N) == 0L || COUNT) {
    cli_results2(N, END)
    return(invisible(N))
  }

  # COUNT BELOW LIMIT --> Single Request
  if (all2(N <= LIMIT)) {
    cli_results2(N, END)

    res <- purrr::imap(BASE, \(x, nm) {
      request_cms(x, LIMIT, query(END, ARG))
    }) |>
      collapse::rowbind(idcol = .id, return = 4L) |>
      polish(c(rlang::set_names(.id), NM))

    return(res)
  }

  # COUNT ABOVE LIMIT --> Multiple Requests
  cli_pages2(N, LIMIT, END)

  URL <- url_str(
    paste0(BASE, "?"),
    opts(size = LIMIT, offset = "<<i>>"),
    query(END, ARG)
  )

  URL <- purrr::map2_chr(URL, N, \(x, n) {
    create_offset(
      n = n,
      limit = LIMIT,
      url = x
    )
  })

  purrr::imap(URL, \(x, nm) parallel_request(x)) |>
    collapse::rowbind(idcol = .id, return = 4L) |>
    polish(c(rlang::set_names(.id), NM))
}
