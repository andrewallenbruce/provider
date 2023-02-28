#' Search the CMS Physician Facility Affiliations API
#'
#' @description Dataset of providers' facility affiliations
#'
#' @details This file lists clinicians' facility affiliations, which have been
#'    expanded to include Long-term Care Hospitals (LTCHs), Skilled Nursing
#'    Facilities (SNFs), Inpatient Rehabilitation Facility (IRFs), Home Health
#'    Agencies, Hospices, and/or Dialysis Facilities, in addition to hospitals.
#'
#' ## Links
#' *  [CMS Physician Facility Affiliations](https://data.cms.gov/provider-data/dataset/27ea-46a8)
#' *  [Certification Number (CCN) State Codes](https://www.cms.gov/Medicare/Provider-Enrollment-and-Certification/SurveyCertificationGenInfo/Downloads/Survey-and-Cert-Letter-16-09.pdf)
#'
#' @source Centers for Medicare & Medicaid Services
#' @note Update Frequency: **Monthly**
#'
#' @param npi Unique clinician ID assigned by NPPES
#' @param pac_id_ind Unique individual clinician ID assigned by PECOS
#' @param last_name Individual clinician last name
#' @param first_name Individual clinician first name
#' @param middle_name Individual clinician middle name
#' @param facility_type Facilities can fall into the following type categories:
#'    Hospital, Long-term Care Hospital, Nursing Home, Inpatient
#'    Rehabilitation Facility, Home Health Agency, Hospice, and Dialysis
#'    Facility
#' @param facility_ccn alphanumeric; Medicare CCN (CMS Certification Number) of
#'    facility type or unit within hospital where an individual clinician
#'    provides service. Effective 2007, the CCN replaced the terms
#'    *Medicare Provider Number*, *Medicare Identification Number* and
#'    *OSCAR Number*. The CCN is used to verify Medicare/Medicaid certification
#'    for survey and certification, assessment-related activities and
#'    communications.
#' @param parent_ccn numeric; Medicare CCN of the primary hospital where an
#'    individual clinician provides service, should the clinician provide
#'    services in a unit within the hospital.
#' @param offset offset; API pagination
#' @param clean_names Convert column names to snakecase; default is `TRUE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examples
#' facility_affiliations(npi = 1003019563)
#' facility_affiliations(facility_ccn = "060004")
#' facility_affiliations(parent_ccn = 670055)
#' \dontrun{
#' facility_affiliations(first_name = "John")
#' facility_affiliations(facility_type = "Home Health Agency")
#' }
#' @autoglobal
#' @export

facility_affiliations <- function(npi           = NULL,
                                  pac_id_ind        = NULL,
                                  last_name     = NULL,
                                  first_name    = NULL,
                                  middle_name   = NULL,
                                  facility_type = NULL,
                                  facility_ccn  = NULL,
                                  parent_ccn    = NULL,
                                  offset        = 0,
                                  clean_names   = TRUE) {
  # args tribble ------------------------------------------------------------
  args <- tibble::tribble(
    ~x,                   ~y,
    "NPI",                npi,
    "Ind_PAC_ID",         pac_id_ind,
    "lst_nm",             last_name,
    "frst_nm",            first_name,
    "mid_nm",             middle_name,
    "facility_type",      facility_type,
    "facility_afl_ccn",   facility_ccn,
    "parent_ccn",         parent_ccn)

  # map param_format and collapse -------------------------------------------
  params_args <- purrr::map2(args$x, args$y, sql_format) |>
    unlist() |> stringr::str_flatten()

  id <- "a9970163-ef6b-5a2e-b3f6-f18b0514e093"

  id_fmt <- paste0("[SELECT * FROM ", id, "]")

  # build URL ---------------------------------------------------------------
  http   <- "https://data.cms.gov/provider-data/api/1/datastore/sql?query="
  post   <- paste0("[LIMIT 10000 OFFSET ", offset, "]&show_db_columns")
  url    <- paste0(http, id_fmt, params_args, post) |>
    param_brackets() |> param_space()

  # send request ----------------------------------------------------------
  resp <- httr2::request(url) |> httr2::req_perform()

  # no search results returns empty tibble ----------------------------------
  if (as.numeric(httr2::resp_header(resp, "content-length")) == 0) {
    return(tibble::tibble())
  } else {

    # parse response ---------------------------------------------------------
    results <- tibble::tibble(httr2::resp_body_json(resp,
               check_type = FALSE, simplifyVector = TRUE)) |>
      dplyr::mutate(dplyr::across(dplyr::contains("date"), ~parsedate::parse_date(.)),
                    dplyr::across(tidyselect::where(is.character), ~dplyr::na_if(., "")),
                    dplyr::across(tidyselect::where(is.character), ~dplyr::na_if(., "N/A")))

  }

  # clean names -------------------------------------------------------------
  if (isTRUE(clean_names)) {results <- dplyr::rename_with(results, str_to_snakecase)}

  return(results)
}
