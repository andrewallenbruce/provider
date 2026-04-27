#' Hospital General Information
#'
#' @description A list of all hospitals that have been registered with Medicare.
#'   The list includes addresses, phone numbers, hospital type, and overall
#'   hospital rating.
#'
#' @source
#'    * [API: Hospital General Information](https://data.cms.gov/provider-data/dataset/27ea-46a8)
#'    * [API: Data Dictionary](https://data.cms.gov/provider-data/dataset/xubh-q36u#data-dictionary)
#'
#' @param county `<chr>` Location county
#' @param hosp_type `<enum>` Provider type:
#'    - `acute` = Acute Care Hospitals
#'    - `cah` = Critical Access Hospitals
#'    - `child` = Children's
#'    - `dod` = Acute Care - Department of Defense
#'    - `ltc` = Long-term
#'    - `psych` = Psychiatric
#'    - `reh` = Rural Emergency Hospital
#'    - `vha` = Acute Care - Veterans Administration
#' @param ownership `<enum>` Ownership type:
#'    - `private` = Voluntary non-profit - Private
#'    - `other` = Voluntary non-profit - Other
#'    - `church` = Voluntary non-profit - Church
#'    - `district` = Government - Hospital District or Authority
#'    - `local` = Government - Local
#'    - `federal` = Government - Federal
#'    - `state` = Government - State
#'    - `dod` = Department of Defense
#'    - `profit` = Proprietary
#'    - `physician` = Physician
#'    - `tribal` = Tribal
#'    - `vha` = Veterans Health Administration
#' @param rating `<num>` Hospital rating; 1-5 or "Not Available"
#' @param count `<lgl>` Return the total row count
#' @param set `<lgl>` Return the entire dataset
#'
#' @rdname hospitals
#'
#' @autoglobal
#' @export
hospitals2 <- function(
  ccn = NULL,
  org_name = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  county = NULL,
  hosp_type = NULL,
  ownership = NULL,
  rating = NULL,
  count = FALSE,
  set = FALSE
) {
  check_count_set(count, set)
  execute(
    base_prov(
      end = eval_bare(END_EXP),
      count = count,
      set = set,
      arg = param_prov(
        facility_id = ccn,
        facility_name = org_name,
        citytown = city,
        state = state,
        zip_code = zip,
        countyparish = county,
        hospital_type = enum_(hosp_type),
        hospital_ownership = enum_(ownership),
        hospital_overall_rating = rating
      )
    )
  )
}
