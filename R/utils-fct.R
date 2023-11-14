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

#' Convert genders to unordered factor
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
