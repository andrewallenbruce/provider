#' @noRd
EndPoint <- expr(call_name(call_match(call = caller_call(), fn = caller_fn())))

#' @noRd
#' @autoglobal
exec_prov <- function(COUNT, ARG, LIMIT = 1500L) {

  END <- eval_bare(EndPoint)
  BASE <- uuid_prov(END)

  check_online()
  check_bool(COUNT)
  check_modifiers(ARG, END)

  # COUNT --> Return Invisibly
  if (!length(ARG)) {
    if (COUNT) {
      N <- request_count(BASE)
      cli_total(N, END)
      return(invisible(N))
    }

    # EMPTY QUERY --> First 10 Rows
    cli_no_query(END)
    return(polish(request_prov(BASE), END))
  }

  # QUERY --> Request Count
  ARG <- build(ARG)
  N <- request_count(BASE, ARG)

  # NO RESULTS or COUNT --> Return Invisibly
  if (N == 0L || COUNT) {
    cli_results(N, END)
    return(invisible(N))
  }

  # COUNT BELOW LIMIT --> Single Request
  if (N <= LIMIT) {
    cli_results(N, END)
    return(polish(request_prov(BASE, LIMIT, ARG), END))
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

  URL <- create_offset(N, LIMIT, url_str(BASE, OPT, ARG))
  polish(parallel_results(URL), END)
}

#' @noRd
#' @autoglobal
exec_cms <- function(COUNT, SET, ARG, LIMIT = 5000L) {
  check_online()
  check_bool(COUNT)
  check_bool(SET)

  END <- eval_bare(EndPoint)
  BASE <- uuid_cms(END)

  # N0 QUERY
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

    # COUNT --> Return Invisibly
    if (COUNT) {
      N <- request_rows(BASE)
      cli_total(N, END)
      return(invisible(N))
    }

    # !COUNT --> First 10 Rows
    cli_no_query(END)
    return(polish(request_cms(BASE), END))
  }

  # QUERY --> Request Count
  ARG <- build(ARG)
  N <- request_rows(BASE, ARG)

  # NO RESULTS or COUNT --> Return Invisibly
  if (N == 0L || COUNT) {
    cli_results(N, END)
    return(invisible(N))
  }

  # COUNT BELOW LIMIT --> Single Request
  if (N <= LIMIT) {
    cli_results(N, END)
    return(polish(request_cms(BASE, LIMIT, ARG), END))
  }

  # COUNT ABOVE LIMIT --> Multiple Requests
  cli_pages(N, LIMIT, END)

  URL <- url_str(
    paste0(BASE, "?"),
    opts(size = LIMIT, offset = "<<i>>"),
    ARG
  )
  polish(parallel_request(create_offset(N, LIMIT, URL)), END)
}

#' @noRd
#' @autoglobal
exec_cms2 <- function(COUNT, ARG, .id, LIMIT = 5000L) {
  check_online()
  check_bool(COUNT)

  END <- call_name(call_match(call = caller_call(), fn = caller_fn()))
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
