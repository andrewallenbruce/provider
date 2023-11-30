#' Add county name, FIPs, and geometry to data frame with zip codes
#' @param df data frame
#' @param statecol bare column name column containing state abbreviations
#' @param zipcol bare column name containing zip codes
#' @param add_fips add county FIPS code column, default is `FALSE`
#' @param add_geo add county geometry column, default is `FALSE`
#' @param as_sf convert tibble to an `{sf}` object, default is `FALSE`
#'
#' @examples
#' # Example data frame containing state abbreviation and zip code
#' ex <- dplyr::tibble(state = "GA",
#'                     zip = "31605")
#' ex
#'
#' # Adds county name and latitude/longitude
#' ex |> add_counties(state, zip)
#'
#' # Adds county FIPS
#' ex |> add_counties(state,
#'                    zip,
#'                    add_fips = TRUE)
#'
#' # Adds county `geometry` column,
#' # based on county FIPS column
#' ex |> add_counties(state,
#'                    zip,
#'                    add_fips = TRUE,
#'                    add_geo  = TRUE)
#'
#' # Converts data frame to an `sf` object
#' ex |> add_counties(state,
#'                    zip,
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

    # dplyr::tibble(
    #   city = c('Mount Zion', 'Montezuma', 'Thomaston'),
    #   state = fct_stabb(rep('GA', 3)),
    #   county = c('Carroll', 'Macon', 'Upson'),
    #   zip = c('30150', '31063', '30286'),
    #   county_fips = c('13045', '13193', '13293')
    # )

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
  }

  if (as_sf) {
    df <- sf::st_as_sf(df,
                       coords = c("lng", "lat"),
                       crs = sf::st_crs(4326),
                       na.fail = FALSE)
  }
  return(df)
}
