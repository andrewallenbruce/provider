#' Long-Term Care Hospitals
#'
#' @description A list of long-term care hospitals with information such as
#'   address, phone number, ownership data and more.
#'
#' @source
#'    * [API: Long-Term Care Hospital - General Information](https://data.cms.gov/provider-data/dataset/azum-44iv)
#'
#' @param ccn `<chr>` The CMS Certification Number (CCN) is used to identify the facility listed
#' @param name `<chr>` Name of the facility
#' @param city,state,zip,county `<chr>` Facility’s city, state, zip, county
#' @param own_type Facility’s ownership type: For Profit, Non-profit, Government, Physician, Tribal
#' @param beds `<int>` The total number of beds in the facility
#' @param count `<lgl>` Return the total row count
#' @returns A [tibble][tibble::tibble-package] containing the search results.
#' @examplesIf httr2::is_online()
#' long_term(count = TRUE)
#' long_term(state = "GA")
#' @export
long_term <- function(
  ccn = NULL,
  name = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  county = NULL,
  own_type = NULL,
  beds = NULL,
  count = FALSE
) {
  x <- end_pdc(
    count = count,
    set = FALSE,
    cms_certification_number_ccn = ccn,
    provider_name = name,
    citytown = city,
    state = state,
    zip_code = zip,
    countyparish = county,
    ownership_type = own_type,
    total_number_of_beds = beds
  )

  x <- execute(x)

  polish(x)
}
