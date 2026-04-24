#' Hospitals 2
#'
#' @param county `<chr>` Location county
#' @param hosp_type `<enum>` Provider type;
#'    - `acute` = Acute Care Hospitals
#'    - `cah` = Critical Access Hospitals
#'    - `child` = Children's
#'    - `dod` = Acute Care - Department of Defense
#'    - `ltc` = Long-term
#'    - `psych` = Psychiatric
#'    - `reh` = Rural Emergency Hospital
#'    - `vha` = Acute Care - Veterans Administration
#' @param ownership `<enum>` Provider type;
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
  exec_prov(
    COUNT = count,
    SET = set,
    ARG = param_prov(
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
}
