#' Search the Medicare Fee-For-Service Public Provider Enrollment API
#'
#' @description Information on a point in time snapshot of enrollment
#'    level data for providers actively enrolled in Medicare.
#'
#' @details The Medicare Fee-For-Service Public Provider Enrollment dataset
#'    includes information on providers who are actively approved to bill
#'    Medicare or have completed the 855O at the time the data was pulled
#'    from the Provider Enrollment and Chain Ownership System (PECOS). The
#'    release of this provider enrollment data is not related to other
#'    provider information releases such as Physician Compare or Data
#'    Transparency.
#'
#' ## Links
#' * [Medicare Fee-For-Service Public Provider Enrollment API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/medicare-fee-for-service-public-provider-enrollment)
#'
#' @source Centers for Medicare & Medicaid Services
#' @note Update Frequency: **Quarterly**
#'
#' @param npi An NPI is a 10-digit unique numeric identifier that all providers
#'    must obtain before enrolling in Medicare. It is assigned to health care
#'    providers upon application through the National Plan and Provider
#'    Enumeration System (NPPES).
#' @param pecos_id Provider associate level variable (PAC ID) from PECOS
#'    database used to link across tables. A PAC ID is a 10-digit unique
#'    numeric identifier that is assigned to each individual or organization
#'    in PECOS. All entity-level information (e.g., tax identification numbers
#'    and organizational names) is linked through the PAC ID. A PAC ID may be
#'    associated with multiple Enrollment IDs if the individual or
#'    organization enrolled multiple times under different circumstances.
#' @param enroll_id Provider enrollment ID from PECOS database used to link
#'    across tables. An Enrollment ID is a 15-digit unique alphanumeric
#'    identifier that is assigned to each new provider enrollment application.
#'    All enrollment-level information (e.g., enrollment type, enrollment
#'    state, provider specialty and reassignment of benefits) is linked
#'    through the Enrollment ID.
#' @param prov_type_code Provider enrollment application and enrollment
#'    specialty type. This field shows the provider’s primary specialty code.
#'    For practitioners and DME suppliers, please see the Secondary Specialty
#'    file for a list of secondary specialties (when applicable). Only about
#'    20% of practitioners and DME suppliers have at least one secondary
#'    specialty.
#' @param prov_type_desc Provider enrollment application and enrollment
#'    specialty type description
#' @param state Provider enrollment state, abbreviated location. Providers
#'    enroll at the state level, so one PAC ID may be associated with multiple
#'    ENRLMT_IDs and multiple STATE_CD values.
#' @param first_name Individual provider first name
#' @param middle_name Individual provider middle name
#' @param last_name Individual provider last name
#' @param org_name Organizational provider name
#' @param gender Individual provider gender; F(female), M(male), 9(unknown)
#' @param clean_names Clean column names with {janitor}'s
#'    `clean_names()` function; default is `TRUE`.
#' @param lowercase Convert column names to lowercase; default is `TRUE`.
#'
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examples
#' provider_enrollment(npi = 1003026055)
#' provider_enrollment(last = "phadke", first = "radhika")
#' provider_enrollment(prov_type_desc = "PRACTITIONER - ENDOCRINOLOGY", state = "AK", gender = "F")
#' \dontrun{
#' # Won't filter, returns entire dataset
#' provider_enrollment(taxonomy_desc = "Trauma Surgery")
#' }
#' @autoglobal
#' @export

provider_enrollment <- function(npi                = NULL,
                                pecos_id           = NULL,
                                enroll_id          = NULL,
                                prov_type_code     = NULL,
                                prov_type_desc     = NULL,
                                state              = NULL,
                                first_name         = NULL,
                                middle_name        = NULL,
                                last_name          = NULL,
                                org_name           = NULL,
                                gender             = NULL,
                                clean_names        = TRUE,
                                lowercase          = TRUE) {
  # args tribble ------------------------------------------------------------
  args <- tibble::tribble(
                        ~x,  ~y,
                          "NPI", npi,
           "PECOS_ASCT_CNTL_ID", pecos_id,
                    "ENRLMT_ID", enroll_id,
             "PROVIDER_TYPE_CD", prov_type_code,
           "PROVIDER_TYPE_DESC", prov_type_desc,
                     "STATE_CD", state,
                   "FIRST_NAME", first_name,
                     "MDL_NAME", middle_name,
                    "LAST_NAME", last_name,
                     "ORG_NAME", org_name,
                      "GNDR_SW", gender)


  # map param_format and collapse -------------------------------------------
  params_args <- purrr::map2(args$x, args$y, param_format) |> unlist() |>
    stringr::str_c(collapse = "") |> param_space()

  # build URL ---------------------------------------------------------------
  http   <- "https://data.cms.gov/data-api/v1/dataset/"
  id     <- "2457ea29-fc82-48b0-86ec-3b0755de7515"
  post   <- "/data.json?"
  url    <- paste0(http, id, post, params_args)

  # send request ----------------------------------------------------------
  resp <- httr2::request(url) |> httr2::req_perform()

  # parse response ----------------------------------------------------------
  results <- tibble::tibble(httr2::resp_body_json(resp, check_type = FALSE,
                                                  simplifyVector = TRUE))

  # clean names -------------------------------------------------------------
  if (isTRUE(clean_names)) {results <- janitor::clean_names(results)}
  # lowercase ---------------------------------------------------------------
  if (isTRUE(lowercase)) {results <- dplyr::rename_with(results, tolower)}

  return(results)
}
