#' Ambulatory Surgical Centers
#'
#' @description A list of ambulatory surgical center ratings for the Outpatient
#'   and Ambulatory Surgery Consumer Assessment of Healthcare Providers and
#'   Systems (OAS CAHPS) survey. The OAS CAHPS survey collects information about
#'   patients' experiences of care in hospital outpatient departments (HOPDs)
#'   and ambulatory surgical centers (ASCs). The data are updated and reported
#'   each quarter with data from the most recently completed quarter replacing
#'   the oldest quarter of data.
#'
#' @source
#'    * [API: OAS CAHPS Survey for Ambulatory Surgical Centers - Facility](https://data.cms.gov/provider-data/dataset/48nr-hqxx)
#'
#' @param ccn `<chr>` desc
#' @param name `<chr>` desc
#' @param city,state,zip,county `<chr>` desc
#' @param rating `<int>` desc
#' @param count `<lgl>` Return the total row count
#' @returns A [tibble][tibble::tibble-package] containing the search results.
#' @examplesIf httr2::is_online()
#' ambulatory(count = TRUE)
#' ambulatory(state = "GA")
#' @export
ambulatory <- function(
  ccn = NULL,
  name = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  county = NULL,
  rating = NULL,
  count = FALSE
) {
  x <- end_pdc(
    count = count,
    set = FALSE,
    facility_id = ccn,
    facility_name = name,
    citytown = city,
    state = state,
    zip_code = zip,
    countyparish = county,
    patients_rating_of_the_facility_linear_mean_score = rating
  )

  x <- execute(x)

  polish(x)
}

#' Inpatient Psychiatric Facilities
#'
#' @description This dataset includes provider-level data for quality measures
#'   included under the IPFQR program, including HBIPS, SUB, TOB, Transition
#'   Record (TR), Screening for Metabolic Disorders (SMD), FAPH, IMM,
#'   Readmissions (READM), and Medication Continuation (MedCont, formerly known
#'   as MedCoPsy). Psychiatric facilities that are eligible for the Inpatient
#'   Psychiatric Facility Quality Reporting (IPFQR) program are required to meet
#'   all program requirements, otherwise their Medicare payments may be reduced.
#'
#' @source
#'    * [API: Inpatient Psychiatric Facility Quality Measure Data - by Facility](https://data.cms.gov/provider-data/dataset/q9vs-r7wp)
#'
#' @param ccn `<chr>` desc
#' @param name `<chr>` desc
#' @param city,state,zip,county `<chr>` desc
#' @param count `<lgl>` Return the total row count
#' @returns A [tibble][tibble::tibble-package] containing the search results.
#' @examplesIf httr2::is_online()
#' psych(count = TRUE)
#' psych(state = "GA")
#' @export
psych <- function(
  ccn = NULL,
  name = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  county = NULL,
  rating = NULL,
  count = FALSE
) {
  x <- end_pdc(
    count = count,
    set = FALSE,
    facility_id = ccn,
    facility_name = name,
    citytown = city,
    state = state,
    zip_code = zip,
    countyparish = county
  )

  x <- execute(x)

  polish(x)
}

#' Inpatient Rehabilitation Facilities
#'
#' @description This dataset shows characteristics of the inpatient
#'   rehabilitation facilities that are shown on Inpatient Rehabilitation
#'   Facility Compare.
#'
#' @source
#'    * [API: Inpatient Rehabilitation Facility - General Information](https://data.cms.gov/provider-data/dataset/7t8x-u3ir)
#'
#' @param ccn `<chr>` desc
#' @param name `<chr>` desc
#' @param city,state,zip,county `<chr>` desc
#' @param count `<lgl>` Return the total row count
#' @returns A [tibble][tibble::tibble-package] containing the search results.
#' @examplesIf httr2::is_online()
#' rehab(count = TRUE)
#' rehab(state = "GA")
#' @export
rehab <- function(
  ccn = NULL,
  name = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  county = NULL,
  count = FALSE
) {
  x <- end_pdc(
    count = count,
    set = FALSE,
    cms_certification_number_ccn = ccn,
    provider_name = name,
    citytown = city,
    state = state,
    zip_code = zip,
    countyparish = county
  )

  x <- execute(x)

  polish(x)
}

#' Veterans Health Administration Hospitals
#'
#' @description
#' A list of all VHA hospitals. The list includes addresses and phone numbers.
#'
#' @source
#'    * [API: Veterans Health Administration Provider Level Data](https://data.cms.gov/provider-data/dataset/uyx4-5s7f)
#'
#' @param ccn `<chr>` desc
#' @param name `<chr>` desc
#' @param rating `<int>` desc
#' @param city,state,zip,county `<chr>` desc
#' @param count `<lgl>` Return the total row count
#' @returns A [tibble][tibble::tibble-package] containing the search results.
#' @examplesIf httr2::is_online()
#' veteran(count = TRUE)
#' veteran(state = "GA")
#' @export
veteran <- function(
  ccn = NULL,
  name = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  county = NULL,
  rating = NULL,
  count = FALSE
) {
  x <- end_pdc(
    count = count,
    set = FALSE,
    facility_id = ccn,
    facility_name = name,
    citytown = city,
    state = state,
    zip_code = zip,
    countyparish = county,
    hospital_overall_rating = rating
  )

  x <- execute(x)

  polish(x)
}
