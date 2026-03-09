#' Clinicians Enrolled in Medicare
#'
#' @description Access information about providers enrolled in Medicare,
#' including the medical school that they attended and the year they graduated
#'
#' @section Links:
#'
#'    * [National Downloadable File](https://data.cms.gov/provider-data/dataset/mj5m-pzi6)
#'    * [Provider Data Catalog (PDC) Data Dictionary](https://data.cms.gov/provider-data/sites/default/files/data_dictionaries/physician/DOC_Data_Dictionary.pdf)
#'
#' @param npi `<int>` Individual National Provider Identifier
#' @param pac `<int>` Individual PECOS Associate Control ID
#' @param enid `<chr>` Individual Medicare Enrollment ID
#' @param first,middle,last,suffix `<chr>` Individual provider's name
#' @param gender `<chr>` Individual provider's gender; `"F"` (Female), `"M"` (Male), or `"U"` (Unknown)
#' @param credential `<chr>` Individual provider's credential, i.e. `"MD"`
#' @param school `<chr>` Individual provider’s alma mater
#' @param year `<int>` Individual provider’s graduation year
#' @param specialty `<chr>` Individual provider’s primary medical specialty
#' @param city,state,zip `<chr>` Facility's city, state, zip
#' @param facility_name `<chr>` Facility associated with Provider
#' @param facility_pac `<int>` Facility's PECOS Associate Control ID
#'
#' @returns A [tibble][tibble::tibble-package] with the columns:
#'
#'   |**Field**       |**Description**                                       |
#'   |:---------------|:-----------------------------------------------------|
#'   |`npi`           |10-digit individual NPI                               |
#'   |`pac`           |10-digit individual PAC ID                            |
#'   |`enid`          |15-digit individual enrollment ID                     |
#'   |`first`         |Provider's first name                                 |
#'   |`middle`        |Provider's middle name                                |
#'   |`last`          |Provider's last name                                  |
#'   |`suffix`        |Provider's name suffix                                |
#'   |`gender`        |Provider's gender                                     |
#'   |`credential`    |Provider's credential                                 |
#'   |`school`        |Provider's medical school                             |
#'   |`grad_year`     |Provider's graduation year                            |
#'   |`specialty`     |Provider's primary specialty                          |
#'   |`specialty_sec` |Provider's secondary specialty                        |
#'   |`facility_name` |Facility associated with provider                     |
#'   |`pac_org`       |Facility's 10-digit PAC ID                            |
#'   |`members`       |Number of providers associated with facility's PAC ID |
#'   |`address`       |Provider's street address                             |
#'   |`city`          |Provider's city                                       |
#'   |`state`         |Provider's state                                      |
#'   |`zip`           |Provider's zip code                                   |
#'   |`phone`         |Provider's phone number                               |
#'   |`telehealth`    |Indicates if provider offers telehealth services      |
#'   |`assign_ind`    |Indicates if provider accepts Medicare assignment     |
#'   |`assign_org`    |Indicates if facility accepts Medicare assignment     |
#'
#' @examples
#' clinicians()
#'
#' clinicians(enid = "I20081002000549")
#'
#' clinicians(first = "ETAN")
#'
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
  facility_pac = NULL
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
