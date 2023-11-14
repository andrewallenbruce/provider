#' Convert geographic levels to ordered factor
#' @param x vector
#' @autoglobal
#' @noRd
fct_level <- function(x) {
  factor(x,
         levels = c("National",
                    "State",
                    "County",
                    "Provider"),
         ordered = TRUE)
}

#' Convert time period levels to ordered factor
#' @param x vector
#' @autoglobal
#' @noRd
fct_period <- function(x) {
  factor(x,
         levels = c("Year",
                    "Month",
                    month.name),
         ordered = TRUE)
}

#' Convert sexes to unordered labelled factor
#' @param x vector
#' @autoglobal
#' @noRd
fct_gen <- function(x) {
  factor(x,
         levels = c("M", "F", "9"),
         labels = c("Male", "Female", "Unknown"))
}

#' Convert state abbreviations to ordered factor
#' @autoglobal
#' @noRd
fct_stabb <- function(x) {
  factor(x,
         levels = c('US',
                    state.abb[1:8],
                    'DC',
                    state.abb[9:50],
                    'AS', 'GU', 'MP', 'PR', 'VI', 'UK'),
         ordered = TRUE)
}

#' Convert state names to ordered factor
#' @param x vector
#' @autoglobal
#' @noRd
fct_stname <- function(x) {
  factor(x,
         levels = c('National',
                    state.name[1:8],
                    'District of Columbia',
                    state.name[9:50],
                    'American Samoa',
                    'Guam',
                    'Northern Mariana Islands',
                    'Puerto Rico',
                    'Virgin Islands',
                    'Unknown'),
         ordered = TRUE)
}

#' Convert enumeration types to labelled factor
#' @param x vector
#' @autoglobal
#' @noRd
fct_enum <- function(x) {
  factor(x,
         levels = c("NPI-1", "NPI-2"),
         labels = c("Individual", "Organization"))
}

#' Convert entity types to labelled factor
#' @param x vector
#' @autoglobal
#' @noRd
fct_ent <- function(x) {
  factor(x,
         levels = c("I", "O"),
         labels = c("Individual", "Organization"))
}

#' Convert place of service types to labelled factor
#' @param x vector
#' @autoglobal
#' @noRd
fct_pos <- function(x) {
  factor(x,
         levels = c("F", "O"),
         labels = c("Facility", "Non-facility"))
}

#' Convert address purpose to labelled factor
#' @param x vector
#' @autoglobal
#' @noRd
fct_purp <- function(x) {
  factor(x,
         levels = c("PRACTICE", "MAILING", "LOCATION"),
         labels = c("Practice", "Mailing", "Location"))
}

#' Convert age groups to unordered factor
#' @param x vector
#' @autoglobal
#' @noRd
fct_age <- function(x) {
  factor(x, levels = c("All", "<65", "65+"))
}

#' Convert demographic levels to unordered factor
#' @param x vector
#' @autoglobal
#' @noRd
fct_demo <- function(x) {
  factor(x, levels = c("All", "Dual Status", "Sex", "Race"))
}

#' Convert subdemographic levels to unordered factor
#' @param x vector
#' @autoglobal
#' @noRd
fct_subdemo <- function(x) {
  factor(x, levels = c("All",
                       "Medicare Only",
                       "Medicare and Medicaid",
                       "Female",
                       "Male",
                       "Asian Pacific Islander",
                       "Hispanic",
                       "Native American",
                       "non-Hispanic Black",
                       "non-Hispanic White"))
}

#' Convert multiple chronic condition groups to labelled, ordered factor
#' @param x vector
#' @autoglobal
#' @noRd
fct_mcc <- function(x) {
  factor(x,
         levels = c("0 to 1", "2 to 3", "4 to 5", "6+"),
         labels = c("0-1", "2-3", "4-5", "6+"),
         ordered = TRUE)
}

#' @autoglobal
#' @noRd
fct_part <- function(x) {
  factor(x, levels = c("Group", "Individual", "MIPS APM"))
}

#' @autoglobal
#' @noRd
fct_status <- function(x) {
  factor(x,
         levels = c("engaged",
                    "opted_into_mips",
                    "small_practitioner",
                    "rural",
                    "hpsa",
                    "ambulatory_surgical_center",
                    "hospital_based_clinician",
                    "non_patient_facing",
                    "facility_based",
                    "extreme_hardship",
                    "extreme_hardship_quality",
                    "quality_bonus",
                    "extreme_hardship_pi",
                    "pi_hardship",
                    "pi_reweighting",
                    "pi_bonus",
                    "extreme_hardship_ia",
                    "ia_study",
                    "extreme_hardship_cost"),
         labels = c("Engaged",
                    "Opted into MIPS",
                    "Small Practitioner",
                    "Rural Clinician",
                    "HPSA Clinician",
                    "Ambulatory Surgical Center",
                    "Hospital-Based Clinician",
                    "Non-Patient Facing",
                    "Facility-Based",
                    "Extreme Hardship",
                    "Extreme Hardship (Quality)",
                    "Quality Bonus",
                    "Extreme Hardship (PI)",
                    "PI Hardship",
                    "PI Reweighting",
                    "PI Bonus",
                    "Extreme Hardship (IA)",
                    "IA Study",
                    "Extreme Hardship (Cost)"))
}

#' @autoglobal
#' @noRd
fct_measure <- function(x) {
  factor(x,
         levels = c("quality", "pi", "ia", "cost"),
         labels = c("Quality", "Promoting Interoperability",
                    "Improvement Activities", "Cost"))
}
