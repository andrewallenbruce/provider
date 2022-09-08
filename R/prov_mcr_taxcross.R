#' Search Medicare Provider and Supplier Taxonomy Crosswalk API
#'
#'A list of the type of providers and suppliers with the proper
#'taxonomy code eligible for medicare programs.
#'
#' @description The Medicare Provider and Supplier Taxonomy
#' Crosswalk dataset lists the providers and suppliers eligible
#' to enroll in Medicare programs with the proper healthcare
#' provider taxonomy code. This data includes the Medicare
#' speciality codes, if available, provider/supplier type
#' description, taxonomy code, and the taxonomy description.
#' This dataset is derived from information gathered from the
#' National Plan and Provider Enumerator System (NPPES) and the
#' Provider Enrollment, Chain and Ownership System (PECOS).
#'
#' @param taxonomy_code unique 10-character alphanumeric code that
#' designates a provider’s classification and specialization.
#'
#' @return A tibble containing the NPI(s) searched for,
#' the date-time the search was performed, and
#' a list-column of the results.
#'
#' @export
#'
#' @source https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/medicare-provider-and-supplier-taxonomy-crosswalk
#'
#' @examples
#' prov_mcr_taxcross("2086S0102X")

prov_mcr_taxcross <- function(taxonomy_code) {

  # Check internet connection
  attempt::stop_if_not(
    curl::has_internet() == TRUE,
    msg = "Please check your internet connection.")

  # strip spaces
  taxonomy_code <- gsub(pattern = " ", replacement = "", taxonomy_code)

  # Number of characters should be 10
  attempt::stop_if_not(
    nchar(taxonomy_code) == 10,
    msg = c("Taxonomy codes must have 10 characters. Provided code has ",
            nchar(taxonomy_code),
            " characters."))

  # Medicare Provider and Supplier Taxonomy Crosswalk Base URL
  mcr_tax_base_url <- "https://data.cms.gov/data-api/v1/dataset/113eb0bc-0c9a-4d91-9f93-3f6b28c0bf6b/data"

  # Create polite version
  polite_req <- polite::politely(
    httr2::request,
    verbose = FALSE,
    delay = 2)

  # Create request
  req <- polite_req(mcr_tax_base_url)

  # Send and save response
  resp <- req |>
    httr2::req_url_query(keyword = taxonomy_code) |>
    httr2::req_throttle(50 / 60) |>
    httr2::req_perform()

  # Save time of API query
  datetime <- resp |> httr2::resp_date()

  # Parse JSON response and save results
  results <- resp |> httr2::resp_body_json(
    check_type = FALSE,
    simplifyVector = TRUE)

  return(results)
}
