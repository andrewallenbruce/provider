#' Search Medicare Fee-For-Service Public Provider Enrollment API
#'
#' Information on a point in time snapshot of enrollment
#' level data for providers actively enrolled in Medicare.
#'
#' @description The Medicare Fee-For-Service Public Provider Enrollment
#' dataset includes information on providers who are actively approved to
#' bill Medicare or have completed the 855O at the time the data was pulled
#' from the Provider Enrollment and Chain Ownership System (PECOS). These
#' files are populated from PECOS and contain basic enrollment and provider
#' information, reassignment of benefits information and practice location
#' city, state and zip. These files are not intended to be used as real-time
#' reporting as the data changes from day to day and the files are updated
#' only on a quarterly basis.
#'
#' @param npi 10-digit National Provider Identifier (NPI)
#'
#' @return A tibble containing the NPI(s) searched for,
#' the date-time the search was performed, and
#' a list-column of the results.
#'
#' @export
#'
#' @source https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/medicare-fee-for-service-public-provider-enrollment
#'
#' @examples
#' prov_mcr_ffs(1003026055)

prov_mcr_ffs <- function(npi) {

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

  # Medicare Fee-For-Service Public Provider Enrollment Base URL
  mcr_ffs_base_url <- "https://data.cms.gov/data-api/v1/dataset/2457ea29-fc82-48b0-86ec-3b0755de7515/data"

  # Create polite version
  polite_req <- polite::politely(
    httr2::request,
    verbose = FALSE,
    delay = 2)

  # Create request
  req <- polite_req(mcr_ffs_base_url)

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
