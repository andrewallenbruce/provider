#' Provider-Facility Affiliations
#'
#' @description [affiliations()] allows the user access to data concerning
#'   providers' facility affiliations
#'
#' @section Links:
#'    * [Physician Facility Affiliations](https://data.cms.gov/provider-data/dataset/27ea-46a8)
#'    * [Certification Number (CCN) State Codes](https://www.cms.gov/Medicare/Provider-Enrollment-and-Certification/SurveyCertificationGenInfo/Downloads/Survey-and-Cert-Letter-16-09.pdf)
#'
#' @param npi `<int>` Individual clinician ID, assigned by *NPPES*
#' @param pac `<chr>` Individual clinician ID, assigned by *PECOS*
#' @param first,middle,last,suffix `<chr>` Individual clinician's name
#' @param facility_type `<chr>` Type of facility:
#'
#' |**abbr**  |**full**                      |
#' |:---------|:---------------------------------|
#' |`hp`      |Hospital                          |
#' |`lt`      |Long-term care hospital           |
#' |`nh`      |Nursing home                      |
#' |`irf`     |Inpatient rehabilitation facility |
#' |`hha`     |Home health agency                |
#' |`snf`     |Skilled nursing facility          |
#' |`hs`      |Hospice                           |
#' |`df`      |Dialysis facility                 |
#'
#'
#' @param facility_ccn `<chr>` Medicare CCN of `facility_type` column's
#'    facility *or* of a *unit* within the hospital where the individual
#'    clinician provides services.
#' @param parent_ccn `<chr>` Medicare CCN of *primary* hospital where the
#'    individual clinician provides services in a unit within said hospital.
#'
#' @template returns
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
  args <- parameters(
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

  base <- "https://data.cms.gov/provider-data/api/1/datastore/query/27ea-46a8/0?"

  # No Query: Warn & Return First 10 Rows =====================
  if (!length(args)) {
    cli::cli_alert_warning(c("{.emph No Query} ", cli::symbol$pointer, " Returning first 10 rows."))

    url <- flatten_url(
      base,
      opts = set_opts(
        count = "false",
        results = "true",
        schema = "false",
        limit = 10L
      )
    )

    res <- bare_request(url, "results") |>
      fastplyr::as_tbl() |>
      map_na_if() |>
      rename_affiliations()

    return(res)
  }

  # Valid Query: Flatten & Request Result Count =====================
  url <- flatten_url(
    base,
    opts = set_opts(
      count = "true",
      results = "false",
      schema = "false",
      offset = 0,
      limit = 1500
    ),
    query = flatten_query(args)
  )

  N <- bare_request(url, "count")

  # Query Returned Nothing: Alert & Exit =====================
  if (N == 0L) {
    cli::cli_alert_danger("Query returned {N} results.")
    return(invisible(NULL))
  }

  # Count is Within API Limit: Request & Return Results
  if (N <= 1500L) {
    cli::cli_alert_success("Query returned {N} result{?s}.")

    url <- flatten_url(
      base,
      opts = set_opts(
        count = "false",
        results = "true",
        schema = "false",
        offset = 0,
        limit = 1500
      ),
      query = flatten_query(args)
    )

    res <- bare_request(url, "results") |>
      fastplyr::as_tbl() |>
      map_na_if() |>
      rename_affiliations()

    return(res)
  }

  # Count Above API Limit: Alert & Return Results =====================
  cli::cli_alert_success("Query returned {format(N, big.mark = ',')} results.")
  cli::cli_alert_info("Retrieving {offset(N, 1500L)} page{?s}...")

  url <- flatten_url(
    base,
    opts = set_opts(
      count = "false",
      results = "true",
      schema = "false",
      limit = 1500,
      offset = "<<i>>"
    ),
    query = flatten_query(args)
  )

  urls <- offset(N, 1500L, "seq") |>
    purrr::map_chr(\(x) {
      gsub(x = url, pattern = "<<i>>", replacement = x, fixed = TRUE)
    })

  parallel_request(urls, "results") |>
    collapse::rowbind() |>
    fastplyr::as_tbl() |>
    map_na_if() |>
    rename_affiliations()
}

#' @autoglobal
#' @noRd
rename_affiliations <- function(x) {
  NM <- c(
    npi = "npi",
    ind_pac_id = "pac",
    provider_last_name = "last",
    provider_first_name = "first",
    provider_middle_name = "middle",
    suff = "suffix",
    facility_type = "facility_type",
    facility_affiliations_certification_number = "facility_ccn",
    facility_type_certification_number = "parent_ccn"
  )

  collapse::setrename(x, NM, .nse = FALSE)

  collapse::gv(x, unlist_(NM))
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
