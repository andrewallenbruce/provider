#' Convert state abbreviations to ordered factor
#' @autoglobal
#' @noRd
fct_stabb <- function(x) {
  factor(
    x,
    levels = c(
      'US',
      state.abb[1:8],
      'DC',
      state.abb[9:50],
      'AS',
      'GU',
      'MP',
      'PR',
      'VI',
      'UK'
    ),
    ordered = TRUE
  )
}

#' Convert state names to ordered factor
#' @param x vector
#' @autoglobal
#' @noRd
fct_stname <- function(x) {
  factor(
    x,
    levels = c(
      'National',
      state.name[1:8],
      'District of Columbia',
      state.name[9:50],
      'American Samoa',
      'Guam',
      'Northern Mariana Islands',
      'Puerto Rico',
      'Virgin Islands',
      'Unknown'
    ),
    ordered = TRUE
  )
}

#' Convert QPP participation types to unordered factor
#' @param x vector
#' @autoglobal
#' @noRd
fct_part <- function(x) {
  factor(x, levels = c("Group", "Individual", "MIPS APM"))
}

#' Convert QPP special statuses to labelled factor
#' @param x vector
#' @autoglobal
#' @noRd
fct_status <- function(x) {
  factor(
    x,
    levels = c(
      "engaged",
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
      "extreme_hardship_cost"
    ),
    labels = c(
      "Engaged",
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
      "Extreme Hardship (Cost)"
    )
  )
}

#' Convert QPP measure categories to labelled factor
#' @param x vector
#' @autoglobal
#' @noRd
fct_measure <- function(x) {
  factor(
    x,
    levels = c("quality", "pi", "ia", "cost"),
    labels = c(
      "Quality",
      "Promoting Interoperability",
      "Improvement Activities",
      "Cost"
    )
  )
}

#' Convert hospital subgroup types to unordered factor
#' @param x vector
#' @autoglobal
#' @noRd
fct_subgroup <- function(x) {
  factor(
    x,
    levels = c(
      "Acute Care",
      "Alcohol Drug",
      "Childrens' Hospital",
      "General",
      "Long-term",
      "None",
      "Other",
      "Psychiatric",
      "Psychiatric Unit",
      "Rehabilitation",
      "Rehabilitation Unit",
      "Short-Term",
      "Specialty Hospital",
      "Swing-Bed Approved"
    )
  )
}
