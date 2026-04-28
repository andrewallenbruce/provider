#' Dialysis Facilities
#'
#' @description Access information concerning individual providers'
#'    affiliations with organizations/facilities.
#'
#' @source
#'    * [API: Physician Facility Affiliations](https://data.cms.gov/provider-data/dataset/27ea-46a8)
#'
#' @param ccn `<chr>` Individual National Provider Identifier
#' @param facility_name `<chr>` facility type
#' @param stars `<int>` 1 - 5
#' @param network `<int>` 1 - 18
#' @param status `<enum>` Non-profit/profit
#' @param chain_owned `<lgl>` CCN of the **primary** hospital containing
#' @param chain_name `<chr>` facility type
#' @param address,city,state,zip,county `<chr>` Individual provider's name
#' @param count `<lgl>` Return the total row count
#' @param set `<lgl>` Return the entire dataset
#'
#' @returns A [tibble][tibble::tibble-package]
#'
#' @examplesIf httr2::is_online()
#' esrd(count = TRUE)
#' esrd()
#' esrd(stars = "1.0")
#' esrd(network = 18)
#' @autoglobal
#' @export
esrd <- function(
  ccn = NULL,
  facility_name = NULL,
  stars = NULL,
  network = NULL,
  address = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  county = NULL,
  status = NULL,
  chain_owned = NULL,
  chain_name = NULL,
  count = FALSE,
  set = FALSE
) {
  check_count_set(count, set)
  execute(
    base_prov(
      end = "esrd",
      count = count,
      set = set,
      arg = param_prov(
        cms_certification_number_ccn = ccn,
        network = network,
        facility_name = facility_name,
        five_star = stars,
        address_line_1 = address,
        citytown = city,
        state = state,
        zip_code = zip,
        countyparish = county,
        profit_or_nonprofit = status,
        chain_owned = chain_owned,
        chain_organization = chain_name
      )
    )
  )
}
