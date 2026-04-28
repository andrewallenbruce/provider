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
#' @param chain_name `<chr>` facility type
#' @param stars `<int>` 1 - 5
#' @param network `<int>` 1 - 18
#' @param status `<enum>` Non-profit or profit
#' @param address,city,state,zip,county `<chr>` Individual provider's name
#' @param count `<lgl>` Return the total row count
#' @param set `<lgl>` Return the entire dataset
#'
#' @returns A [tibble][tibble::tibble-package]
#'
#' @examplesIf httr2::is_online()
#' esrd(count = TRUE)
#' esrd()
#' esrd(stars = 1)
#' esrd(network = 15:18)
#' @autoglobal
#' @export
esrd <- function(
  ccn = NULL,
  facility_name = NULL,
  chain_name = NULL,
  stars = NULL,
  network = NULL,
  address = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  county = NULL,
  status = NULL,
  count = FALSE,
  set = FALSE
) {
  check_count_set(count, set)
  check_numeric(stars)
  execute(
    base_prov(
      end = "esrd",
      count = count,
      set = set,
      arg = param_prov(
        cms_certification_number_ccn = ccn,
        network = network,
        facility_name = facility_name,
        five_star = convert_stars(stars),
        address_line_1 = address,
        citytown = city,
        state = state,
        zip_code = zip,
        countyparish = county,
        profit_or_nonprofit = status,
        chain_organization = chain_name
      )
    )
  )
}

#' @autoglobal
#' @noRd
convert_stars <- function(x = NULL) {
  if (is.null(x)) {
    return(NULL)
  }
  if (!all2(x %in% 1:5)) {
    cli::cli_abort("{.arg stars} must be a whole number between 1 and 5.")
  }

  names(set_names(1:5, paste0, ".0")[x])
}
