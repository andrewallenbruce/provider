#' Search the Medicare Provider and Supplier Taxonomy Crosswalk API
#'
#' @description A list of the type of providers and suppliers with the
#'    proper taxonomy code eligible for medicare programs.
#'
#' @details The Medicare Provider and Supplier Taxonomy Crosswalk dataset
#'    lists the providers and suppliers eligible to enroll in Medicare
#'    programs with the proper healthcare provider taxonomy code. This data
#'    includes the Medicare speciality codes, if available, provider/supplier
#'    type description, taxonomy code, and the taxonomy description. This
#'    dataset is derived from information gathered from National Plan and
#'    Provider Enumerator System (NPPES) and Provider Enrollment, Chain and
#'    Ownership System (PECOS).
#'
#' ## Links
#' * [Medicare Provider and Supplier Taxonomy Crosswalk API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/medicare-provider-and-supplier-taxonomy-crosswalk)
#' * [Medicare Find Your Taxonomy Code](https://www.cms.gov/Medicare/Provider-Enrollment-and-Certification/Find-Your-Taxonomy-Code)
#'
#' @source Centers for Medicare & Medicaid Services
#' @note Update Frequency: **Weekly**
#'
#' @param specialty_code Code that corresponds to the listed Medicare specialty
#' @param specialty_desc Description of the Medicare Provider/Supplier Type
#' @param taxonomy_code The taxonomy codes the providers use
#' @param taxonomy_desc The description of the taxonomy that the providers use
#' @param clean_names Convert column names to snakecase; default is `TRUE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examples
#' taxonomy_crosswalk(specialty_code = "B4[14]")
#'
#' taxonomy_crosswalk(specialty_desc = "Rehabilitation Agency")
#'
#' taxonomy_crosswalk(taxonomy_code = "2086S0102X")
#'
#' taxonomy_crosswalk(taxonomy_desc = "Agencies/Hospice Care Community Based")
#' @autoglobal
#' @export

taxonomy_crosswalk <- function(specialty_code = NULL,
                               specialty_desc = NULL,
                               taxonomy_code  = NULL,
                               taxonomy_desc  = NULL,
                               clean_names    = TRUE) {
  # args tribble ------------------------------------------------------------
  args <- tibble::tribble(
  ~x,  ~y,
  "MEDICARE SPECIALTY CODE", specialty_code,
  "MEDICARE PROVIDER/SUPPLIER TYPE DESCRIPTION", specialty_desc,
  "PROVIDER TAXONOMY CODE", taxonomy_code,
  "PROVIDER TAXONOMY DESCRIPTION:  TYPE CLASSIFICATION SPECIALIZATION",
  taxonomy_desc)

  # map param_format and collapse -------------------------------------------
  params_args <- purrr::map2(args$x, args$y, param_format) |> unlist() |>
    stringr::str_c(collapse = "") |> param_space()

  # build URL ---------------------------------------------------------------
  http   <- "https://data.cms.gov/data-api/v1/dataset/"
  id     <- "113eb0bc-0c9a-4d91-9f93-3f6b28c0bf6b"
  post   <- "/data.json?"
  url    <- paste0(http, id, post, params_args)

  # send request ----------------------------------------------------------
  resp <- httr2::request(url) |> httr2::req_perform()

  # parse response ----------------------------------------------------------
  results <- tibble::tibble(httr2::resp_body_json(resp, check_type = FALSE,
                                                  simplifyVector = TRUE))

  # clean names -------------------------------------------------------------
  if (isTRUE(clean_names)) {results <- dplyr::rename_with(results, str_to_snakecase)}

  return(results)
}
