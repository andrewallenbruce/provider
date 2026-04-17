#' @noRd
uuid_prov <- function(endpoint) {
  paste0(
    "https://data.cms.gov/provider-data/api/1/datastore/query/",
    switch(
      endpoint,
      affiliations = "27ea-46a8",
      clinicians = "mj5m-pzi6",
      hospitals2 = "xubh-q36u",
      cli::cli_abort("{.arg endpoint} {.val {endpoint}} is invalid.")
    ),
    "/0?"
  )
}

#' @noRd
uuid_cms <- function(endpoint) {
  p0 <- function(id) {
    paste0(
      "https://data.cms.gov/",
      "data-api/v1/dataset/",
      id,
      "/data"
    )
  }

  x <- switch(
    endpoint,
    clia = "d3eb38ac-d8e9-40d3-b7b7-6205d3d1dc16",
    hospitals = "f6f6505c-e8b0-4d57-b258-e2b94133aaf2",
    opt_out = "9887a515-7552-4693-bf58-735c77af46d7",
    order_refer = "c99b5865-1119-4436-bb80-c5af2773ea1f",
    providers = "2457ea29-fc82-48b0-86ec-3b0755de7515",
    reassignments = "20f51cff-4137-4f3a-b6b7-bfc9ad57983b",
    revocations = "a6496a7d-4e19-479a-a9ad-d4c0a49e07c3",
    transparency = "6a3aa708-3c9d-411a-a1a4-e046d3ade7ef",
    pending = list(
      Physician = "6bd6b1dd-208c-4f9c-88b8-b15fec6db548",
      `Non-Physician` = "261b83b6-b89f-43ad-ae7b-0d419a3bc24b"
    ),
    quality = "7adb8b1b-b85c-4ed3-b314-064776e50180",
    rhc = list(
      Enrollment = "3b7e7659-067e-41ea-8e36-f9ee2036e1f6",
      Owners = "ab03c9bc-0c22-4ca4-b032-21dd3408210d"
    ),
    fqhc = list(
      Enrollment = "4bcae866-3411-439a-b762-90a6187c194b",
      Owners = "ed289c89-0bb8-4221-a20a-85776066381b"
    ),
    utilization = list(
      Geography = "6fea9d79-0129-4e4c-b1b8-23cd86a4f435",
      Provider = "8889d81e-2ee7-448f-8713-f071038289b5",
      Service = "92396110-2aed-4d63-a6a2-5d6207d46a29"
    ),
    cli::cli_abort("{.arg endpoint} {.val {endpoint}} is invalid.")
  )

  if (length(x) > 1L) {
    purrr::map(x, p0)
  } else {
    p0(x)
  }
}

#' @noRd
create_offset <- function(n, limit, url) {
  purrr::map_chr(
    offset(n, limit, "seq"),
    function(x) {
      sub_idx(url, x)
    }
  )
}

#' @noRd
opts <- function(
  count = NULL,
  results = NULL,
  schema = NULL,
  size = NULL,
  limit = NULL,
  offset = NULL
) {
  x <- params(
    count = count,
    results = results,
    schema = schema,
    size = size,
    limit = limit,
    offset = offset
  )

  if (length(x) == 0L) {
    return(NULL)
  }
  flatten_opts(x)
}

#' @noRd
url_str <- function(base, opts = opts(), args = NULL) {
  if (is.null(args) || length(args) == 0L) {
    return(paste0(base, opts))
  }
  paste(paste0(base, opts), args, sep = "&")
}

#' @noRd
request_bare <- function(base, opts = NULL, args = NULL, query = NULL) {
  url_str(base = base, opts = opts, args = args) |>
    httr2::request() |>
    httr2::req_error(body = function(resp) {
      httr2::resp_body_json(resp)$message
    }) |>
    # httr2::req_user_agent("provider (https://andrewallenbruce.github.io/provider)") |>
    httr2::req_perform() |>
    parse_string(query = query)
}

#' @noRd
request_count <- function(base, args = NULL) {
  request_bare(
    base = base,
    opts = opts(
      count = "true",
      results = "false",
      schema = "false"
    ),
    args = args,
    query = "count"
  )
}

#' @noRd
request_rows <- function(base, args = NULL) {
  request_bare(
    base = paste0(base, "/stats?"),
    args = args,
    query = "found_rows"
  )
}

#' @noRd
request_prov <- function(base, limit = 10, args = NULL) {
  request_bare(
    base = base,
    opts = opts(
      count = "false",
      results = "true",
      schema = "false",
      limit = limit
    ),
    args = args,
    query = "results"
  )
}

#' @noRd
request_cms <- function(base, limit = 10, args = NULL) {
  request_bare(
    base = paste0(base, "?"),
    opts = opts(size = limit),
    args = args
  )
}

#' @noRd
parallel_results <- function(x) {
  parallel_request(x, query = "results")
}

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
exec_pend <- function(COUNT, ARG, .id, LIMIT = 5000L) {
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
      polish(END, id = .id)

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
      polish(END, id = .id)

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
    polish(END, id = .id)
}
