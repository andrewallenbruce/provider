#' Search the CMS Public Reporting of Missing Digital Contact Information API
#'
#' Information on providers missing digital contact information in NPPES.
#'
#' @description In the May 2020 CMS Interoperability and Patient Access
#' final rule, CMS finalized the policy to publicly report the names
#' and NPIs of those providers who do not have digital contact
#' information included in the NPPES system (85 FR 25584). This
#' data includes the NPI and provider name of providers and
#' clinicians without digital contact information in NPPES.
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
#' prov_nppes_missing(1760485387)

prov_nppes_missing <- function(npi) {

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

  # CMS Missing Digital Contact Information Base URL
  nppes_missing_url <- "https://data.cms.gov/data-api/v1/dataset/63a83bb1-4c02-43b3-8ef4-e3d3c6cf62fa/data"

  # Create polite version
  polite_req <- polite::politely(
    httr2::request,
    verbose = FALSE,
    delay = 2)

  # Create request
  req <- polite_req(nppes_missing_url)

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
