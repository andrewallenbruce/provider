#' Clinician Demographics
#'
#' @description
#' Demographics of clinicians listed in the Provider Data Catalog (PDC)
#'
#' @section Data Source:
#' The Doctors and Clinicians National Downloadable File is organized such that
#' each line is unique at the clinician/enrollment record/group/address level.
#' Clinicians with multiple Medicare enrollment records and/or single enrollments
#' linking to multiple practice locations are listed on multiple lines.
#'
#' ### Inclusion Criteria
#' A Clinician or Group must have:
#'   - Current and approved Medicare enrollment record in PECOS
#'   - Valid physical practice location or address
#'   - Valid specialty
#'   - National Provider Identifier
#'   - One Medicare FFS claim within the last six months
#'   - Two approved clinicians reassigning their benefits to the group
#'
#' @references
#'   - [API: National Downloadable File](https://data.cms.gov/provider-data/dataset/mj5m-pzi6)
#'   - [Provider Data Catalog (PDC) Data Dictionary](https://data.cms.gov/provider-data/sites/default/files/data_dictionaries/physician/DOC_Data_Dictionary.pdf)
#'   - [Source Information](https://data.cms.gov/provider-data/topics/doctors-clinicians/data-sources)
#'
#' @param npi `<int>` National Provider Identifier
#' @param pac `<int>` PECOS Associate Control ID
#' @param enid `<chr>` Medicare Enrollment ID
#' @param first,middle,last,suffix `<chr>` Individual provider's name
#' @param gender `<chr>` Provider's gender; `"F"` (Female), `"M"` (Male), or `"U"` (Unknown)
#' @param credential `<chr>` Provider's credential, i.e. `"MD"`, `"OD"`
#' @param school `<chr>` Provider’s medical school
#' @param year `<int>` Provider’s graduation year
#' @param specialty `<chr>` Provider’s primary medical specialty
#' @param city,state,zip `<chr>` Facility's city, state, zip
#' @param facility_name `<chr>` Facility associated with Provider
#' @param facility_pac `<int>` Facility's PECOS Associate Control ID
#' @param count `<lgl>` Return the dataset's total row count
#' @returns A [tibble][tibble::tibble-package]
#' @examples
#' clinicians(count = TRUE)
#' clinicians(enid = "I20081002000549")
#' clinicians(first = "ETAN")
#' clinicians(city = starts_with("At"), state = "GA", year = 2020)
#' @autoglobal
#' @export
clinicians <- function(
  npi = NULL,
  pac = NULL,
  enid = NULL,
  first = NULL,
  middle = NULL,
  last = NULL,
  suffix = NULL,
  gender = NULL,
  credential = NULL,
  specialty = NULL,
  school = NULL,
  year = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  facility_name = NULL,
  facility_pac = NULL,
  count = FALSE
) {
  args <- params(
    npi = npi,
    ind_pac_id = pac,
    ind_enrl_id = enid,
    provider_last_name = last,
    provider_first_name = first,
    provider_middle_name = middle,
    suff = suffix,
    gndr = gender,
    cred = credential,
    med_sch = school,
    grd_yr = year,
    pri_spec = specialty,
    facility_name = facility_name,
    org_pac_id = facility_pac,
    citytown = city,
    state = state,
    zip_code = zip
  )

  .c(BASE, LIMIT, NM) %=% constants("clinicians")

  # Return Total Rows =====================
  if (count) {
    cli_results(request_count(url_(
      BASE,
      opts(count = "true", results = "false", schema = "false")
    )))
    return(invisible(NULL))
  }

  # No Query: Warn & Return First 10 Rows =====================
  if (!length(args)) {
    cli_no_query()

    url <- url_(
      BASE,
      opts(
        count = "false",
        results = "true",
        schema = "false",
        limit = 10
      )
    )

    res <- request_results(url) |>
      fastplyr::as_tbl() |>
      map_na_if() |>
      rename_(NM)

    return(res)
  }
  # Valid Query: Flatten & Request Result Count =====================
  url <- url_(
    BASE,
    opts(
      count = "true",
      results = "false",
      schema = "false",
      limit = LIMIT
    ),
    query(args)
  )

  N <- request_count(url)

  # Query Returned Nothing: Alert & Exit =====================
  if (N == 0L) {
    cli_no_results()
    return(invisible(NULL))
  }

  # Count is Within API Limit: Request & Return Results
  if (N <= LIMIT) {
    cli_results(N)

    url <- url_(
      BASE,
      opts(
        count = "false",
        results = "true",
        schema = "false",
        limit = LIMIT
      ),
      query(args)
    )

    res <- request_results(url) |>
      fastplyr::as_tbl() |>
      map_na_if() |>
      rename_(NM)

    return(res)
  }

  # Count Above API Limit: Alert & Return Results =====================
  cli_pages(N, offset(N, LIMIT))

  url <- url_(
    BASE,
    opts(
      count = "false",
      results = "true",
      schema = "false",
      limit = LIMIT,
      offset = "<<i>>"
    ),
    query(args)
  )

  urls <- offset(N, LIMIT, "seq") |>
    purrr::map_chr(\(x) {
      gsub(x = url, pattern = "<<i>>", replacement = x, fixed = TRUE)
    })

  parallel_results(urls) |>
    fastplyr::as_tbl() |>
    map_na_if() |>
    rename_(NM)
}
