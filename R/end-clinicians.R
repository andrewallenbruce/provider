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
#' @inheritParams provider_common_params
#' @param npi `<int>` National Provider Identifier
#' @param pac `<chr>` PECOS Associate Control ID
#' @param enid `<chr>` Medicare Enrollment ID
#' @param first,last `<chr>` Individual provider's name
#' @param gender `<enum>` Provider's gender; `"F"` (Female), `"M"` (Male), or `"U"` (Unknown)
#' @param credential `<chr>` Provider's credential, i.e. `"MD"`, `"OD"`
#' @param school `<chr>` Provider’s medical school
#' @param grad_year `<int>` Provider’s graduation year
#' @param specialty `<chr>` Provider’s primary medical specialty
#' @param city,state,zip `<chr>` Facility's city, state, zip
#' @param org_name `<chr>` Facility associated with Provider
#' @param org_pac `<chr>` Facility's PECOS Associate Control ID
#' @param members `<int>` Number of members in Organization
#' @examplesIf httr2::is_online()
#' clinicians(first = "Etan")
#' @export
clinicians <- function(
  npi = NULL,
  pac = NULL,
  enid = NULL,
  first = NULL,
  last = NULL,
  gender = NULL,
  credential = NULL,
  specialty = NULL,
  school = NULL,
  grad_year = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  org_name = NULL,
  org_pac = NULL,
  members = NULL,
  count = FALSE
) {
  check_char_(gender)

  x <- pdc(
    count = count,
    set = FALSE,
    npi = npi,
    ind_pac_id = pac,
    ind_enrl_id = enid,
    provider_first_name = first,
    provider_last_name = last,
    gndr = gender,
    cred = credential,
    med_sch = school,
    grd_yr = grad_year,
    pri_spec = specialty,
    facility_name = org_name,
    org_pac_id = org_pac,
    num_org_mem = members,
    citytown = city,
    state = state,
    zip_code = zip
  )

  x <- execute(x)

  polish(x)
}
