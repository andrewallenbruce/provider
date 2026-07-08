#' Ambulatory Surgical Centers
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
#' @param rating `<int>` desc
#' @param count `<lgl>` Return the total row count
#' @returns A [tibble][tibble::tibble-package] containing the search results.
#' @examplesIf httr2::is_online()
#' ambulatory(count = TRUE)
#' ambulatory(state = "GA")
#' @export
ambulatory <- function(
  ccn = NULL,
  name = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  county = NULL,
  rating = NULL,
  count = FALSE
) {
  x <- end_pdc(
    count = count,
    set = FALSE,
    facility_id = ccn,
    facility_name = name,
    citytown = city,
    state = state,
    zip_code = zip,
    countyparish = county,
    patients_rating_of_the_facility_linear_mean_score = rating
  )

  x <- execute(x)

  polish(x)
}
