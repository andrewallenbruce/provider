#' Search the NPPES by NPI
#'
#' @param npi 10-digit National Provider Identifier (NPI)
#'
#' @return A tibble containing the NPI(s) searched for,
#' the date-time the search was performed, and
#' a list-column of the results.
#'
#' @export
#'
#' @examples
#' prov_npi_nppes(1528060837)

prov_npi_nppes <- function(npi) {

  # Check internet connection
  attempt::stop_if_not(
    curl::has_internet() == TRUE,
    msg = "Please check your internet connection.")

  # strip spaces
  npi <- gsub(pattern = " ", replacement = "", npi)

  # Number of characters should be 10
  attempt::stop_if_not(
    nchar(npi) == 10,
    msg = c("NPIs must have 10 digits. Provided NPI has ",
            nchar(npi),
            " digits."))

  # Luhn check
  attempt::stop_if_not(
    provider::prov_npi_luhn(npi) == TRUE,
    msg = "Luhn Check: NPI may be invalid.")

  # NPPES Base URL
  nppes_base_url <- "https://npiregistry.cms.hhs.gov/api/?version=2.1"

  # Create polite version
  polite_req <- polite::politely(httr2::request,
                                 verbose = FALSE,
                                 delay = 2)

  # Create request
  req <- polite_req(nppes_base_url)

  # Send and save response
  resp <- req |>
    httr2::req_url_query(number = npi) |>
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

  # Append NPIs searched for to tibble
  results$search <- npi

  # Append time of API query to tibble
  results$datetime <- datetime

  # Move columns to beginning
  results <- results |>
    dplyr::relocate(c(search, datetime))

  # Filter out resultCount rows
  results <- results |>
    dplyr::filter(outcome != "resultCount")

  return(results)
}
