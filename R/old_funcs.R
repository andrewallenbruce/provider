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
#' ## Data Update Frequency
#' Weekly
#'
#' ## Data Source
#' Centers for Medicare & Medicaid Services
#'
#' ## Links
#' * [NPPES National Provider Identifier (NPI) Registry API](https://npiregistry.cms.hhs.gov/api-page)
#' * [NPPES NPI Registry Search](https://npiregistry.cms.hhs.gov/search)
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
#' @param state State abbreviation associated with the provider's address.
#'    This field **cannot** be used as the only input criterion. If this
#'    field is used, at least one other field, besides the `prov_type` and
#'    `country`, must be populated. Valid values for state abbreviations:
#'    \url{https://npiregistry.cms.hhs.gov/help-api/state}.
#' @param country Country abbreviation associated with the provider's
#'    address. This field **can** be used as the only input criterion, as long
#'    as the value selected *is not* **US** (United States). Valid values for
#'    country abbreviations:
#'    \url{https://npiregistry.cms.hhs.gov/help-api/country}.
#' @param limit Maximum number of results to return;
#'    default is 10, maximum is 1200.
#' @param skip Number of results to skip after searching
#'    the previous number; set in `limit`.
#'
#' @return A [tibble][tibble::tibble-package] containing the date-time the search was performed
#'    and a list-column of the results.
#'
#' @examples
#' \dontrun{
#' # Single NPI
#' provider_nppes(npi = 1528060837)
#'
#' # City, state, country
#' provider_nppes(city = "Atlanta",
#'                state = "GA",
#'                country = "US")
#'
#' # First name, city, state
#' provider_nppes(first = "John",
#'                city = "Baltimore",
#'                state = "MD")
#'
#' provider_nppes(npi = 1336413418) # NPI-2
#' provider_nppes(npi = 1710975040) # NPI-1
#' provider_nppes(npi = 1659781227) # Deactivated
#'
#' # List of NPIs
#' npi_list <- c(1003026055,
#'               1710983663,
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
#' npi_df <- data.frame(npi = c(1710983663,
#'                              1003026055,
#'                              1316405939,
#'                              1720392988,
#'                              1518184605,
#'                              1922056829,
#'                              1083879860))
#' npi_df |>
#' tibble::deframe() |>
#' purrr::map_dfr(provider_nppes)
#' }
#' @autoglobal
#' @noRd

provider_nppes <- function(npi     = NULL,
                           first   = NULL,
                           last    = NULL,
                           org     = NULL,
                           city    = NULL,
                           state   = NULL,
                           country = NULL,
                           limit   = 10,
                           skip    = NULL) {

  # Check internet connection
  attempt::stop_if_not(curl::has_internet() == TRUE,
                       msg = "Please check your internet connection.")

  # Limit must be between 1 and 1200
  attempt::stop_if_not(limit > 1 || limit < 1200,
                       msg = "Limit must be between 1 and 1200.")

  # Strip any spaces
  first   <- gsub(pattern = " ", replacement = "", first)
  last    <- gsub(pattern = " ", replacement = "", last)
  city    <- gsub(pattern = " ", replacement = "", city)
  state   <- gsub(pattern = " ", replacement = "", state)
  country <- gsub(pattern = " ", replacement = "", country)

  # Uppercase
  state   <- stringr::str_to_upper(state)
  country <- stringr::str_to_upper(country)

  # NPPES Base URL
  nppes_url <- "https://npiregistry.cms.hhs.gov/api/?version=2.1"

  # Create request
  req <- httr2::request(nppes_url)

  # Send and save response
  resp <- req |>
    httr2::req_url_query(number            = npi,
                         first_name        = first,
                         last_name         = last,
                         organization_name = org,
                         city              = city,
                         state             = state,
                         country_code      = country,
                         limit             = limit,
                         skip              = skip) |>
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

  if (nrow(results |>
           dplyr::filter(outcome == "Errors")) >= 1 & !is.null(npi)) {

    npi_for_errors <- as.character(npi)

    results <- results |>
      tidyr::unnest(cols = c(data_lists)) |>
      dplyr::mutate(npi  = npi_for_errors,
                    prov_type = "Deactivated") |>
      dplyr::select(-description, -field, -number) |>
      tidyr::nest(data_lists  = c(npi, prov_type))

  }

  return(results)

}


