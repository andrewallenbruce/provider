#' Provider Facility Affiliations
#'
#' @description [affiliations()] allows the user access to data concerning
#'   providers' facility affiliations
#'
#' @section Links:
#'    * [Physician Facility Affiliations](https://data.cms.gov/provider-data/dataset/27ea-46a8)
#'    * [Certification Number (CCN) State Codes](https://www.cms.gov/Medicare/Provider-Enrollment-and-Certification/SurveyCertificationGenInfo/Downloads/Survey-and-Cert-Letter-16-09.pdf)
#'
#' @param npi `<int>` Unique clinician ID assigned by NPPES
#' @param pac `<chr>` Unique individual clinician ID assigned by PECOS
#' @param facility_ccn `<chr>` CCN of `facility_type` or unit within hospital where an individual clinician provides service
#' @param parent_ccn `<chr>` CCN of the primary hospital where individual clinician provides service, should the clinician provide services in a unit within the hospital
#' @param first,middle,last,suffix `<chr>` Clinician name
#' @param facility_type `<chr>` type of facility:
#'    * `"hp"` Hospital
#'    * `"lt"` Long-Term Care Hospital
#'    * `"nh"` Nursing Home
#'    * `"irf"` Inpatient Rehabilitation Facility
#'    * `"hha"` Home Health Agency
#'    * `"snf"` Skilled Nursing Facility
#'    * `"hs"` Hospice
#'    * `"df"` Dialysis Facility
#'
#' @template returns
#'
#' @examples
#' # affiliations(facility_type = c("lt", "irf")) 15,105 results
#'
#' affiliations(facility_ccn = "33Z302")
#'
#' affiliations(parent_ccn = 331302)
#'
#' affiliations(pac = 7810891009)
#'
#' affiliations(npi = 1003026055)
#'
#' affiliations(first = "KIM")
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
  args <- compact_list(
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

  # No Query: Warn & Return First 10 Rows =====================
  if (!length(args)) {
    cli::cli_alert_warning(
      "No arguments provided. Returning first 10 rows."
    )

    opts <- flatten_opts(list(
      count = "false",
      results = "true",
      schema = "false",
      limit = 10L
    ))

    base <- "https://data.cms.gov/provider-data/api/1/datastore/query/27ea-46a8/0?"
    url <- flatten_url(base, opts)

    res <- httr2::request(url) |>
      httr2::req_error(body = \(resp) httr2::resp_body_json(resp)$message) |>
      httr2::req_perform() |>
      parse_string("results") |>
      fastplyr::as_tbl()

    res <- affiliations_names(res)
    return(res)
  }

  # Valid Query: Flatten & Request Result Count =====================
  query <- flatten_query(args)

  opts <- flatten_opts(list(
    count = "true",
    results = "false",
    schema = "false",
    offset = 0,
    limit = 1500
  ))

  base <- "https://data.cms.gov/provider-data/api/1/datastore/query/27ea-46a8/0?"
  url <- flatten_url(base, opts, query)

  N <- httr2::request(url) |>
    httr2::req_error(body = \(resp) httr2::resp_body_json(resp)$message) |>
    httr2::req_perform() |>
    parse_string("count")

  # Query Returned Nothing: Alert & Exit =====================
  if (N == 0L) {
    cli::cli_alert_danger("Query returned 0 results.")
    return(invisible(NULL))
  }

  # Count is Within API Limit: Request & Return Results
  if (N <= 1500L) {
    cli::cli_alert_success("Query returning {N} results.")

    opts <- flatten_opts(list(
      count = "false",
      results = "true",
      schema = "false",
      offset = 0,
      limit = 1500
    ))

    url <- flatten_url(base, opts, query)

    res <- httr2::request(url) |>
      httr2::req_error(body = \(resp) httr2::resp_body_json(resp)$message) |>
      httr2::req_perform() |>
      parse_string("results") |>
      fastplyr::as_tbl()

    res <- affiliations_names(res)
    return(res)
  }

  # Count Above API Limit: Alert & Return Results =====================
  cli::cli_alert_success(
    "Query returning {offset(N, 1500L)} pages ({N} results)."
  )

  opts <- flatten_opts(list(
    count = "false",
    results = "true",
    schema = "false",
    limit = 1500,
    offset = "<<i>>"
  ))

  url <- flatten_url(base, opts, query)

  urls <- offset(N, 1500L, "seq") |>
    purrr::map_chr(\(x) {
      gsub(x = url, pattern = "<<i>>", replacement = x, fixed = TRUE)
    })

  res <- map_perform_parallel(urls, "results") |>
    collapse::rowbind() |>
    fastplyr::as_tbl()

  affiliations_names(res)
}

#' @autoglobal
#' @noRd
affiliations_names <- function(x) {
  rlang::set_names(
    x,
    c(
      "npi",
      "pac",
      "first",
      "middle",
      "last",
      "suffix",
      "facility_type",
      "parent_ccn",
      "facility_ccn"
    )
  )
}

#' @autoglobal
#' @noRd
facility_enum <- function(facility_type = NULL) {
  if (!is.null(facility_type)) {
    facility_enum <- list(
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
      names(facility_enum),
      multiple = TRUE
    )

    facility_type <- unlist_(facility_enum[facility_type])
  }
  return(facility_type)
}

#' @autoglobal
#' @noRd
get_pro_api <- function() {
  RcppSimdJson::fload(
    json = "https://data.cms.gov/provider-data/api/1/metastore/schemas/dataset/items"
  ) |>
    collapse::sbt(
      title %iin% c("Facility Affiliation Data", "National Downloadable File")
    ) |>
    collapse::slt(
      title,
      identifier,
      url = landingPage,
      last_release = released,
      next_release = nextUpdateDate
    ) |>
    fastplyr::as_tbl()
}
