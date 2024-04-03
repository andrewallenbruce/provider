#' Provider Taxonomies
#'
#' @description
#' `taxonomy_codes()` returns a [tibble()] of the current Health Care Provider
#' Taxonomy code set
#'
#' __Update Frequency__: _Biannually_
#'
#' @section Taxonomy Codes:
#' The Health Care Provider Taxonomy code set is a collection of unique
#' alphanumeric codes, ten characters in length. They contain no embedded logic.
#'
#' The code set Levels are organized to allow for drilling down to the
#' provider's most specific level of specialization, with three distinct "Levels":
#'
#' @section __Level I__ _Provider Grouping_:
#' A major grouping of service(s) or occupation(s) of health care providers.
#'
#' _Examples:_ Allopathic & Osteopathic Physicians, Dental Providers, Hospitals
#'
#' @section __Level II__ _Classification_:
#' A more specific service or occupation related to the Provider Grouping.
#'
#' For example, the classification for Allopathic & Osteopathic Physicians is
#' based upon the General Specialty Certificates as issued by the appropriate
#' national boards.
#'
#' The following boards will, however, have their general certificates appear as
#' Level III Areas of specialization strictly due to display limitations of the
#' code set for Boards that have multiple general certificates:
#'
#' _Medical Genetics, Preventive Medicine, Psychiatry & Neurology, Radiology,_
#' _Surgery, Otolaryngology, Pathology_
#'
#' @section __Level III__ _Area of Specialization_:
#' A more specialized area of the Classification in which a provider chooses to
#' practice or make services available.
#'
#' For example, the area of specialization for Allopathic & Osteopathic
#' Physicians is based upon the Subspecialty Certificates as issued by the
#' appropriate national boards.
#'
#' @section __Categories__ _(Level 0)_:
#' The code set includes three specialty categories:
#'
#' __Group (of Individuals)__:
#' 1. Multi-Specialty
#' 1. Single Specialty
#'
#' __Individuals__:
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
#' __Non-Individuals__:
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
#' @section Display Name:
#' The display name is a combination of the code name and the Level in
#' which the code is nested, which more precisely identifies the code.
#'
#' For example, Addiction Medicine is a physician subspecialty in Anesthesiology,
#' Family Medicine, Internal Medicine, Preventive Medicine, and Psychiatry &
#' Neurology.
#'
#' "Addiction Medicine" does not identify the specialty of
#' the physician, but the display name of "Addiction Medicine (Internal
#' Medicine) Physician" clearly does.
#'
#' In another example, "Radiology" could be confused with several
#' taxonomies, but "Radiology Chiropractor" more accurately specifies the provider.
#'
#' @section Description:
#' + `taxonomy_code`: Provider Taxonomy Code
#' + `taxonomy_category`: Indicates whether Taxonomy is Individual or Non-Individual, i.e., a group taxonomy
#' + `taxonomy_grouping`: Level I, Provider Grouping
#' + `taxonomy_classification`: Level II, Classification
#' + `taxonomy_specialization`: Level III, Area of Specialization
#' + `taxonomy_display_name`: Consumer-friendly taxonomy name, made of the code name and the Level in which the code is nested.
#' + `taxonomy_definition`: Definition of Taxonomy
#' + `version`: Three digit version of the code set. The first two digits indicate the year and the third digit indicates either the first release of the year ("0") or the second release of the year ("1").
#' + `release_date`: Date the version of the code set was released
#'
#' @source
#' <https://www.nucc.org/index.php/code-sets-mainmenu-41/provider-taxonomy-mainmenu-40/csv-mainmenu-57>
#'
#' @param shape shape of the data frame returned, 'wide' or 'long'
#'
#' @return A [tibble][tibble::tibble-package] with the columns:
#'
#' @examplesIf interactive()
#' taxonomy_codes()
#' @autoglobal
#' @export
taxonomy_codes <- function(shape = c('wide', 'long')) {

  results <- pins::board_url(
    github_raw("andrewallenbruce/provider/main/pkgdown/assets/pins-board/")) |>
    pins::pin_read("taxonomy_codes")

  shape <- match.arg(shape)

  if (shape == 'wide') return(results)

  if (shape == 'long') {
    results <- results |>
      dplyr::select(Code = taxonomy_code,
                    Category = taxonomy_category,
                    Grouping = taxonomy_grouping,
                    Classification = taxonomy_classification,
                    Specialization = taxonomy_specialization) |>
      dplyr::mutate(Category_Level = 0, .before = Category) |>
      dplyr::mutate(Grouping_Level = 1, .before = Grouping) |>
      dplyr::mutate(Classification_Level = 2, .before = Classification) |>
      dplyr::mutate(Specialization_Level = 3, .before = Specialization) |>
      tidyr::unite("Category", Category:Category_Level, remove = TRUE) |>
      tidyr::unite("Grouping", Grouping:Grouping_Level, remove = TRUE) |>
      tidyr::unite("Classification", Classification:Classification_Level,
                   remove = TRUE, na.rm = TRUE) |>
      tidyr::unite("Specialization", Specialization:Specialization_Level,
                   remove = TRUE, na.rm = TRUE) |>
      tidyr::pivot_longer(!Code, names_to = "Level",
                          values_to = "Description") |>
      dplyr::filter(Description != "3") |>
      tidyr::separate_wider_delim(Description,
                                  delim = "_",
                                  names = c("Description", "Group")) |>
      dplyr::mutate(Group = NULL,
                    Level = factor(Level,
      levels = c("Category", "Grouping", "Classification", "Specialization"),
      labels = c("I. Category", "II. Grouping",
                 "III. Classification", "IV. Specialization"), ordered = TRUE))
  }
    return(results)
}

#' @autoglobal
#' @noRd
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
                  release_date = lubridate::ymd("2023-07-01"))
  return(x)
}
