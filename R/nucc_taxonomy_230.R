#' Health Care Provider Taxonomy code set
#'
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
#' @format ## `nucc_taxonomy_230` A data frame with 873 rows and 8 columns:
#' \describe{
#'   \item{code}{Taxonomy Code}
#'   \item{grouping}{Level I, Provider Grouping}
#'   \item{classification}{Level II, Classification}
#'   \item{specialization}{Level III, Area of Specialization}
#'   \item{definition}{Definition of Taxonomy}
#'   \item{notes}{Notes pertaining to Taxonomy, e.g. sources, date modified, date implemented, etc.}
#'   \item{display_name}{A more consumer-friendly name for the taxonomy code; a combination of the code name and the Level in which the code is nested.}
#'   \item{section}{Indicates whether Taxonomy is Individual or Non-Individual, i.e., a group taxonomy}
#' }
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
"nucc_taxonomy_230"
