#' @autoglobal
#' @noRd
supplier_codes <- function(x) {

  dplyr::case_match(x,
      "C" ~ "Ambulatory Surgical Center",
      "D" ~ "Clinical Laboratory Improvement Amendments of 1988 (CLIA) Laboratory",
      "X" ~ "Portable X-Ray Facility",
      .default = x)
}

#' @autoglobal
#' @noRd
medicaid_facility_codes <- function(x) {

  dplyr::case_match(
    x,
    c("A", "B") ~ "NF (Formerly assigned to Medicaid SNF)",
    c("E", "F") ~ "NF (Formerly assigned to ICF)",
    c("G", "H") ~ "ICF/IID",
    "J" ~ "Medicaid-Only Hospital",
    "K" ~ "Medicaid HHA",
    "L" ~ "Psychiatric Residential Treatment Facility (PRTF)",
    "M" ~ "Psychiatric Unit of a CAH",
    "R" ~ "Rehabilitation Unit of a CAH",
    "S" ~ "Psychiatric Unit",
    "T" ~ "Rehabilitation Unit",
    "U" ~ "Swing-Bed Approval for Short-Term Hospital",
    "W" ~ "Swing-Bed Approval for Long-Term Care Hospital",
    "Z" ~ "Swing-Bed Approval for CAH",
    .default = x)
}

#' @autoglobal
#' @noRd
medicaid_hospital_ranges <- function(x) {

  dplyr::case_match(
    x,
    vctrs::vec_c(paste0("00", as.character(1:9)),
                 paste0("0", as.character(10:99))) ~ "Short-term Acute Care Hospital",
    as.character(100:199) ~ "Children's Hospital",
    as.character(200:299) ~ "Children's Psychiatric Hospital",
    as.character(300:399) ~ "Psychiatric Hospital",
    as.character(400:499) ~ "Rehabilitation Hospital",
    as.character(500:599) ~ "Long-term Hospital",
                    .default = x)
}

#' @autoglobal
#' @noRd
facility_ranges <- function(x) {

  dplyr::case_match(
    x,
    vctrs::vec_c(paste0("000", as.character(1:9)),
                 paste0("00", as.character(10:99)),
                 paste0("0", as.character(100:879))) ~ "Short-term (General and Specialty) Hospital",
    paste0("0", as.character(880:899)) ~ "Hospital participating in ORD demonstration project",
    vctrs::vec_c(as.character(1000:1199),
                 as.character(1800:1989)) ~ "Federally Qualified Health Center",
    as.character(1225:1299) ~ "Medical Assistance Facility",
    as.character(1300:1399) ~ "Critical Access Hospital",
    as.character(1400:1499) ~ "Community Mental Health Center",
    as.character(1500:1799) ~ "Hospice",
    as.character(1990:1999) ~ "Religious Non-medical Health Care Institution (formerly Christian Science Sanatoria Hospital Services)",
    as.character(2000:2299) ~ "Long-Term Care Hospital",
    as.character(2300:2499) ~ "Hospital-based Renal Dialysis Facility",
    as.character(2500:2899) ~ "Independent Renal Dialysis Facility",
    as.character(2900:2999) ~ "Independent Special Purpose Renal Dialysis Facility",
    as.character(3025:3099) ~ "Rehabilitation Hospital",
    vctrs::vec_c(as.character(3100:3199),
                 as.character(7000:8499),
                 as.character(9000:9799)) ~ "Home Health Agency",
    as.character(3300:3399) ~ "Children's Hospital",
    vctrs::vec_c(as.character(3400:3499),
                 as.character(3975:3999),
                 as.character(8500:8899)) ~ "Rural Health Clinic (Provider-based)",
    vctrs::vec_c(as.character(3800:3974),
                 as.character(8900:8999)) ~ "Rural Health Clinic (Free-standing)",
    as.character(3500:3699) ~ "Hospital-based Satellite Renal Dialysis Facility",
    as.character(3700:3799) ~ "Hospital-based Special Purpose Renal Dialysis Facility",
    as.character(4000:4499) ~ "Psychiatric Hospital",
    vctrs::vec_c(as.character(3200:3299),
                 as.character(4500:4599),
                 as.character(4800:4899)) ~ "Comprehensive Outpatient Rehabilitation Facility",
    vctrs::vec_c(as.character(4600:4799),
                 as.character(4900:4999)) ~ "Community Mental Health Center",
    as.character(5000:6499) ~ "Skilled Nursing Facility",
    as.character(6500:6989) ~ "Outpatient Physical Therapy Services",
    as.character(9800:9899) ~ "Transplant Center",
    as.character(6990:6999) ~ "Number Reserved (formerly Christian Science Sanatoria Skilled Nursing Services)",
    as.character(9900:9999) ~ "Reserved for Future Use",
    paste0("0", as.character(900:999)) ~ "Multiple Hospital Component in a Medical Complex (Number Retired)",
    as.character(1200:1224) ~ "Alcohol/Drug Hospital (Number Retired)",
    as.character(3000:3024) ~ "Tuberculosis Hospital (Number Retired)",
  .default = x)

}

