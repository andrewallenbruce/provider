#' @noRd
recode_clia <- function(x, col) {
  switch(
    col,
    # same as apl_type
    cert = cheapr::val_match(
      x,
      1 ~ "Compliance",
      2 ~ "Waiver",
      3 ~ "Accreditation",
      4 ~ "PPM",
      9 ~ "Registration",
      .default = x
    ),
    action = cheapr::val_match(
      x,
      1 ~ "Initial",
      2 ~ "Recertification",
      3 ~ "Termination",
      4 ~ "Change of Ownership",
      5 ~ "Validation",
      8 ~ "Full Survey After Complaint",
      .default = x
    ),
    status = cheapr::val_match(
      x,
      "A" ~ "Compliant",
      "B" ~ "Non-Compliant",
      .default = x
    )
  )
}

#' @noRd
fct_region <- function(x) {
  factor(
    x,
    levels = c('01', '02', '03', '04', '05', '06', '07', '08', '09', '10'),
    labels = c(
      'Boston',
      'New York',
      'Philadelphia',
      'Atlanta',
      'Chicago',
      'Dallas',
      'Kansas City',
      'Denver',
      'San Francisco',
      'Seattle'
    )
  )
}

#' @noRd
fct_owner <- function(x) {
  factor(
    x,
    levels = c('01', '02', '03', '04', '05', '06', '07', '08', '09', '10'),
    labels = c(
      'Religious Affiliation',
      'Private',
      'Other',
      'Proprietary',
      'Govt: City',
      'Govt: County',
      'Govt: State',
      'Govt: Federal',
      'Govt: Other',
      'Unknown'
    )
  )
}

#' @noRd
fct_lab <- function(x) {
  factor(
    x,
    levels = c("00", "22", "01", "05", "10"),
    labels = c(
      "CLIA Lab",
      "CLIA Lab",
      "CLIA88 Lab",
      "CLIA Exempt Lab",
      "CLIA VA Lab"
    )
  )
}

#' @noRd
fct_facility <- function(x) {
  factor(
    x,
    levels = c(
      '01',
      '02',
      '03',
      '04',
      '05',
      '06',
      '07',
      '08',
      '09',
      '10',
      '11',
      '12',
      '13',
      '14',
      '15',
      '16',
      '17',
      '18',
      '19',
      '20',
      '21',
      '22',
      '23',
      '24',
      '25',
      '26',
      '27',
      '28',
      '29'
    ),
    labels = c(
      'Ambulance',
      'Ambulatory Surgical Center',
      'Ancillary Test Site',
      'Assisted Living Facility',
      'Blood Banks',
      'Community Clinic',
      'Comprehensive Outpatient Rehab',
      'End-Stage Renal Disease Dialysis',
      'Federally Qualified Health Center',
      'Health Fair',
      'Health Maintenance Organization',
      'Home Health Agency',
      'Hospice',
      'Hospital',
      'Independent',
      'Industrial',
      'Insurance',
      'Intermediate Care Facility-Individuals with Intellectual Disabilities',
      'Mobile Lab',
      'Pharmacy',
      'Physician Office',
      'Other Practitioner',
      'Prison',
      'Public Health Laboratory',
      'Rural Health Clinic',
      'School-Student Health Service',
      'Skilled Nursing Facility',
      'Tissue Bank-Repositories',
      'Other'
    ),
    ordered = TRUE
  )
}

#' @noRd
fct_term <- function(x) {
  factor(
    x,
    levels = c(
      '00',
      '01',
      '02',
      '03',
      '04',
      '05',
      '06',
      '07',
      '08',
      '09',
      '10',
      '11',
      '12',
      '13',
      '14',
      '15',
      '16',
      '17',
      '20',
      '33',
      '80',
      '99'
    ),
    labels = c(
      'Active Provider',
      'Voluntary: Merger, Closure',
      'Voluntary: Dissatisfaction with Reimbursement',
      'Voluntary: Risk of Involuntary Termination',
      'Voluntary: Other Reason for Withdrawal',
      'Involuntary: Failure to Meet Health-Safety Req',
      'Involuntary: Failure to Meet Agreement',
      'Other: Provider Status Change',
      'Nonpayment of Fees (CLIA Only)',
      'Rev/Unsuccessful Participation in PT (CLIA Only)',
      'Rev/Other Reason (CLIA Only)',
      'Incomplete CLIA Application Information (CLIA Only)',
      'No Longer Performing Tests (CLIA Only)',
      'Multiple to Single Site Certificate (CLIA Only)',
      'Shared Laboratory (CLIA Only)',
      'Failure to Renew Waiver PPM Certificate (CLIA Only)',
      'Duplicate CLIA Number (CLIA Only)',
      'Mail Returned No Forward Address Cert Ended (CLIA Only)',
      'Notification Bankruptcy (CLIA Only)',
      'Accreditation Not Confirmed (CLIA Only)',
      'Awaiting State Approval',
      'OIG Action Do Not Activate (CLIA Only)'
    ),
    ordered = TRUE
  )
}
