#' Search the Medicare Provider of Services File - Clinical Laboratories API
#'
#' @description [provider_clia()] allows access to a dataset that
#'    provides information on clinical laboratories including
#'    demographics and the type of testing services the facility
#'    provides.
#'
#' # Medicare Provider of Services File - Clinical Laboratories API
#'
#' The Provider of Services (POS) Clinical Laboratories (CLIA) data
#' provides information on CLIA demographics and types of testing
#' services the facility provides. In this file you will find provider
#' number, name, address and characteristics of the participating
#' institution providers. This data is gathered as part of the CMS
#' Provider Certification process and is updated each time a provider
#' is recertified.
#'
#' ## Data Update Frequency
#' Quarterly
#'
#' ## Data Source
#' Centers for Medicare & Medicaid Services
#'
#' ## Links
#'  * [Medicare Provider of Services File - Clinical Laboratories API](https://data.cms.gov/provider-characteristics/hospitals-and-other-facilities/provider-of-services-file-clinical-laboratories)
#'  * [Data Dictionary](https://data.cms.gov/sites/default/files/2020-12/POS_CLIA_LAYOUT_SEP20.pdf)
#'
#' @param name Name of the provider certified to participate in the Medicare
#'    and/or Medicaid programs.
#' @param city City in which the provider is physically located.
#' @param state Two-character state abbreviation.
#' @param year Year between 2010-2022, in YYYY format
#' @param clean_names Clean column names with {janitor}'s
#'    `clean_names()` function; default is `TRUE`.
#' @param full If true, downloads the first 1000 rows of data;
#'    default is `FALSE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results with the
#'    following columns:
#'    \describe{
#'    \item{prvdr_ctgry_sbtyp_cd}{Identifies the subtype of provider within the primary category. (01 = CLIA88 Lab)}
#'    \item{prvdr_ctgry_cd}{Identifies the type of provider participating in the Medicare/Medicaid program. (22 = CLIA Lab)}
#'    \item{chow_cnt}{Number of times this provider has undergone a change of ownership.}
#'    \item{chow_dt}{Effective date of the most recent change of ownership for this provider.}
#'    \item{city_name}{City in which the provider is physically located.}
#'    }
#'
#' @examples
#' \dontrun{
#' provider_clia(name = "carbon hill", year = "2022")
#'
#' provider_clia(city = "alabaster")
#'
#' # Download First 1,000 Rows of Dataset =====================================
#' provider_clia(full = TRUE)
#' }
#' @autoglobal
#' @export

provider_clia <- function(name = NULL,
                          city = NULL,
                          state = NULL,
                          year = "2022",
                          clean_names = TRUE,
                          full = FALSE
) {

  # Check internet connection
  attempt::stop_if_not(
    curl::has_internet() == TRUE,
    msg = "Please check your internet connection.")

  switch(year,
         "2022" = yr <- "d3eb38ac-d8e9-40d3-b7b7-6205d3d1dc16",
         "2021" = yr <- "0a1e9e1d-ca8a-4fde-bfb8-1436973f18c4",
         "2020" = yr <- "0ac881d5-3742-4d71-85c0-b94cacf2c3f7",
         "2019" = yr <- "cf000286-6a42-4031-81dd-aaa4fc8446fc",
         "2018" = yr <- "4428eca4-3d4a-44e8-b146-df4e4cdba812",
         "2017" = yr <- "97285b4b-ccce-4834-bbe1-05050665e498",
         "2016" = yr <- "f68318d3-d74f-4e81-9b46-2d696ac599bb",
         "2015" = yr <- "3e4c89ea-3e3f-4e29-959b-00f257c4893f",
         "2014" = yr <- "cd7be382-7736-4411-a224-f01728cddae1",
         "2013" = yr <- "3d21bf00-189b-4d5b-9cf7-75f88b849f71",
         "2012" = yr <- "d5f8f520-824a-4ccb-bb99-25f83bba13f4",
         "2011" = yr <- "c7f8619d-945f-4d8b-9747-f1b3f2e56c84",
         "2010" = yr <- "3b635cea-fa5e-42de-ba61-4ba2f88e032f"
  )

  # Paste URL together
  http <- "https://data.cms.gov/data-api/v1/dataset/"
  clia_url <- paste0(http, yr, "/data")

  # Create polite version
  polite_req <- polite::politely(
    httr2::request,
    verbose = FALSE,
    delay = 2)

  # Create request
  req <- polite_req(clia_url)

  if (isTRUE(full)) {

    # Send and save response
    resp <- req |>
      httr2::req_url_query() |>
      httr2::req_perform()

  } else {

    # Create list of arguments
    arg <- stringr::str_c(c(
      name = name,
      city = city,
      state = state
    ), collapse = ",")

    # Check that at least one argument is not null
    attempt::stop_if_all(arg, is.null,
                         "You need to specify at least one argument")

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

    message("Search returned nothing.")

  } else {

    # Clean names with janitor
    if (isTRUE(clean_names)) {

      results <- results |>
        janitor::clean_names()
    }

    return(results)
  }
}
