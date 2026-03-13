#' Clinical Laboratories
#'
#' @description
#' Clinical laboratories including demographics and the type of testing
#' services the facility provides.
#'
#' @section CLIA:
#'
#' CMS regulates all laboratory testing (except research) performed on humans
#' in the U.S. through the __Clinical Laboratory Improvement Amendments__.
#' In total, __CLIA__ covers approximately 320,000 laboratory entities.
#'
#' Although all clinical laboratories must be properly certified to receive
#' Medicare or Medicaid payments, CLIA has no direct Medicare or Medicaid
#' program responsibilities.
#'
#' @section Certification:
#'
#' ```{r, child = "man/md/clia_links.md"}
#' ```
#'
#' @references
#'
#' ```{r, child = "man/md/clia_links.md"}
#' ```
#'
#' @param name `<chr>` Provider or clinical laboratory's name
#' @param ccn `<chr>` 10-character CLIA number
#' @param certification `<chr>` CLIA certificate type:
#'    - `"waiver"`
#'    - `"ppm"`
#'    - `"registration"`
#'    - `"compliance"`
#'    - `"accreditation"`
#' @param city `<chr>` City
#' @param state `<chr>` State
#' @param zip `<chr>` Zip code
#' @param status `<chr>` `A` (Compliant) or `B` (Non-Compliant)
#' @param active `<lgl>` Return only active providers
#' @param count `<lgl>` Return the dataset's total row count
#' @returns A [tibble][tibble::tibble-package] containing the search results.
#' @examplesIf httr2::is_online()
#' clia(count = TRUE)
#' clia()
#' clia(ccn = provider:::cdc_labs$ccn)
#' clia(
#'   certification = "accreditation",
#'   city = "Valdosta",
#'   state = "GA"
#' )
#' @autoglobal
#' @export
clia <- function(
  name = NULL,
  ccn = NULL,
  certification = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  status = NULL,
  active = FALSE,
  count = FALSE
) {
  .c(BASE, LIMIT, NM) %=% constants(rlang::call_name(rlang::call_match()))

  exec_cms(
    ARG = params(
      FAC_NAME = name,
      PRVDR_NUM = ccn,
      CRTFCT_TYPE_CD = enum_(certification),
      CITY_NAME = city,
      STATE_CD = state,
      ZIP_CD = zip,
      CMPLNC_STUS_CD = status,
      PGM_TRMNTN_CD = lab_active(active)
    ),
    BASE = BASE,
    LIMIT = LIMIT,
    NM = NM,
    COUNT = count
  )
}

#' @noRd
lab_active <- function(active) {
  if (is.null(active)) {
    return(NULL)
  }
  if (active) "00" else NULL
}

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
