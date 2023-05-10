#' Search the NPPES National Provider Identifier Registry API
#'
#' @description `nppes_npi()` allows you to search the NPPES NPI
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
#' @param npi 10-digit National Provider Identifier (NPI).
#' @param entype The Read API can be refined to retrieve only Individual
#'    Providers (`NPI-1` or Type 1) or Organizational Providers (`NPI-2` or
#'    Type 2.) When not specified, both Type 1 and Type 2 NPIs will be
#'    returned. When using the Enumeration Type, it cannot be the only
#'    criteria entered. Additional criteria must also be entered as well.
#' @param first_name Provider's first name. Applies to
#'    **Individual Providers (NPI-1)** only. Trailing wildcard entries are
#'    permitted requiring at least two characters to be entered (e.g. "jo*" ).
#'    This field allows the following special characters: ampersand(`&`),
#'    apostrophe(`,`), colon(`:`), comma(`,`), forward slash(`/`),
#'    hyphen(`-`), left and right parentheses(`()`), period(`.`),
#'    pound sign(`#`), quotation mark(`"`), and semi-colon(`;`).
#' @param last_name Provider's last name. Applies to
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
#' @param taxonomy_desc Search for providers by their taxonomy by entering the
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
#' @param zipcode The Postal Code associated with the provider's address
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
#' @param tidy Tidy output; default is `TRUE`.
#' @examplesIf interactive()
#' nppes_npi(npi = 1528060837)
#' @return A [tibble][tibble::tibble-package] containing the search results.
#' @autoglobal
#' @export
nppes_npi <- function(npi            = NULL,
                      entype      = NULL,
                      first_name     = NULL,
                      last_name      = NULL,
                      org_name       = NULL,
                      taxonomy_desc  = NULL,
                      city           = NULL,
                      state          = NULL,
                      zipcode        = NULL,
                      country        = NULL,
                      limit          = 1200,
                      skip           = NULL,
                      tidy           = TRUE) {

  # request and response ----------------------------------------------------
  request <- httr2::request("https://npiregistry.cms.hhs.gov/api/?version=2.1") |>
    httr2::req_url_query(number               = npi,
                         enumeration_type     = entype,
                         first_name           = first_name,
                         last_name            = last_name,
                         organization_name    = org_name,
                         taxonomy_description = taxonomy_desc,
                         city                 = city,
                         state                = state,
                         postal_code          = zipcode,
                         country_code         = country,
                         limit                = limit,
                         skip                 = skip) |>
    httr2::req_perform()

  # parse response ---------------------------------------------------------
  response <- httr2::resp_body_json(request,
                                check_type = FALSE,
                                simplifyVector = TRUE)

  res_cnt <- response$result_count
  # no search results returns empty tibble ----------------------------------
  if (is.null(res_cnt) | res_cnt == 0) {

    cli_args <- tibble::tribble(
      ~x,              ~y,
      "npi",           as.character(npi),
      "enum_type",     entype,
      "first_name",    first_name,
      "last_name",     last_name,
      "org_name",      org_name,
      "taxonomy_desc", taxonomy_desc,
      "city",          city,
      "state",         state,
      "zipcode",       as.character(zipcode),
      "country",       country) |>
      tidyr::unnest(cols = c(y))

    cli_args <- purrr::map2(cli_args$x,
                            cli_args$y,
                            stringr::str_c,
                            sep = ": ",
                            collapse = "")

    cli::cli_alert_danger("No results for {.val {cli_args}}",
                          wrap = TRUE)
    return(invisible(NULL))
  }

  results <- response$results |> dplyr::tibble()
return(results)
  if (tidy) {

    results <- results |>
      dplyr::select(npi = number,
                    entype = enumeration_type,
                    basic,
                    addresses,
                    taxonomy = taxonomies) |>
      tidyr::unnest(basic) |>
      dplyr::mutate(dplyr::across(dplyr::contains("date"), ~parsedate::parse_date(.)),
                    dplyr::across(dplyr::contains("date"), ~lubridate::ymd(.)),
                    dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., "")),
                    dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., "N/A")),
                    dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., "--")),
                    dplyr::across(dplyr::where(is.character), ~clean_credentials(.)),
                    enumeration_duration = lubridate::as.duration(lubridate::today() - enumeration_date),
                    entype = entype_char(entype),
                    dplyr::across(dplyr::any_of(c("sole_proprietor", "organizational_subpart")), ~yn_logical(.)))

      # replace empty lists with NA -------------------------------------------
      results[apply(results, 2, function(x) lapply(x, length) == 0)] <- NA

      # addresses --------------------------------------------------------------
      address <- results |>
        dplyr::select(npi, addresses) |>
        tidyr::unnest(addresses) |>
        tidyr::unite("street",
                     dplyr::any_of(c("address_1", "address_2")),
                     remove = TRUE,
                     na.rm = TRUE,
                     sep = " ") |>
        dplyr::mutate(address_purpose = tolower(address_purpose),
                      address_type = NULL,
                      country_code = NULL) |>
        dplyr::rename(country = country_name,
                      phone_number = telephone_number,
                      zipcode = postal_code) |>
        dplyr::filter(address_purpose == "location") |>
        dplyr::select(!address_purpose)

      # tidyr::pivot_wider(id_cols = dplyr::any_of(c("npi", "country")),
      #   names_from = address_purpose,
      #                    values_from = dplyr::any_of(c("street", "city",
      #                                                  "state", "zipcode",
      #                                                  "phone", "fax")),
      #                    names_glue = "{address_purpose}_{.value}")

      results <- results |>
        dplyr::select(!addresses) |>
        dplyr::left_join(address, dplyr::join_by(npi))

      ## Some taxonomies are all labelled
      ## primary = FALSE nppes_npi(npi = 1558364273)

      # tidyr::unnest(taxonomy, names_sep = "_") |>
      # dplyr::filter(taxonomy_primary == TRUE) |>
      # dplyr::select(!c(taxonomy_taxonomy_group, taxonomy_primary)) |>
      # janitor::remove_empty(which = c("rows", "cols"))

      valid_fields <- c("npi",
                        "entype",
                        "enumeration_date",
                        "enumeration_duration",
                        "last_updated",
                        "certification_date",
                        "status",
                        "organization_name",
                        "organizational_subpart",
                        "first_name",
                        "middle_name",
                        "last_name",
                        "credential",
                        "gender",
                        "sole_proprietor",
                        "country",
                        "street",
                        "city",
                        "state",
                        "zipcode",
                        "phone_number",
                        "fax_number",
                        "taxonomy_code",
                        "taxonomy_desc",
                        "taxonomy_state",
                        "taxonomy_license")

      results <- results |>
        dplyr::select(dplyr::any_of(valid_fields))

      }
  return(results)
}

