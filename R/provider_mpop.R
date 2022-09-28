#' Search the Medicare Physician & Other Practitioners
#' (by Provider and Service) API
#'
#' @description Information on services and procedures provided to
#' Original Medicare (fee-for-service) Part B (Medical Insurance)
#' beneficiaries by physicians and other healthcare professionals;
#' aggregated by provider and service.
#'
#' # Medicare Physician & Other Practitioners Dataset
#'
#' The Medicare Physician & Other Practitioners by
#' Provider and Service dataset provides information on use,
#' payments, and submitted charges organized by National Provider
#' Identifier (NPI), Healthcare Common Procedure Coding System
#' (HCPCS) code, and place of service.
#'
#' @param npi 10-digit National Provider Identifier (NPI)
#' @param last Provider's last name
#' @param first Provider's first name
#' @param year Year between 2013-2020, in YYYY format
#' @param clean_names Clean column names with {janitor}'s
#'    `clean_names()` function; default is `TRUE`.
#' @param full If true, downloads the first 1000 rows of data;
#'    default is `FALSE`.
#'
#' @return A [tibble()] containing the search results.
#'
#' @references
#'    \url{https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-provider-and-service}
#'
#' @examples
#' \dontrun{
#' # Search by NPI ===========================================================
#' provider_mpop(npi = 1003000126, year = "2020")
#'
#' # Search by First Name ====================================================
#' provider_mpop(first = "Enkeshafi", year = "2019")
#'
#' # Unnamed List of NPIs
#' npi_list <- c(1003026055,
#'               1316405939,
#'               1720392988,
#'               1518184605,
#'               1922056829,
#'               1083879860)
#'
#' npi_list |> purrr::map_dfr(provider_mpop)
#'
#' # Returns the First 1,000 Rows in the Dataset =============================
#' provider_mpop(full = TRUE)
#'}
#'
#' @export

provider_mpop <- function(npi = NULL,
                          last = NULL,
                          first = NULL,
                          year = "2020",
                          clean_names = TRUE,
                          full = FALSE
                          ) {


  # Check internet connection
  attempt::stop_if_not(
    curl::has_internet() == TRUE,
    msg = "Please check your internet connection.")

  # Medicare Physician & Practitioners Provider and Service URLs by Year
  switch(year,
  "2020" = mpop_url <- "https://data.cms.gov/data-api/v1/dataset/92396110-2aed-4d63-a6a2-5d6207d46a29/data",
  "2019" = mpop_url <- "https://data.cms.gov/data-api/v1/dataset/5fccd951-9538-48a7-9075-6f02b9867868/data",
  "2018" = mpop_url <- "https://data.cms.gov/data-api/v1/dataset/02c0692d-e2d9-4714-80c7-a1d16d72ec66/data",
  "2017" = mpop_url <- "https://data.cms.gov/data-api/v1/dataset/7ebc578d-c2c7-46fd-8cc8-1b035eba7218/data",
  "2016" = mpop_url <- "https://data.cms.gov/data-api/v1/dataset/5055d307-4fb3-4474-adbb-a11f4182ee35/data",
  "2015" = mpop_url <- "https://data.cms.gov/data-api/v1/dataset/0ccba18d-b821-47c6-bb55-269b78921637/data",
  "2014" = mpop_url <- "https://data.cms.gov/data-api/v1/dataset/e6aacd22-1b89-4914-855c-f8dacbd2ec60/data",
  "2013" = mpop_url <- "https://data.cms.gov/data-api/v1/dataset/ebaf67d7-1572-4419-a053-c8631cc1cc9b/data"
  )

  # Create polite version
  polite_req <- polite::politely(
    httr2::request,
    verbose = FALSE,
    delay = 2)

  # Create request
  req <- polite_req(mpop_url)

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

  # Convert to numeric & round averages up
  results <- results |>
    dplyr::mutate(
      Tot_Benes = as.numeric(Tot_Benes),
      Tot_Srvcs = as.numeric(Tot_Srvcs),
      Tot_Bene_Day_Srvcs = as.numeric(Tot_Bene_Day_Srvcs),
      Avg_Sbmtd_Chrg = janitor::round_half_up(
        as.numeric(Avg_Sbmtd_Chrg), digits = 2),
      Avg_Mdcr_Alowd_Amt = janitor::round_half_up(
        as.numeric(Avg_Mdcr_Alowd_Amt), digits = 2),
      Avg_Mdcr_Pymt_Amt = janitor::round_half_up(
        as.numeric(Avg_Mdcr_Pymt_Amt), digits = 2),
      Avg_Mdcr_Stdzd_Amt = janitor::round_half_up(
        as.numeric(Avg_Mdcr_Stdzd_Amt), digits = 2))

  # Add year to data frame & relocate to beginning
  results <- results |>
    dplyr::mutate(year = year) |>
    dplyr::relocate(year)

  # Clean names with janitor
  if (isTRUE(clean_names)) {

    results <- results |>
      janitor::clean_names()
  }

  return(results)
  }
}
