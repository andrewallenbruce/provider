#' Search the Medicare Fee-For-Service Public Provider Enrollment API
#'
#' @description Information on a point in time snapshot of enrollment
#'    level data for providers actively enrolled in Medicare.
#'
#' # The Medicare Fee-For-Service Public Provider Enrollment
#'
#' This dataset includes information on providers who are actively approved to
#' bill Medicare or have completed the 855O at the time the data was pulled
#' from the **Provider Enrollment and Chain Ownership System** (PECOS).
#'
#' These files are populated from PECOS and contain basic enrollment and
#' provider information, reassignment of benefits information and practice
#' location city, state and zip.
#'
#' These files are not intended to be used as real-time reporting as the data
#' changes from day to day and the files are updated only on a quarterly basis.
#' If any information on these files needs to be updated, the provider needs
#' to contact their respective Medicare Administrative Contractor (MAC) to
#' have that information updated.
#'
#' This data does not include information on opt-out providers. Information
#' is redacted where necessary to protect Medicare provider privacy.
#'
#' ## Data Update Frequency
#' Quarterly
#'
#' ## Data Source
#' Centers for Medicare & Medicaid Services
#'
#' ## Links
#' * [Medicare Fee-For-Service Public Provider Enrollment API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/medicare-fee-for-service-public-provider-enrollment)
#' * [Medicare Fee-For-Service Public Provider Enrollment Data Dictionary](https://data.cms.gov/resources/medicare-fee-for-service-public-provider-enrollment-data-dictionary)
#' * [Provider Enrollment and Chain Ownership System Site](https://pecos.cms.hhs.gov/pecos)
#'
#' @param npi 10-digit National Provider Identifier (NPI).
#' @param last Provider's last name
#' @param first Provider's first name
#' @param type_desc description of Provider specialty (taxonomy).
#' @param clean_names Clean column names with {janitor}'s
#'    [clean_names()] function; default is `TRUE`.
#' @param full If true, downloads the first 1000 rows of data;
#'    default is `FALSE`.
#'
#' @return A [tibble()] containing the search results.
#'
#' @examples
#' \dontrun{
#' provider_mppe(npi = 1003026055)
#'
#' provider_mppe(last = "phadke", first = "radhika")
#'
#' provider_mppe(type_desc = "endocrinology")
#'
#' # Unnamed List of NPIs
#' npi_list <- c(1003026055,
#'               1316405939,
#'               1720392988,
#'               1518184605,
#'               1922056829,
#'               1083879860)
#'
#' npi_list |> purrr::map_dfr(provider_mppe)
#'
#' # Data frame of NPIs
#' npi_df <- data.frame(npi = c(1003026055,
#'                              1316405939,
#'                              1720392988,
#'                              1518184605,
#'                              1922056829,
#'                              1083879860))
#' npi_df |>
#' tibble::deframe() |>
#' purrr::map_dfr(provider_mppe)
#'
#' # Download First 1,000 Rows of Dataset =====================================
#' provider_mppe(full = TRUE)
#' }
#' @autoglobal
#' @export

provider_mppe <- function(npi = NULL,
                          last = NULL,
                          first = NULL,
                          type_desc = NULL,
                          clean_names = TRUE,
                          full = FALSE
) {

  # Check internet connection
  attempt::stop_if_not(
    curl::has_internet() == TRUE,
    msg = "Please check your internet connection.")

  # Medicare Fee-For-Service Public Provider Enrollment Base URL
  mppe_url <- "https://data.cms.gov/data-api/v1/dataset/2457ea29-fc82-48b0-86ec-3b0755de7515/data"

  # Create polite version
  polite_req <- polite::politely(
    httr2::request,
    verbose = FALSE,
    delay = 2)

  # Create request
  req <- polite_req(mppe_url)

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
    first = first,
    last = last,
    type_desc = type_desc),
    collapse = ",")

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

    message("NPI not in database")

  } else {

    # Clean names with janitor
    if (isTRUE(clean_names)) {

      results <- results |>
        janitor::clean_names()
    }

    return(results)
  }
}
