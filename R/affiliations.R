#' Provider-Facility Affiliations
#'
#' @description Access information concerning individual providers'
#'    affiliations with organizations/facilities.
#'
#' @references
#'    * [Physician Facility Affiliations](https://data.cms.gov/provider-data/dataset/27ea-46a8)
#'    * [Certification Number (CCN) State Codes](https://www.cms.gov/Medicare/Provider-Enrollment-and-Certification/SurveyCertificationGenInfo/Downloads/Survey-and-Cert-Letter-16-09.pdf)
#'
#' @param npi `<int>` Individual National Provider Identifier
#' @param pac `<chr>` Individual PECOS Associate Control ID
#' @param first,middle,last,suffix `<chr>` Individual provider's name
#' @param facility_type `<chr>` facility type abbreviation:
#'
#'    |**ABBR**  |**FULL**                          |
#'    |:---------|:---------------------------------|
#'    |`hp`      |Hospital                          |
#'    |`lt`      |Long-term care hospital           |
#'    |`nh`      |Nursing home                      |
#'    |`irf`     |Inpatient rehabilitation facility |
#'    |`hha`     |Home health agency                |
#'    |`snf`     |Skilled nursing facility          |
#'    |`hs`      |Hospice                           |
#'    |`df`      |Dialysis facility                 |
#'
#'
#' @param facility_ccn `<chr>` CCN of `facility_type` column's
#'    facility **or** of a **unit** within the hospital where the individual
#'    provider provides services.
#' @param parent_ccn `<chr>` CCN of the **primary** hospital containing the
#'    unit where the individual provider provides services.
#'
#' @returns A [tibble][tibble::tibble-package]
#'
#' @examples
#' affiliations()
#'
#' affiliations(pac = 7810891009)
#'
#' affiliations(npi = 1003026055)
#'
#' affiliations(first = "KIM")
#'
#' affiliations(facility_ccn = c("33Z302", 331302))
#'
#' @autoglobal
#'
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
  parent_ccn = NULL
) {
  args <- params(
    npi = npi,
    ind_pac_id = pac,
    provider_last_name = last,
    provider_first_name = first,
    provider_middle_name = middle,
    suff = suffix,
    facility_type = facility_enum(facility_type),
    facility_affiliations_certification_number = facility_ccn,
    facility_type_certification_number = parent_ccn
  )

  .c(BASE, LIMIT, NM) %=% constants("affiliations")

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

#' @autoglobal
#' @noRd
facility_enum <- function(facility_type = NULL) {
  if (is.null(facility_type)) {
    return(NULL)
  }

  ENUM <- list(
    hp = "Hospital",
    lt = "Long-term care hospital",
    nh = "Nursing home",
    irf = "Inpatient rehabilitation facility",
    hha = "Home health agency",
    snf = "Skilled nursing facility",
    hs = "Hospice",
    df = "Dialysis facility"
  )

  facility_type <- rlang::arg_match(
    facility_type,
    rlang::names2(ENUM),
    multiple = TRUE
  )

  unlist_(ENUM[facility_type])
}
