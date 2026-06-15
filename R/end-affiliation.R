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
#' @param first,last `<chr>` Individual provider's name
#' @param fac_type `<enum>` facility type:
#'    - `esrd` = Dialysis facility
#'    - `hha` = Home health agency
#'    - `hospice` = Hospice
#'    - `hospital` = Hospital
#'    - `irf` = Inpatient rehabilitation facility
#'    - `ltch` = Long-term care hospital
#'    - `nurse` = Nursing home
#'    - `snf` = Skilled nursing facility
#' @param fac_ccn `<chr>` CCN of `fac_type` column's
#'    facility **or** of a **unit** within the hospital where the individual
#'    provider provides services.
#' @param parent_ccn `<int>` CCN of the **primary** hospital containing the
#'    unit where the individual provider provides services.
#' @param count `<lgl>` Return the total row count
#' @returns A [tibble][tibble::tibble-package] containing the search results.
#' @examplesIf httr2::is_online()
#' affiliations(parent_ccn = 331302)
#' affiliations(fac_ccn = 331302)
#' @export
affiliations <- function(
  npi = NULL,
  pac = NULL,
  first = NULL,
  last = NULL,
  fac_type = NULL,
  fac_ccn = NULL,
  parent_ccn = NULL,
  count = FALSE
) {
  check_char_(fac_type)

  x <- pdc(
    count = count,
    set = FALSE,
    npi = npi,
    ind_pac_id = pac,
    provider_first_name = first,
    provider_last_name = last,
    facility_type = tag_enum(fac_type),
    facility_affiliations_certification_number = fac_ccn,
    facility_type_certification_number = parent_ccn
  )

  x <- execute(x)

  polish(x)
}
