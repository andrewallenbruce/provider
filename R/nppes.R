#' National Registry of All Health Care Providers
#'
#' @description
#' `nppes()` allows you to search the National Plan and Provider Enumeration
#' System (NPPES) NPI Registry's public API, a free directory of all active
#' National Provider Identifier (NPI) records.
#'
#' **National Provider Identifier** <br>
#' Healthcare providers acquire their unique 10-digit NPIs to identify
#' themselves in a standard way throughout their industry. Once CMS supplies
#' an NPI, they publish the parts of the NPI record that have public relevance,
#' including the provider’s name, taxonomy and practice address.
#'
#' **Enumeration Type** <br>
#' Two categories of health care providers exist for NPI enumeration purposes:
#'
#' **Entity Type 1** <br>
#' Individual health care providers (including sole proprietors) may get an
#' NPI as **Entity Type 1**. As a sole proprietor, they must apply for the NPI
#' using their own SSN, not an Employer Identification Number (EIN) even if
#' they have an EIN. As a sole proprietor, they may get only one NPI, just like
#' any other individual. The following factors **do not** affect whether a sole
#' proprietor is an Entity Type 1:
#'
#'    - Number of different office locations
#'    - Whether they have employees
#'    - Whether the IRS issued them an EIN
#'
#' An **incorporated individual** is a single health care provider who forms
#' and conducts business under a corporation. A sole proprietor **is not** an
#' incorporated individual because the sole proprietor didn't form a
#' corporation. If you're a sole/solo practitioner, it doesn't necessarily mean
#' you're a sole proprietor, and vice versa. If you're an individual health care
#' provider who's incorporated, you may need to get an NPI for yourself
#' (Entity Type 1) and an NPI for your corporation or LLC (Entity Type 2).
#'
#' <br>
#'
#' **Entity Type 2** <br>
#' Organizational health care providers are group health care providers eligible
#' for NPIs as Entity Type 2. Organization health care providers may have a
#' single employee or thousands of employees. An example is an incorporated
#' individual who is an organization's only employee. Some organization health
#' care providers are made up of parts that work somewhat independently from
#' their parent organization. These parts may offer different types of health
#' care or offer health care in separate physical locations. These parts and
#' their physical locations aren't themselves legal entities but are part of
#' the organization health care provider (which is a legal entity). The NPI
#' Final Rule refers to the parts and locations as sub-parts. An organization
#' health care provider can get its sub-parts their own NPIs. If a sub-part
#' conducts any HIPAA standard transactions on its own (separately from its
#' parent), it must get its own NPI. Sub-part determination makes sure that
#' entities within a covered organization are uniquely identified in HIPAA
#' standard transactions they conduct with Medicare and other covered entities.
#' For example, a hospital offers acute care, laboratory, pharmacy, and
#' rehabilitation services. Each of these sub-parts may need its own NPI because
#' each sends its own standard transactions to one or more health plans. Sub-part
#' delegation doesn't affect Entity Type 1 health care providers. As individuals,
#' these health care providers can't choose sub-parts and are not sub-parts.
#'
#' **Authorized Official** <br>
#' An appointed official (e.g., chief executive officer, chief financial officer,
#' general partner, chairman of the board, or direct owner) to whom the
#' organization has granted the legal authority to enroll it in the Medicare
#' program, to make changes or updates to the organization's status in the
#' Medicare program, and to commit the organization to fully abide by the
#' statutes, regulations, and program instructions of the Medicare program.
#'
#' **Links**
#' - [NPPES NPI Registry API Documentation](https://npiregistry.cms.hhs.gov/api-page)
#' - [NPPES NPI Registry API Demo](https://npiregistry.cms.hhs.gov/demo-api)
#'
#' *Update Frequency:* **Weekly**
#'
#' @param npi 10-digit National Provider Identifier (NPI).
#' @param entype Entity type. Choices are either `I` for an Individual provider
#'    or `O` for an Organizational provider. Cannot be the only criteria entered.
#' @param first_name Individual provider's first name. Trailing
#'    wildcard entries are permitted requiring at least two characters to be
#'    entered (e.g. `jo*` ).
#' @param last_name Individual provider's last name. Trailing wildcard
#'    entries are permitted requiring at least two characters to be entered
#'    (e.g. `jo*` ).
#' @param purpose_name Refers to whether the name information entered pertains
#'    to an Authorized Official's name or a Provider's name. When not specified,
#'    the results will search against a provider's first and last name. AO will
#'    only search against Authorized Official names. While PROVIDER will only
#'    search against Provider name. Valid values are: `AO` and `Provider.`
#' @param org_name Healthcare organization's name (NPI-2). Trailing wildcard
#'    entries are permitted requiring at least two characters to be entered.
#'    All types of Organization Names (LBN, DBA, Former LBN, Other Name)
#'    associated with an NPI are examined for matching contents, therefore, the
#'    results might contain an organization name different from the one entered
#'    in the Organization Name criterion.
#' @param taxonomy_desc Search for providers by their taxonomy by entering the
#'    taxonomy description.
#' @param city City associated with the provider's address. To search for a
#'    Military Address, enter either `APO` or `FPO`.
#' @param state State abbreviation associated with the provider's address. If
#'    this field is used, at least one other field, besides the `entype` and
#'    `country`, must be populated.
#' @param zip The Postal Code associated with the provider's address
#'    identified in Address Purpose. If you enter a 5 digit postal code, it
#'    will match any appropriate 9 digit (zip+4) codes in the data. Trailing
#'    wildcard entries are permitted requiring at least two characters to be
#'    entered (e.g., `21*`).
#' @param country Country abbreviation associated with the provider's
#'    address. This field **can** be used as the only input criterion, as long
#'    as the value selected *is not* `US` (United States).
#' @param limit Maximum number of results to return; default is 1200.
#' @param skip Number of results to skip after those set in `limit`.
#' @param tidy Tidy output; default is `TRUE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examples
#' nppes(npi = 1528060837, tidy = FALSE)
#' @autoglobal
#' @export
nppes <- function(npi = NULL,
                  entype = NULL,
                  first_name = NULL,
                  last_name = NULL,
                  org_name = NULL,
                  purpose_name   = NULL,
                  taxonomy_desc  = NULL,
                  city = NULL,
                  state = NULL,
                  zip = NULL,
                  country = NULL,
                  limit = 1200,
                  skip = NULL,
                  tidy = TRUE) {

  if (!is.null(npi))          {npi <- npi_check(npi)}
  if (!is.null(entype))       {entype <- entype_arg(entype)}
  if (!is.null(purpose_name)) {rlang::arg_match(purpose_name, c("AO", "Provider"))}
  if (!is.null(zip))          {zip <- as.character(zip)}

  request <- httr2::request("https://npiregistry.cms.hhs.gov/api/?version=2.1") |>
    httr2::req_url_query(number               = npi,
                         enumeration_type     = entype,
                         first_name           = first_name,
                         last_name            = last_name,
                         name_purpose         = purpose_name,
                         organization_name    = org_name,
                         taxonomy_description = taxonomy_desc,
                         city                 = city,
                         state                = state,
                         postal_code          = zip,
                         country_code         = country,
                         limit                = limit,
                         skip                 = skip) |>
    httr2::req_perform()

  response <- httr2::resp_body_json(request, simplifyVector = TRUE)

  res_cnt <- response$result_count

  if (is.null(res_cnt) || res_cnt == 0) {

    cli_args <- dplyr::tribble(
      ~x,              ~y,
      "npi",           npi,
      "entype",        entype,
      "first_name",    first_name,
      "last_name",     last_name,
      "purpose_name",  purpose_name,
      "org_name",      org_name,
      "taxonomy_desc", taxonomy_desc,
      "city",          city,
      "state",         state,
      "zip",           zip,
      "country",       country) |>
      tidyr::unnest(cols = c(y))

    cli_args <- purrr::map2(cli_args$x,
                            cli_args$y,
                            stringr::str_c,
                            sep = ": ",
                            collapse = "")

    cli::cli_alert_danger("No results for {.val {cli_args}}", wrap = TRUE)
    return(invisible(NULL))
  }

  results <- response$results |>
    dplyr::tibble() |>
    dplyr::select(npi = number,
                  entype = enumeration_type,
                  basic,
                  addresses,
                  taxonomy = taxonomies,
                  identifiers,
                  endpoints,
                  practice_locations = practiceLocations,
                  other_names,
                  dplyr::everything()) |>
    tidyr::unnest(c(basic))

  results[apply(results, 2, function(x) lapply(x, length) == 0)] <- NA

  if (tidy) {
    key <- dplyr::join_by(npi)

    # basic ------------------------------------------------------------------
    basic <- results |>
      dplyr::select(!c(addresses,
                       taxonomy,
                       identifiers,
                       endpoints,
                       practice_locations,
                       other_names))

    # addresses --------------------------------------------------------------
    address <- results |>
      dplyr::select(npi, addresses) |>
      tidyr::unnest(c(addresses)) |>
      dplyr::mutate(address_type = NULL,
                    country_name = NULL) |>
      dplyr::rename(country      = country_code,
                    phone = telephone_number,
                    zip      = postal_code,
                    purpose      = address_purpose) |>
      dplyr::mutate(purpose = dplyr::if_else(purpose == "LOCATION",
                                             "PRACTICE",
                                             purpose))


    # practice locations ------------------------------------------------------
    pracloc <- results |>
      dplyr::select(npi, practice_locations) |>
      tidyr::unnest(c(practice_locations))

    if (ncol(pracloc) > 2) {

      pracloc <- pracloc |>
        # tidyr::unite("street",
        #              dplyr::any_of(c("address_1", "address_2")),
        #              remove = TRUE, na.rm = TRUE, sep = " ") |>
        dplyr::mutate(address_type = NULL,
                      country_name = NULL) |>
        dplyr::rename(country      = country_code,
                      phone = telephone_number,
                      zip      = postal_code,
                      purpose      = address_purpose,
                      street       = address_1)

      address <- dplyr::bind_rows(address, pracloc)
    }

    final <- dplyr::left_join(basic, address, key)

    # taxonomy ----------------------------------------------------------------
    taxonomy <- results |>
      dplyr::select(npi, taxonomy) |>
      tidyr::unnest(c(taxonomy))

    if (ncol(taxonomy) > 2) {

      taxonomy <- taxonomy |>
        dplyr::select(npi,
                      tx_code = code,
                      tx_desc = desc,
                      tx_group = taxonomy_group,
                      tx_state = state,
                      tx_license = license,
                      tx_primary = primary)

      final <- dplyr::left_join(final, taxonomy, key)
    }

    # identifiers -------------------------------------------------------------
    identifiers <- results |>
      dplyr::select(npi, identifiers) |>
      tidyr::unnest(c(identifiers))

    if (ncol(identifiers) > 2) {

      identifiers <- identifiers |>
        dplyr::select(npi,
                      id_desc = desc,
                      id_issuer = issuer,
                      id_identifier = identifier,
                      id_state = state)

      final <- dplyr::left_join(final, identifiers, key)
    }

    # endpoints ---------------------------------------------------------------
    endpoints <- results |>
      dplyr::select(npi, endpoints) |>
      tidyr::unnest(c(endpoints))

    if (ncol(endpoints) > 2) {

      endpoints <- endpoints |>
        tidyr::unite("street",
                     dplyr::any_of(c("address_1", "address_2")),
                     remove = TRUE,
                     na.rm = TRUE,
                     sep = " ")
      names(endpoints) <- c("npi",
            paste0("end_", names(endpoints)[2:length(names(endpoints))]))

      final <- dplyr::left_join(final, endpoints, key)
    }

    # other names -------------------------------------------------------------
    other <- results |>
      dplyr::select(npi, other_names) |>
      tidyr::unnest(c(other_names))

    if (ncol(other) > 2) {

      names(other) <- c("npi",
           paste0("other_", names(other)[2:length(names(other))]))

      final <- dplyr::left_join(final, other, key)
    }

    # final post-join cleaning logic -----------------------------------------
    results <- final |>
      dplyr::mutate(dplyr::across(dplyr::contains("date"), ~anytime::anydate(.)),
                    dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., "")),
                    dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., "N/A")),
                    dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., "--")),
                    dplyr::across(dplyr::where(is.character), ~clean_credentials(.)),
                    entype = entype_char(entype),
                    dplyr::across(dplyr::any_of(c("sole_proprietor",
                                                  "organizational_subpart")),
                                  ~yn_logical(.)))

    valid_fields <- c("npi",
                      "entype",
                      "enumeration_date",
                      "last_updated",
                      "certification_date",
                      "status",
                      "organization_name",
                      "first_name",
                      "middle_name",
                      "last_name",
                      "credential",
                      "gender",
                      "organizational_subpart",
                      "sole_proprietor",
                      "purpose",
                      "address_1",
                      "address_2",
                      "city",
                      "state",
                      "zip",
                      "country",
                      "phone",
                      "fax_number",
                      "authorized_official_first_name",
                      "authorized_official_middle_name",
                      "authorized_official_last_name",
                      "authorized_official_title_or_position",
                      "authorized_official_telephone_number",
                      "authorized_official_credential",
                      "parent_organization_legal_business_name",
                      "tx_code",
                      "tx_desc",
                      "tx_group",
                      "tx_state",
                      "tx_license",
                      "tx_primary",
                      "id_desc",
                      "id_issuer",
                      "id_identifier",
                      "id_state")

    results <- results |>
      dplyr::select(dplyr::any_of(valid_fields),
                    dplyr::starts_with("end_"),
                    dplyr::starts_with("other_"),
                    dplyr::everything())

  }
  return(results)
}

#' Search the NPPES National Provider Identifier Registry API
#'
#' @description `nppes_npi()` allows you to search the NPPES NPI
#'    Registry's public API by many of the parameters defined in the
#'    API's documentation.
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