#' @autoglobal
#' @noRd
emergency_codes <- function(x) {

  dplyr::case_match(
    x,
    "E" ~ "Non-Federal Emergency Hospital",
    "F" ~ "Federal Emergency Hospital",
    .default = x)

}

#' @autoglobal
#' @noRd
ipps_parent_hospital_types <- function(x) {

  dplyr::case_match(
    x,
    "A" ~ "LTCH (20)",
    "B" ~ "LTCH (21)",
    "C" ~ "LTCH (22)",
    "D" ~ "Rehabilitation Hospital (30)",
    "E" ~ "Children's Hospital (33)",
    "F" ~ "Psychiatric Hospital (40)",
    "G" ~ "Psychiatric Hospital (41)",
    "H" ~ "Psychiatric Hospital (42)",
    "J" ~ "Psychiatric Hospital (43)",
    "K" ~ "Psychiatric Hospital (44)",
    .default = x)

}

#' @autoglobal
#' @noRd
medicaid_type_codes <- function(x) {

  vctrs::vec_c("A", "B", "E", "F", "G", "H", "K", "L", "J")

}

#' @autoglobal
#' @noRd
ipps_excluded_type_codes <- function(x) {

  vctrs::vec_c("M", "R", "S", "T", "U", "W", "Z")

}

#' @autoglobal
#' @noRd
ccn_state_codes <- function(x) {

  dplyr::case_match(
    x,
    "01" ~ "Alabama",
    "30" ~ "New Hampshire",
    "02" ~ "Alaska",
    c("31", "83") ~ "New Jersey",
    c("00", "03") ~ "Arizona",
    c("32", "96") ~ "New Mexico",
    c("04", "89") ~ "Arkansas",
    c("33", "57") ~ "New York",
    c("05", "55", "75", "92", "A0", "A1", "B2") ~ "California",
    c("34", "86") ~ "North Carolina",
    c("06", "91") ~ "Colorado",
    "35" ~ "North Dakota",
    c("07", "81") ~ "Connecticut",
    c("36", "72", "A6") ~ "Ohio",
    "08" ~ "Delaware",
    c("37", "90") ~ "Oklahoma",
    "09" ~ "District of Columbia",
    c("38", "93") ~ "Oregon",
    c("10", "68", "69", "A2") ~ "Florida",
    c("39", "73", "A7") ~ "Pennsylvania",
    c("11", "85") ~ "Georgia",
    c("40", "84") ~ "Puerto Rico",
    "12" ~ "Hawaii",
    "41" ~ "Rhode Island",
    c("13", "54"), "Idaho",
    c("42", "87"), "South Carolina",
    c("14", "78"), "Illinois",
    "43" ~ "South Dakota",
    "15" ~ "Indiana",
    c("44", "88", "A8") ~ "Tennessee",
    c("16", "76") ~ "Iowa",
    c("45", "67", "74", "97", "A9") ~ "Texas",
    c("17", "70") ~ "Kansas",
    "46" ~ "Utah",
    c("18", "B0") ~ "Kentucky",
    "47" ~ "Vermont",
    c("19", "71", "95", "A3"), "Louisiana",
    "48" ~ "Virgin Islands",
    "20" ~ "Maine",
    "49" ~ "Virginia",
    c("21", "80") ~ "Maryland",
    c("50", "94") ~ "Washington",
    c("22", "82") ~ "Massachusetts",
    c("51", "58", "B1") ~ "West Virginia",
    c("23", "A4") ~ "Michigan",
    "52" ~ "Wisconsin",
    c("24", "77") ~ "Minnesota",
    "53" ~ "Wyoming",
    c("25", "A5") ~ "Mississippi",
    "56" ~ "Canada",
    c("26", "79") ~ "Missouri",
    "59" ~ "Mexico",
    "27" ~ "Montana",
    "64" ~ "American Samoa",
    "28" ~ "Nebraska",
    "65" ~ "Guam",
    "29" ~ "Nevada",
    "66" ~ "Commonwealth of the Northern Marianas Islands",
    "99" ~ "Foreign Countries (exceptions: Canada and Mexico)",
    .default = x)

}


#' @autoglobal
#' @noRd
ccn_decode <- function(x) {

  if (nchar(x) %in% !c(6, 10)) {type <- "Unknown Type"}
  if (nchar(x) == 6)           {type <- "Medicare Provider"}
  if (nchar(x) == 10)          {type <- "Medicare Supplier"}

  s <- unlist(strsplit(x, ""))

  # First two characters always represent the state
  state <- ccn_state_codes(paste0(s[1], s[2]))

  # Medicare Provider
  if (nchar(x) == 6 && isTRUE(grepl("^[[:digit:]]+$", s[3]))) {
    facility <- facility_ranges(paste0(s[3], s[4], s[5], s[6]))
  }
  if (nchar(x) == 6 && s[3] == "P") {
    facility <- "Organ Procurement Organization"
  }
}
