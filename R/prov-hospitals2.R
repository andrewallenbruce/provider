#' Hospitals 2
#'
#' @inheritParams hospitals
#' @param county `<chr>`
#' @param hosp_type `<chr>`
#' @param ownership `<chr>`
#' @keywords internal
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
  count = FALSE
) {
  exec_prov2(
    COUNT = count,
    ARG = param_prov(
      facility_id = ccn,
      facility_name = org_name,
      citytown = city,
      state = state,
      zip_code = zip,
      countyparish = county,
      hospital_type = hosp_type,
      hospital_ownership = ownership
    )
  )
}
