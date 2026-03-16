#' Pending Medicare Enrollments
#'
#' @description
#' Providers with pending Medicare enrollment applications.
#'
#' @references
#'    * [Medicare Pending Initial Logging and Tracking Physicians API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/pending-initial-logging-and-tracking-physicians)
#'    * [Medicare Pending Initial Logging and Tracking Non-Physicians API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/pending-initial-logging-and-tracking-non-physicians)
#'
#' @param npi `<int>` National Provider Identifier
#' @param first,last `<chr>` Provider's name
#' @param count `<lgl>` Return the dataset's total row count
#' @returns A [tibble][tibble::tibble-package]
#' @examplesIf httr2::is_online()
#' pending(count = TRUE)
#' pending(first = "John")
#' pending(first = starts_with("J"))
#' @autoglobal
#' @export
pending <- function(
  npi = NULL,
  first = NULL,
  last = NULL,
  count = FALSE
) {
  check_online()
  END <- rlang::call_name(rlang::call_match())

  .c(BASE, LIMIT, NM) %=% constants(END)

  COUNT = count

  ARG <- params(
    NPI = npi,
    LAST_NAME = last,
    FIRST_NAME = first
  )

  # COUNT --> Return Invisibly
  if (!length(ARG)) {
    if (COUNT) {
      N <- purrr::map_int(BASE, function(x, nm) {
        request_rows(paste0(x, "/stats?"))
      })
      cli_results(N, END)
      return(invisible(N))
    }

    # EMPTY QUERY --> First 10 Rows
    cli_no_query()

    res <- purrr::imap(BASE, function(x, nm) {
      request_bare(url_str(paste0(x, "?"), opts(size = 10))) |>
        polish(NM)
    }) |>
      collapse::rowbind(idcol = "prov_type")

    return(res)
  }

  # QUERY --> Request Count
  N <- purrr::map_int(BASE, function(x, nm) {
    request_rows(url_str(
      paste0(x, "/stats?"),
      opts(size = LIMIT),
      query(END, ARG)
    ))
  })

  # NO RESULTS or COUNT --> Return Invisibly
  if (sum(N, na.rm = TRUE) == 0L || COUNT) {
    cli_results(N, END)
    return(invisible(N))
  }

  # COUNT BELOW LIMIT --> Single Request
  if (all(N <= LIMIT)) {
    cli_results(N, END)

    res <- purrr::imap(BASE, function(x, nm) {
      request_bare(url_str(
        paste0(x, "?"),
        opts(size = LIMIT),
        query(END, ARG)
      )) |>
        polish(NM)
    }) |>
      collapse::rowbind(idcol = "prov_type")

    return(res)
  }

  # COUNT ABOVE LIMIT --> Multiple Requests
  cli_pages(N, LIMIT, END)

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

  purrr::imap(URL, function(x, nm) {
    parallel_request(x) |>
      polish(NM)
  }) |>
    collapse::rowbind(idcol = "prov_type")
}
