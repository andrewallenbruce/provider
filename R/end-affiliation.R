#' Provider-Facility Affiliations
#'
#' @description Access information concerning individual providers'
#'    affiliations with organizations/facilities.
#'
#' @source
#'    * [API: Physician Facility Affiliations](https://data.cms.gov/provider-data/dataset/27ea-46a8)
#'
#' @inheritParams provider_common_params
#' @param npi `<int>` Individual National Provider Identifier
#' @param pac `<chr>` Individual PECOS Associate Control ID
#' @param first,last `<chr>` Individual provider's name
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
#' @returns A [tibble][tibble::tibble-package]
#' @examplesIf httr2::is_online()
#' affiliations(parent_ccn = 331302)
#' affiliations(facility_ccn = 331302)
#' @export
affiliations <- function(
  npi = NULL,
  pac = NULL,
  first = NULL,
  last = NULL,
  facility_type = NULL,
  facility_ccn = NULL,
  parent_ccn = NULL,
  count = FALSE
) {
  check_char_(facility_type)

  x <- pdc(
    count = count,
    set = FALSE,
    npi = npi,
    ind_pac_id = pac,
    provider_first_name = first,
    provider_last_name = last,
    facility_type = tag_enum(facility_type),
    facility_affiliations_certification_number = facility_ccn,
    facility_type_certification_number = parent_ccn
  )

  x <- execute(x)

  polish(x)
}
