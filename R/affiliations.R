#' Provider-Facility Affiliations
#'
#' @description Access information concerning individual providers'
#'    affiliations with organizations/facilities.
#'
#' @references
#'    * [API: Physician Facility Affiliations](https://data.cms.gov/provider-data/dataset/27ea-46a8)
#'    * [Certification Number (CCN) State Codes](https://www.cms.gov/Medicare/Provider-Enrollment-and-Certification/SurveyCertificationGenInfo/Downloads/Survey-and-Cert-Letter-16-09.pdf)
#'
#' @param npi `<int>` Individual National Provider Identifier
#' @param pac `<chr>` Individual PECOS Associate Control ID
#' @param first,middle,last,suffix `<chr>` Individual provider's name
#' @param facility_type `<chr>` facility type abbreviation
#' @param facility_ccn `<chr>` CCN of `facility_type` column's
#'    facility **or** of a **unit** within the hospital where the individual
#'    provider provides services.
#' @param parent_ccn `<chr>` CCN of the **primary** hospital containing the
#'    unit where the individual provider provides services.
#' @param count `<lgl>` Return the dataset's total row count
#' @returns A [tibble][tibble::tibble-package]
#' @examples
#' affiliations(count = TRUE)
#' affiliations()
#' affiliations(first = "")
#' affiliations(facility_ccn = "33Z302")
#' affiliations(parent_ccn = 331302)
#' affiliations(facility_ccn = 331302)
#' @autoglobal
#' @export
affiliations <- function(
  npi = NULL,
  pac = NULL,
  first = NULL,
  middle = NULL,
  last = NULL,
  suffix = NULL,
  facility_type = NULL,
  facility_ccn = NULL,
  parent_ccn = NULL,
  count = FALSE
) {
  ARG <- params(
    npi = npi,
    ind_pac_id = pac,
    provider_last_name = last,
    provider_first_name = first,
    provider_middle_name = middle,
    suff = suffix,
    facility_type = enum_(facility_type),
    facility_affiliations_certification_number = facility_ccn,
    facility_type_certification_number = parent_ccn
  )

  .c(BASE, LIMIT, NM) %=% constants("affiliations")

  # EMPTY QUERY --> Return First 10 Rows
  if (!length(ARG)) {
    # COUNT --> Return Total Row Count
    if (count) {
      cli_results(
        request_count(
          url_(BASE, opts(count = "true", results = "false", schema = "false"))
        )
      )
      return(invisible(NULL))
    }

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
  N <- request_count(url_(
    BASE,
    opts(
      count = "true",
      results = "false",
      schema = "false",
      limit = LIMIT
    ),
    query(ARG)
  ))

  # NO RESULTS --> Alert & Exit
  if (N == 0L) {
    cli_results(N)
    return(invisible(NULL))
  }

  # COUNT --> Return Total Row Count
  if (count) {
    cli_results(N)
    return(invisible(NULL))
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

  # COUNT ABOVE LIMIT --> Multiple Parallel Requests
  cli_pages(N, offset(N, LIMIT))

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
