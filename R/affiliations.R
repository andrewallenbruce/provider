#' Provider Facility Affiliations
#'
#' @description
#' `affiliations()` allows you to access information concerning providers' facility affiliations
#'
#' ### Links
#'  - [Physician Facility Affiliations](https://data.cms.gov/provider-data/dataset/27ea-46a8)
#'  - [Certification Number (CCN) State Codes](https://www.cms.gov/Medicare/Provider-Enrollment-and-Certification/SurveyCertificationGenInfo/Downloads/Survey-and-Cert-Letter-16-09.pdf)
#'
#' *Update Frequency:* **Monthly**
#'
#' @param npi Unique clinician ID assigned by NPPES
#' @param pac_id Unique individual clinician ID assigned by PECOS
#' @param last_name Individual clinician last name
#' @param first_name Individual clinician first name
#' @param middle_name Individual clinician middle name
#' @param facility_type Facilities can fall into the following type categories:
#'    - Hospital
#'    - Long-term Care Hospital (LTCH)
#'    - Nursing Home
#'    - Inpatient Rehabilitation Facility (IRF)
#'    - Home Health Agency (HHA)
#'    - Skilled Nursing Facility (SNF)
#'    - Hospice
#'    - Dialysis Facility
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
affiliations <- function(npi           = NULL,
                         pac_id        = NULL,
                         first_name    = NULL,
                         middle_name   = NULL,
                         last_name     = NULL,
                         facility_type = NULL,
                         facility_ccn  = NULL,
                         parent_ccn    = NULL,
                         offset        = 0L,
                         tidy          = TRUE) {

  if (!is.null(npi))    {npi_check(npi)}
  if (!is.null(pac_id)) {pac_check(pac_id)}

  args <- dplyr::tribble(
    ~param,                                         ~arg,
    "npi",                                          npi,
    "ind_pac_id",                                   pac_id,
    "frst_nm",                                      first_name,
    "mid_nm",                                       middle_name,
    "lst_nm",                                       last_name,
    "facility_type",                                facility_type,
    "facility_affiliations_certification_number",   facility_ccn,
    "facility_type_certification_number",           parent_ccn)

  url <- paste0("https://data.cms.gov/provider-data/api/1/datastore/sql?query=",
                "[SELECT * FROM ", fac_affil_id(), "]",
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
      "npi",           as.character(npi),
      "pac_id",        as.character(pac_id),
      "first_name",    first_name,
      "middle_name",   middle_name,
      "last_name",     last_name,
      "facility_type", facility_type,
      "facility_ccn",  as.character(facility_ccn),
      "parent_ccn",    as.character(parent_ccn)) |>
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
        parent_ccn     = facility_type_certification_number)
    }
  return(results)
}

#' @autoglobal
#' @noRd
fac_affil_id <- function() {

  response <- httr2::request("https://data.cms.gov/provider-data/api/1/metastore/schemas/dataset/items/27ea-46a8?show-reference-ids=true") |>
    httr2::req_perform() |>
    httr2::resp_body_json(check_type = FALSE, simplifyVector = TRUE)

  response$distribution |> dplyr::pull(identifier)
}
