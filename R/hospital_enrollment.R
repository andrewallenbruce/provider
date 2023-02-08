#' Search the CMS Hospital Enrollments API
#'
#' @description Information on hospitals currently enrolled in Medicare.
#'
#' @details The Hospital Enrollments dataset provides enrollment information of
#'   all Hospitals currently enrolled in Medicare. This data includes
#'   information on the Hospital's sub-group type, legal business name, doing
#'   business as name, organization type and address.
#'
#'   ## Links
#'   * [Hospital Enrollments](https://data.cms.gov/provider-characteristics/hospitals-and-other-facilities/hospital-enrollments)
#'
#' @source Centers for Medicare & Medicaid Services
#' @note Update Frequency: **Monthly**
#'
#' @param npi Hospital’s National Provider Identifier (NPI)
#' @param ccn Hospital’s CMS Certification Number (CCN), formerly called an
#'   OSCAR Number
#' @param enroll_id Hospital’s enrollment ID
#' @param enroll_state Hospital’s enrollment state
#' @param prov_type_cd Enrollment application and specialty type code
#' @param pac_id Hospital’s PECOS Associate Control (PAC) ID
#' @param org_name Hospital’s legal business name
#' @param dba_name Hospital’s doing-business-as name
#' @param city City of the hospital’s practice location address
#' @param state State of the hospital’s practice location address.
#' @param zip Zip code of the hospital’s practice location address
#' @param clean_names Clean column names with {janitor}'s `clean_names()`
#'   function; default is `TRUE`.
#' @param lowercase Convert column names to lowercase; default is `TRUE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examples
#' hospital_enrollment(npi = 1689653487)
#' hospital_enrollment(ccn = "440058")
#' hospital_enrollment(pac_id = 6103733050)
#' \dontrun{
#' hospital_enrollment(city = "Atlanta")
#' hospital_enrollment(zip = 117771928)
#' }
#' @autoglobal
#' @export

hospital_enrollment <- function(npi          = NULL,
                                ccn          = NULL,
                                enroll_id    = NULL,
                                enroll_state = NULL,
                                prov_type_cd = NULL,
                                pac_id       = NULL,
                                org_name     = NULL,
                                dba_name     = NULL,
                                city         = NULL,
                                state        = NULL,
                                zip          = NULL,
                                clean_names  = TRUE,
                                lowercase    = TRUE) {
  # args tribble ------------------------------------------------------------
  args <- tibble::tribble(
    ~x,                       ~y,
    "ENROLLMENT ID",          enroll_id,
    "ENROLLMENT STATE",       enroll_state,
    "PROVIDER TYPE CODE",     prov_type_cd,
    "NPI",                    npi,
    "CCN",                    ccn,
    "ASSOCIATE ID",           pac_id,
    "ORGANIZATION NAME",      org_name,
    "DOING BUSINESS AS NAME", dba_name,
    "CITY",                   city,
    "STATE",                  state,
    "ZIP CODE",               zip)

  # map param_format and collapse -------------------------------------------
  params_args <- purrr::map2(args$x, args$y, param_format) |> unlist() |>
    stringr::str_c(collapse = "") |> param_space()

  # build URL ---------------------------------------------------------------
  http   <- "https://data.cms.gov/data-api/v1/dataset/"
  id     <- "f6f6505c-e8b0-4d57-b258-e2b94133aaf2"
  post   <- "/data.json?"
  url    <- paste0(http, id, post, params_args)

  # send request ----------------------------------------------------------
  resp <- httr2::request(url) |> httr2::req_perform()

  # no search results returns empty tibble ----------------------------------
  if (as.numeric(httr2::resp_header(resp, "content-length")) == 0) {
    return(tibble::tibble())
  } else {

    # parse response ---------------------------------------------------------
    results <- tibble::tibble(httr2::resp_body_json(resp,
              check_type = FALSE, simplifyVector = TRUE)) |>
      dplyr::mutate(dplyr::across(dplyr::contains(c("Flag", "Subgroup", "Proprietary")), yn_logical)) |>
      dplyr::mutate(dplyr::across(tidyselect::where(is.character), ~dplyr::na_if(., "")),
                    dplyr::across(tidyselect::where(is.character), ~dplyr::na_if(., "N/A")))

  }

  # clean names -------------------------------------------------------------
  if (isTRUE(clean_names)) {results <- janitor::clean_names(results)}
  # lowercase ---------------------------------------------------------------
  if (isTRUE(lowercase)) {results <- dplyr::rename_with(results, tolower)}
  return(results)


}
