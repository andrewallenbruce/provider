#' Search the Medicare Physician & Other Practitioners API
#'
#' @description Information on services and procedures provided to
#'    Original Medicare (fee-for-service) Part B (Medical Insurance)
#'    beneficiaries by physicians and other healthcare professionals.
#'
#' # Medicare Physician & Other Practitioners APIs
#'
#' [provider_mpop()] allows you to access data from three different APIs.
#' These APIs contain three interrelated sets of data:
#'
#' ## by Provider and Service
#'
#' The **Provider and Service** dataset provides information on use,
#' payments, and submitted charges organized by National Provider Identifier
#' (NPI), Healthcare Common Procedure Coding System (HCPCS) code, and place
#' of service. This dataset is based on information gathered from CMS
#' administrative claims data for Original Medicare Part B beneficiaries
#' available from the CMS Chronic Conditions Data Warehouse.
#'
#' ## by Geography and Service
#'
#' The **Geography and Service** dataset contains information on use,
#' payments, submitted charges, and beneficiary demographic and health
#' characteristics organized by geography, Healthcare Common Procedure
#' Coding System (HCPCS) code, and place of service. This dataset is based on
#' information gathered from CMS administrative claims data for Original
#' Medicare Part B beneficiaries available from the CMS Chronic Conditions
#' Data Warehouse.
#'
#' ## by Provider
#'
#' The **Provider** dataset provides information on use, payments,
#' submitted charges and beneficiary demographic and health characteristics
#' organized by National Provider Identifier (NPI). This dataset is based on
#' information gathered from CMS administrative claims data for Original
#' Medicare Part B beneficiaries available from the CMS Chronic Conditions
#' Data Warehouse.
#'
#' ## Data Update Frequency
#' Annually
#'
#' ## Data Source
#' Centers for Medicare & Medicaid Services
#'
#' ## Links
#'  * [Medicare Physician & Other Practitioners: by Provider and Service API](https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-provider-and-service)
#'  * [Medicare Physician & Other Practitioners: by Geography and Service API](https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-geography-and-service)
#'  * [Medicare Physician & Other Practitioners: by Provider API](https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-provider)
#'
#' @param npi 10-digit National Provider Identifier (NPI)
#' @param last Provider's last name
#' @param first Provider's first name
#' @param hcpcs HCPCS code used to identify the specific medical service
#'    furnished by the provider.
#' @param set API to access, options are "serv", "geo", and "prov"
#' @param year Year between 2013-2020, in YYYY format
#' @param clean_names Clean column names with {janitor}'s
#'    `clean_names()` function; default is `TRUE`.
#' @param full If `TRUE`, downloads the first 1000 rows of data;
#'    default is `FALSE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examples
#' \dontrun{
#' # Search by NPI
#' provider_mpop(npi = 1003000126, set = "serv", year = "2020")
#'
#' # Search by First Name
#' provider_mpop(first = "Enkeshafi", set = "serv", year = "2019")
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
#'
#' # by Provider
#' provider_mpop(npi = 1003000134, set = "prov")
#'
#' # by Geography
#' provider_mpop(hcpcs = "0002A", set = "geo")
#'
#' # Returns the First 1,000 Rows in the Dataset
#' provider_mpop(full = TRUE, set = "serv")
#' provider_mpop(full = TRUE, set = "geo")
#' provider_mpop(full = TRUE, set = "prov")
#'}
#'
#' @export

