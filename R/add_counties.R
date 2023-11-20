#' Add county name, FIPs, and geometry to data frame with zip codes
#' @param df data frame
#' @param statecol bare column name column containing state abbreviations
#' @param zipcol bare column name containing zip codes
#' @param add_fips add county FIPS code column, default is `FALSE`
#' @param add_geo add county geometry column, default is `FALSE`
#' @param as_sf convert tibble to an `{sf}` object, default is `FALSE`
#'
#' @examplesIf interactive()
#' nppes(npi = 1720098791) |>
#'       add_counties(statecol = state,
#'                    zipcol   = zip,
#'                    add_fips = TRUE,
#'                    add_geo  = TRUE,
#'                    as_sf    = TRUE)
#'
#' @autoglobal
#' @export
add_counties <- function(df,
                         statecol,
                         zipcol,
                         add_fips = FALSE,
                         add_geo  = FALSE,
                         as_sf   = FALSE) {

  # prepare `join_by` object
  by <- dplyr::join_by({{ zipcol }} == zip,
                       {{ statecol }} == state)

  # normalize zip codes to 5 digits
  df <- dplyr::mutate(df,
                      "{{ zipcol }}" := zipcodeR::normalize_zip({{ zipcol }}))

  # prepare zip code tibble
  zdb <- dplyr::tibble(
    zip    = zipcodeR::zip_code_db$zipcode,
    #city   = zipcodeR::zip_code_db$major_city,
    county = stringr::str_remove(zipcodeR::zip_code_db$county, " County"),
    state  = fct_stabb(zipcodeR::zip_code_db$state),
    lat    = zipcodeR::zip_code_db$lat,
    lng    = zipcodeR::zip_code_db$lng)

  # join tibbles
  df <- dplyr::left_join(df, zdb, by)

  if (add_fips) {
    # County FIPS codes
    poss_fips <- purrr::possibly(fipio::coords_to_fips,
                                 otherwise = NA_character_)

    df <- df |>
      dplyr::mutate(county_fips = purrr::map2(df$lng, df$lat, poss_fips))

    df[apply(df, 2, function(x) lapply(x, length) == 0)] <- NA

    df <- tidyr::unnest(df, county_fips, keep_empty = TRUE)
  }

  if (add_geo) {
    # Geometries based on county FIPS
    poss_geo <- purrr::possibly(fipio::fips_geometry,
                                otherwise = NA_character_)

    df <- df |>
      dplyr::mutate(geometry = purrr::map(df$county_fips, poss_geo))

    # df[apply(df, 2, function(x) lapply(x, length) == 0)] <- NA
    # df <- df |> tidyr::unnest(geometry, keep_empty = TRUE)
  }

  if (as_sf) {
    df <- sf::st_as_sf(df,
                       sf_column_name = geometry,
                       crs = sf::st_crs(4326),
                       na.fail = FALSE)
  }
  return(df)
}