#' Unpack NPPES NPI Registry Search Results
#'
#' @description `provider_unpack()` allows you to unpack the list-columns
#'    within the response from `provider_nppes()`.
#'
#' @param df [tibble][tibble::tibble-package] response from [provider_nppes()]
#' @param clean_names Clean column names with {janitor}'s
#'    `clean_names()` function; default is `TRUE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the unpacked
#' list-columns of a search performed with the [provider_nppes()] function.
#'
#' @seealso [provider_nppes()]
#'
#' @examples
#' \dontrun{
#' # Single NPI ==============================================================
#' provider_nppes(npi = 1528060837) |>
#' provider_unpack()
#'
#' # City, state, country ====================================================
#' provider_nppes(city = "Atlanta",
#'                state = "GA",
#'                country = "US") |>
#' provider_unpack()
#'
#' # First name, city, state  ================================================
#' provider_nppes(first = "John",
#'                city = "Baltimore",
#'                state = "MD") |>
#' provider_unpack()
#' }
#' @autoglobal
#' @noRd

provider_unpack <- function(df,
                            clean_names = TRUE) {

  # Check for data input
  if (missing(df)) stop("You haven't input a data frame.")

  # Handle any ERROR returns
  if (nrow(df |> dplyr::filter(outcome == "Errors")) >= 1) {

    results <- df |>
      dplyr::filter(outcome == "Errors") |>
      tidyr::unnest(data_lists) |>
      dplyr::select(!c(datetime, outcome))

  } else {

    # Start with base, unnest first level
    start <- df |>
      dplyr::filter(outcome == "results") |>
      tidyr::unnest(data_lists) |>
      dplyr::rename(npi = number,
                    prov_type = enumeration_type) |>
      dplyr::select(!c(datetime,
                       outcome,
                       created_epoch,
                       last_updated_epoch))

    # BASIC
    basic <- start |>
      dplyr::select(npi, prov_type, basic) |>
      tidyr::unnest(basic) |>
      dplyr::mutate(prov_type = dplyr::case_when(
        prov_type == "NPI-1" ~ as.character("Individual"),
        prov_type == "NPI-2" ~ as.character("Organization"),
        TRUE ~ as.character(prov_type)),
        sole_proprietor = dplyr::case_when(
          sole_proprietor == "NO" ~ as.logical(FALSE),
          sole_proprietor == "YES" ~ as.logical(TRUE),
          TRUE ~ NA))

    # Isolate lists & remove if empty
    lists <- start |>
      dplyr::select(!(basic)) |>
      dplyr::select(npi,
                    where(~ is.list(.x) &&
                            (insight::is_empty_object(.x) == FALSE)))

    # Replace Empty Lists with NA
    lists[apply(lists, 2, function(x) lapply(x, length) == 0)] <- NA

    # List names for identification
    ls_names <- tibble::enframe(names(lists))

    # ADDRESSES
    if (nrow(ls_names |> dplyr::filter(value == "addresses")) >= 1) {

      addresses <- lists |>
        dplyr::select(npi, addresses) |>
        tidyr::unnest(cols = c(addresses)) |>
        dplyr::mutate(
          address_purpose = stringr::str_to_lower(
            address_purpose)) |>
        dplyr::select(-c(country_name, address_type))

      #--Join Columns--#
      results <- dplyr::full_join(basic, addresses, by = "npi")

    } else {
      invisible("No Addresses")
    }

    # TAXONOMIES
    if (nrow(ls_names |> dplyr::filter(value == "taxonomies")) >= 1) {

      taxonomies <- lists |>
        dplyr::select(npi, taxonomies) |>
        tidyr::unnest(cols = c(taxonomies)) |>
        datawizard::data_addprefix("taxon_",
                                   exclude = c("npi", "taxonomy_group"))

      #--Join Columns--#
      results <- dplyr::full_join(results, taxonomies, by = "npi")

    } else {
      invisible("No Taxonomies")
    }

    # IDENTIFIERS
    if (nrow(ls_names |> dplyr::filter(value == "identifiers")) >= 1) {

      identifiers <- lists |>
        dplyr::select(npi, identifiers) |>
        tidyr::unnest(cols = c(identifiers)) |>
        datawizard::data_addprefix("ident_",
                                   exclude = c("npi", "identifier"))

      #--Join Columns--#
      results <- dplyr::full_join(results, identifiers, by = "npi")

    } else {
      invisible("No Identifiers")
    }

    # OTHER NAMES
    if (nrow(ls_names |> dplyr::filter(value == "other_names")) >= 1) {

      other_names <- lists |>
        dplyr::select(npi, other_names) |>
        tidyr::unnest(cols = c(other_names)) |>
        datawizard::data_addprefix("other_names_",
                                   exclude = "npi")

      #--Join Columns--#
      results <- dplyr::full_join(results, other_names, by = "npi")

    } else {
      invisible("No Other Names")
    }

    # PRACTICE LOCATIONS
    if (nrow(ls_names |> dplyr::filter(value == "practiceLocations")) >= 1) {

      practiceLocations <- lists |>
        dplyr::select(npi, practiceLocations) |>
        tidyr::unnest(cols = c(practiceLocations)) |>
        dplyr::rename(country_abb = country_code,
                      state_abb = state) |>
        datawizard::data_addprefix("pract_", exclude = "npi")

      #--Join Columns--#
      results <- dplyr::full_join(results, practiceLocations,
                                  by = "npi")

    } else {
      invisible("No Practice Locations")
    }

    # ENDPOINTS
    if (nrow(ls_names |> dplyr::filter(value == "endpoints")) >= 1) {

      endpoints <- lists |>
        dplyr::select(npi, endpoints) |>
        tidyr::unnest(cols = c(endpoints)) |>
        datawizard::data_addprefix("endpts_",
                                   exclude = "npi")

      #--Join Columns--#
      results <- dplyr::full_join(results, endpoints, by = "npi")

    } else {
      invisible("No Endpoints")
    }

  }

  # Clean names with janitor
  if (clean_names == TRUE) {

    results <- results |>
      janitor::clean_names()

    return(results)

  } else {

    return(results)
  }
}


