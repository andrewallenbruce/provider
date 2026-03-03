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
#' @param ccn_facility `<chr>` Medicare CCN of facility type or unit within hospital where an individual clinician provides service
#' @param ccn_parent `<chr>` Medicare CCN of the primary hospital where individual clinician provides service, should the clinician provide services in a unit within the hospital
#' @param first `<chr>` Individual clinician first name
#' @param middle `<chr>` Individual clinician middle name
#' @param last `<chr>` Individual clinician last name
#' @param suffix `<chr>` Individual clinician suffix
#'
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
#' affiliations(ccn_facility = "33Z302")
#'
#' affiliations(ccn_parent = 331302)
#'
#' affiliations(pac = 7810891009)
#'
#' affiliations(first = "KIM")
#'
#' @autoglobal
#'
#' @export
affiliations <- function(
  npi = NULL,
  pac = NULL,
  ccn_facility = NULL,
  ccn_parent = NULL,
  first = NULL,
  middle = NULL,
  last = NULL,
  suffix = NULL,
  facility_type = NULL
) {
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

  args <- compact_list(
    npi = npi,
    ind_pac_id = pac,
    provider_last_name = last,
    provider_first_name = first,
    provider_middle_name = middle,
    suff = suffix,
    facility_type = facility_type,
    facility_affiliations_certification_number = ccn_facility,
    facility_type_certification_number = ccn_parent
  )

  # if no query, warn and return first 100 results

  if (!length(args)) {
    cli::cli_alert_warning(
      "No arguments provided. Returning first 100 results."
    )

    opts <- flatten_opts(list(
      count = "false",
      results = "true",
      schema = "false",
      limit = 100L
    ))

    base <- "https://data.cms.gov/provider-data/api/1/datastore/query/27ea-46a8/0?"
    url <- flatten_url(base, opts)

    res <- httr2::request(url) |>
      httr2::req_error(body = \(resp) httr2::resp_body_json(resp)$message) |>
      httr2::req_perform() |>
      httr2::resp_body_json(simplifyVector = TRUE) |>
      _$results |>
      fastplyr::as_tbl()

    res <- rlang::set_names(
      res,
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
    return(res)
  }

  # Format query and request number of results

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

  cnt <- httr2::request(url) |>
    httr2::req_error(body = \(resp) httr2::resp_body_json(resp)$message) |>
    httr2::req_perform() |>
    httr2::resp_body_json(simplifyVector = TRUE) |>
    _$count

  # If count is 0, alert and exit

  if (cnt == 0L) {
    cli::cli_alert_danger("Query returned 0 results.")
    return(invisible(NULL))
  }

  # If count is within api limit, return results

  if (cnt <= 1500L) {
    cli::cli_alert_success("Query returning {cnt} results.")

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
      httr2::resp_body_json(simplifyVector = TRUE) |>
      _$results |>
      fastplyr::as_tbl()

    res <- rlang::set_names(
      res,
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
    return(res)
  }

  # At this point, count is above api limit.

  cli::cli_alert_success(
    "Query returning {offset(cnt, 1500L)} pages ({cnt} results)."
  )

  opts <- flatten_opts(list(
    count = "false",
    results = "true",
    schema = "false"
  ))

  url <- flatten_url(base, opts, query)

  # url <- flatten_url(base, opts, query) |> urlparse::url_encoder(":/=+?&")
  # url <- flatten_url(base, query, opts)

  res <- httr2::request(url) |>
    httr2::req_error(body = \(resp) httr2::resp_body_json(resp)$message)

  res <- res |>
    httr2::req_perform_iterative(
      next_req = httr2::iterate_with_offset(
        param_name = "offset",
        start = 0L,
        offset = 1500L,
        resp_pages = function(resp) {
          offset(cnt, 1500L)
        }
      )
    )

  res <- res |>
    purrr::map(\(x) {
      httr2::resp_body_json(x, simplifyVector = TRUE) |>
        _$results
    }) |>
    collapse::rowbind() |>
    fastplyr::as_tbl()

  rlang::set_names(
    res,
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
