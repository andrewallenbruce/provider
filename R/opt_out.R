#' Search the Medicare Opt Out Affidavits API
#'
#' @description A list of practitioners who are currently opted out
#'    of Medicare.
#'
#' @details The Opt Out Affidavits dataset provides information on providers
#'    who have decided not to participate in Medicare. It contains the
#'    provider's NPI, specialty, address, and effective dates.
#'
#' ## Data Update Frequency
#' Monthly
#'
#' ## Data Source
#' Centers for Medicare & Medicaid Services
#'
#' ## Links
#' * [Medicare Opt Out Affidavits API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/opt-out-affidavits)
#'
#' @param first First Name of the Opt Out Provider
#' @param last Last Name of the Opt Out Provider
#' @param npi National Provider Identifier (NPI) number of the Opt Out Provider
#' @param specialty Specialty of the Opt Out Provider
#' @param date_start Date from which the Provider's Opt Out Status is
#'    effective
#' @param date_end Date on which the Provider's Opt Out Status ends
#' @param address Provider's Street Address
#' @param city Provider's City
#' @param state_abb Provider's State Abbreviation
#' @param zip Provider's Zip Code
#' @param eligible Flag indicating whether the Provider is eligible to
#'    Order and Refer
#' @param clean_names Clean column names with {janitor}'s
#'    `clean_names()` function; default is `TRUE`.
#' @param lowercase Convert column names to lowercase; default is `TRUE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examples
#' opt_out(specialty = "Psychiatry", zip = "07626")
#' opt_out(first = "David", last = "Smith")
#' opt_out(npi = 1114974490)
#' opt_out(state_abb = "NY", eligible = "N")
#' opt_out(date_start = "01/30/1998", date_end = "01/30/2024")
#' opt_out(city = "Los Angeles", address = "9201 W SUNSET BLVD")
#' \dontrun{
#' # Returns empty list i.e., provider is not in the database
#' opt_out(npi = 1326011057)
#'
#' # Example of possible data cleaning
#' psych <- opt_out(specialty = "Psychiatry")
#'
#' psych |>
#' dplyr::mutate(last_updated = as.Date(parsedate::parse_date(last_updated)),
#' optout_effective_date = as.Date(parsedate::parse_date(optout_effective_date)),
#' optout_end_date = as.Date(parsedate::parse_date(optout_end_date))) |>
#'               age_days(date, optout_end_date, colname = "days_until_end") |>
#'               age_days(last_updated, date, colname = "days_since_update") |>
#'               age_days(optout_effective_date, date, colname = "days_since_optout") |>
#' dplyr::mutate(zip_code = purrr::map_chr(zip_code, format_zipcode)) |>
#' dplyr::mutate(address_full = full_address(.data, "first_line_street_address",
#' "second_line_street_address", "city_name", "state_code","zip_code"))
#' }
#' @autoglobal
#' @export

opt_out <- function(first        = NULL,
                    last         = NULL,
                    npi          = NULL,
                    specialty    = NULL,
                    date_start   = NULL,
                    date_end     = NULL,
                    address      = NULL,
                    city         = NULL,
                    state_abb    = NULL,
                    zip          = NULL,
                    eligible     = NULL,
                    clean_names  = TRUE,
                    lowercase    = TRUE) {
  # args tribble ------------------------------------------------------------
  args <- tibble::tribble(
                                ~x,           ~y,
                      "First Name",        first,
                       "Last Name",         last,
                             "NPI",          npi,
                       "Specialty",    specialty,
           "Optout Effective Date",   date_start,
                 "Optout End Date",     date_end,
       "First Line Street Address",      address,
                       "City Name",         city,
                      "State Code",    state_abb,
                        "Zip code",          zip,
     "Eligible to Order and Refer",     eligible)

  # map param_format and collapse -------------------------------------------
  params_args <- purrr::map2(args$x, args$y, param_format) |> unlist() |>
    stringr::str_c(collapse = "") |> param_space()

  # build URL ---------------------------------------------------------------
  http   <- "https://data.cms.gov/data-api/v1/dataset/"
  id     <- "9887a515-7552-4693-bf58-735c77af46d7"
  post   <- "/data.json?"
  url    <- paste0(http, id, post, params_args)

  # send request ----------------------------------------------------------
  resp <- httr2::request(url) |> httr2::req_perform()

  # parse response ----------------------------------------------------------
  results <- tibble::tibble(httr2::resp_body_json(resp,
            check_type = FALSE, simplifyVector = TRUE)) |>
    dplyr::mutate(Date = as.Date(httr2::resp_date(resp)),
                  NPI = as.character(NPI)) |>
    dplyr::relocate(Date, "Last updated")

  # clean names -------------------------------------------------------------
  if (isTRUE(clean_names)) {results <- janitor::clean_names(results)}
  # lowercase ---------------------------------------------------------------
  if (isTRUE(lowercase)) {results <- dplyr::rename_with(results, tolower)}

  return(results)
}
