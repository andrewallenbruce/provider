#' Search the NPPES National Provider Identifier Registry API
#'
#' @description `provider_nppes()` allows you to search the NPPES NPI
#'    Registry's public API by many of the parameters defined in the
#'    API's documentation.
#'
#' @details The NPPES NPI Registry Public Search is a free directory of all
#'    active National Provider Identifier (NPI) records. Healthcare providers
#'    acquire their unique 10-digit NPIs to identify themselves in a standard
#'    way throughout their industry. After CMS supplies an NPI, they publish
#'    the parts of the NPI record that have public relevance, including the
#'    provider’s name, taxonomy and practice address. It enables you to search
#'    for providers in the NPPES (National Plan and Provider Enumeration
#'    System.) All information produced by the NPI Registry is provided in
#'    accordance with the NPPES Data Dissemination Notice. There is no charge
#'    to use the NPI Registry.
#'
#' ## Links
#' * [NPPES NPI Registry API Documentation](https://npiregistry.cms.hhs.gov/api-page)
#' * [NPPES NPI Registry API Demo](https://npiregistry.cms.hhs.gov/demo-api)
#'
#' @source Centers for Medicare & Medicaid Services
#' @note Update Frequency: **Weekly**
#'
#' @param npi 10-digit National Provider Identifier (NPI).
#' @param prov_type The Read API can be refined to retrieve only Individual
#'    Providers (`NPI-1` or Type 1) or Organizational Providers (`NPI-2` or
#'    Type 2.) When not specified, both Type 1 and Type 2 NPIs will be
#'    returned. When using the Enumeration Type, it cannot be the only
#'    criteria entered. Additional criteria must also be entered as well.
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
#' @param org_name Healthcare organization's name. Applies to
#'    **Organizational Providers (NPI-2)** only. Trailing wildcard entries are
#'    permitted requiring at least two characters to be entered. All types of
#'    Organization Names (LBN, DBA, Former LBN, Other Name) associated with an
#'    NPI are examined for matching contents, therefore, the results might
#'    contain an organization name different from the one entered in the
#'    Organization Name criterion. This field allows the following special
#'    characters: ampersand, apostrophe, "at" sign, colon, comma, forward
#'    slash, hyphen, left and right parentheses, period, pound sign, quotation
#'    mark, and semi-colon.
#' @param taxonomy Search for providers by their taxonomy by entering the
#'    taxonomy description.
#' @param city City associated with the provider's address. To search for a
#'    Military Address, enter either `APO` or `FPO` into the City field.
#'    This field allows the following special characters: ampersand,
#'    apostrophe, colon, comma, forward slash, hyphen, left and right
#'    parentheses, period, pound sign, quotation mark, and semi-colon.
#' @param state State abbreviation associated with the provider's address.
#'    This field **cannot** be used as the only input criterion. If this
#'    field is used, at least one other field, besides the `prov_type` and
#'    `country`, must be populated. Valid values for state abbreviations:
#'    \url{https://npiregistry.cms.hhs.gov/help-api/state}.
#' @param zip The Postal Code associated with the provider's address
#'    identified in Address Purpose. If you enter a 5 digit postal code, it
#'    will match any appropriate 9 digit (zip+4) codes in the data. Trailing
#'    wildcard entries are permitted requiring at least two characters to be
#'    entered (e.g., "21*").
#' @param country Country abbreviation associated with the provider's
#'    address. This field **can** be used as the only input criterion, as long
#'    as the value selected *is not* **US** (United States). Valid values for
#'    country abbreviations:
#'    \url{https://npiregistry.cms.hhs.gov/help-api/country}.
#' @param limit Maximum number of results to return;
#'    default is 200, maximum is 1200.
#' @param skip Number of results to skip after searching
#'    the previous number; set in `limit`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examples
#' \dontrun{
#' ### Single NPI
#' nppes_npi(npi = 1528060837)
#'
#' ### City, state, country
#' nppes_npi(city = "Atlanta",
#'           state = "GA",
#'           country = "US")
#'
#' ### First name, city, state
#' nppes_npi(first = "John",
#'           city = "Baltimore",
#'           state = "MD")
#'
#' nppes_npi(npi = 1336413418) # NPI-2
#' nppes_npi(npi = 1710975040) # NPI-1
#' nppes_npi(npi = 1659781227) # Deactivated
#'
#' ### List of NPIs
#' npi_list <- c(1003026055,
#'               1710983663,
#'               1316405939,
#'               1720392988,
#'               1518184605,
#'               1922056829,
#'               1083879860)
#'
#' npi_list |>
#' purrr::map_dfr(nppes_npi) |>
#' dplyr::group_split(outcome)
#'
#' ### Data frame of NPIs
#' npi_df <- data.frame(npi = c(1710983663,
#'                              1003026055,
#'                              1316405939,
#'                              1720392988,
#'                              1518184605,
#'                              1922056829,
#'                              1083879860))
#' npi_df |>
#' tibble::deframe() |>
#' purrr::map_dfr(nppes_npi)
#'
#' ###Tribble example
#' tribble <- tibble::tribble(
#' ~fn,         ~params,
#' "nppes_npi", list(1336413418),
#' "nppes_npi", list(1710975040),
#' "nppes_npi", list(1659781227),
#' "nppes_npi", list(first = "John", city = "Baltimore", state = "MD"),
#' "nppes_npi", list(first = "Andrew", city = "Atlanta", state = "GA"))
#'
#' purrr::invoke_map_dfr(tribble$fn, tribble$params)
#' }
#' @autoglobal
#' @export

nppes_npi <- function(npi       = NULL,
                      prov_type = NULL,
                      first     = NULL,
                      last      = NULL,
                      org_name  = NULL,
                      taxonomy  = NULL,
                      city      = NULL,
                      state     = NULL,
                      zip       = NULL,
                      country   = NULL,
                      limit     = 200,
                      skip      = NULL) {

  # base URL ---------------------------------------------------------------
  url <- "https://npiregistry.cms.hhs.gov/api/?version=2.1"

  # request and response ----------------------------------------------------
  resp <- httr2::request(url) |>
          httr2::req_url_query(number               = npi,
                               enumeration_type     = prov_type,
                               first_name           = first,
                               last_name            = last,
                               organization_name    = org_name,
                               taxonomy_description = taxonomy,
                               city                 = city,
                               state                = state,
                               postal_code          = zip,
                               country_code         = country,
                               limit                = limit,
                               skip                 = skip) |>
          httr2::req_perform()

  res <- httr2::resp_body_json(resp,
                               check_type = FALSE,
                               simplifyVector = TRUE)

  # Remove result_count header
  res$result_count <- NULL

  # Convert to tibble
  results <- tibble::enframe(res, name = "outcome", value = "data_lists") |>
    dplyr::mutate(datetime = httr2::resp_date(resp), .before = 1) |>
    tidyr::unnest(cols = c(data_lists))

  if (nrow(dplyr::filter(results, outcome == "Errors")) >= 1) {
    results <- results |> tidyr::nest(errors = c(description, field, number))}

  if (nrow(dplyr::filter(results, outcome == "results")) >= 1) {
    results <- results |>
      tidyr::unnest(cols = c(basic)) |>
      tidyr::nest(dates = c(enumeration_date,
                            last_updated,
                            created_epoch,
                            last_updated_epoch))}

  return(results)

}
