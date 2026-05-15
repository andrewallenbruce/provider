#' @param specialty_code `<chr>`
#'
#' Medicare Part A Provider specialty code:
#'
#' + `"00-00"`: Religious Non-Medical Healthcare Institution (RNHCI)
#' + `"00-01"`: Community Mental Health Center
#' + `"00-02"`: Comprehensive Outpatient Rehabilitation Facility (CORF)
#' + `"00-03"`: End-Stage Renal Disease Facility (ESRD)
#' + `"00-04"`: Federally Qualified Health Center (FQHC)
#' + `"00-05"`: Histocompatibility Laboratory
#' + `"00-06"`: Home Health Agency (HHA)
#' + `"00-08"`: Hospice
#' + `"00-09"`: Hospital
#' + `"00-10"`: Indian Health Services Facility
#' + `"00-13"`: Organ Procurement Organization (OPO)
#' + `"00-14"`: Outpatient PT/Occupational Therapy/Speech Pathology
#' + `"00-17"`: Rural Health Clinic (RHC)
#' + `"00-18"`: Skilled Nursing Facility (SNF)
#' + `"00-19"`: Other
#' + `"00-24"`: Rural Emergency Hospital (REH)
#' + `"00-85"`: Critical Access Hospital (CAH)
#'
#' @returns A [tibble][tibble::tibble-package] with the columns:
#'
#' |**Field**           |**Description**                                                |
#' |:-------------------|:--------------------------------------------------------------|
#' |`npi`               |Hospital's 10-digit National Provider Identifier               |
#' |`pac_org`           |Hospital’s 10-digit PECOS Associate Control ID                 |
#' |`enid_org`          |Hospital’s 15-digit Enrollment ID                              |
#' |`enid_state`        |Hospital’s Enrollment State                                    |
#' |`facility_ccn`      |Hospital’s CMS Certification Number                            |
#' |`organization`      |Hospital’s Legal Business Name                                 |
#' |`doing_business_as` |Hospital’s Doing-Business-As Name                              |
#' |`specialty_code`    |Hospital’s Medicare Part A Provider Specialty Code             |
#' |`specialty`         |Specialty Code Description                                     |
#' |`incorp_date`       |Date the Business was Incorporated                             |
#' |`incorp_state`      |State in which the Business was Incorporated                   |
#' |`structure`         |Hospital’s Organization Structure Type                         |
#' |`address`           |Hospital’s Practice Location Address                           |
#' |`city`              |Hospital’s Practice Location City                              |
#' |`state`             |Hospital’s Practice Location State                             |
#' |`zip`               |Hospital’s Practice Location Zip Code                          |
#' |`location_type`     |Practice Location Type                                         |
#' |`multi_npi`         |Indicates Hospital has more than one NPI                       |
#' |`reh_date`          |Date the Hospital/CAH converted to an REH                      |
#' |`reh_ccns`          |CCNs associated with the Hospital/CAH that converted to an REH |
#' |`registration`      |Hospital’s IRS Registration Status                             |
#' |`subgroup`          |Hospital's Subgroup/Unit Designations, REH Conversion Status   |
#' |`other`             |If `subgroup` is `"Other"`, description of Subgroup/Unit       |
#'
#' @examplesIf interactive()
#' hospitals(pac_org = 6103733050)
#'
#' hospitals(state = "GA", reh = TRUE)
#'
#' hospitals(city = "Savannah", state = "GA")
#'
#' hospitals(city = "Savannah",
#'           state = "GA",
#'           subgroup = list(acute = FALSE))
#'
#' hospitals(city = "Savannah",
#'           state = "GA",
#'           subgroup = list(
#'           gen = TRUE,
#'           rehab = FALSE))