#' Search the Medicare Revalidation Clinic Group Practice Reassignment API
#'
#' @description Information on clinic group practice revalidation
#'    for Medicare enrollment.
#'
#' # Medicare Revalidation Clinic Group Practice Reassignment API
#'
#' The Revalidation Clinic Group Practice Reassignment dataset
#' provides information between the physician and the group
#' practice they reassign their billing to. It also includes
#' individual employer association counts and the revalidation
#' dates for the individual physician as well as the clinic group
#' practice. This dataset is based on information gathered from the
#' Provider Enrollment, Chain and Ownership System (PECOS).
#'
#' ## Data Update Frequency
#' Monthly
#'
#' ## Data Source
#' Centers for Medicare & Medicaid Services
#'
#' ## Links
#'  * [Medicare Revalidation Clinic Group Practice Reassignment API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-clinic-group-practice-reassignment)
#'
#' @param npi 10-digit National Provider Identifier (NPI)
#' @param last Last name of provider who is reassigning their
#'    benefits or is an employee
#' @param first First name of provider who is reassigning their
#'    benefits or is an employee
#' @param clean_names Clean column names with {janitor}'s
#'    `clean_names()` function; default is `TRUE`.
#' @param full If true, downloads the first 1000 rows of data;
#'    default is `FALSE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examples
#' \dontrun{
#' provider_rcgpr(npi = 1427050418)
#'
#' provider_rcgpr(last = "Denney", first = "James")
#'
#' # Unnamed List of NPIs
#' npi_list <- c(1003026055,
#'               1871035477,
#'               1720392988,
#'               1518184605,
#'               1922056829,
#'               1083879860)
#'
#' npi_list |> purrr::map_dfr(provider_rcgpr)
#'
#' # Data frame of NPIs
#' npi_df <- data.frame(npi = c(1003026055,
#'                              1871035477,
#'                              1720392988,
#'                              1518184605,
#'                              1922056829,
#'                              1083879860))
#' npi_df |>
#' tibble::deframe() |>
#' purrr::map_dfr(provider_rcgpr)
#'
#' # Download First 1,000 Rows of Dataset =====================================
#' provider_rcgpr(full = TRUE)
#' }
#' @autoglobal
#' @noRd

