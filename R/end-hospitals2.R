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
#'    - `acute` = Acute Care
#'    - `cah` = Critical Access Hospital
#'    - `child` = Childrens' Hospital
#'    - `dod` = Acute Care - Department of Defense
#'    - `ltc` = Long-term
#'    - `psych` = Psychiatric
#'    - `reh` = Rural Emergency Hospital
#'    - `vha` = Acute Care - Veterans Administration
#' @param own_type `<enum>` Ownership type:
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
#' @param rating `<int>` Hospital rating; 1-5 or "Not Available"
#' @param count `<lgl>` Return the total row count
#' @param set `<lgl>` Return the entire dataset
#' @rdname hospitals
#' @export
hospitals2 <- function(
  ccn = NULL,
  org_name = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  county = NULL,
  hosp_type = NULL,
  own_type = NULL,
  rating = NULL,
  count = FALSE,
  set = FALSE
) {
  x <- pdc(
    count = count,
    set = set,
    facility_id = ccn,
    facility_name = org_name,
    citytown = city,
    state = state,
    zip_code = zip,
    countyparish = county,
    hospital_type = tag_enum(hosp_type),
    hospital_ownership = tag_enum(own_type),
    hospital_overall_rating = rating
  )

  x <- execute(x)

  polish(x)
}
