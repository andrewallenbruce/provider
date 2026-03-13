#' Revocations of Medicare Enrollments
#'
#' @description
#' Eligibility to order and refer within Medicare
#'
#' @references
#'    - [API: Medicare Order and Referring](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/order-and-referring)
#'    - [CMS: Ordering & Certifying](https://www.cms.gov/medicare/enrollment-renewal/providers-suppliers/chain-ownership-system-pecos/ordering-certifying)
#'
#' @param npi `<int>` 10-digit Individual National Provider Identifier
#' @param enid `<chr>` 15-digit Medicare Enrollment ID
#' @param first,middle,last `<chr>` Individual provider's name
#' @param specialty `<chr>` Enrollment specialty description
#' @param state `<chr>` Enrollment state, full or abbreviation
#' @param org_name `<chr>` Organization name
#' @param multi `<lgl>` Provider has multiple NPIs
#' @param reason `<chr>` reason for revocation
#' @param count `<lgl>` Return the dataset's total row count
#' @returns A [tibble][tibble::tibble-package]
#' @examples
#' revocations(count = TRUE)
#' revocations(state = "GA")
#' revocations(specialty = contains("CARDIO"))
#' @autoglobal
#' @export
revocations <- function(
  npi = NULL,
  enid = NULL,
  first = NULL,
  middle = NULL,
  last = NULL,
  org_name = NULL,
  multi = NULL,
  state = NULL,
  specialty = NULL,
  reason = NULL,
  count = FALSE
) {
  ARG <- params(
    ENRLMT_ID = enid,
    NPI = npi,
    FIRST_NAME = first,
    MDL_NAME = middle,
    LAST_NAME = last,
    ORG_NAME = org_name,
    MULTIPLE_NPI_FLAG = cv_lgl(multi),
    STATE_CD = state,
    PROVIDER_TYPE_DESC = specialty,
    REVOCATION_RSN = reason
  )

  .c(BASE, LIMIT, NM) %=% constants(rlang::call_name(rlang::call_match()))

  # COUNT --> Return Total Row Count
  if (!length(ARG)) {
    if (count) {
      cli_results(request_rows(paste0(BASE, "/stats?")))
      return(invisible(NULL))
    }

    # EMPTY QUERY --> Return First 10 Rows
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

  # NO RESULTS or COUNT --> Return Total Row Count
  if (N == 0L || count) {
    cli_results(N)
    return(invisible(NULL))
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
  cli_pages(N, offset(N, LIMIT))

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
