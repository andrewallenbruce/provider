#' The CCN is used to identify each separately certified Medicare provider or
#' supplier. It is used to track provider agreements and cost reports. The
#' national provider identifier (NPI) and provider transaction account number
#' (PTAN) are tied to the CCN.
#'
#' The CCN for providers and suppliers paid under Medicare Part A have six
#' digits. The first two digits identify the State in which the provider is
#' located. The last four digits identify the type of facility.
#'
#' Organ procurement organizations (OPOs) are assigned a 6-digit alphanumeric
#' CCN.  The first 2 digits identify the State Code.  The third digit is the
#' alpha character “P.”  The remaining 3 digits are the unique facility identifier.
#'
#' @autoglobal
#' @noRd
# nocov start
ccn_decode <- function(x) {

  if (nchar(x) %in% !c(6, 10)) {type <- "Unknown Type"}
  if (nchar(x) == 6)           {type <- "Medicare Provider"}
  if (nchar(x) == 10)          {type <- "Medicare Supplier"}

  s <- unlist(strsplit(x, ""), use.names = FALSE)

  # First two characters always represent the state
  cd <- paste0(s[1], s[2])
  st <- ccn_state_codes(cd)
  state <- paste0(st, " [", cd, "]")

  # Medicare Provider
  if (nchar(x) == 6 && isTRUE(grepl("^[[:digit:]]+$", s[3]))) {
    type <- "Medicare Provider"
    fcd <- paste0(s[3], s[4], s[5], s[6])
    fac <- facility_ranges(fcd)
    facility <- paste0(fac, " [", fcd, "]")

    return(list(type = type,
                state = state,
                facility_type = facility))
  }

  if (nchar(x) == 6 && s[3] == "P") {
    type <- "Medicare Provider"
    facility <- paste0("Organ Procurement Organization", " [P]")

    return(list(type = type,
                state = state,
                facility_type = facility,
                facility_id = paste0(s[4], s[5], s[6])))
  }

  # Medicaid-Only Provider
  if (nchar(x) == 6 && isFALSE(grepl("^[[:digit:]]+$", s[3]))) {
    type <- "Medicaid-Only Provider"
    parent <- paste0(medicaid_facility_codes(s[3]), " [", s[3], "]")
    fcd <- paste0(s[4], s[5], s[6])
    fac <- medicaid_hospital_ranges(fcd)
    facility <- paste0(fac, " [", fcd, "]")
  }
  # Medicare-Medicaid Provider Excluded from IPPS
  if (nchar(x) == 6 && isFALSE(grepl("^[[:digit:]]+$", s[4]))) {
    parent <- medicaid_facility_codes(s[4])}

  return(list(type = type,
              state = state,
              facility_type = facility,
              parent_type = parent))
}

# ccn_decode("11T122")

#' @autoglobal
#' @noRd
medicaid_type_codes <- function(x) {

  vctrs::vec_c("A", "B", "E",
               "F", "G", "H",
               "K", "L", "J")
}

