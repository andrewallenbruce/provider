#' Dialysis Facilities
#'
#' @description A list of all dialysis facilities registered with Medicare that
#'   includes addresses and phone numbers, as well as services and quality of
#'   care provided.
#'
#' @source
#'    * [API: Dialysis Facility - Listing by Facility](https://data.cms.gov/provider-data/dataset/23ew-n7w9)
#'
#' @param ccn `<chr>` Facility CMS Certification Number
#' @param facility_name `<chr>` Facility name
#' @param chain_name `<chr>` Name of the chain organization the facility is owned/managed by
#' @param rating `<int>` Facility's Quality of Care star rating (1 - 5)
#' @param network `<int>` Numeric code for the network the facility participates in (1 - 18)
#' @param status `<enum>` `Non-profit` or `profit`
#' @param address,city,state,zip,county `<chr>` Facility's city, state, zip, county
#' @param count `<lgl>` Return the total row count
#' @param set `<lgl>` Return the entire dataset
#'
#' @returns A [tibble][tibble::tibble-package]
#'
#' @examplesIf httr2::is_online()
#' esrd(count = TRUE)
#'
#' esrd()
#'
#' esrd(rating = 1)
#'
#' esrd(network = 15:18)
#'
#' @export
esrd <- function(
  ccn = NULL,
  facility_name = NULL,
  chain_name = NULL,
  rating = NULL,
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
  check_numeric(rating)
  check_numeric(network)

  x <- pdc(
    cms_certification_number_ccn = ccn,
    network = network,
    facility_name = facility_name,
    five_star = convert_rating(rating),
    address_line_1 = address,
    citytown = city,
    state = state,
    zip_code = zip,
    countyparish = county,
    profit_or_nonprofit = status,
    chain_organization = chain_name,
    .count = count,
    .set = set,
  )

  x <- execute(x)

  polish(x)
}

#' @noRd
convert_rating <- function(x = NULL, call = caller_env()) {
  if (is.null(x)) {
    return(NULL)
  }
  if (!any2(x %in% 1:5)) {
    cli::cli_abort(
      "{.arg rating} must be a whole number between 1 and 5.",
      call = call
    )
  }

  # TODO convert to tag_enum

  names2(set_names(1:5, paste0, ".0")[unique(x)])
}
