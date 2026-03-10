#' Clinical Laboratories
#'
#' @description
#' Clinical laboratories including demographics and the type of testing
#' services the facility provides.
#'
#' @section CLIA:
#'
#' CMS regulates all laboratory testing (except research) performed on humans
#' in the U.S. through the __Clinical Laboratory Improvement Amendments (CLIA)__.
#' In total, CLIA covers approximately 320,000 laboratory entities.
#'
#' The _Division of Clinical Laboratory Improvement & Quality_, within the
#' _Quality, Safety & Oversight Group_, under the _Center for Clinical Standards and Quality_
#' (CCSQ) has the responsibility for implementing the CLIA Program.
#'
#' Although all clinical laboratories must be properly certified to receive
#' Medicare or Medicaid payments, CLIA has no direct Medicare or Medicaid
#' program responsibilities.
#'
#' @section Certification:
#'
#' The five CLIA certificate types, all of which are effective for a period of
#' two years, are as follows, in order of increasing complexity:
#'
#' 1. **Waiver**: Issued to a laboratory to perform only waived tests; does
#'    not waive the lab from all CLIA requirements. Waived tests are laboratory
#'    tests that are simple to perform. Routine inspections are not conducted
#'    for waiver labs, although 2% are visited each year to ensure quality
#'    laboratory testing.
#'
#' 2. **Provider-Performed Microscopy Procedures (PPM)**: Issued to a
#'    laboratory in which a physician, mid-level practitioner or dentist
#'    performs limited tests that require microscopic examination. PPM tests are
#'    considered moderate complexity. Waived tests can also be performed under this
#'    certificate type. There are no routine inspections conducted for PPM labs.
#'
#' 3. **Registration**: Initially issued to a laboratory that has applied for
#'    a Certificate of Compliance or Accreditation, enabling the lab to conduct
#'    moderate/high complexity testing until the survey is performed and the
#'    laboratory is found to be in CLIA compliance. Includes PPM and waived
#'    testing.
#'
#' 4. **Compliance**: Allows the laboratory to conduct moderate/high complexity
#'    testing and is issued after an inspection finds the lab to be in
#'    compliance with all applicable CLIA requirements. Includes PPM and
#'    waived testing.
#'
#' 5. **Accreditation**: Exactly the same as the Certificate of Compliance,
#'    except that the laboratory must be accredited by one of the following
#'    CMS-approved accreditation organizations:
#'
#'      - [A2LA](https://a2la.org/): American Association for Laboratory Accreditation
#'      - [AABB](https://www.aabb.org/): Association for the Advancement of Blood & Biotherapies
#'      - [AOA](https://osteopathic.org/): American Osteopathic Association
#'      - [ASHI-HLA](https://www.ashi-hla.org/): American Society for Histocompatibility & Immunogenetics
#'      - [CAP](https://www.cap.org/): College of American Pathologists
#'      - [COLA](https://www.cola.org/): Commission on Office Laboratory Accreditation
#'      - [JCAHO](https://www.jointcommission.org/): The Joint Commission
#'
#' @references
#'   - [Provider of Services File - Clinical Laboratories API](https://data.cms.gov/provider-characteristics/hospitals-and-other-facilities/provider-of-services-file-clinical-laboratories)
#'   - [CMS CLIA](https://www.cms.gov/medicare/quality/clinical-laboratory-improvement-amendments)
#'   - [CDC CLIA](https://www.cdc.gov/clia/php/about/index.html)
#'   - [CMS QCOR](https://qcor.cms.gov/main.jsp)
#'   - [CLIA Certificates](https://www.cdc.gov/labs/clia-certificates/index.html)
#'   - [CLIA Certificate Fee Schedule](https://www.cms.gov/files/document/clia-certificate-fee-schedule-updated-06/7/2024.pdf)
#'   - [CLIA Certification Guide](https://www.cms.gov/files/document/clia-cert-quick-start-guide.pdf)
#'
#' @param name `<chr>` Provider or clinical laboratory's name
#' @param ccn `<chr>` 10-character CLIA number
#' @param cert `<chr>` CLIA certificate type:
#'    - `"waiver"`
#'    - `"ppm"`
#'    - `"registration"`
#'    - `"compliance"`
#'    - `"accreditation"`
#' @param city `<chr>` City
#' @param state `<chr>` State
#' @param zip `<chr>` Zip code
#' @param active `<lgl>` Return only active providers#'
#' @returns A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examples
#' # Artic Envestigations Program Laboratory, Anchorage, AK
#' laboratories(ccn = "02D0873639")
#'
#' # Dengue Laboratory, San Juan, PR
#' laboratories(ccn = "40D0869394")
#'
#' # CDC/CGH/DGHA International Laboratory, Atlanta, GA
#' laboratories(ccn = "11D1061576")
#'
#' # Infectious Diseases Laboratory, Atlanta, GA
#' laboratories(ccn = "11D0668319")
#'
#' # National Center for Environmental Health, Division of Laboratory Science, Atlanta, GA
#' laboratories(ccn = "11D0668290")
#'
#' # Vector-Borne Diseases Laboratory, Fort Collins, CO
#' laboratories(ccn = "06D0880233")
#'
#' # Wiregrass Georgia Tech College Student Health Center, Valdosta, GA
#' laboratories(ccn = "11D2306220")
#'
#' laboratories(ccn = "11D0265516")
#'
#' laboratories(cert = "ppm", city = "Valdosta", state = "GA", active = TRUE)
#'
#' @autoglobal
#'
#' @export
laboratories <- function(
  name = NULL,
  ccn = NULL,
  cert = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  active = FALSE
) {
  args <- params(
    FAC_NAME = name,
    PRVDR_NUM = ccn,
    CRTFCT_TYPE_CD = cert_enum(cert),
    CITY_NAME = city,
    STATE_CD = state,
    ZIP_CD = zip,
    PGM_TRMNTN_CD = conv_active(active)
  )

  .c(BASE, LIMIT, NM) %=% constants("laboratories")

  # No Query: Warn & Return First 10 Rows =====================
  if (!length(args)) {
    cli_no_query()

    url <- url_(paste0(BASE, "?"), opts(size = 10))

    res <- request_bare(url) |>
      fastplyr::as_tbl() |>
      map_na_if() |>
      rename_(NM)

    return(res)
  }

  # Valid Query: Flatten & Request Result Count =====================
  url <- url_(
    paste0(BASE, "/stats?"),
    opts(size = LIMIT),
    query2(args)
  )

  N <- request_rows(url)

  # Query Returned Nothing: Alert & Exit =====================
  if (N == 0L) {
    cli_no_results()
    return(invisible(NULL))
  }

  # Count is Within API Limit: Request & Return Results
  if (N <= LIMIT) {
    cli_results(N)

    url <- url_(
      paste0(BASE, "?"),
      opts(size = LIMIT),
      query2(args)
    )

    res <- request_bare(url) |>
      fastplyr::as_tbl() |>
      map_na_if() |>
      rename_(NM)

    return(res)
  }

  # Count Above API Limit: Alert & Return Results =====================
  cli_pages(N, offset(N, LIMIT))

  url <- url_(
    paste0(BASE, "?"),
    opts(size = LIMIT, offset = "<<i>>"),
    query2(args)
  )

  urls <- offset(N, LIMIT, "seq") |>
    purrr::map_chr(\(x) {
      gsub(x = url, pattern = "<<i>>", replacement = x, fixed = TRUE)
    })

  parallel_request(urls) |>
    fastplyr::as_tbl() |>
    map_na_if() |>
    rename_(NM)
}


#' @noRd
conv_active <- function(active) {
  if (active) "00" else NULL
}

#' @noRd
cert_enum <- function(cert = NULL) {
  if (is.null(cert)) {
    return(NULL)
  }

  ENUM <- list(
    "compliance" = 1,
    "waiver" = 2,
    "accreditation" = 3,
    "ppm" = 4,
    "registration" = 9
  )

  cert <- rlang::arg_match(
    cert,
    rlang::names2(ENUM),
    multiple = TRUE
  )

  unlist_(ENUM[cert])
}

#' @autoglobal
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

#' @autoglobal
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

#' @autoglobal
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

#' @autoglobal
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

#' @autoglobal
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

#' @autoglobal
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
