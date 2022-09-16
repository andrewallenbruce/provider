#' Unpack NPPES Search Data
#'
#' @param df data.frame or tbl_df, response from prov_city_nppes()
#'
#' @return A tibble containing the NPI(s) searched for on the
#' NPPES, the date-time of the search, and the unnested and
#' tidied list-columns of results split into groups.
#'
#' @export
#'
#' @examples
#' \dontrun{prov_nppes_unpack_city(nppes_response)}

prov_nppes_unpack_city <- function(df) {

  # Check for data input
  if (missing(df)) stop("You haven't input a data frame.")

  # Handle any ERROR returns
  if (nrow(df |> dplyr::filter(outcome == "Errors")) >= 1) {

    errors <- df |>
      dplyr::filter(outcome == "Errors") |>
      tidyr::unnest(data_lists) |>
      dplyr::mutate(prov_type = "Deactivated") |>
      dplyr::select(prov_type)

    # Bind rows
    results <- errors

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
      tidyr::unnest(basic)

    # Isolate lists & remove if empty
    lists <- start |>
      dplyr::select(!(basic)) |>
      dplyr::select(npi, where(~ is.list(.x) &&
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
  return(results)
}
