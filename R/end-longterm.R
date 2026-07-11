#' Long-Term Care Hospitals
#'
#' @description Access information concerning individual providers'
#'    affiliations with organizations/facilities.
#'
#' @source
#'    * [API: Physician Facility Affiliations](https://data.cms.gov/provider-data/dataset/27ea-46a8)
#'
#' @param ccn `<chr>` desc
#' @param name `<chr>` desc
#' @param city,state,zip,county `<chr>` desc
#' @param own_type description
#' @param beds `<int>` desc
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
