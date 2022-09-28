#' Search the Medicare Opt Out Affidavits API
#'
#' @description A list of practitioners who are currently
#'    opted out of Medicare.
#'
#' # Medicare Opt Out Affidavits Dataset
#'
#' The Opt Out Affidavits dataset provides
#' information on providers who have decided not to
#' participate in Medicare. It contains the provider's NPI,
#' specialty, address, and effective dates.
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
#'
#' @return A [tibble()] containing the search results.
#'
#'
#'@references
#'    \url{https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/opt-out-affidavits}
#'
#' @examples
#' \dontrun{
#' # Search by NPI ===========================================================
#' provider_mooa(npi = 1114974490)
#'
#' # Search by Last Name =====================================================
#' provider_mooa(last = "Altchek")
#' }
#'
#' @export

provider_mooa <- function(npi = NULL,
                          last = NULL,
                          first = NULL,
                          clean_names = TRUE
                          ) {

  # Check internet connection
  attempt::stop_if_not(
    curl::has_internet() == TRUE,
    msg = "Please check your internet connection.")

  if (!is.null(npi)) {

    # Luhn check
    attempt::stop_if_not(provider_luhn(npi) == TRUE,
                         msg = "Luhn Check: NPI may be invalid.")

  }

  # Medicare Opt Out Base URL
  mooa_url <- "https://data.cms.gov/data-api/v1/dataset/9887a515-7552-4693-bf58-735c77af46d7/data"

  # Create polite version
  polite_req <- polite::politely(
    httr2::request,
    verbose = FALSE,
    delay = 2)

  # Create request
  req <- polite_req(mooa_url)

  # Create list of arguments
  arg <- stringr::str_c(c(
    npi = npi,
    last = last,
    first = first
  ), collapse = ",")

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

  # Parse JSON response and save results
  results <- resp |> httr2::resp_body_json(
    check_type = FALSE,
    simplifyVector = TRUE)

  # Clean names with janitor
  if (clean_names == TRUE) {

    results <- results |>
      janitor::clean_names()

    return(results)

  } else {

    return(results)

  }
}
