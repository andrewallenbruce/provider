#' Taxonomy to Medicare Specialty Crosswalk
#'
#' @description
#'
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
#' @param tidy < *boolean* > Tidy output; default is `TRUE`
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
                               tidy                  = TRUE) {

  if (!is.null(keyword_search)) {

    response <- httr2::request(encode_url(paste0(
      build_url("tax"), keyword_search))) |>
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

  if (isTRUE(vctrs::vec_is_empty(results))) {

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

  if (tidy) {
    results <- tidyup(results) |>
      dplyr::mutate(dplyr::across(dplyr::everything(), stringr::str_squish)) |>
      cross_cols()
  }
  return(results)
}

#' @param df data frame
#' @autoglobal
#' @noRd
cross_cols <- function(df) {

  cols <- c('specialty_code'        = 'medicare_specialty_code',
            'specialty_description' = 'medicare_provider_supplier_type',
            'taxonomy_code'         = 'provider_taxonomy_code',
            'taxonomy_description'  = 'provider_taxonomy_description_type_classification_specialization')

  df |> dplyr::select(dplyr::all_of(cols))

}

#' Download Current NUCC Taxonomy CSV
#'
#' @description
#' `download_nucc_csv()` allows you to download a csv file of the current Health
#' Care Provider Taxonomy code set from the NUCC website
#'
#' ## Taxonomy Codes
#' The Health Care Provider Taxonomy code set is a collection of unique
#' alphanumeric codes, ten characters in length. The code set is structured into
#' three distinct "Levels":
#'
#'    * **Level I (Provider Grouping)**: A major grouping of service(s) or
#' occupation(s) of health care providers. For example: Allopathic & Osteopathic
#' Physicians, Dental Providers, Hospitals, etc.
#'    * **Level II: (Classification)**: A more specific service or occupation
#' related to the Provider Grouping. For example, the Classification for
#' Allopathic & Osteopathic Physicians is based upon the General Specialty
#' Certificates as issued by the appropriate national boards. The following
#' boards will however, have their general certificates appear as Level III
#' areas of specialization strictly due to display limitations of the code set
#' for Boards that have multiple general certificates: Medical Genetics,
#' Preventive Medicine, Psychiatry & Neurology, Radiology, Surgery,
#' Otolaryngology, Pathology.
#'    * **Level III: (Area of Specialization)**: A more specialized area of the
#' Classification in which a provider chooses to practice or make services
#' available. For example, the Area of Specialization for provider type
#' Allopathic & Osteopathic Physicians is based upon the Subspecialty
#' Certificates as issued by the appropriate national boards.
#'
#' The Health Care Provider Taxonomy code set Levels are organized to allow for
#' drilling down to the provider's most specific level of specialization. The
#' ten digit codes for each provider category are unique and contain no embedded
#' logic. The codes and categories are to be used exactly as they are assigned
#' in the Taxonomy list. At no time should codes be separated to form new codes,
#' parsed apart, or edited on any one position within the code.
#'
#' @section How Many Categories are There?:
#'    The Health Care Provider Taxonomy code set is a collection of unique
#'    alphanumeric codes, ten characters in length. The Health Care Provider
#'    Taxonomy code set includes specialty categories for individuals, Groups
#'    of individuals, and non-individuals.
#'
#'    The **Individual Category** includes:
#'    1. Allopathic & Osteopathic Physicians
#'    1. Behavioral Health and Social Service Providers
#'    1. Chiropractic Providers
#'    1. Dental Providers
#'    1. Dietary and Nutritional Service Providers
#'    1. Emergency Medical Service Providers
#'    1. Eye and Vision Service Providers
#'    1. Nursing Service Providers
#'    1. Nursing Service Related Providers
#'    1. Other Service Providers
#'    1. Pharmacy Service Providers
#'    1. Physician Assistants and Advanced Practice Nursing Providers
#'    1. Podiatric Medicine and Surgery Service Providers
#'    1. Respiratory, Developmental, Rehabilitative and Restorative Service Providers
#'    1. Speech, Language and Hearing Service Providers
#'    1. Student, Health Care
#'    1. Technologists, Technicians, and Other Technical Service Providers
#'
#'    The **Group (of Individuals) Category** includes:
#'    1. Multi-Specialty
#'    1. Single Specialty
#'
#'    The **Non-Individual Category** includes:
#'    1. Agencies
#'    1. Ambulatory Health Care Facilities
#'    1. Hospital Units
#'    1. Hospitals
#'    1. Laboratories
#'    1. Managed Care Organizations
#'    1. Nursing and Custodial Care Facilities
#'    1. Other Service Providers
#'    1. Residential Treatment Facilities
#'    1. Respite Care Facilities
#'    1. Suppliers
#'    1. Transportation Services
#'
#' @section Description:
#'    - `code`: Taxonomy Code
#'    - `grouping`: Level I, Provider Grouping
#'    - `classification`: Level II, Classification
#'    - `specialization`: Level III, Area of Specialization
#'    - `definition`: Definition of Taxonomy
#'    - `notes`: Notes pertaining to Taxonomy, e.g. sources, date modified, date implemented, etc.
#'    - `display_name`: A more consumer-friendly name for the taxonomy code; a combination of the code name and the Level in which the code is nested.
#'    - `section`: Indicates whether Taxonomy is Individual or Non-Individual, i.e., a group taxonomy
#' @note The "230" designation indicates the version of the code set. NUCC
#'   updates the set every six months. The "23" indicates the year and the "0"
#'   indicates the first update of the year.
#' @note The taxonomy code display name is a more consumer-friendly name for the
#'   code. The display name is a combination of the code name and the Level in
#'   which the code is nested, which more precisely identifies the code.  For
#'   example, Addiction Medicine is a physician subspecialty in Anesthesiology,
#'   Family Medicine, Internal Medicine, Preventive Medicine, and Psychiatry &
#'   Neurology. Seeing “Addiction Medicine” does not identify the specialty of
#'   the physician, but the display name of “Addiction Medicine (Internal
#'   Medicine) Physician” clearly does. In another example, the code
#'   “Radiology” could be confused with several codes, but “Radiology
#'   Chiropractor” specifies the exact provider.
#' @source
#' <https://www.nucc.org/index.php/code-sets-mainmenu-41/provider-taxonomy-mainmenu-40/csv-mainmenu-57>
#'
#' *Update Frequency:* **Biannually**
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examplesIf interactive()
#' download_nucc_csv()
#' @autoglobal
#' @export
download_nucc_csv <- function() {

  url <- "https://www.nucc.org"

  x <- rvest::session(url) |>
       rvest::session_follow_link("Code Sets") |>
       rvest::session_follow_link("Taxonomy") |>
       rvest::session_follow_link("CSV") |>
       rvest::html_elements("a") |>
       rvest::html_attr("href") |>
       stringr::str_subset("taxonomy") |>
       stringr::str_subset("csv")

  x <- rvest::session(paste0(url, x)) |>
       rvest::session_follow_link("Version")

  x <- x$response$url

  x <- data.table::fread(x) |>
    dplyr::tibble() |>
    janitor::clean_names() |>
    dplyr::mutate(
      dplyr::across(
        dplyr::everything(), ~dplyr::na_if(., "")),
      dplyr::across(
        dplyr::everything(), ~stringr::str_squish(.))) |>
    dplyr::select(category = section,
                  grouping,
                  classification,
                  specialization,
                  # display_name, definition,
                  taxonomy = code)
  return(x)
}
