#' Provider-Facility Affiliations
#'
#' @description
#' `affiliations()` allows you to access information concerning providers'
#' facility affiliations
#'
#' ### Links
#'  - [Physician Facility Affiliations](https://data.cms.gov/provider-data/dataset/27ea-46a8)
#'  - [Certification Number (CCN) State Codes](https://www.cms.gov/Medicare/Provider-Enrollment-and-Certification/SurveyCertificationGenInfo/Downloads/Survey-and-Cert-Letter-16-09.pdf)
#'
#' *Update Frequency:* **Monthly**
#'
#' @param npi 10-digit National Provider Identifier
#' @param pac_id_ind 10-digit Provider associate level variable. Links all
#' entity-level information and may be associated with multiple enrollment IDs
#' if the individual or organization enrolled multiple times.
#' @param first,middle,last Individual clinician's first, middle, or last name
#' @param facility_type Facilities can fall into the following type categories:
#'    - `"Hospital"`
#'    - `"Long-term care hospital"` (LTCH)
#'    - `"Nursing home"`
#'    - `"Inpatient rehabilitation facility"` (IRF)
#'    - `"Home health agency"` (HHA)
#'    - `"Skilled nursing facility"` (SNF)
#'    - `"Hospice"`
#'    - `"Dialysis facility"`
#' @param facility_ccn alphanumeric; Medicare CCN (CMS Certification Number) of
#'    facility type or unit within hospital where an individual clinician
#'    provides service. The CCN replaced the terms *Medicare Provider Number*,
#'    *Medicare Identification Number* and *OSCAR Number* and is used to verify
#'    Medicare/Medicaid certification for survey and certification,
#'    assessment-related activities and communications.
#' @param parent_ccn numeric; CCN of the primary hospital where an
#'    individual clinician provides service, should the clinician provide
#'    services in a unit within the hospital.
#' @param offset offset; API pagination
#' @param tidy Tidy output; default is `TRUE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @seealso [clinicians()], [providers()], [hospitals()]
#'
#' @examplesIf interactive()
#' affiliations(parent_ccn = 670055)
#' @autoglobal
#' @export
affiliations <- function(npi = NULL,
                         pac_id_ind = NULL,
                         first = NULL,
                         middle = NULL,
                         last = NULL,
                         facility_type = NULL,
                         facility_ccn = NULL,
                         parent_ccn = NULL,
                         offset = 0L,
                         tidy = TRUE) {

  if (!is.null(npi))           {npi          <- npi_check(npi)}
  if (!is.null(pac_id_ind))    {pac_id_ind   <- pac_check(pac_id_ind)}
  if (!is.null(facility_ccn))  {facility_ccn <- as.character(facility_ccn)}
  if (!is.null(parent_ccn))    {parent_ccn   <- as.character(parent_ccn)}

  if (!is.null(facility_type)) {
    rlang::arg_match(facility_type, c("Hospital",
                                      "Long-term care hospital",
                                      "Nursing home",
                                      "Inpatient rehabilitation facility",
                                      "Home health agency",
                                      "Skilled nursing facility",
                                      "Hospice",
                                      "Dialysis facility"))}

  args <- dplyr::tribble(
    ~param,                                         ~arg,
    "npi",                                          npi,
    "ind_pac_id",                                   pac_id_ind,
    "frst_nm",                                      first,
    "mid_nm",                                       middle,
    "lst_nm",                                       last,
    "facility_type",                                facility_type,
    "facility_affiliations_certification_number",   facility_ccn,
    "facility_type_certification_number",           parent_ccn)

  url <- paste0("https://data.cms.gov/provider-data/api/1/datastore/sql?query=",
                "[SELECT * FROM ", aff_id(), "]",
                encode_param(args, type = "sql"),
                "[LIMIT 10000 OFFSET ", offset, "]")

  error_body <- function(response) {httr2::resp_body_json(response)$message}

  response <- httr2::request(encode_url(url)) |>
    httr2::req_error(body = error_body) |>
    httr2::req_perform()

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  if (isTRUE(vctrs::vec_is_empty(results))) {

    cli_args <- dplyr::tribble(
      ~x,              ~y,
      "npi",           npi,
      "pac_id_ind",    pac_id_ind,
      "first",         first,
      "middle",        middle,
      "last",          last,
      "facility_type", facility_type,
      "facility_ccn",  facility_ccn,
      "parent_ccn",    parent_ccn) |>
      tidyr::unnest(cols = c(y))

    cli_args <- purrr::map2(cli_args$x,
                            cli_args$y,
                            stringr::str_c,
                            sep = ": ",
                            collapse = "")

    cli::cli_alert_danger("No results for {.val {cli_args}}", wrap = TRUE)
    return(invisible(NULL))

  }

  if (tidy) {
    results <- janitor::clean_names(results) |>
      dplyr::tibble() |>
      dplyr::mutate(dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., ""))) |>
      dplyr::select(
        npi,
        pac_id_ind     = ind_pac_id,
        first_name     = frst_nm,
        middle_name    = mid_nm,
        last_name      = lst_nm,
        suffix         = suff,
        facility_type,
        facility_ccn   = facility_affiliations_certification_number,
        parent_ccn     = facility_type_certification_number,
        dplyr::everything())
    }
  return(results)
}

#' @autoglobal
#' @noRd
aff_id <- function() {

  response <- httr2::request("https://data.cms.gov/provider-data/api/1/metastore/schemas/dataset/items/27ea-46a8?show-reference-ids=true") |>
    httr2::req_perform() |>
    httr2::resp_body_json(simplifyVector = TRUE)

  return(response$distribution$identifier)
}
