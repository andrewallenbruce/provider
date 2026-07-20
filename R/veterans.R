#' Veterans Health Administration Hospitals
#'
#' @description
#' A list of all VHA hospitals. The list includes addresses and phone numbers.
#'
#' @source
#'    * [API: Veterans Health Administration Provider Level Data](https://data.cms.gov/provider-data/dataset/uyx4-5s7f)
#'
#' @param ccn `<chr>` desc
#' @param name `<chr>` desc
#' @param rating `<int>` desc
#' @param city,state,zip,county `<chr>` desc
#' @param count `<lgl>` Return the total row count
#' @returns A [tibble][tibble::tibble-package] containing the search results.
#' @examplesIf httr2::is_online()
#' veteran(count = TRUE)
#' veteran(state = "GA")
#' @export
veteran <- function(
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
    hospital_overall_rating = rating
  )

  x <- execute(x)

  polish(x)
}
