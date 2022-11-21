#' Search the Medicare Provider and Supplier Taxonomy Crosswalk API
#'
#' @description A list of the type of providers and suppliers with the
#'    proper taxonomy code eligible for Medicare programs.
#'
#' # The Medicare Provider and Supplier Taxonomy Crosswalk
#'
#' This dataset lists the providers and suppliers eligible
#' to enroll in Medicare programs with the proper healthcare
#' provider taxonomy code. This data includes the Medicare
#' speciality codes, if available, provider/supplier type
#' description, taxonomy code, and the taxonomy description.
#' This dataset is derived from information gathered from the
#' **National Plan and Provider Enumerator System** (NPPES) and the
#' **Provider Enrollment, Chain and Ownership System** (PECOS).
#'
#' ## Data Update Frequency
#' Weekly
#'
#' ## Data Source
#' Centers for Medicare & Medicaid Services
#'
#' ## Links
#' * [Medicare Provider and Supplier Taxonomy Crosswalk API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/medicare-provider-and-supplier-taxonomy-crosswalk)
#' * [Medicare Find Your Taxonomy Code](https://www.cms.gov/Medicare/Provider-Enrollment-and-Certification/Find-Your-Taxonomy-Code)
#' * [National Uniform Claim Committee: Taxonomies](https://taxonomy.nucc.org/)
#'
#' # NUCC Taxonomy Codes
#'
#' The Healthcare Provider Taxonomy codes are a HIPAA standard code
#' set named in the implementation specifications for some of the
#' ASC X12 standard HIPAA transactions. If the Taxonomy code is
#' required in order to properly pay or process a claim/encounter
#' information transaction, it is required to be reported. Thus,
#' reporting of the Healthcare Provider Taxonomy Code varies from
#' one health plan to another. The National Uniform Claim Committee
#' (NUCC) maintains this list of 10-digit codes. A provider must
#' select a code when applying for an NPI number.
#'
#' Medicare does not use the taxonomy code for pricing a provider's
#' services. Medicare uses the provider information based on NPI,
#' locality and specialty (e.g., the specialty code in Medicare’s
#' database) to price appropriately.
#'
#' @param txn_code unique 10-character alphanumeric code that
#'    designates a provider’s classification and specialization.
#' @param desc description of taxonomy classification or specialization.
#' @param clean_names Clean column names with {janitor}'s
#'    `clean_names()` function; default is `TRUE`.
#' @param full If true, downloads the first 1000 rows of data;
#'    default is `FALSE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examples
#' \dontrun{
#' provider_mpstc(txn_code = "2086S0102X")
#'
#' provider_mpstc(desc = "surgery")
#'
#' # Unnamed List of NPIs
#' npi_list <- c(1003026055,
#'               1316405939,
#'               1720392988,
#'               1518184605,
#'               1922056829,
#'               1083879860)
#'
#' npi_list |> purrr::map_dfr(provider_nppes) |>
#'             dplyr::group_split(outcome) |>
#'             purrr::map_dfr(provider_unpack) |>
#'             dplyr::distinct(taxon_code) |>
#'             tibble::deframe() |>
#'             purrr::map_dfr(provider_mpstc)
#'
#' # Download First 1,000 Rows of Dataset =====================================
#' provider_mpstc(full = TRUE)
#' }
#' @autoglobal
#' @export

provider_mpstc <- function(txn_code    = NULL,
                           desc        = NULL,
                           clean_names = TRUE,
                           full        = FALSE) {

  # Check internet connection
  attempt::stop_if_not(curl::has_internet() == TRUE,
    msg = "Please check your internet connection.")

  # Medicare Provider and Supplier Taxonomy Crosswalk Base URL
  mpstc_url <- "https://data.cms.gov/data-api/v1/dataset/113eb0bc-0c9a-4d91-9f93-3f6b28c0bf6b/data"

  # Create request
  req <- httr2::request(mpstc_url)

  if (isTRUE(full)) {

    # Send and save response
    resp <- req |>
      httr2::req_url_query() |>
      httr2::req_perform()

  } else if (!is.null(txn_code)) {

  # strip spaces
  txn_code <- gsub(pattern = " ", replacement = "", txn_code)

  # Number of characters should be 10
  attempt::stop_if_not(
    nchar(txn_code) == 10,
    msg = c("Taxonomy codes must have 10 characters. Provided code has ",
            nchar(txn_code),
            " characters."))

    # Send and save response
    resp <- req |>
      httr2::req_url_query(keyword = txn_code) |>
      httr2::req_throttle(50 / 60) |>
      httr2::req_perform()

  } else {

  # Create list of arguments
  arg <- stringr::str_c(c(
    desc = desc), collapse = ",")

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

    message("Taxonomy code is not in database")

  } else {

    # Clean names with janitor
    if (isTRUE(clean_names)) {

      results <- results |>
        janitor::clean_names()
    }

    return(results)
  }
}
