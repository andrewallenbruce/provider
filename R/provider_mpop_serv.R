#' Search the Medicare Physician & Other Practitioners
#' by Provider and Service API
#'
#' @description [provider_mpop()] allows you to access data from Medicare's
#'    Physician & Other Practitioners by Provider and Service API.
#'
#' @details The **Provider and Service** dataset provides information on
#'    services and procedures provided to Medicare (fee-for-service) Part B
#'    beneficiaries by physicians and other healthcare professionals.
#'
#'    The data is based on information gathered from CMS administrative claims
#'    data for Part B beneficiaries available from the CMS Chronic Conditions
#'    Data Warehouse.
#'
#'    The spending and utilization data in the Physician and Other
#'    Practitioners by Provider and Service Dataset are aggregated
#'    to the following:
#'
#'    1. the NPI for the performing provider,
#'    2. the Healthcare Common Procedure Coding System (HCPCS) code, and
#'    3. the place of service (either facility or non-facility).
#'
#'    There can be multiple records for a given NPI based on the number of
#'    distinct HCPCS codes that were billed and where the services were
#'    provided. Data have been aggregated based on the place of service
#'    because separate fee schedules apply depending on whether the place
#'    of service submitted on the claim is facility or non-facility.
#'
#'  * [Medicare Physician & Other Practitioners: by Provider and Service API](https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-provider-and-service)
#'
#' @source Centers for Medicare & Medicaid Services
#' @note Data Update Frequency: Annually
#'
#' @param npi 10-digit National Provider Identifier (NPI)
#' @param last Provider's last name
#' @param first Provider's first name
#' @param year Year in YYYY format, between 2013-2020; default is 2020
#' @param clean_names Clean column names with {janitor}'s
#'    `clean_names()` function; default is `TRUE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examples
#' \dontrun{
#' # Search by NPI
#' provider_mpop_serv(npi = 1003000126)
#'
#' # Search by First Name for 2019
#' provider_mpop_serv(first = "Enkeshafi", year = "2019")
#'
#' # Multiple NPIs
#' npis <- c(1003026055,
#'           1316405939,
#'           1720392988,
#'           1518184605,
#'           1922056829,
#'           1083879860)
#'
#' npis |> purrr::map_dfr(provider_mpop_serv)
#'
#' # Retrieve All Provider Data, 2013-2020
#' dates <- as.character(seq(from = 2013, to = 2020))
#' purrr::map_dfr(dates, ~provider_mpop_serv(npi = 1003000126, year = .x))
#' }
#' @autoglobal
#' @export

provider_mpop_serv <- function(npi         = NULL,
                               last        = NULL,
                               first       = NULL,
                               year        = "2020",
                               clean_names = TRUE) {


  # Check internet connection -----------------------------------------------
  attempt::stop_if_not(curl::has_internet() == TRUE,
                       msg = "Please check your internet connection.")

  # Provider and Service URLs by Year
  switch(year,
         "2020" = id <- "92396110-2aed-4d63-a6a2-5d6207d46a29",
         "2019" = id <- "5fccd951-9538-48a7-9075-6f02b9867868",
         "2018" = id <- "02c0692d-e2d9-4714-80c7-a1d16d72ec66",
         "2017" = id <- "7ebc578d-c2c7-46fd-8cc8-1b035eba7218",
         "2016" = id <- "5055d307-4fb3-4474-adbb-a11f4182ee35",
         "2015" = id <- "0ccba18d-b821-47c6-bb55-269b78921637",
         "2014" = id <- "e6aacd22-1b89-4914-855c-f8dacbd2ec60",
         "2013" = id <- "ebaf67d7-1572-4419-a053-c8631cc1cc9b")


  # Paste URL together
  http <- "https://data.cms.gov/data-api/v1/dataset/"
  mpop_url <- paste0(http, id, "/data")

  # Create request
  req <- httr2::request(mpop_url)

  # Search by NPI -----------------------------------------------------------
  if (!is.null(npi)) {

    # Luhn check
    attempt::stop_if_not(provider_luhn(npi) == TRUE,
                         msg = "Luhn Check: NPI may be invalid.")

    # Send and save response
    resp <- req |>
      httr2::req_url_query(keyword = npi) |>
      httr2::req_throttle(50 / 60) |>
      httr2::req_perform()

    } else {

      # Search by Other Parameters ------------------------------------------
      args <- stringr::str_c(c(last = last, first = first), collapse = ",")

      # Check that at least one argument is not null
      attempt::stop_if_all(args, is.null, "Specify at least one argument")

      # Send and save response
      resp <- req |>
      httr2::req_url_query(keyword = args) |>
      httr2::req_throttle(50 / 60) |>
      httr2::req_perform()

    }

  # Save time of API query
  datetime <- resp |> httr2::resp_date()

  # Parse JSON response and save results
  results <- resp |>
    httr2::resp_body_json(check_type = FALSE,
                          simplifyVector = TRUE) |>
    tibble::tibble()

  # Empty List - NPI is not in the database
  if (isTRUE(is.null(nrow(results))) & isTRUE(is.null(ncol(results)))) {

    return(message(paste("Provider No.", npi, "is not in the database")))

    } else {

    # Convert to numeric
    results <- results |>
      dplyr::mutate(Year = year,
                    Tot_Benes = as.numeric(Tot_Benes),
                    Tot_Srvcs = as.numeric(Tot_Srvcs),
                    Tot_Bene_Day_Srvcs = as.numeric(Tot_Bene_Day_Srvcs),
                    Avg_Sbmtd_Chrg     = as.numeric(Avg_Sbmtd_Chrg),
                    Avg_Mdcr_Alowd_Amt = as.numeric(Avg_Mdcr_Alowd_Amt),
                    Avg_Mdcr_Pymt_Amt  = as.numeric(Avg_Mdcr_Pymt_Amt),
                    Avg_Mdcr_Stdzd_Amt = as.numeric(Avg_Mdcr_Stdzd_Amt)) |>
      dplyr::relocate(Year)

    }

    # Clean names with janitor
    if (isTRUE(clean_names)) {results <- results |> janitor::clean_names()}

    return(results)
}

