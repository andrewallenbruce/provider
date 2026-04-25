#' Provider-Facility Affiliations
#'
#' @description Access information concerning individual providers'
#'    affiliations with organizations/facilities.
#'
#' @source
#'    * [API: Physician Facility Affiliations](https://data.cms.gov/provider-data/dataset/27ea-46a8)
#'
#' @param npi `<int>` Individual National Provider Identifier
#' @param pac `<chr>` Individual PECOS Associate Control ID
#' @param first,middle,last,suffix `<chr>` Individual provider's name
#' @param facility_type `<enum>` facility type:
#'    - `esrd` = Dialysis facility
#'    - `hha` = Home health agency
#'    - `hospice` = Hospice
#'    - `hospital` = Hospital
#'    - `irf` = Inpatient rehabilitation facility
#'    - `ltch` = Long-term care hospital
#'    - `nurse` = Nursing home
#'    - `snf` = Skilled nursing facility
#' @param facility_ccn `<chr>` CCN of `facility_type` column's
#'    facility **or** of a **unit** within the hospital where the individual
#'    provider provides services.
#' @param parent_ccn `<int>` CCN of the **primary** hospital containing the
#'    unit where the individual provider provides services.
#' @param count `<lgl>` Return the total row count
#' @param set `<lgl>` Return the entire dataset
#'
#' @returns A [tibble][tibble::tibble-package]
#'
#' @examplesIf httr2::is_online()
#' affiliations(count = TRUE)
#' affiliations(count = TRUE, facility_ccn = 331302)
#' affiliations()
#' affiliations(parent_ccn = 331302)
#' affiliations(facility_ccn = 331302)
#' affiliations(first = "Andrew",
#'              last = contains("B"),
#'              facility_type = "hospital")
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
  count = FALSE,
  set = FALSE
) {
  check_count_set(count, set)
  check_char_(facility_type)
  execute(
    base_prov2(
      end = "affiliations",
      count = count,
      set = set,
      arg = param_prov(
        npi = npi,
        ind_pac_id = pac,
        provider_last_name = last,
        provider_first_name = first,
        provider_middle_name = middle,
        suff = suffix,
        facility_type = enum_(facility_type),
        facility_affiliations_certification_number = facility_ccn,
        facility_type_certification_number = parent_ccn
      )
    )
  )
}
