#' Provider Enrollment in Medicare
#'
#' @description
#' Enrollment data on individual and organizational providers that are
#'    actively approved to bill Medicare.
#'
#' @references
#'    - [API: Medicare Provider Supplier Enrollment](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/medicare-fee-for-service-public-provider-enrollment)
#'    - [Provider Enrollment Data Dictionary](https://data.cms.gov/resources/medicare-fee-for-service-public-provider-enrollment-data-dictionary)
#'
#' @param npi `<int>` 10-digit Individual National Provider Identifier
#' @param pac `<chr>` 10-digit PECOS Associate Control ID
#' @param enid `<chr>` 15-digit Medicare Enrollment ID
#' @param first,middle,last `<chr>` Individual provider's name
#' @param spec `<chr>` Enrollment specialty code
#' @param specialty `<chr>` Enrollment specialty description
#' @param state `<chr>` Enrollment state, full or abbreviation
#' @param org_name `<chr>` Organization name
#' @param multi `<lgl>` Provider has multiple NPIs
#' @param count `<lgl>` Return the dataset's total row count
#' @returns A [tibble][tibble::tibble-package]
#' @examples
#' providers(count = TRUE)
#' providers(enid = "I20040309000221")
#' providers(npi = 1417918293)
#' providers(pac = 2860305554)
#' providers(state = "AK")
#' @autoglobal
#' @export
providers <- function(
  npi = NULL,
  pac = NULL,
  enid = NULL,
  first = NULL,
  middle = NULL,
  last = NULL,
  spec = NULL,
  specialty = NULL,
  state = NULL,
  org_name = NULL,
  multi = NULL,
  count = FALSE
) {
  ARG <- params(
    NPI = npi,
    MULTIPLE_NPI_FLAG = cv_lgl(multi),
    PECOS_ASCT_CNTL_ID = pac,
    ENRLMT_ID = enid,
    PROVIDER_TYPE_CD = spec,
    PROVIDER_TYPE_DESC = specialty,
    STATE_CD = state,
    LAST_NAME = last,
    FIRST_NAME = first,
    MDL_NAME = middle,
    ORG_NAME = org_name
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
