#' Search the Medicare Physician & Other
#' Practitioners - by Provider and Service API
#'
#'Information on services and procedures provided
#'to Original Medicare (fee-for-service) Part B
#'(Medical Insurance) beneficiaries by physicians
#'and other healthcare professionals; aggregated by
#'provider and service.
#'
#' @description The Medicare Physician & Other Practitioners by
#' Provider and Service dataset provides information on use,
#' payments, and submitted charges organized by National Provider
#' Identifier (NPI), Healthcare Common Procedure Coding System
#' (HCPCS) code, and place of service.
#'
#' @param npi 10-digit National Provider Identifier (NPI)
#' @param year year between 2013-2020, in YYYY format
#'
#' @return A tibble containing the NPI(s) searched for,
#' the date-time the search was performed, and
#' a list-column of the results.
#'
#' @export
#'
#' @source https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-provider-and-service
#'
#' @examples
#' prov_mcr_phys_pract(npi = 1003000126, year = "2020")

prov_mcr_phys_pract <- function(npi, year = "2020") {

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

  # Medicare Physician & Practitioners Provider and Service Base URL
  switch(year,
  "2020" = mcr_phys_pract_url <- "https://data.cms.gov/data-api/v1/dataset/92396110-2aed-4d63-a6a2-5d6207d46a29/data",
  "2019" = mcr_phys_pract_url <- "https://data.cms.gov/data-api/v1/dataset/5fccd951-9538-48a7-9075-6f02b9867868/data",
  "2018" = mcr_phys_pract_url <- "https://data.cms.gov/data-api/v1/dataset/02c0692d-e2d9-4714-80c7-a1d16d72ec66/data",
  "2017" = mcr_phys_pract_url <- "https://data.cms.gov/data-api/v1/dataset/7ebc578d-c2c7-46fd-8cc8-1b035eba7218/data",
  "2016" = mcr_phys_pract_url <- "https://data.cms.gov/data-api/v1/dataset/5055d307-4fb3-4474-adbb-a11f4182ee35/data",
  "2015" = mcr_phys_pract_url <- "https://data.cms.gov/data-api/v1/dataset/0ccba18d-b821-47c6-bb55-269b78921637/data",
  "2014" = mcr_phys_pract_url <- "https://data.cms.gov/data-api/v1/dataset/e6aacd22-1b89-4914-855c-f8dacbd2ec60/data",
  "2013" = mcr_phys_pract_url <- "https://data.cms.gov/data-api/v1/dataset/ebaf67d7-1572-4419-a053-c8631cc1cc9b/data")


  # Create polite version
  polite_req <- polite::politely(
    httr2::request,
    verbose = FALSE,
    delay = 2)

  # Create request
  req <- polite_req(mcr_phys_pract_url)

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

  # Convert to numeric
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

  # Add year to data frame
  results <- results |>
    dplyr::mutate(year = year) |>
    dplyr::relocate(year)

  return(results)
}
