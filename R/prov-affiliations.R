#' Provider-Facility Affiliations
#'
#' @description Access information concerning individual providers'
#'    affiliations with organizations/facilities.
#'
#' @references
#'    * [API: Physician Facility Affiliations](https://data.cms.gov/provider-data/dataset/27ea-46a8)
#'    * [Certification Number (CCN) State Codes](https://www.cms.gov/Medicare/Provider-Enrollment-and-Certification/SurveyCertificationGenInfo/Downloads/Survey-and-Cert-Letter-16-09.pdf)
#'
#' @param npi `<int>` Individual National Provider Identifier
#' @param pac `<chr>` Individual PECOS Associate Control ID
#' @param first,middle,last,suffix `<chr>` Individual provider's name
#' @param facility_type `<chr>` facility type abbreviation
#' @param facility_ccn `<chr>` CCN of `facility_type` column's
#'    facility **or** of a **unit** within the hospital where the individual
#'    provider provides services.
#' @param parent_ccn `<int>` CCN of the **primary** hospital containing the
#'    unit where the individual provider provides services.
#' @param count `<lgl>` Return the dataset's total row count
#' @returns A [tibble][tibble::tibble-package]
#' @examplesIf httr2::is_online()
#' affiliations(count = TRUE)
#' affiliations()
#' affiliations(first = "")
#' affiliations(facility_ccn = "33Z302")
#' affiliations(parent_ccn = 331302)
#' affiliations(facility_ccn = 331302)
#' @autoglobal
#' @export
affiliations <- function(
  npi = NULL,
  pac = NULL,
  first = NULL,
  middle = NULL,
  last = NULL,
  suffix = NULL,
  facility_type = NULL,
  facility_ccn = NULL,
  parent_ccn = NULL,
  count = FALSE
) {
  END <- rlang::call_name(rlang::call_match())

  .c(BASE, LIMIT, NM) %=% constants(END)

  exec_prov(
    END,
    ARG = params(
      npi = npi,
      ind_pac_id = pac,
      provider_last_name = last,
      provider_first_name = first,
      provider_middle_name = middle,
      suff = suffix,
      facility_type = enum_(facility_type),
      facility_affiliations_certification_number = facility_ccn,
      facility_type_certification_number = parent_ccn
    ),
    BASE = BASE,
    LIMIT = LIMIT,
    NM = NM,
    COUNT = count
  )
}
