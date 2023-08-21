#' Provider Facility Affiliations
#'
#' @description
#' `facility_affiliations()` allows you to access information concerning providers' facility affiliations
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
#'     - Hospital
#'     - Long-term Care Hospital (LTCH)
#'     - Nursing Home
#'     - Inpatient Rehabilitation Facility (IRF)
#'     - Home Health Agency (HHA)
#'     - Skilled Nursing Facility (SNF)
#'     - Hospice
#'     - Dialysis Facility
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
#' @examplesIf interactive()
#' facility_affiliations(facility_ccn = "060004")
#' facility_affiliations(parent_ccn = 670055)
#'
#' @autoglobal
#' @export
facility_affiliations <- function(npi           = NULL,
                                  pac_id        = NULL,
                                  first_name    = NULL,
                                  middle_name   = NULL,
                                  last_name     = NULL,
                                  facility_type = NULL,
                                  facility_ccn  = NULL,
                                  parent_ccn    = NULL,
                                  offset        = 0L,
                                  tidy          = TRUE) {

  if (!is.null(npi)) {npi_check(npi)}
  if (!is.null(pac_id)) {pac_check(pac_id)}

  # args tribble ------------------------------------------------------------
  args <- tibble::tribble(
    ~x,                   ~y,
    "NPI",                npi,
    "Ind_PAC_ID",         pac_id,
    "frst_nm",            first_name,
    "mid_nm",             middle_name,
    "lst_nm",             last_name,
    "facility_type",      facility_type,
    "facility_afl_ccn",   facility_ccn,
    "parent_ccn",         parent_ccn)

  # map param_format and collapse -------------------------------------------
  params_args <- purrr::map2(args$x, args$y, sql_format) |>
    unlist() |>
    stringr::str_flatten()

  # build URL ---------------------------------------------------------------
  http   <- "https://data.cms.gov/provider-data/api/1/datastore/sql?query="
  id     <- paste0("[SELECT * FROM ", fac_affil_id(), "]")
  post   <- paste0("[LIMIT 10000 OFFSET ", offset, "]&show_db_columns")
  url    <- paste0(http, id, params_args, post) |>
    param_brackets() |>
    param_space()

  # send request ----------------------------------------------------------
  response <- httr2::request(url) |> httr2::req_perform()

  # no search results returns empty tibble ----------------------------------
  if (as.integer(httr2::resp_header(response, "content-length")) <= 28L) {

    cli_args <- tibble::tribble(
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

    # parse response ---------------------------------------------------------
    results <- tibble::tibble(httr2::resp_body_json(response,
               check_type = FALSE, simplifyVector = TRUE))

  # clean names -------------------------------------------------------------
  if (tidy) {
    results <- janitor::clean_names(results) |>
      dplyr::mutate(dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., ""))) |>
      dplyr::select(
        npi,
        pac_id_ind   = ind_pac_id,
        first_name   = frst_nm,
        middle_name  = mid_nm,
        last_name    = lst_nm,
        suffix       = suff,
        facility_type,
        facility_ccn = facility_afl_ccn,
        parent_ccn) |>
      janitor::remove_empty(which = c("rows", "cols"))
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
