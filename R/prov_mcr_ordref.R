#' Search Medicare Order and Referring API
#'
#' All physicians and non-physician practitioners who are legally
#' eligible to order and refer in the Medicare program and
#' who have current enrollment records in Medicare.
#'
#' @description The Order and Referring dataset provides
#' information on all physicians and non-physician practitioners,
#' by their National Provider Identifier (NPI), who are of a
#' type/specialty that is legally eligible to order and refer in
#' the Medicare program and who have current enrollment records in Medicare.
#'
#' @param npi 10-digit National Provider Identifier (NPI)
#'
#' @return A tibble containing the NPI(s) searched for,
#' the date-time the search was performed, and
#' a list-column of the results.
#'
#' @export
#'
#' @source https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/order-and-referring
#'
#' @examples
#' prov_mcr_ordref(1003026055)

prov_mcr_ordref <- function(npi) {

  # Check internet connection
  attempt::stop_if_not(
    curl::has_internet() == TRUE,
    msg = "Please check your internet connection.")

  # strip spaces
  npi <- gsub(pattern = " ", replacement = "", npi)

  # Number of characters should be 10
  attempt::stop_if_not(
    nchar(npi) == 10,
    msg = c(
      "NPIs must have 10 digits. Provided NPI has ",
      nchar(npi),
      " digits."))

  # Luhn check
  attempt::stop_if_not(
    provider::prov_npi_luhn(npi) == TRUE,
    msg = "Luhn Check: NPI may be invalid.")

  # Medicare Medicare Order and Referring Base URL
  mcr_ordref_base_url <- "https://data.cms.gov/data-api/v1/dataset/c99b5865-1119-4436-bb80-c5af2773ea1f/data"

  # Create polite version
  polite_req <- polite::politely(
    httr2::request,
    verbose = FALSE,
    delay = 2)

  # Create request
  req <- polite_req(mcr_ordref_base_url)

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
