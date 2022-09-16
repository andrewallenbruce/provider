#' Search the NPPES NPI Public Registry
#'
#' @description The NPPES NPI Registry Public Search is a
#'    free directory of all active National Provider Identifier
#'    (NPI) records. Healthcare providers acquire their unique
#'    10-digit NPIs to identify themselves in a standard way
#'    throughout their industry. After CMS supplies an NPI,
#'    they publish the parts of the NPI record that have public
#'    relevance, including the provider’s name, taxonomy and
#'    practice address. It enables you to search for providers
#'    in the NPPES (National Plan and Provider Enumeration System.)
#'    All information produced by the NPI Registry is provided in
#'    accordance with the NPPES Data Dissemination Notice.
#'    There is no charge to use the NPI Registry.
#'
#' @param npi 10-digit National Provider Identifier (NPI)
#' @param first Provider's first name
#' @param last Provider's last name
#' @param city City in which provider practices
#' @param state_abbr Abbreviation of state in which provider practices
#' @param limit Maximum number of results to return, default is 10
#' @param skip Number of results to skip after searching the previous,
#'    say, 200 examples
#'
#' @return A tibble containing the date-time the search was performed
#'    and a list-column of the results.
#'
#' @references
#'    \url{https://npiregistry.cms.hhs.gov/api-page}
#'
#' @examples
#' \dontrun{
#' provider_nppes(1528060837)
#'
#' provider_nppes(city = "Atlanta", state_abbr = "GA")
#'
#' provider_nppes(first = "John", city = "Baltimore", state_abbr = "MD")
#' }
#' @export

provider_nppes <- function(npi = NULL,
                           first = NULL,
                           last = NULL,
                           city = NULL,
                           state_abbr = NULL,
                           limit = 10,
                           skip = NULL) {

  # Check internet connection
  attempt::stop_if_not(curl::has_internet() == TRUE,
    msg = "Please check your internet connection.")

  if (!is.null(npi)) {

    # Strip any spaces
    npi <- gsub(pattern = " ", replacement = "", npi)

    # Number of characters should be 10
    attempt::stop_if_not(nchar(npi) == 10,
      msg = c("NPIs must have 10 digits. Provided NPI has ",
              nchar(npi),
              " digits."))

    # Luhn check
    attempt::stop_if_not(
      provider::prov_npi_luhn(npi) == TRUE,
      msg = "Luhn Check: NPI may be invalid.")

  }

  # Limit must be between 1 and 1200
  attempt::stop_if_not(limit > 1 || limit < 1200,
    msg = "Limit must be between 1 and 1200.")

  # Strip any spaces
  first <- gsub(pattern = " ", replacement = "", first)
  last <- gsub(pattern = " ", replacement = "", last)
  city <- gsub(pattern = " ", replacement = "", city)
  state_abbr <- gsub(pattern = " ", replacement = "", state_abbr)

  # NPPES Base URL
  nppes_base_url <- "https://npiregistry.cms.hhs.gov/api/?version=2.1"

  # Create polite version
  polite_req <- polite::politely(
    httr2::request,
    verbose = FALSE,
    delay = 2)

  # Create request
  req <- polite_req(nppes_base_url)

  # Send and save response
  resp <- req |>
    httr2::req_url_query(number = npi,
                         first_name = first,
                         last_name = last,
                         city = city,
                         state = state_abbr,
                         limit = limit,
                         skip = skip) |>
    httr2::req_throttle(50 / 60) |>
    httr2::req_perform()

  # Save time of API query
  datetime <- resp |> httr2::resp_date()

  # Parse JSON response and save results
  results <- resp |> httr2::resp_body_json(
    check_type = FALSE,
    simplifyVector = TRUE)

  # Remove result_count header
  results$result_count <- NULL

  # Convert to tibble
  results <- results |>
    tibble::enframe(
      name = "outcome",
      value = "data_lists")

  # Append time of API query to results
  results$datetime <- datetime

  # Move columns to beginning
  results <- results |>
    dplyr::relocate(datetime)

  # Filter out resultCount rows
  results <- results |>
    dplyr::filter(outcome != "resultCount")

  return(results)
}
