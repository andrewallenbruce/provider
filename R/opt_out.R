#' Search the Medicare Opt Out Affidavits API
#'
#' @description A list of practitioners who are currently opted out
#'    of Medicare.
#'
#' @details The Opt Out Affidavits dataset provides information on providers
#'    who have decided not to participate in Medicare. It contains the
#'    provider's NPI, specialty, address, and effective dates.
#'
#' ## Links
#' * [Medicare Opt Out Affidavits API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/opt-out-affidavits)
#'
#' @source Centers for Medicare & Medicaid Services
#' @note Update Frequency: **Monthly**
#'
#' @param first_name First Name of the Opt Out Provider
#' @param last_name Last Name of the Opt Out Provider
#' @param npi National Provider Identifier (NPI) number of the Opt Out Provider
#' @param specialty Specialty of the Opt Out Provider
#' @param address Provider's Street Address
#' @param city Provider's City
#' @param state Provider's State Abbreviation
#' @param zipcode Provider's Zip Code
#' @param eligible Flag indicating whether the Provider is eligible to
#'    Order and Refer
#' @param tidy Tidy output; default is `TRUE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examples
#' opt_out(specialty = "Psychiatry", zipcode = "07626")
#' opt_out(first = "David", last = "Smith")
#' opt_out(npi = 1114974490)
#' opt_out(state = "NY", eligible = "N")
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
#' age_days(date, optout_end_date, colname = "days_until_end") |>
#' age_days(last_updated, date, colname = "days_since_update") |>
#' age_days(optout_effective_date, date, colname = "days_since_optout") |>
#' dplyr::mutate(zip_code = purrr::map_chr(zip_code, format_zipcode)) |>
#' dplyr::mutate(address_full = full_address(.data, "first_line_street_address",
#' "second_line_street_address", "city_name", "state_code","zip_code"))
#' }
#' @autoglobal
#' @export

opt_out <- function(npi          = NULL,
                    first_name   = NULL,
                    last_name    = NULL,
                    specialty    = NULL,
                    address      = NULL,
                    city         = NULL,
                    state        = NULL,
                    zipcode      = NULL,
                    eligible     = NULL,
                    tidy         = TRUE) {
  # args tribble ------------------------------------------------------------
  args <- tibble::tribble(
                                ~x,           ~y,
                             "NPI",          npi,
                      "First Name",   first_name,
                       "Last Name",    last_name,
                       "Specialty",    specialty,
       "First Line Street Address",      address,
                       "City Name",         city,
                      "State Code",        state,
                        "Zip code",      zipcode,
     "Eligible to Order and Refer",     eligible)

  # map param_format and collapse -------------------------------------------
  params_args <- purrr::map2(args$x, args$y, param_format) |>
    unlist() |>
    stringr::str_c(collapse = "") |>
    param_space()

  # build URL ---------------------------------------------------------------
  http   <- "https://data.cms.gov/data-api/v1/dataset/"
  id     <- "9887a515-7552-4693-bf58-735c77af46d7"
  post   <- "/data.json?"
  url    <- paste0(http, id, post, params_args)

  # send request ----------------------------------------------------------
  response <- httr2::request(url) |> httr2::req_perform()

  # no search results returns empty tibble ----------------------------------
  if (httr2::resp_header(response, "content-length") == "0") {

    cli_args <- tibble::tribble(
      ~x,              ~y,
      "npi",           npi,
      "first_name",    first_name,
      "last_name",     last_name,
      "specialty",     specialty,
      "address",       address,
      "city",          city,
      "state",         state,
      "zipcode",       zipcode,
      "eligible",     eligible) |>
      tidyr::unnest(cols = c(y))

    cli_args <- purrr::map2(cli_args$x,
                            as.character(cli_args$y),
                            stringr::str_c,
                            sep = ": ",
                            collapse = "")

    cli::cli_alert_danger("No results for {.val {cli_args}}", wrap = TRUE)


    return(NULL)

  }

  # parse response ----------------------------------------------------------
  results <- tibble::tibble(httr2::resp_body_json(response,
            check_type = FALSE, simplifyVector = TRUE))

  # clean names -------------------------------------------------------------
  if (tidy) {
    results <- dplyr::rename_with(results, str_to_snakecase) |>
      dplyr::mutate(npi = as.character(npi),
                    dplyr::across(dplyr::contains("eligible"), yn_logical),
                    dplyr::across(dplyr::contains("date"), ~parsedate::parse_date(.)),
                    dplyr::across(dplyr::contains("date"), ~lubridate::ymd(.)),
                    dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., "")),
                    dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., "N/A")),
                    optout_duration = lubridate::as.duration(optout_end_date - optout_effective_date)) |>
      tidyr::unite("address",
                   dplyr::any_of(c("first_line_street_address",
                                   "second_line_street_address")),
                   remove = TRUE, na.rm = TRUE, sep = " ") |>
      dplyr::select(npi,
                    first_name,
                    last_name,
                    specialty,
                    optout_start_date = optout_effective_date,
                    optout_end_date,
                    optout_duration,
                    last_updated,
                    order_and_refer = eligible_to_order_and_refer,
                    address,
                    city = city_name,
                    state = state_code,
                    zipcode = zip_code)
    }
  return(results)
}
