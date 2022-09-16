#' Search the NPPES NPI Public Registry
#'
#' @description The NPPES NPI Registry Public Search is a
#' free directory of all active National Provider Identifier
#' (NPI) records. Healthcare providers acquire their unique
#' 10-digit NPIs to identify themselves in a standard way
#' throughout their industry. After CMS supplies an NPI,
#' they publish the parts of the NPI record that have public
#' relevance, including the provider’s name, taxonomy and
#' practice address. It enables you to search for providers
#' in the NPPES (National Plan and Provider Enumeration System.)
#' All information produced by the NPI Registry is provided in
#' accordance with the NPPES Data Dissemination Notice.
#' There is no charge to use the NPI Registry.
#'
#' @param city city in which provider practices
#' @param state abbreviation of state in which provider practices
#' @param limit maximum number of results expected back
#' @param skip number of results to skip after searching the previous,
#' say, 200 examples
#'
#' @return A tibble containing the NPI(s) searched for,
#' the date-time the search was performed, and
#' a list-column of the results.
#'
#' @export
#'
#' @examples
#' prov_city_nppes(city = "Atlanta", state = "GA", limit = "1")

prov_city_nppes <- function(city,
                            state,
                            limit = 200,
                            skip = NULL) {

  # Check internet connection
  attempt::stop_if_not(
    curl::has_internet() == TRUE,
    msg = "Please check your internet connection.")

  # strip spaces
  city <- gsub(pattern = " ", replacement = "", city)
  state <- gsub(pattern = " ", replacement = "", state)

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
    httr2::req_url_query(city = city,
                         state = state,
                         limit = limit,
                         skip = skip
    ) |>
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

  # Append time of API query to tibble
  results$datetime <- datetime

  # Move columns to beginning
  results <- results |>
    dplyr::relocate(datetime)

  # Filter out resultCount rows
  results <- results |>
    dplyr::filter(outcome != "resultCount")

  return(results)
}