provider_rcgpr <- function(npi        = NULL,
                           last        = NULL,
                           first       = NULL,
                           clean_names = TRUE,
                           full        = FALSE) {

  # Check internet connection
  attempt::stop_if_not(
    curl::has_internet() == TRUE,
    msg = "Please check your internet connection.")

  # Medicare Revalidation Clinic Group Practice Reassignment URL
  rcgpr_url <- "https://data.cms.gov/data-api/v1/dataset/e1f1fa9a-d6b4-417e-948a-c72dead8a41c/data"

  # Create request
  req <- httr2::request(rcgpr_url)

  if (isTRUE(full)) {

    # Send and save response
    resp <- req |>
      httr2::req_url_query() |>
      httr2::req_perform()

  } else if (!is.null(npi)) {

    # Send and save response
    resp <- req |>
      httr2::req_url_query(keyword = npi) |>
      httr2::req_throttle(50 / 60) |>
      httr2::req_perform()

  } else {

    # Create list of arguments
    arg <- stringr::str_c(c(
      last = last,
      first = first
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

#' Search the CMS Public Reporting of Missing Digital Contact Information API
#'
#' @description Information on providers that are missing digital contact
#'    information in NPPES.
#'
#' # Public Reporting of Missing Digital Contact Information
#'
#' In the May 2020 CMS Interoperability and Patient Access
#' final rule, CMS finalized the policy to publicly report the names
#' and NPIs of those providers who do not have digital contact
#' information included in the NPPES system (85 FR 25584). This
#' data includes the NPI and provider name of providers and
#' clinicians without digital contact information in NPPES. This data
#' is gathered from the NPPES for providers who are missing digital
#' contact information.
#'
#' ## Data Update Frequency
#' Quarterly
#'
#' ## Data Source
#' Centers for Medicare & Medicaid Services
#'
#' ## Links
#' * [CMS Public Reporting of Missing Digital Contact Information API](https://data.cms.gov/provider-compliance/public-reporting-of-missing-digital-contact-information)
#'
#' @param npi 10-digit National Provider Identifier (NPI)
#' @param last Provider's last name
#' @param first Provider's first name
#' @param clean_names Clean column names with {janitor}'s
#'    `clean_names()` function; default is `TRUE`.
#' @param full If true, downloads the first 1000 rows of data;
#'    default is `FALSE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examples
#' \dontrun{
#' provider_promdci(npi = 1760485387)
#' provider_promdci(npi = 1144224569)
#' provider_promdci(last = "Dewey", first = "Paul")
#'
#' # Unnamed List of NPIs
#' npi_list <- c(1003026055,
#'               1316405939,
#'               1720392988,
#'               1518184605,
#'               1922056829,
#'               1083879860)
#'
#' npi_list |> purrr::map_dfr(provider_promdci)
#'
#' # Returns the First 1,000 Rows in the Dataset
#' provider_promdci(full = TRUE)
#' }
#' @autoglobal
#' @noRd

provider_promdci <- function(npi         = NULL,
                             last        = NULL,
                             first       = NULL,
                             clean_names = TRUE,
                             full        = FALSE
) {

  # Check internet connection
  attempt::stop_if_not(
    curl::has_internet() == TRUE,
    msg = "Please check your internet connection.")

  # CMS Missing Digital Contact Information Base URL
  promdci_url <- "https://data.cms.gov/data-api/v1/dataset/63a83bb1-4c02-43b3-8ef4-e3d3c6cf62fa/data"

  # Create request
  req <- httr2::request(promdci_url)

  if (isTRUE(full)) {

    # Send and save response
    resp <- req |>
      httr2::req_url_query() |>
      httr2::req_perform()

  } else if (!is.null(npi)) {

    # Send and save response
    resp <- req |>
      httr2::req_url_query(keyword = npi) |>
      httr2::req_throttle(50 / 60) |>
      httr2::req_perform()

  } else {

    # Create list of arguments
    arg <- stringr::str_c(c(
      last = last,
      first = first), collapse = ",")

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
  if (isTRUE(insight::is_empty_object(results))) {

    message("NPI is not in database")

  } else {

    # Clean names with janitor
    if (isTRUE(clean_names)) {

      results <- results |>
        janitor::clean_names()
    }

    return(results)
  }
}

#' Search the Medicare Revalidation Due Date API
#'
#' @description Information on revalidation due dates for Medicare providers.
#'
#' # Medicare Revalidation Due Date API
#'
#' The Revalidation Due Date List dataset contains
#' revalidation due dates for Medicare providers who are due to
#' revalidate in the following six months. If a provider's due
#' date does not fall within the ensuing six months, the due
#' date is marked 'TBD'. In addition the dataset also includes
#' subfiles with reassignment information for a given provider
#' as well as due date listings for clinics and group practices
#' and their providers.
#'
#' ## Data Update Frequency
#' Monthly
#'
#' ## Data Source
#' Centers for Medicare & Medicaid Services
#'
#' ## Links
#' * [Medicare Revalidation Due Date API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-due-date-list)
#'
#' @param npi 10-digit National Provider Identifier (NPI)
#' @param last Provider's last name
#' @param first Provider's first name
#' @param clean_names Clean column names with {janitor}'s
#'    `clean_names()` function; default is `TRUE`.
#' @param full If `TRUE`, downloads the entire dataset; default is `FALSE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examples
#' \dontrun{
#' provider_mrdd(npi = 1184699621)
#'
#' provider_mrdd(last = "Byrd", first = "Eric")
#'
#' # Unnamed List of NPIs
#'
#' npi_list <- c(1003026055,
#'               1316405939,
#'               1720392988,
#'               1518184605,
#'               1922056829,
#'               1083879860)
#'
#' npi_list |> purrr::map_dfr(provider_mrdd)
#'
#' # Download First 1,000 Records
#'
#' provider_mrdd(full = TRUE)
#' }
#' @autoglobal
#' @noRd

provider_mrdd <- function(npi         = NULL,
                          last        = NULL,
                          first       = NULL,
                          clean_names = TRUE,
                          full        = FALSE) {

  # Check internet connection
  attempt::stop_if_not(curl::has_internet() == TRUE,
                       msg = "Please check your internet connection.")

  # Medicare Revalidation Due Date Base URL
  http <- "https://"
  site <- "data.cms.gov/data-api/v1/dataset/"
  id   <- "3746498e-874d-45d8-9c69-68603cafea60"
  end  <- "/data"
  url  <- paste0(http, site, id, end)

  # Create request
  req <- httr2::request(url)

  if (isTRUE(full)) {

    # Send and save response
    resp <- req |>
      httr2::req_url_query() |>
      httr2::req_perform()

  } else if (!is.null(npi)) {

    # Send and save response
    resp <- req |>
      httr2::req_url_query(keyword = npi) |>
      httr2::req_throttle(50 / 60) |>
      httr2::req_perform()

  } else {

    # Create list of arguments
    arg <- stringr::str_c(c(
      last = last,
      first = first), collapse = ",")

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

  # Convert to tibble
  results <- results |> tibble::tibble()

  # Empty List - NPI is not in the database
  if (isTRUE(insight::is_empty_object(results))) {

    message("NPI is not in database")

  } else {

    # Clean names with janitor
    if (isTRUE(clean_names)) {

      results <- results |>
        janitor::clean_names()
    }

    return(results)
  }
}

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
#' @noRd

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
#' @noRd

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

  # Create request
  req <- httr2::request(mppe_url)

  if (isTRUE(full)) {

    # Send and save response
    resp <- req |>
      httr2::req_url_query() |>
      httr2::req_perform()

  } else if (!is.null(npi)) {

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
#' @param geo_lvl Geographic level for "geo" API, options are "National" and
#'    "State"
#' @param set API to access, options are "serv", "geo", and "prov"
#' @param year Year between 2013-2020, in YYYY format
#' @param clean_names Clean column names with {janitor}'s
#'    `clean_names()` function; default is `TRUE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examples
#' \dontrun{
#' # by Provider and Service API ------------------
#' ## Search by NPI
#' provider_mpop(npi = 1003000126,
#'               set = "serv",
#'               year = "2020")
#'
#' ## Search by First Name
#' provider_mpop(first = "Enkeshafi",
#'               set = "serv",
#'               year = "2019")
#'
#' ## Unnamed List of NPIs
#' npi_list <- c(1003026055,
#'               1316405939,
#'               1720392988,
#'               1518184605,
#'               1922056829,
#'               1083879860)
#'
#' npi_list |>
#' purrr::map_dfr(provider_mpop)
#'
#' ## Retrieve All Provider Data, 2013-2020
#' dates <- as.character(seq(from = 2013, to = 2020))
#' purrr::map_dfr(dates, ~provider_mpop(npi = 1003000126,
#'                                      set = "serv",
#'                                      year = .x))
#'
#'
#' # by Provider API ------------------
#' provider_mpop(npi = 1003000134, set = "prov")
#'
#' ## Retrieve All Provider Data, 2013-2020
#' dates <- as.character(seq(from = 2013, to = 2020))
#' purrr::map_dfr(dates, ~provider_mpop(npi = 1003000126,
#'                                      set = "prov",
#'                                      year = .x))
#'
#' # by Geography and Service API ------------------
#' provider_mpop(hcpcs = "0002A", set = "geo")
#'
#' ## Retrieve All Procedures Data, 2013-2020
#' dates <- as.character(seq(from = 2013, to = 2020))
#' geo_ex <- purrr::map_dfr(dates, ~provider_mpop(npi = 1003000126,
#'                                                set = "serv",
#'                                                year = .x))
#' procedures <- geo_ex |>
#'               dplyr::distinct(hcpcs_cd) |>
#'               tibble::deframe()
#'
#' arg_list <- list(x = dates, y = hcpcs_codes)
#' arg_cross <- purrr::cross_df(arg_list2)
#'
#' ### National Level
#' purrr::map2_dfr(arg_cross2$x,
#'                 arg_cross2$y, ~provider_mpop(set = "geo",
#'                                              geo_lvl = "National",
#'                                              year = .x,
#'                                              hcpcs = .y))
#'
#' ### State Level
#' purrr::map2_dfr(arg_cross2$x,
#'                 arg_cross2$y, ~provider_mpop(set = "geo",
#'                                              geo_lvl = "Georgia",
#'                                              year = .x,
#'                                              hcpcs = .y))
#' }
#' @autoglobal
#' @noRd

provider_mpop <- function(npi         = NULL,
                          last        = NULL,
                          first       = NULL,
                          hcpcs       = NULL,
                          geo_lvl     = NULL,
                          set         = "serv",
                          year        = "2020",
                          clean_names = TRUE) {


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

  if (!is.null(npi)) {

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
      hcpcs = hcpcs,
      geo_lvl = geo_lvl), collapse = ",")

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
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#' @examples
#' \dontrun{
#' provider_clia(name = "carbon hill", year = "2022")
#'
#' provider_clia(city = "alabaster")
#'
#' }
#' @autoglobal
#' @noRd

provider_clia <- function(name = NULL,
                          city = NULL,
                          state = NULL,
                          year = 2022,
                          clean_names = TRUE) {

  # dataset version ids by year ---------------------------------------------
  id <- dplyr::case_when(year == 2022 ~ "d3eb38ac-d8e9-40d3-b7b7-6205d3d1dc16",
                         year == 2021 ~ "0a1e9e1d-ca8a-4fde-bfb8-1436973f18c4",
                         year == 2020 ~ "0ac881d5-3742-4d71-85c0-b94cacf2c3f7",
                         year == 2019 ~ "cf000286-6a42-4031-81dd-aaa4fc8446fc",
                         year == 2018 ~ "4428eca4-3d4a-44e8-b146-df4e4cdba812",
                         year == 2017 ~ "97285b4b-ccce-4834-bbe1-05050665e498",
                         year == 2016 ~ "f68318d3-d74f-4e81-9b46-2d696ac599bb",
                         year == 2015 ~ "3e4c89ea-3e3f-4e29-959b-00f257c4893f",
                         year == 2014 ~ "cd7be382-7736-4411-a224-f01728cddae1",
                         year == 2013 ~ "3d21bf00-189b-4d5b-9cf7-75f88b849f71",
                         year == 2012 ~ "d5f8f520-824a-4ccb-bb99-25f83bba13f4",
                         year == 2011 ~ "c7f8619d-945f-4d8b-9747-f1b3f2e56c84",
                         year == 2010 ~ "3b635cea-fa5e-42de-ba61-4ba2f88e032f")

  # args tribble ------------------------------------------------------------
  args <- tibble::tribble(
    ~x,         ~y,
    "Rndrng_NPI",        npi,
    "Rndrng_Prvdr_Last_Org_Name",   last_org,
    "Rndrng_Prvdr_First_Name",      first,
    "Rndrng_Prvdr_Crdntls",       cred,
    "Rndrng_Prvdr_Gndr",     gender,
    "Rndrng_Prvdr_Ent_Cd",       type,
    "Rndrng_Prvdr_City",       city,
    "Rndrng_Prvdr_State_Abrvtn",  state_abb,
    "Rndrng_Prvdr_State_FIPS",       fips,
    "Rndrng_Prvdr_Zip5",        zip,
    "Rndrng_Prvdr_RUCA",       ruca,
    "Rndrng_Prvdr_Cntry",    country,
    "Rndrng_Prvdr_Type",  specialty,
    "Rndrng_Prvdr_Mdcr_Prtcptg_Ind",    par_ind,
    "HCPCS_Cd", hcpcs_code,
    "HCPCS_Drug_Ind",   drug_ind,
    "Place_Of_Srvc",        pos)

  # map param_format and collapse -------------------------------------------
  params_args <- purrr::map2(args$x, args$y, param_format) |> unlist() |>
    stringr::str_c(collapse = "")

  # build URL ---------------------------------------------------------------
  http   <- "https://data.cms.gov/data-api/v1/dataset/"
  post   <- "/data.json?"
  url    <- paste0(http, id, post, params_args)

  # create request ----------------------------------------------------------
  req <- httr2::request(url)

  # send response -----------------------------------------------------------
  resp <- req |> httr2::req_perform()

  # parse response ----------------------------------------------------------
  results <- resp |>
    httr2::resp_body_json(check_type = FALSE, simplifyVector = TRUE) |>
    tibble::tibble() |>
    dplyr::mutate(Year = year) |>
    dplyr::relocate(Year)

  # clean names -------------------------------------------------------------
  if (isTRUE(clean_names)) {results <- janitor::clean_names(results)}
  # lowercase ---------------------------------------------------------------
  if (isTRUE(lowercase)) {results <- dplyr::rename_with(results, tolower)}

  return(results)
}
