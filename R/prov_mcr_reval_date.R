#' Search the Medicare Revalidation Due Date API
#'
#' Information on revalidation due dates for Medicare providers.
#'
#' @description The Revalidation Due Date List dataset contains
#' revalidation due dates for Medicare providers who are due to
#' revalidate in the following six months. If a provider's due
#' date does not fall within the ensuing six months, the due
#' date is marked 'TBD'. In addition the dataset also includes
#' subfiles with reassignment information for a given provider
#' as well as due date listings for clinics and group practices
#' and their providers.
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
#' prov_mcr_reval_date(1184699621)

prov_mcr_reval_date <- function(npi) {

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

  # Medicare Revalidation Due Date Base URL
  mcr_reval_date_url <- "https://data.cms.gov/data-api/v1/dataset/3746498e-874d-45d8-9c69-68603cafea60/data"

  # Create polite version
  polite_req <- polite::politely(
    httr2::request,
    verbose = FALSE,
    delay = 2)

  # Create request
  req <- polite_req(mcr_reval_date_url)

  # Send and save response
  resp <- req |>
    httr2::req_url_query(keyword = npi) |>
    httr2::req_throttle(50 / 60) |>
    httr2::req_perform()

  # Save time of API query
  datetime <- resp |> httr2::resp_date()

  # Parse JSON response and save results
  results <- resp |> httr2::resp_body_json(
    check_type = FALSE,
    simplifyVector = TRUE)

  return(results)
}
