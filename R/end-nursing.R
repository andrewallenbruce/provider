#' Nursing Homes
#'
#' @description General information on currently active nursing homes, including
#'   number of certified beds, quality measure scores, staffing and other
#'   information used in the Five-Star Rating System. Data are presented as one
#'   row per nursing home.
#'
#' @source
#'    * [API: Nursing Home Provider Information](https://data.cms.gov/provider-data/dataset/4pq5-n9py)
#'
#' @param ccn `<chr>` CMS Certification Number
#' @param name `<chr>` Provider Name
#' @param org_name `<chr>` Unique name identifying a group of nursing homes that
#'   share at least one individual or organizational owner, officer, or entity
#'   with operational/managerial control
#' @param org_dba `<chr>` Legal Business Name
#' @param city,state,zip,county `<chr>` desc
#' @param beds `<int>` Number of Federally Certified Beds
#' @param rating `<int>` Overall Rating (1-5)
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
