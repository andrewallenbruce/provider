#' Ambulatory Surgical Centers
#'
#' @description A list of ambulatory surgical center ratings for the Outpatient
#'   and Ambulatory Surgery Consumer Assessment of Healthcare Providers and
#'   Systems (OAS CAHPS) survey. The OAS CAHPS survey collects information about
#'   patients' experiences of care in hospital outpatient departments (HOPDs)
#'   and ambulatory surgical centers (ASCs). The data are updated and reported
#'   each quarter with data from the most recently completed quarter replacing
#'   the oldest quarter of data.
#'
#' @source
#'    * [API: OAS CAHPS Survey for Ambulatory Surgical Centers - Facility](https://data.cms.gov/provider-data/dataset/48nr-hqxx)
#'
#' @param ccn `<chr>` desc
#' @param name `<chr>` desc
#' @param city,state,zip `<chr>` desc
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
    patients_rating_of_the_facility_linear_mean_score = rating
  )

  x <- execute(x)

  polish(x)
}
