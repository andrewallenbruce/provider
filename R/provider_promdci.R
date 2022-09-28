#' Search the CMS Public Reporting of Missing Digital Contact Information API
#'
#' @description Information on providers that are missing digital contact
#'    information in NPPES.
#'
#' # Public Reporting of Missing Digital Contact Information
#'
#' In the May 2020 CMS Interoperability and Patient Access
#' final rule, CMS finalized the policy to publicly report the names
#' and NPIs of those providers who do not have digital contact
#' information included in the NPPES system (85 FR 25584). This
#' data includes the NPI and provider name of providers and
#' clinicians without digital contact information in NPPES. This data
#' is gathered from the NPPES for providers who are missing digital
#' contact information.
#'
#' ## Data Update Frequency
#' Quarterly
#'
#' ## Data Source
#' Centers for Medicare & Medicaid Services
#'
#' @param npi 10-digit National Provider Identifier (NPI)
#' @param last Provider's last name
#' @param first Provider's first name
#' @param clean_names Clean column names with {janitor}'s
#'    `clean_names()` function; default is `TRUE`.
#' @param full If true, downloads the first 1000 rows of data;
#'    default is `FALSE`.
#'
#' @return A [tibble()] containing the search results.
#'
#' @references
#'    \url{https://data.cms.gov/provider-compliance/public-reporting-of-missing-digital-contact-information}
#'
#' @examples
#' \dontrun{
#' provider_promdci(npi = 1760485387)
#'
#' provider_promdci(last = "Dewey", first = "Paul")
#'
#' # Unnamed List of NPIs
#' npi_list <- c(1003026055,
#'               1316405939,
#'               1720392988,
#'               1518184605,
#'               1922056829,
#'               1083879860)
#'
#' npi_list |> purrr::map_dfr(provider_promdci)
#'
#' # Returns the First 1,000 Rows in the Dataset ============================
#' provider_promdci(full = TRUE)
#' }
#' @export

provider_promdci <- function(npi = NULL,
                             last = NULL,
                             first = NULL,
                             clean_names = TRUE,
                             full = FALSE
                             ) {

  # Check internet connection
  attempt::stop_if_not(
    curl::has_internet() == TRUE,
    msg = "Please check your internet connection.")

  # CMS Missing Digital Contact Information Base URL
  promdci_url <- "https://data.cms.gov/data-api/v1/dataset/63a83bb1-4c02-43b3-8ef4-e3d3c6cf62fa/data"

  # Create polite version
  polite_req <- polite::politely(
    httr2::request,
    verbose = FALSE,
    delay = 2)

  # Create request
  req <- polite_req(promdci_url)

  if (isTRUE(full)) {

    # Send and save response
    resp <- req |>
      httr2::req_url_query() |>
      httr2::req_perform()

  } else if (!is.null(npi)) {

    # Luhn check
    attempt::stop_if_not(provider_luhn(npi) == TRUE,
                         msg = "Luhn Check: NPI may be invalid.")

    # Send and save response
    resp <- req |>
      httr2::req_url_query(keyword = npi) |>
      httr2::req_throttle(50 / 60) |>
      httr2::req_perform()

  } else {

    # Create list of arguments
    arg <- stringr::str_c(c(
      last = last,
      first = first), collapse = ",")

    # Check that at least one argument is not null
    attempt::stop_if_all(
      arg, is.null, "You need to specify at least one argument")

    # Send and save response
    resp <- req |>
      httr2::req_url_query(keyword = arg) |>
      httr2::req_throttle(50 / 60) |>
      httr2::req_perform()

    # Save time of API query
    datetime <- resp |> httr2::resp_date()

  }

  # Parse JSON response and save results
  results <- resp |> httr2::resp_body_json(
    check_type = FALSE,
    simplifyVector = TRUE)

  # Empty List - NPI is not in the database
  if (isTRUE(insight::is_empty_object(results))) {

    message("NPI is not in database")

  } else {

    # Clean names with janitor
    if (isTRUE(clean_names)) {

      results <- results |>
        janitor::clean_names()
    }

    return(results)
  }
}