provider_mpop <- function(npi         = NULL,
                          last        = NULL,
                          first       = NULL,
                          hcpcs       = NULL,
                          set         = "serv",
                          year        = "2020",
                          clean_names = TRUE,
                          full        = FALSE
                          ) {


  # Check internet connection
  attempt::stop_if_not(
    curl::has_internet() == TRUE,
    msg = "Please check your internet connection.")

  if (set == "serv") {

  # Provider and Service URLs by Year
  switch(year,
  "2020" = id <- "92396110-2aed-4d63-a6a2-5d6207d46a29",
  "2019" = id <- "5fccd951-9538-48a7-9075-6f02b9867868",
  "2018" = id <- "02c0692d-e2d9-4714-80c7-a1d16d72ec66",
  "2017" = id <- "7ebc578d-c2c7-46fd-8cc8-1b035eba7218",
  "2016" = id <- "5055d307-4fb3-4474-adbb-a11f4182ee35",
  "2015" = id <- "0ccba18d-b821-47c6-bb55-269b78921637",
  "2014" = id <- "e6aacd22-1b89-4914-855c-f8dacbd2ec60",
  "2013" = id <- "ebaf67d7-1572-4419-a053-c8631cc1cc9b"
  )}

  if (set == "geo") {

  # Geography and Service URLs by Year
  switch(year,
  "2020" = id <- "6fea9d79-0129-4e4c-b1b8-23cd86a4f435",
  "2019" = id <- "673030ae-ceed-4561-8fca-b1275395a86a",
  "2018" = id <- "05a85700-052f-4509-af43-7042b9b35868",
  "2017" = id <- "8e96a9f2-ce6e-46fd-b30d-8c695c756bfd",
  "2016" = id <- "c7d3f18c-2f00-4553-8cd1-871b727d5cdd",
  "2015" = id <- "dbee9609-2c90-43ca-b1b8-161bd9cfcdb2",
  "2014" = id <- "28181bd2-b377-4003-b73a-4bd92d1db4a9",
  "2013" = id <- "3c2a4756-0a8c-4e4d-845a-6ad169cb13d3"
  )}

  if (set == "prov") {

  # Provider URLs by Year
  switch(year,
  "2020" = id <- "8889d81e-2ee7-448f-8713-f071038289b5",
  "2019" = id <- "a399e5c1-1cd1-4cbe-957f-d2cc8fe5d897",
  "2018" = id <- "a5cfcc24-eaf7-472c-8831-7f396c77a890",
  "2017" = id <- "bed1a455-2dad-4359-9cec-ec59cf251a14",
  "2016" = id <- "9301285e-f2ff-4035-9b59-48eaa09a0572",
  "2015" = id <- "acba6dc6-3e76-4176-9564-84ab5ea4c8aa",
  "2014" = id <- "d3d74823-9909-4177-946d-cdaa268b90ab",
  "2013" = id <- "bbec6d8a-3b0d-49bb-98be-3170639d3ab5"
  )}

  # Paste URL together
  http <- "https://data.cms.gov/data-api/v1/dataset/"
  mpop_url <- paste0(http, id, "/data")

  # Create request
  req <- httr2::request(mpop_url)

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
      first = first,
      hcpcs = hcpcs), collapse = ",")

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
  if (isTRUE(is.null(nrow(results))) & isTRUE(is.null(ncol(results)))) {

    return(message(paste("Provider No.", npi, "is not in the database")))

  } else {

    results <- results |> tibble::tibble()

  # Convert to numeric

    if (set == "serv") {

      results <- results |>
        dplyr::mutate(
          Tot_Benes          = as.numeric(Tot_Benes),
          Tot_Srvcs          = as.numeric(Tot_Srvcs),
          Tot_Bene_Day_Srvcs = as.numeric(Tot_Bene_Day_Srvcs),
          Avg_Sbmtd_Chrg     = as.numeric(Avg_Sbmtd_Chrg),
          Avg_Mdcr_Alowd_Amt = as.numeric(Avg_Mdcr_Alowd_Amt),
          Avg_Mdcr_Pymt_Amt  = as.numeric(Avg_Mdcr_Pymt_Amt),
          Avg_Mdcr_Stdzd_Amt = as.numeric(Avg_Mdcr_Stdzd_Amt))

    }

    if (set == "geo") {

      results <- results |>
        dplyr::mutate(
          Tot_Rndrng_Prvdrs  = as.numeric(Tot_Rndrng_Prvdrs),
          Tot_Benes          = as.numeric(Tot_Benes),
          Tot_Srvcs          = as.numeric(Tot_Srvcs),
          Tot_Bene_Day_Srvcs = as.numeric(Tot_Bene_Day_Srvcs),
          Avg_Sbmtd_Chrg     = as.numeric(Avg_Sbmtd_Chrg),
          Avg_Mdcr_Alowd_Amt = as.numeric(Avg_Mdcr_Alowd_Amt),
          Avg_Mdcr_Pymt_Amt  = as.numeric(Avg_Mdcr_Pymt_Amt),
          Avg_Mdcr_Stdzd_Amt = as.numeric(Avg_Mdcr_Stdzd_Amt))

    }

    if (set == "prov") {

      results <- results |>
        dplyr::mutate(
          Tot_HCPCS_Cds           = as.numeric(Tot_HCPCS_Cds),
          Tot_Benes               = as.numeric(Tot_Benes),
          Tot_Srvcs               = as.numeric(Tot_Srvcs),
          Tot_Sbmtd_Chrg          = as.numeric(Tot_Sbmtd_Chrg),
          Tot_Mdcr_Alowd_Amt      = as.numeric(Tot_Mdcr_Alowd_Amt),
          Tot_Mdcr_Pymt_Amt       = as.numeric(Tot_Mdcr_Pymt_Amt),
          Tot_Mdcr_Stdzd_Amt      = as.numeric(Tot_Mdcr_Stdzd_Amt),

          Drug_Tot_HCPCS_Cds      = as.numeric(Drug_Tot_HCPCS_Cds),
          Drug_Tot_Benes          = as.numeric(Drug_Tot_Benes),
          Drug_Tot_Srvcs          = as.numeric(Drug_Tot_Srvcs),
          Drug_Sbmtd_Chrg         = as.numeric(Drug_Sbmtd_Chrg),
          Drug_Mdcr_Alowd_Amt     = as.numeric(Drug_Mdcr_Alowd_Amt),
          Drug_Mdcr_Pymt_Amt      = as.numeric(Drug_Mdcr_Pymt_Amt),
          Drug_Mdcr_Stdzd_Amt     = as.numeric(Drug_Mdcr_Stdzd_Amt),

          Med_Tot_HCPCS_Cds       = as.numeric(Med_Tot_HCPCS_Cds),
          Med_Tot_Benes           = as.numeric(Med_Tot_Benes),
          Med_Tot_Srvcs           = as.numeric(Med_Tot_Srvcs),
          Med_Sbmtd_Chrg          = as.numeric(Med_Sbmtd_Chrg),
          Med_Mdcr_Alowd_Amt      = as.numeric(Med_Mdcr_Alowd_Amt),
          Med_Mdcr_Pymt_Amt       = as.numeric(Med_Mdcr_Pymt_Amt),
          Med_Mdcr_Stdzd_Amt      = as.numeric(Med_Mdcr_Stdzd_Amt),

          Bene_Avg_Age            = as.numeric(Bene_Avg_Age),
          Bene_Age_LT_65_Cnt      = as.numeric(Bene_Age_LT_65_Cnt),
          Bene_Age_65_74_Cnt      = as.numeric(Bene_Age_65_74_Cnt),
          Bene_Age_75_84_Cnt      = as.numeric(Bene_Age_75_84_Cnt),
          Bene_Age_GT_84_Cnt      = as.numeric(Bene_Age_GT_84_Cnt),
          Bene_Feml_Cnt           = as.numeric(Bene_Feml_Cnt),
          Bene_Male_Cnt           = as.numeric(Bene_Male_Cnt),
          Bene_Race_Wht_Cnt       = as.numeric(Bene_Race_Wht_Cnt),
          Bene_Race_Black_Cnt     = as.numeric(Bene_Race_Black_Cnt),
          Bene_Race_API_Cnt       = as.numeric(Bene_Race_API_Cnt),
          Bene_Race_Hspnc_Cnt     = as.numeric(Bene_Race_Hspnc_Cnt),
          Bene_Race_NatInd_Cnt    = as.numeric(Bene_Race_NatInd_Cnt),
          Bene_Race_Othr_Cnt      = as.numeric(Bene_Race_Othr_Cnt),
          Bene_Dual_Cnt           = as.numeric(Bene_Dual_Cnt),
          Bene_Ndual_Cnt          = as.numeric(Bene_Ndual_Cnt),

          Bene_CC_AF_Pct          = as.numeric(Bene_CC_AF_Pct),
          Bene_CC_Alzhmr_Pct      = as.numeric(Bene_CC_Alzhmr_Pct),
          Bene_CC_Asthma_Pct      = as.numeric(Bene_CC_Asthma_Pct),
          Bene_CC_Cncr_Pct        = as.numeric(Bene_CC_Cncr_Pct),
          Bene_CC_CHF_Pct         = as.numeric(Bene_CC_CHF_Pct),
          Bene_CC_CKD_Pct         = as.numeric(Bene_CC_CKD_Pct),
          Bene_CC_COPD_Pct        = as.numeric(Bene_CC_COPD_Pct),
          Bene_CC_Dprssn_Pct      = as.numeric(Bene_CC_Dprssn_Pct),
          Bene_CC_Dbts_Pct        = as.numeric(Bene_CC_Dbts_Pct),
          Bene_CC_Hyplpdma_Pct    = as.numeric(Bene_CC_Hyplpdma_Pct),
          Bene_CC_Hyprtnsn_Pct    = as.numeric(Bene_CC_Hyprtnsn_Pct),
          Bene_CC_IHD_Pct         = as.numeric(Bene_CC_IHD_Pct),
          Bene_CC_Opo_Pct         = as.numeric(Bene_CC_Opo_Pct),
          Bene_CC_RAOA_Pct        = as.numeric(Bene_CC_RAOA_Pct),
          Bene_CC_Sz_Pct          = as.numeric(Bene_CC_Sz_Pct),
          Bene_CC_Strok_Pct       = as.numeric(Bene_CC_Strok_Pct),
          Bene_Avg_Risk_Scre      = as.numeric(Bene_Avg_Risk_Scre)
          )
    }

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
