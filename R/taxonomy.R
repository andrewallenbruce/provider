#' Download Current NUCC Taxonomy CSV
#'
#' @description
#'
#' `download_nucc_csv()` allows you to download a csv file of the current Health
#' Care Provider Taxonomy code set from the NUCC website
#'
#' @section Taxonomy Codes:
#'
#' The Health Care Provider Taxonomy code set is a collection of unique
#' alphanumeric codes, ten characters in length. The code set is structured into
#' three distinct "Levels":
#'
#' @section Levels:
#'
#' + __Level I: Provider Grouping__
#' A major grouping of service(s) or occupation(s) of health care providers.
#'
#' _Examples: Allopathic & Osteopathic Physicians, Dental Providers, Hospitals_
#'
#' + __Level II: Classification__
#' A more specific service or occupation related to the Provider Grouping.
#'
#' For example, the Classification for Allopathic & Osteopathic Physicians is
#' based upon the General Specialty Certificates as issued by the appropriate
#' national boards.
#'
#' The following boards will however, have their general certificates appear as
#' Level III Areas of specialization strictly due to display limitations of the
#' code set for Boards that have multiple general certificates:
#'
#' _Medical Genetics, Preventive Medicine, Psychiatry & Neurology, Radiology,_
#' _Surgery, Otolaryngology, Pathology_
#'
#' + __Level III: Area of Specialization__
#' A more specialized area of the Classification in which a provider chooses to
#' practice or make services available.
#'
#' For example, the Area of Specialization for provider type Allopathic &
#' Osteopathic Physicians is based upon the Subspecialty Certificates as issued
#' by the appropriate national boards.
#'
#' The code set Levels are organized to allow for drilling down to the provider's
#' most specific level of specialization.
#'
#' The ten digit codes for each provider category are unique and contain no
#' embedded logic.
#'
#' @section How Many Categories are There?:
#'
#' The Taxonomy code set includes specialty categories for Individuals, Groups
#' of Individuals, and Non-Individuals.
#'
#' The **Individual Category** includes:
#'
#' 1. Allopathic & Osteopathic Physicians
#' 1. Behavioral Health and Social Service Providers
#' 1. Chiropractic Providers
#' 1. Dental Providers
#' 1. Dietary and Nutritional Service Providers
#' 1. Emergency Medical Service Providers
#' 1. Eye and Vision Service Providers
#' 1. Nursing Service Providers
#' 1. Nursing Service Related Providers
#' 1. Other Service Providers
#' 1. Pharmacy Service Providers
#' 1. Physician Assistants and Advanced Practice Nursing Providers
#' 1. Podiatric Medicine and Surgery Service Providers
#' 1. Respiratory, Developmental, Rehabilitative and Restorative Service Providers
#' 1. Speech, Language and Hearing Service Providers
#' 1. Student, Health Care
#' 1. Technologists, Technicians, and Other Technical Service Providers
#'
#' The **Group (of Individuals) Category** includes:
#'
#' 1. Multi-Specialty
#' 1. Single Specialty
#'
#' The **Non-Individual Category** includes:
#'
#' 1. Agencies
#' 1. Ambulatory Health Care Facilities
#' 1. Hospital Units
#' 1. Hospitals
#' 1. Laboratories
#' 1. Managed Care Organizations
#' 1. Nursing and Custodial Care Facilities
#' 1. Other Service Providers
#' 1. Residential Treatment Facilities
#' 1. Respite Care Facilities
#' 1. Suppliers
#' 1. Transportation Services
#'
#' @section Description:
#' + `code`: Taxonomy Code
#' + `grouping`: Level I, Provider Grouping
#' + `classification`: Level II, Classification
#' + `specialization`: Level III, Area of Specialization
#' + `definition`: Definition of Taxonomy
#' + `notes`: Notes pertaining to Taxonomy, e.g. sources, date modified, date implemented, etc.
#' + `display_name`: A more consumer-friendly name for the taxonomy code; a combination of the code name and the Level in which the code is nested.
#' + `section`: Indicates whether Taxonomy is Individual or Non-Individual, i.e., a group taxonomy
#' @note The "230" designation indicates the version of the code set. NUCC
#' updates the set every six months. The "23" indicates the year and the "0"
#' indicates the first update of the year.
#' @note The taxonomy code display name is a more consumer-friendly name for the
#' code. The display name is a combination of the code name and the Level in
#' which the code is nested, which more precisely identifies the code.  For
#' example, Addiction Medicine is a physician subspecialty in Anesthesiology,
#' Family Medicine, Internal Medicine, Preventive Medicine, and Psychiatry &
#' Neurology. Seeing “Addiction Medicine” does not identify the specialty of
#' the physician, but the display name of “Addiction Medicine (Internal
#' Medicine) Physician” clearly does. In another example, the code
#' “Radiology” could be confused with several codes, but “Radiology
#' Chiropractor” specifies the exact provider.
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
#' @keywords internal
download_nucc_csv <- function() {

  x <- rvest::session("https://www.nucc.org") |>
    rvest::session_follow_link("Code Sets") |>
    rvest::session_follow_link("Taxonomy") |>
    rvest::session_follow_link("CSV") |>
    rvest::html_elements("a") |>
    rvest::html_attr("href") |>
    stringr::str_subset("taxonomy") |>
    stringr::str_subset("csv")

  x <- rvest::session(paste0("https://www.nucc.org", x)) |>
    rvest::session_follow_link("Version")

  x <- x$response$url

  x <- data.table::fread(x) |>
    dplyr::tibble() |>
    janitor::clean_names() |>
    dplyr::mutate(dplyr::across(dplyr::everything(), ~dplyr::na_if(., "")),
                  dplyr::across(dplyr::everything(), ~stringr::str_squish(.))) |>
    dplyr::select(taxonomy_code = code,
                  taxonomy_category = section,
                  taxonomy_grouping = grouping,
                  taxonomy_classification = classification,
                  taxonomy_specialization = specialization,
                  taxonomy_display_name = display_name,
                  taxonomy_definition = definition) |>
    dplyr::mutate(version = 231,
                  release_date = anytime::anydate("2023-07-01"))
  return(x)
}
