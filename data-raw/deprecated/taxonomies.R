#' NUCC Provider Taxonomy Codeset
#'
#' `search_taxonomy()` returns a [tibble()] of the current Health Care Provider
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
#' + `code`: Provider Taxonomy Code
#' + `category`: Indicates whether Taxonomy is Individual or Non-Individual, i.e., a group taxonomy
#' + `grouping`: Level I, Provider Grouping
#' + `classification`: Level II, Classification
#' + `specialization`: Level III, Area of Specialization
#' + `display_name`: Consumer-friendly taxonomy name, made of the code name and the Level in which the code is nested.
#' + `definition`: Definition of Taxonomy
#' + `version`: Three digit version of the code set. The first two digits indicate the year and the third digit indicates either the first release of the year ("0") or the second release of the year ("1").
#' + `release_date`: Date the version of the code set was released
#'
#' @source
#' [National Uniform Claim Committee](https://www.nucc.org/index.php/code-sets-mainmenu-41/provider-taxonomy-mainmenu-40/csv-mainmenu-57)
#'
#' @param code `<chr>` vector of taxonomy codes
#'
#' @param shape `<chr>` shape of data to return, `wide` (default) or `long`
#'
#' @param unnest `<lgl>`unnest `hierarchy` column, default is `FALSE`
#'
#' @template args-dots
#'
#' @template returns
#'
#' @examples
#' taxonomies(code = c("207K00000X", "193200000X"))
#'
#' taxonomies(code   = "207K00000X",
#'            shape  = "long",
#'            unnest = TRUE)
#'
#' @autoglobal
#'
#' @export
taxonomies <- function(code   = NULL,
                       shape  = c('wide', 'long'),
                       unnest = FALSE,
                       ...) {

  shape <- match.arg(shape)

  txn <- switch(
    shape,
    "wide" = pins::pin_read(mount_board(), "taxonomy"),
    "long" = pins::pin_read(mount_board(), "taxlong")
  )

  txn <- fuimus::search_in_if(txn, txn$code, code)

  if (shape == "long" && unnest) {
    txn <- tidyr::unnest(txn, cols = c(hierarchy))
  }
  return(txn)
}