#' @autoglobal
#' @noRd
medicaid_facility_codes <- function(x) {

  # 3rd character of a 6-character CCN
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
ipps_parent_hospital_types <- function(x) {

  # 4th character of a 6-character CCN
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
ipps_excluded_type_codes <- function(x) {

  vctrs::vec_c("M", "R", "S",
               "T", "U", "W", "Z")

}

#' @autoglobal
#' @noRd
supplier_codes <- function(x) {

  # 3rd character of a 10-character CCN
  dplyr::case_match(x,
                    "C" ~ "Ambulatory Surgical Center",
                    "D" ~ "Clinical Laboratory Improvement Amendments of 1988 (CLIA) Laboratory",
                    "X" ~ "Portable X-Ray Facility",
                    .default = x)
}


#' @autoglobal
#' @noRd
emergency_codes <- function(x) {

  # 6th character of a 6-character CCN
  dplyr::case_match(
    x,
    "E" ~ "Non-Federal Emergency Hospital",
    "F" ~ "Federal Emergency Hospital",
    .default = x)

}

#' @autoglobal
#' @noRd
.ccn <- function(x) {

  if(is.numeric(x)) x <- as.character(x)

  .ccn.state <- vctrs::vec_c(
    '00' = 'Arizona',
    '01' = 'Alabama',
    '02' = 'Alaska',
    '03' = 'Arizona',
    '04' = 'Arkansas',
    '05' = 'California',
    '06' = 'Colorado',
    '07' = 'Connecticut',
    '08' = 'Delaware',
    '09' = 'District of Columbia',
    '10' = 'Florida',
    '11' = 'Georgia',
    '12' = 'Hawaii',
    '13' = 'Idaho',
    '14' = 'Illinois',
    '15' = 'Indiana',
    '16' = 'Iowa',
    '17' = 'Kansas',
    '18' = 'Kentucky',
    '19' = 'Louisiana',
    '20' = 'Maine',
    '21' = 'Maryland',
    '22' = 'Massachusetts',
    '23' = 'Michigan',
    '24' = 'Minnesota',
    '25' = 'Mississippi',
    '26' = 'Missouri',
    '27' = 'Montana',
    '28' = 'Nebraska',
    '29' = 'Nevada',
    '30' = 'New Hampshire',
    '31' = 'New Jersey',
    '32' = 'New Mexico',
    '33' = 'New York',
    '34' = 'North Carolina',
    '35' = 'North Dakota',
    '36' = 'Ohio',
    '37' = 'Oklahoma',
    '38' = 'Oregon',
    '39' = 'Pennsylvania',
    '40' = 'Puerto Rico',
    '41' = 'Rhode Island',
    '42' = 'South Carolina',
    '43' = 'South Dakota',
    '44' = 'Tennessee',
    '45' = 'Texas',
    '46' = 'Utah',
    '47' = 'Vermont',
    '48' = 'Virgin Islands',
    '49' = 'Virginia',
    '50' = 'Washington',
    '51' = 'West Virginia',
    '52' = 'Wisconsin',
    '53' = 'Wyoming',
    '54' = 'Idaho',
    '55' = 'California',
    '56' = 'Canada',
    '57' = 'New York',
    '58' = 'West Virginia',
    '59' = 'Mexico',
    '60' = NA,
    '61' = NA,
    '62' = NA,
    '63' = NA,
    '64' = 'American Samoa',
    '65' = 'Guam',
    '66' = 'Northern Marianas Islands',
    '67' = 'Texas',
    '68' = 'Florida',
    '69' = 'Florida',
    '70' = 'Kansas',
    '71' = 'Louisiana',
    '72' = 'Ohio',
    '73' = 'Pennsylvania',
    '74' = 'Texas',
    '75' = 'California',
    '76' = 'Iowa',
    '77' = 'Minnesota',
    '78' = 'Illinois',
    '79' = 'Missouri',
    '80' = 'Maryland',
    '81' = 'Connecticut',
    '82' = 'Massachusetts',
    '83' = 'New Jersey',
    '84' = 'Puerto Rico',
    '85' = 'Georgia',
    '86' = 'North Carolina',
    '87' = 'South Carolina',
    '88' = 'Tennessee',
    '89' = 'Arkansas',
    '90' = 'Oklahoma',
    '91' = 'Colorado',
    '92' = 'California',
    '93' = 'Oregon',
    '94' = 'Washington',
    '95' = 'Louisiana',
    '96' = 'New Mexico',
    '97' = 'Texas',
    '98' = NA,
    '99' = 'Foreign Countries',
    'A0' = 'California',
    'A1' = 'California',
    'A2' = "Florida",
    'A3' = "Louisiana",
    'A4' = 'Michigan',
    'A5' = 'Mississippi',
    'A6' = 'Ohio',
    'A7' = 'Pennsylvania',
    'A8' = 'Tennessee',
    'A9' = 'Texas',
    'B0' = 'Kentucky',
    'B1' = 'West Virginia',
    'B2' = 'California')

  unname(state[x])
}

#' @autoglobal
#' @noRd
ccn.state <- function(x) {
  list(
    '00' = 'Arizona',
    '01' = 'Alabama',
    '02' = 'Alaska',
    '03' = 'Arizona',
    '04' = 'Arkansas',
    '05' = 'California',
    '06' = 'Colorado',
    '07' = 'Connecticut',
    '08' = 'Delaware',
    '09' = 'District of Columbia',
    '10' = 'Florida',
    '11' = 'Georgia',
    '12' = 'Hawaii',
    '13' = 'Idaho',
    '14' = 'Illinois',
    '15' = 'Indiana',
    '16' = 'Iowa',
    '17' = 'Kansas',
    '18' = 'Kentucky',
    '19' = 'Louisiana',
    '20' = 'Maine',
    '21' = 'Maryland',
    '22' = 'Massachusetts',
    '23' = 'Michigan',
    '24' = 'Minnesota',
    '25' = 'Mississippi',
    '26' = 'Missouri',
    '27' = 'Montana',
    '28' = 'Nebraska',
    '29' = 'Nevada',
    '30' = 'New Hampshire',
    '31' = 'New Jersey',
    '32' = 'New Mexico',
    '33' = 'New York',
    '34' = 'North Carolina',
    '35' = 'North Dakota',
    '36' = 'Ohio',
    '37' = 'Oklahoma',
    '38' = 'Oregon',
    '39' = 'Pennsylvania',
    '40' = 'Puerto Rico',
    '41' = 'Rhode Island',
    '42' = 'South Carolina',
    '43' = 'South Dakota',
    '44' = 'Tennessee',
    '45' = 'Texas',
    '46' = 'Utah',
    '47' = 'Vermont',
    '48' = 'Virgin Islands',
    '49' = 'Virginia',
    '50' = 'Washington',
    '51' = 'West Virginia',
    '52' = 'Wisconsin',
    '53' = 'Wyoming',
    '54' = 'Idaho',
    '55' = 'California',
    '56' = 'Canada',
    '57' = 'New York',
    '58' = 'West Virginia',
    '59' = 'Mexico',
    '60' = NA,
    '61' = NA,
    '62' = NA,
    '63' = NA,
    '64' = 'American Samoa',
    '65' = 'Guam',
    '66' = 'Northern Marianas Islands',
    '67' = 'Texas',
    '68' = 'Florida',
    '69' = 'Florida',
    '70' = 'Kansas',
    '71' = 'Louisiana',
    '72' = 'Ohio',
    '73' = 'Pennsylvania',
    '74' = 'Texas',
    '75' = 'California',
    '76' = 'Iowa',
    '77' = 'Minnesota',
    '78' = 'Illinois',
    '79' = 'Missouri',
    '80' = 'Maryland',
    '81' = 'Connecticut',
    '82' = 'Massachusetts',
    '83' = 'New Jersey',
    '84' = 'Puerto Rico',
    '85' = 'Georgia',
    '86' = 'North Carolina',
    '87' = 'South Carolina',
    '88' = 'Tennessee',
    '89' = 'Arkansas',
    '90' = 'Oklahoma',
    '91' = 'Colorado',
    '92' = 'California',
    '93' = 'Oregon',
    '94' = 'Washington',
    '95' = 'Louisiana',
    '96' = 'New Mexico',
    '97' = 'Texas',
    '98' = NA,
    '99' = 'Foreign Countries',
    'A0' = 'California',
    'A1' = 'California',
    'A2' = "Florida",
    'A3' = "Louisiana",
    'A4' = 'Michigan',
    'A5' = 'Mississippi',
    'A6' = 'Ohio',
    'A7' = 'Pennsylvania',
    'A8' = 'Tennessee',
    'A9' = 'Texas',
    'B0' = 'Kentucky',
    'B1' = 'West Virginia',
    'B2' = 'California')
}

#' @autoglobal
#' @noRd
ccn_state_codes <- function(x) {

  dplyr::case_match(
    x,
    "01" ~ "Alabama",
    "02" ~ "Alaska",
    "08" ~ "Delaware",
    "09" ~ "District of Columbia",
    "12" ~ "Hawaii",
    "15" ~ "Indiana",
    "20" ~ "Maine",
    "27" ~ "Montana",
    "28" ~ "Nebraska",
    "29" ~ "Nevada",
    "30" ~ "New Hampshire",
    "35" ~ "North Dakota",
    "41" ~ "Rhode Island",
    "43" ~ "South Dakota",
    "46" ~ "Utah",
    "47" ~ "Vermont",
    "48" ~ "Virgin Islands",
    "49" ~ "Virginia",
    "52" ~ "Wisconsin",
    "53" ~ "Wyoming",
    "56" ~ "Canada",
    "59" ~ "Mexico",
    "64" ~ "American Samoa",
    "65" ~ "Guam",
    "66" ~ "Northern Marianas Islands",
    "99" ~ "Foreign Countries",
    c("00", "03") ~ "Arizona",
    c("04", "89") ~ "Arkansas",
    c("05", "55", "75", "92", "A0", "A1", "B2") ~ "California",
    c("06", "91") ~ "Colorado",
    c("07", "81") ~ "Connecticut",
    c("10", "68", "69", "A2") ~ "Florida",
    c("11", "85") ~ "Georgia",
    c("13", "54") ~ "Idaho",
    c("14", "78") ~ "Illinois",
    c("16", "76") ~ "Iowa",
    c("17", "70") ~ "Kansas",
    c("18", "B0") ~ "Kentucky",
    c("19", "71", "95", "A3") ~ "Louisiana",
    c("21", "80") ~ "Maryland",
    c("22", "82") ~ "Massachusetts",
    c("23", "A4") ~ "Michigan",
    c("24", "77") ~ "Minnesota",
    c("25", "A5") ~ "Mississippi",
    c("26", "79") ~ "Missouri",
    c("31", "83") ~ "New Jersey",
    c("32", "96") ~ "New Mexico",
    c("33", "57") ~ "New York",
    c("34", "86") ~ "North Carolina",
    c("37", "90") ~ "Oklahoma",
    c("38", "93") ~ "Oregon",
    c("36", "72", "A6") ~ "Ohio",
    c("39", "73", "A7") ~ "Pennsylvania",
    c("40", "84") ~ "Puerto Rico",
    c("42", "87") ~ "South Carolina",
    c("44", "88", "A8") ~ "Tennessee",
    c("45", "67", "74", "97", "A9") ~ "Texas",
    c("50", "94") ~ "Washington",
    c("51", "58", "B1") ~ "West Virginia",
    .default = x)
}
# nocov end
