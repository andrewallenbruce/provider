#' Taxonomy Code // Medicare Specialty
#'
#' @description
#' Allows you to search the types of providers and suppliers eligible for
#' Medicare programs by taxonomy code or Medicare specialty type code.
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
#' Links:
#' - [Provider and Supplier Taxonomy Crosswalk](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/medicare-provider-and-supplier-taxonomy-crosswalk)
#' - [Taxonomy Crosswalk Methodology](https://data.cms.gov/resources/medicare-provider-and-supplier-taxonomy-crosswalk-methodology)
#' - [Find Your Taxonomy Code](https://www.cms.gov/medicare/enrollment-renewal/providers-suppliers/health-care-taxonomy)
#'
#' *Update Frequency:* **Weekly**
#'
#' @param specialty_code < *character* > Medicare specialty code
#' @param specialty_description < *character* > Medicare provider/supplier type
#' @param taxonomy_code < *character* > 10-digit taxonomy code
#' @param taxonomy_description < *character* > Provider's taxonomy description
#' @param keyword_search < *character* > Search term to use for quick full-text search.
#' @param tidy < *boolean* > // __default:__ `TRUE` Tidy output
#' @param ... Empty
#'
#' @return A [tibble][tibble::tibble-package] with the columns:
#'
#' |**Field**              |**Description**                                    |
#' |:----------------------|:--------------------------------------------------|
#' |`specialty_code`       |Code that corresponds to the Medicare specialty    |
#' |`specialty_description`|Description of the Medicare provider/Supplier Type |
#' |`taxonomy_code`        |Provider's taxonomy code                           |
#' |`taxonomy_description` |Description of the taxonomy code                   |
#'
#' @examplesIf interactive()
#' taxonomy_crosswalk(keyword_search = "B4")
#' taxonomy_crosswalk(keyword_search = "Histocompatibility")
#' taxonomy_crosswalk(specialty_description = "Rehabilitation Agency")
#' taxonomy_crosswalk(taxonomy_code = "2086S0102X")
#' @autoglobal
#' @export
taxonomy_crosswalk <- function(taxonomy_code         = NULL,
                               taxonomy_description  = NULL,
                               specialty_code        = NULL,
                               specialty_description = NULL,
                               keyword_search        = NULL,
                               tidy                  = TRUE,
                               ...) {

  if (!is.null(keyword_search)) {

    response <- httr2::request(encode_url(paste0(build_url("tax"), keyword_search))) |>
      httr2::req_perform()

    } else {

      args <- dplyr::tribble(
      ~param,                                                                ~arg,
      "MEDICARE SPECIALTY CODE",                                             specialty_code,
      "MEDICARE PROVIDER%2FSUPPLIER TYPE",                                   specialty_description,
      "PROVIDER TAXONOMY CODE",                                              taxonomy_code,
      "PROVIDER TAXONOMY DESCRIPTION%3A TYPE CLASSIFICATION SPECIALIZATION", taxonomy_description)

      response <- httr2::request(build_url("tax", args)) |> httr2::req_perform()
  }

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  if (vctrs::vec_is_empty(results)) {

    cli_args <- dplyr::tribble(
      ~x,                     ~y,
      "specialty_code",        specialty_code,
      "specialty_description", specialty_description,
      "taxonomy_code",         taxonomy_code,
      "taxonomy_description",  taxonomy_description,
      "keyword_search",        keyword_search) |>
      tidyr::unnest(cols = c(y))

    format_cli(cli_args)
    return(invisible(NULL))
  }
  if (tidy) results <- cols_cross(tidyup(results))
  return(results)
}

#' @param df data frame
#' @autoglobal
#' @noRd
cols_cross <- function(df) {

  cols <- c('specialty_code'        = 'medicare_specialty_code',
            'specialty_description' = 'medicare_provider_supplier_type',
            'taxonomy_code'         = 'provider_taxonomy_code',
            'taxonomy_description'  = 'provider_taxonomy_description_type_classification_specialization')

  df |> dplyr::select(dplyr::any_of(cols))
}
