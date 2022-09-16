#' Unpack NPI NPPES Search Data
#'
#' @param df data.frame or tbl_df, response from prov_npi_nppes()
#'
#' @return A tibble containing the NPI(s) searched for on the
#' NPPES, the date-time of the search, and the unnested and
#' tidied list-columns of results split into groups.
#'
#' @export
#'
#' @examples
#' \dontrun{prov_nppes_unpack(nppes_npi_response)}

prov_nppes_unpack <- function(df) {

  # Check for data input
  if (missing(df)) stop("You haven't input a data frame.")

  # Handle any ERROR returns
  if (nrow(df |> dplyr::filter(outcome == "Errors")) >= 1) {

    errors <- df |>
      dplyr::filter(outcome == "Errors") |>
      tidyr::unnest(data_lists) |>
      dplyr::rename(id = search) |>
      dplyr::mutate(id = as.character(id)) |>
      dplyr::mutate(prov_type = "Deactivated",
                    npi = id) |>
      dplyr::select(prov_type, npi, id)

    # Bind rows
    results <- errors

  } else {

    # Start with base, unnest first level
    start <- df |>
      dplyr::filter(outcome == "results") |>
      tidyr::unnest(data_lists)

    ## || CREATE ID KEY
    key <- start |>
      dplyr::mutate(id = search) |>
      dplyr::select(id) |>
      unlist(use.names = FALSE)

    # Rename number & enumeration type
    basic_1 <- start |>
      dplyr::select(prov_type = enumeration_type,
                    npi = number) |>
      dplyr::mutate(npi = as.character(npi),
                    id = key)

    # BASIC
    basic_2 <- start |>
      dplyr::select(basic) |>
      tidyr::unnest(basic) |>
      dplyr::mutate(id = key)

    #--Join Columns--#
    results <- dplyr::full_join(basic_1, basic_2, by = "id")

    # Isolate lists & remove if empty
    lists <- start |>
      dplyr::select(!(basic)) |>
      dplyr::select(where(~ is.list(.x) &&
      (insight::is_empty_object(.x) == FALSE))) |>
      dplyr::mutate(id = key)

    # Replace Empty Lists with NA
    lists[apply(lists, 2, function(x) lapply(x, length) == 0)] <- NA

    # List names for identification
    ls_names <- tibble::enframe(names(lists))

    # ADDRESSES
    if (nrow(ls_names |> dplyr::filter(value == "addresses")) >= 1) {

      addresses <- lists |>
        dplyr::select(addresses) |>
        tidyr::unnest(cols = c(addresses)) |>
        dplyr::mutate(
          address_purpose = stringr::str_to_lower(
          address_purpose)) |>
        dplyr::select(-c(country_name, address_type)) |>
        tidyr::pivot_wider(
          names_from = address_purpose,
          names_glue = "{address_purpose}_{.value}",
          values_from = dplyr::everything()) |>
        dplyr::select(-mailing_address_purpose, -location_address_purpose) |>
        dplyr::mutate(id = key)

      #--Join Columns--#
      results <- dplyr::full_join(results, addresses, by = "id")

    } else {
      invisible("No Addresses")
    }

    # TAXONOMIES
    if (nrow(ls_names |> dplyr::filter(value == "taxonomies")) >= 1) {

      taxonomies <- lists |>
        dplyr::select(id, taxonomies) |>
        tidyr::unnest(cols = c(taxonomies)) |>
        datawizard::data_addprefix("taxon_", exclude = "id")

      #--Join Columns--#
      results <- dplyr::full_join(results, taxonomies, by = "id")

    } else {
      invisible("No Taxonomies")
    }

    # IDENTIFIERS
    if (nrow(ls_names |> dplyr::filter(value == "identifiers")) >= 1) {

      identifiers <- lists |>
        dplyr::select(id, identifiers) |>
        tidyr::unnest(cols = c(identifiers)) |>
        datawizard::data_addprefix("ident_", exclude = c("id", "identifier"))

      #--Join Columns--#
      results <- dplyr::full_join(results, identifiers, by = "id")

    } else {
      invisible("No Identifiers")
    }

    # OTHER NAMES
    if (nrow(ls_names |> dplyr::filter(value == "other_names")) >= 1) {

      other_names <- lists |>
        dplyr::select(id, other_names) |>
        tidyr::unnest(cols = c(other_names)) |>
        datawizard::data_addprefix("other_names_", exclude = "id")

      #--Join Columns--#
      results <- dplyr::full_join(results, other_names, by = "id")

    } else {
      invisible("No Other Names")
    }

    # PRACTICE LOCATIONS
    if (nrow(ls_names |> dplyr::filter(value == "practiceLocations")) >= 1) {

      practiceLocations <- lists |>
        dplyr::select(id, practiceLocations) |>
        tidyr::unnest(cols = c(practiceLocations)) |>
        dplyr::rename(country_abb = country_code, state_abb = state) |>
        datawizard::data_addprefix("pract_", exclude = "id")

      #--Join Columns--#
      results <- dplyr::full_join(results, practiceLocations, by = "id")

    } else {
      invisible("No Practice Locations")
    }

    # ENDPOINTS
    if (nrow(ls_names |> dplyr::filter(value == "endpoints")) >= 1) {

      endpoints <- lists |>
        dplyr::select(id, endpoints) |>
        tidyr::unnest(cols = c(endpoints)) |>
        datawizard::data_addprefix("endpts_", exclude = "id")

      #--Join Columns--#
      results <- dplyr::full_join(results, endpoints, by = "id")

    } else {
      invisible("No Endpoints")
    }

    # NPPES LOCATION TABLE JOIN
    #results <- dplyr::inner_join(results, provider::nppes_location_reference, by = c("state_abb", "country_abb"))

  }
  return(results)
}