#' Search the NPPES National Provider Identifier Registry API
#'
#' @description `nppes_npi_multi()` allows you to search the NPPES NPI
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
#' @param df data frame, tibble
#' @autoglobal
#' @export
nppes_npi_multi <- function(df) {

  npis <- df |>
    tibble::deframe() |>
    as.list()

  results <- npis |>
    purrr::map(nppes_npi) |>
    dplyr::bind_rows()

  return(results)
}


#' Search the NPPES National Provider Identifier Registry API
#'
#' @description `nppes_npi()` allows you to search the NPPES NPI
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
#' @param enum_type The Read API can be refined to retrieve only Individual
#'    Providers (`NPI-1` or Type 1) or Organizational Providers (`NPI-2` or
#'    Type 2.) When not specified, both Type 1 and Type 2 NPIs will be
#'    returned. When using the Enumeration Type, it cannot be the only
#'    criteria entered. Additional criteria must also be entered as well.
#' @param first_name Provider's first name. Applies to
#'    **Individual Providers (NPI-1)** only. Trailing wildcard entries are
#'    permitted requiring at least two characters to be entered (e.g. "jo*" ).
#'    This field allows the following special characters: ampersand(`&`),
#'    apostrophe(`,`), colon(`:`), comma(`,`), forward slash(`/`),
#'    hyphen(`-`), left and right parentheses(`()`), period(`.`),
#'    pound sign(`#`), quotation mark(`"`), and semi-colon(`;`).
#' @param last_name Provider's last name. Applies to
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
#' @param taxonomy_desc Search for providers by their taxonomy by entering the
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
#' nppes_npi(npi = 1336413418)
#'
#' ### City, state, country
#' nppes_npi(city = "Atlanta",
#'           state = "GA",
#'           country = "US")
#'
#' ### First name, city, state
#' nppes_npi(first_name = "John",
#'           city = "Baltimore",
#'           state = "MD")
#'
#' nppes_npi(npi = 1336413418) # NPI-2
#' nppes_npi(npi = 1710975040) # NPI-1
#' nppes_npi(npi = 1659781227) # Deactivated
#'
#' ### List of NPIs
#' npi_list <- c(1003026055, 1710983663, 1316405939, 1720392988, 1518184605, 1922056829, 1083879860)
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
#' "nppes_npi", list(first_name = "John", city = "Baltimore", state = "MD"),
#' "nppes_npi", list(first_name = "Andrew", city = "Atlanta", state = "GA"))
#'
#' purrr::invoke_map_dfr(tribble$fn, tribble$params)
#' }
#' @autoglobal
#' @noRd
nppes_npi_old <- function(npi            = NULL,
                          enum_type      = NULL,
                          first_name     = NULL,
                          last_name      = NULL,
                          org_name       = NULL,
                          taxonomy_desc  = NULL,
                          city           = NULL,
                          state          = NULL,
                          zip            = NULL,
                          country        = NULL,
                          limit          = 200,
                          skip           = NULL) {

  # base URL ---------------------------------------------------------------
  url <- "https://npiregistry.cms.hhs.gov/api/?version=2.1"

  # request and response ----------------------------------------------------
  resp <- httr2::request(url) |>
    httr2::req_url_query(number               = npi,
                         enumeration_type     = enum_type,
                         first_name           = first_name,
                         last_name            = last_name,
                         organization_name    = org_name,
                         taxonomy_description = taxonomy_desc,
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
    results <- results |> tidyr::nest(errors = c(description, field, number))
    return(results)
  }

  if (nrow(dplyr::filter(results, outcome == "results")) >= 1) {
    results <- results |> tidyr::nest(epochs = c(created_epoch, last_updated_epoch))}

  if (nrow(dplyr::filter(results, enumeration_type == "NPI-2")) >= 1) {
    results <- results |>
      tidyr::unnest(c(basic), keep_empty = TRUE, names_sep = "_") |>
      dplyr::mutate(name = basic_organization_name, .after = 4) |>
      tidyr::nest(authorized_official = tidyr::contains("authorized"),
                  basic = tidyr::contains("basic")) |>
      tidyr::hoist(addresses, city = list("city", 2L), state = list("state", 2L), .remove = FALSE)
    return(results)
  }

  if (nrow(dplyr::filter(results, enumeration_type == "NPI-1")) >= 1) {
    results <- results |>
      tidyr::unnest(c(basic), keep_empty = TRUE, names_sep = "_") |>
      dplyr::mutate(name = stringr::str_c(basic_first_name, basic_last_name, sep = " "), .after = 4) |>
      tidyr::nest(basic = tidyr::contains("basic")) |>
      tidyr::hoist(addresses, city = list("city", 2L), state = list("state", 2L), .remove = FALSE)
    return(results)
  }

  #results[apply(results, 2, function(x) lapply(x, length) == 0)] <- NA

}
