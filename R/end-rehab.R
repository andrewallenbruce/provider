#' Inpatient Rehabilitation Facilities
#'
#' @description This dataset shows characteristics of the inpatient
#'   rehabilitation facilities that are shown on Inpatient Rehabilitation
#'   Facility Compare.
#'
#' @source
#'    * [API: Inpatient Rehabilitation Facility - General Information](https://data.cms.gov/provider-data/dataset/7t8x-u3ir)
#'
#' @param ccn `<chr>` desc
#' @param name `<chr>` desc
#' @param city,state,zip,county `<chr>` desc
#' @param count `<lgl>` Return the total row count
#' @returns A [tibble][tibble::tibble-package] containing the search results.
#' @examplesIf httr2::is_online()
#' rehab(count = TRUE)
#' rehab(state = "GA")
#' @export
rehab <- function(
  ccn = NULL,
  name = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  county = NULL,
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
    countyparish = county
  )

  x <- execute(x)

  polish(x)
}
