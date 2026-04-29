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
    base_prov(
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

#' Clinician Demographics
#'
#' @description
#' Demographics of clinicians listed in the Provider Data Catalog (PDC)
#'
#' @section Data Source:
#' The Doctors and Clinicians National Downloadable File is organized such that
#' each line is unique at the clinician/enrollment record/group/address level.
#'
#' Clinicians with multiple Medicare enrollment records and/or single enrollments
#' linking to multiple practice locations are listed on multiple lines.
#'
#' #### Inclusion Criteria
#' A Clinician or Group must have:
#'   - Current and approved Medicare enrollment record in PECOS
#'   - Valid physical practice location or address
#'   - Valid specialty
#'   - National Provider Identifier
#'   - One Medicare FFS claim within the last six months
#'   - Two approved clinicians reassigning their benefits to the group
#'
#' @source
#'   - [API: National Downloadable File](https://data.cms.gov/provider-data/dataset/mj5m-pzi6)
#'   - [Dictionary: Provider Data Catalog (PDC)](https://data.cms.gov/provider-data/sites/default/files/data_dictionaries/physician/DOC_Data_Dictionary.pdf)
#'   - [Source Information](https://data.cms.gov/provider-data/topics/doctors-clinicians/data-sources)
#'
#' @param npi `<int>` National Provider Identifier
#' @param pac `<chr>` PECOS Associate Control ID
#' @param enid `<chr>` Medicare Enrollment ID
#' @param first,middle,last,suffix `<chr>` Individual provider's name
#' @param gender `<enum>` Provider's gender; `"F"` (Female), `"M"` (Male), or `"U"` (Unknown)
#' @param credential `<chr>` Provider's credential, i.e. `"MD"`, `"OD"`
#' @param school `<chr>` Provider’s medical school
#' @param grad_year `<int>` Provider’s graduation year
#' @param specialty `<chr>` Provider’s primary medical specialty
#' @param org_city,org_state,org_zip `<chr>` Facility's city, state, zip
#' @param org_name `<chr>` Facility associated with Provider
#' @param org_pac `<chr>` Facility's PECOS Associate Control ID
#' @param count `<lgl>` Return the total row count
#' @param set `<lgl>` Return the entire dataset
#'
#' @returns A [tibble][tibble::tibble-package]
#'
#' @examplesIf httr2::is_online()
#' clinicians(count = TRUE, org_name = not_blank())
#'
#' clinicians(enid = "I20081002000549")
#'
#' clinicians(first = "Etan")
#'
#' @export
clinicians <- function(
  npi = NULL,
  pac = NULL,
  enid = NULL,
  first = NULL,
  middle = NULL,
  last = NULL,
  suffix = NULL,
  gender = NULL,
  credential = NULL,
  specialty = NULL,
  school = NULL,
  grad_year = NULL,
  org_city = NULL,
  org_state = NULL,
  org_zip = NULL,
  org_name = NULL,
  org_pac = NULL,
  count = FALSE,
  set = FALSE
) {
  check_count_set(count, set)
  check_char_(gender)
  execute(
    base_prov(
      end = "clinicians",
      count = count,
      set = set,
      arg = param_prov(
        npi = npi,
        ind_pac_id = pac,
        ind_enrl_id = enid,
        provider_last_name = last,
        provider_first_name = first,
        provider_middle_name = middle,
        suff = suffix,
        gndr = gender,
        cred = credential,
        med_sch = school,
        grd_yr = grad_year,
        pri_spec = specialty,
        facility_name = org_name,
        org_pac_id = org_pac,
        citytown = org_city,
        state = org_state,
        zip_code = org_zip
      )
    )
  )
}

#' Dialysis Facilities
#'
#' @description Access information concerning individual providers'
#'    affiliations with organizations/facilities.
#'
#' @source
#'    * [API: Physician Facility Affiliations](https://data.cms.gov/provider-data/dataset/27ea-46a8)
#'
#' @param ccn `<chr>` Individual National Provider Identifier
#' @param facility_name `<chr>` facility type
#' @param chain_name `<chr>` facility type
#' @param stars `<int>` 1 - 5
#' @param network `<int>` 1 - 18
#' @param status `<enum>` Non-profit or profit
#' @param address,city,state,zip,county `<chr>` Individual provider's name
#' @param count `<lgl>` Return the total row count
#' @param set `<lgl>` Return the entire dataset
#'
#' @returns A [tibble][tibble::tibble-package]
#'
#' @examplesIf httr2::is_online()
#' esrd(count = TRUE)
#' esrd()
#' esrd(stars = 1)
#' esrd(network = 15:18)
#' @autoglobal
#' @export
esrd <- function(
  ccn = NULL,
  facility_name = NULL,
  chain_name = NULL,
  stars = NULL,
  network = NULL,
  address = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  county = NULL,
  status = NULL,
  count = FALSE,
  set = FALSE
) {
  check_count_set(count, set)
  check_numeric(stars)
  execute(
    base_prov(
      end = "esrd",
      count = count,
      set = set,
      arg = param_prov(
        cms_certification_number_ccn = ccn,
        network = network,
        facility_name = facility_name,
        five_star = convert_stars(stars),
        address_line_1 = address,
        citytown = city,
        state = state,
        zip_code = zip,
        countyparish = county,
        profit_or_nonprofit = status,
        chain_organization = chain_name
      )
    )
  )
}

#' @autoglobal
#' @noRd
convert_stars <- function(x = NULL) {
  if (is.null(x)) {
    return(NULL)
  }
  if (!all2(x %in% 1:5)) {
    cli::cli_abort("{.arg stars} must be a whole number between 1 and 5.")
  }

  names(set_names(1:5, paste0, ".0")[x])
}
