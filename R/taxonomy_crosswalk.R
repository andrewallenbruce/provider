#' Taxonomy to Medicare Specialty Crosswalk
#'
#' @description
#' `taxonomy_crosswalk()` allows you to search the types of providers and
#' suppliers eligible for Medicare programs by taxonomy code or Medicare
#' specialty type code.
#'
#' ## Taxonomy Codes
#' The **Healthcare Provider Taxonomy Code Set** is a hierarchical HIPAA
#' standard code set designed to categorize the type, classification, and
#' specialization of health care providers. It consists of two sections:
#'
#'    1. Individuals and Groups of Individuals
#'    1. Non-Individuals
#'
#' When applying for an NPI, a provider must report the taxonomy that most
#' closely describes their type/classification/specialization. In some
#' situations, a provider may need to report more than one taxonomy but must
#' indicate one of them as the primary. The codes selected may not be the same
#' as categorizations used by Medicare for enrollment.
#'
#' @section Links:
#' - [Provider and Supplier Taxonomy Crosswalk](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/medicare-provider-and-supplier-taxonomy-crosswalk)
#' - [Taxonomy Crosswalk Methodology](https://data.cms.gov/resources/medicare-provider-and-supplier-taxonomy-crosswalk-methodology)
#' - [Find Your Taxonomy Code](https://www.cms.gov/Medicare/Provider-Enrollment-and-Certification/Find-Your-Taxonomy-Code)
#'
#' @section Update Frequency: **Weekly**
#' @param taxonomy_code Taxonomy code
#' @param taxonomy_description Taxonomy code description
#' @param medicare_specialty_code Medicare specialty code
#' @param medicare_specialty_type Medicare specialty code description
#' @param tidy Tidy output; default is `TRUE`
#' @return A [tibble][tibble::tibble-package] containing the search results.
#' @examplesIf interactive()
#' taxonomy_crosswalk(medicare_specialty_code = "B4[14]")
#' taxonomy_crosswalk(medicare_specialty_type = "Rehabilitation Agency")
#' taxonomy_crosswalk(taxonomy_code = "2086S0102X")
#' @autoglobal
#' @export
taxonomy_crosswalk <- function(taxonomy_code           = NULL,
                               taxonomy_description    = NULL,
                               medicare_specialty_code = NULL,
                               medicare_specialty_type = NULL,
                               tidy                    = TRUE) {

  # update distribution id
  id <- cms_update("Medicare Provider and Supplier Taxonomy Crosswalk", "id") |>
    dplyr::slice_head() |>
    dplyr::pull(distro)

  # build URL
  url <- glue::glue("https://data.cms.gov/data-api/v1/dataset/{id}/data?")

  # send request
  response <- httr2::request(url) |> httr2::req_perform()

  # parse response
  results <- tibble::tibble(httr2::resp_body_json(response,
            check_type = FALSE, simplifyVector = TRUE))

  # tidy output
  if (tidy) {
    results <- janitor::clean_names(results) |>
      dplyr::mutate(
        dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., "")),
        dplyr::across(dplyr::where(is.character), ~stringr::str_squish(.))) |>
      dplyr::select(
        medicare_specialty_code,
        medicare_specialty_type = medicare_provider_supplier_type,
        taxonomy_code = provider_taxonomy_code,
        taxonomy_description = provider_taxonomy_description_type_classification_specialization)

  if (!is.null(taxonomy_code)) {
    results <- dplyr::filter(results,
                             taxonomy_code == {{ taxonomy_code }})}

  if (!is.null(taxonomy_description)) {
    results <- dplyr::filter(results,
                             taxonomy_description == {{ taxonomy_description }})}

  if (!is.null(medicare_specialty_code)) {
    results <- dplyr::filter(results,
                             medicare_specialty_code == {{ medicare_specialty_code }})}

  if (!is.null(medicare_specialty_type)) {
    results <- dplyr::filter(results,
                             medicare_specialty_type == {{ medicare_specialty_type }})}
  }

  return(results)

}
