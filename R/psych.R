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
