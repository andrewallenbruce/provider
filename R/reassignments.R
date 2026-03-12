#' Reassignment of Benefits
#'
#' @description
#' Returns information about:
#'    * Individual providers who are reassigning benefits or are an employee of
#'    * Organizational/Group providers who are receiving reassignment of benefits from or are the employer of the individual provider
#'
#' It provides information regarding the physician and the group practice they
#' reassign their billing to, including individual employer association counts.
#'
#' @references
#'    - [API: Medicare Revalidation Reassignment List](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-reassignment-list)
#'
#' @param npi `<int>` 10-digit National Provider Identifier
#' @param pac `<chr>` 10-digit PECOS Associate Control ID
#' @param enid `<chr>` 15-digit Medicare Enrollment ID
#' @param first,last `<chr>` Provider's name
#' @param state `<chr>` Enrollment state abbreviation
#' @param specialty `<chr>` Enrollment specialty
#' @param org_name `<chr>` Legal business name
#' @param org_pac `<chr>` 10-digit PECOS Associate Control ID
#' @param org_enid `<chr>` 15-digit Medicare Enrollment ID
#' @param org_state `<chr>` Enrollment state abbreviation
#' @param count `<lgl>` Return the dataset's total row count
#' @returns A [tibble][tibble::tibble-package]
#' @examples
#' reassignments(count = TRUE)
#' reassignments(org_enid = "I20070209000135")
#' reassignments(pac = 9830437441)
#' reassignments(org_pac = 3173525888)
#' @autoglobal
#' @export
reassignments <- function(
  npi = NULL,
  pac = NULL,
  enid = NULL,
  first = NULL,
  last = NULL,
  state = NULL,
  specialty = NULL,
  org_name = NULL,
  org_pac = NULL,
  org_enid = NULL,
  org_state = NULL,
  count = FALSE
) {
  ARG <- params(
    `Individual NPI` = npi,
    `Individual PAC ID` = pac,
    `Individual Enrollment ID` = enid,
    `Individual First Name` = first,
    `Individual Last Name` = last,
    `Individual State Code` = state,
    `Individual Specialty Description` = specialty,
    `Group Legal Business Name` = org_name,
    `Group PAC ID` = org_pac,
    `Group Enrollment ID` = org_enid,
    `Group State Code` = org_state
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
