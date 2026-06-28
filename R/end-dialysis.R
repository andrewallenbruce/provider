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
#' @param fac_name `<chr>` Facility name
#' @param org_name `<chr>` Name of the chain organization the facility is owned/managed by
#' @param rating `<int>` Facility's Quality of Care star rating; (1-5)
#' @param network `<int>` Numeric code for the network the facility participates in; (1-18)
#' @param status `<enum>` `Non-profit` or `Profit`
#' @param address,city,state,zip,county `<chr>` Facility's city, state, zip, county
#' @param count `<lgl>` Return the total row count
#' @returns A [tibble][tibble::tibble-package] containing the search results.
#' @examplesIf httr2::is_online()
#' dialysis(count = TRUE)
#' dialysis(org_name = "DaVita", state = "GA")
#' @export
dialysis <- function(
  ccn = NULL,
  fac_name = NULL,
  org_name = NULL,
  rating = NULL,
  network = NULL,
  status = NULL,
  address = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  county = NULL,
  count = FALSE
) {
  check_numeric(rating)
  check_numeric(network)

  x <- end_pdc(
    count = count,
    set = FALSE,
    cms_certification_number_ccn = ccn,
    facility_name = fac_name,
    chain_organization = org_name,
    five_star = tag_rating(rating),
    network = network,
    profit_or_nonprofit = status,
    address_line_1 = address,
    citytown = city,
    state = state,
    zip_code = zip,
    countyparish = county
  )

  x <- execute(x)

  polish(x)
}

#' @noRd
tag_rating <- function(x = NULL, call = rlang::caller_env()) {
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
  rlang::names2(rlang::set_names(1:5, paste0, ".0")[collapse::funique(x)])
}
