#' @param x vector
#'
#' @autoglobal
#'
#' @noRd
correct_specialty <- function(x) {
  dplyr::case_match(
    x,
    "Allergy/ Immunology" ~ "Allergy/Immunology",
    "Obstetrics & Gynecology" ~ "Obstetrics/Gynecology",
    "Hematology-Oncology" ~ "Hematology/Oncology",
    "Independent Diagnostic Testing Facility (IDTF)" ~ "Independent Diagnostic Testing Facility",
    "Mass Immunizer Roster Biller" ~ "Mass Immunization Roster Biller",
    "Anesthesiologist Assistants" ~ "Anesthesiology Assistant",
    "Occupational therapist" ~ "Occupational Therapist",
    "Psychologist, Clinical" ~ "Clinical Psychologist",
    .default = x
  )
}
