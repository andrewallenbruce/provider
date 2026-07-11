#' Nursing Homes
#'
#' @description Access information concerning individual providers'
#'    affiliations with organizations/facilities.
#'
#' @source
#'    * [API: Physician Facility Affiliations](https://data.cms.gov/provider-data/dataset/27ea-46a8)
#'
#' @param ccn `<chr>` provider identifier
#' @param name `<chr>` description
#' @param org_name `<chr>` desc
#' @param org_dba `<chr>` desc
#' @param city,state,zip,county `<chr>` desc
#' @param beds `<int>` description
#' @param rating `<int>` description
#' @param count `<lgl>` Return the total row count
#' @returns A [tibble][tibble::tibble-package] containing the search results.
#' @examplesIf httr2::is_online()
#' nursing(count = TRUE)
#' nursing(state = "GA")
#' @export
nursing <- function(
  ccn = NULL,
  name = NULL,
  org_dba = NULL,
  org_name = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  county = NULL,
  beds = NULL,
  rating = NULL,
  count = FALSE
) {
  x <- end_pdc(
    count = count,
    set = FALSE,
    cms_certification_number_ccn = ccn,
    provider_name = name,
    chain_name = org_name,
    legal_business_name = org_dba,
    number_of_certified_beds = beds,
    overall_rating = rating,
    citytown = city,
    state = state,
    zip_code = zip,
    countyparish = county
  )

  x <- execute(x)

  polish(x)
}
