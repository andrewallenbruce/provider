#' Search the NPPES National Provider Identifier (NPI) Registry API
#'
#' @description `provider_nppes()` allows you to search the NPPES NPI
#'    Registry's public API by many of the parameters defined in the
#'    API's documentation.
#'
#' # The NPPES NPI Public Registry
#'
#' The NPPES NPI Registry Public Search is a free directory of all
#' active National Provider Identifier (NPI) records. Healthcare providers
#' acquire their unique 10-digit NPIs to identify themselves in a standard
#' way throughout their industry. After CMS supplies an NPI, they publish
#' the parts of the NPI record that have public relevance, including the
#' provider’s name, taxonomy and practice address. It enables you to search
#' for providers in the NPPES (National Plan and Provider Enumeration System.)
#' All information produced by the NPI Registry is provided in accordance with
#' the NPPES Data Dissemination Notice. There is no charge to use the NPI Registry.
#'
#' @param npi 10-digit National Provider Identifier (NPI).
#' @param first Provider's first name. Applies to
#'    **Individual Providers (NPI-1)** only. Trailing wildcard entries are
#'    permitted requiring at least two characters to be entered (e.g. "jo*" ).
#'    This field allows the following special characters: ampersand(`&`),
#'    apostrophe(`,`), colon(`:`), comma(`,`), forward slash(`/`),
#'    hyphen(`-`), left and right parentheses(`()`), period(`.`),
#'    pound sign(`#`), quotation mark(`"`), and semi-colon(`;`).
#' @param last Provider's last name. Applies to
#'    **Individual Providers (NPI-1)** only. Trailing wildcard entries are
#'    permitted requiring at least two characters to be entered (e.g. "jo*" ).
#'    This field allows the following special characters: ampersand(`&`),
#'    apostrophe(`,`), colon(`:`), comma(`,`), forward slash(`/`),
#'    hyphen(`-`), left and right parentheses(`()`), period(`.`),
#'    pound sign(`#`), quotation mark(`"`), and semi-colon(`;`).
#' @param org Healthcare organization's name. Applies to
#'    **Organizational Providers (NPI-2)** only. Trailing wildcard entries are
#'    permitted requiring at least two characters to be entered. All types of
#'    Organization Names (LBN, DBA, Former LBN, Other Name) associated with an
#'    NPI are examined for matching contents, therefore, the results might
#'    contain an organization name different from the one entered in the
#'    Organization Name criterion. This field allows the following special
#'    characters: ampersand, apostrophe, "at" sign, colon, comma, forward
#'    slash, hyphen, left and right parentheses, period, pound sign, quotation
#'    mark, and semi-colon.
#' @param city City associated with the provider's address. To search for a
#'    Military Address, enter either `APO` or `FPO` into the City field.
#'    This field allows the following special characters: ampersand,
#'    apostrophe, colon, comma, forward slash, hyphen, left and right
#'    parentheses, period, pound sign, quotation mark, and semi-colon.
#' @param state_abbr State abbreviation associated with the provider's address.
#'    This field **cannot** be used as the only input criterion. If this
#'    field is used, at least one other field, besides the `prov_type` and
#'    `country_abbr`, must be populated. Valid values for state abbreviations:
#'    \url{https://npiregistry.cms.hhs.gov/help-api/state}.
#' @param country_abbr Country abbreviation associated with the provider's
#'    address. This field **can** be used as the only input criterion, as long
#'    as the value selected *is not* **US** (United States). Valid values for
#'    country abbreviations:
#'    \url{https://npiregistry.cms.hhs.gov/help-api/country}.
#' @param limit Maximum number of results to return;
#'    default is 10, maximum is 1200.
#' @param skip Number of results to skip after searching
#'    the previous number; set in `limit`.
#'
#' @return A [tibble()] containing the date-time the search was performed
#'    and a list-column of the results.
#'
#' @references
#'    \url{https://npiregistry.cms.hhs.gov/api-page}
#'    \url{https://npiregistry.cms.hhs.gov/search}
#'
#' @seealso [provider_unpack()], [provider_luhn()]
#'
#' @examples
#' \dontrun{
#' # Single NPI ==============================================================
#' provider_nppes(npi = 1528060837)
#'
#' # City, state, country ====================================================
#' provider_nppes(city = "Atlanta",
#'                state_abbr = "GA",
#'                country_abbr = "US")
#'
#' # First name, city, state  ================================================
#' provider_nppes(first = "John",
#'                city = "Baltimore",
#'                state_abbr = "MD")
#'
#' # List of NPIs
#' npi_list <- c(1003026055,
#'               1316405939,
#'               1720392988,
#'               1518184605,
#'               1922056829,
#'               1083879860)
#'
#' npi_list |>
#' purrr::map_dfr(provider_nppes) |>
#' dplyr::group_split(outcome) |>
#' purrr::map_dfr(provider_unpack)
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
#' purrr::map_dfr(provider_nppes)
#' }
#' @export

provider_nppes <- function(npi = NULL,
                           first = NULL,
                           last = NULL,
                           org = NULL,
                           city = NULL,
                           state_abbr = NULL,
                           country_abbr = NULL,
                           limit = 10,
                           skip = NULL) {

  # Check internet connection
  attempt::stop_if_not(curl::has_internet() == TRUE,
    msg = "Please check your internet connection.")

  if (!is.null(npi)) {

    # Luhn check
    attempt::stop_if_not(
      provider::provider_luhn(npi) == TRUE,
      msg = "Luhn Check: NPI may be invalid.")

  }

  # Limit must be between 1 and 1200
  attempt::stop_if_not(limit > 1 || limit < 1200,
    msg = "Limit must be between 1 and 1200.")

  # Strip any spaces
  first <- gsub(pattern = " ", replacement = "", first)
  last <- gsub(pattern = " ", replacement = "", last)
  city <- gsub(pattern = " ", replacement = "", city)
  state_abbr <- gsub(pattern = " ", replacement = "", state_abbr)
  country_abbr <- gsub(pattern = " ", replacement = "", country_abbr)

  # NPPES Base URL
  nppes_base_url <- "https://npiregistry.cms.hhs.gov/api/?version=2.1"

  # Create polite version
  polite_req <- polite::politely(
    httr2::request,
    verbose = FALSE,
    delay = 2)

  # Create request
  req <- polite_req(nppes_base_url) |>
    httr2::req_cache(tempdir())


  # Send and save response
  resp <- req |>
    httr2::req_url_query(number = npi,
                         first_name = first,
                         last_name = last,
                         organization_name = org,
                         city = city,
                         state = state_abbr,
                         country_code = country_abbr,
                         limit = limit,
                         skip = skip) |>
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

  # Append time of API query to results
  results$datetime <- datetime

  # Move columns to beginning
  results <- results |>
    dplyr::relocate(datetime)

  # Filter out resultCount rows
  results <- results |>
    dplyr::filter(outcome != "resultCount")

  return(results)
}
