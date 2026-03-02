# api_url <- list(
#   care = "https://data.cms.gov/data.json",
#   prov = "https://data.cms.gov/provider-data/api/1/metastore/schemas/dataset/items",
#   open = "https://openpaymentsdata.cms.gov/api/1/metastore/schemas/dataset/items"
# )

#' Provider Facility Affiliations
#'
#' @description [affiliations()] allows the user access to data concerning
#'   providers' facility affiliations
#'
#' @section Links:
#'    * [Physician Facility Affiliations](https://data.cms.gov/provider-data/dataset/27ea-46a8)
#'    * [Certification Number (CCN) State Codes](https://www.cms.gov/Medicare/Provider-Enrollment-and-Certification/SurveyCertificationGenInfo/Downloads/Survey-and-Cert-Letter-16-09.pdf)
#'
#' @param id `<list>` List of parameters that uniquely identify a provider, any
#'    of the following: `npi`, `pac`, `ccn`.
#'
#' @param name `<list>` Individual provider's name(s), any of the following:
#'    `first`, `middle`, `last`, `suffix`
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
#' @template returns
#' @examplesIf interactive()
#' affiliations(id = list(ccn = c(670055, 331302, "33Z302")))
#' affiliations(id = list(pac = 7810891009))
#' @autoglobal
#' @export
affiliations <- function(
  id = list(npi = NULL, pac = NULL, ccn = NULL),
  name = list(first = NULL, middle = NULL, last = NULL, suffix = NULL),
  facility_type = NULL
) {
  # TODO simplify step
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

  args <- purrr::compact(list(
    npi = id$npi,
    ind_pac_id = id$pac,
    provider_last_name = name$last,
    provider_first_name = name$first,
    provider_middle_name = name$middle,
    suff = name$suffix,
    facility_type = facility_type,
    facility_affiliations_certification_number = id$ccn[has_letter(id$ccn)],
    facility_type_certification_number = id$ccn[is_numeric(id$ccn)]
  ))

  query <- flatten_query(args)

  base <- "https://data.cms.gov/provider-data/api/1/datastore/query/27ea-46a8/0?"

  opts <- list(
    count = "true",
    results = "false",
    schema = "false"
  )

  opts <- paste0(names(opts), "=", unlist_(opts), collapse = "&")

  url <- paste(paste0(base, opts), query, sep = "&")

  # TODO create base provider API request
  # to use for this and clinicians function
  req <- httr2::request(url) |>
    httr2::req_error(body = \(resp) httr2::resp_body_json(resp)$message)

  cnt <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json(simplifyVector = TRUE) |>
    _$count

  opts <- list(
    count = "false",
    results = "true",
    schema = "false",
    limit = 1500L
  )

  opts <- paste0(names(opts), "=", unlist_(opts), collapse = "&")

  url <- paste(paste0(base, opts), query, sep = "&")

  req <- httr2::request(url) |>
    httr2::req_error(body = \(resp) httr2::resp_body_json(resp)$message)

  res <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json(simplifyVector = TRUE) |>
    _$results |>
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
