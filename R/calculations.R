#' Calculate lagged values by column
#' @param df data frame
#' @param col column of numeric values to calculate lag
#' @param by column to calculate lag by
#' @returns A `tibble`
#' @examples
#' dplyr::tibble(year = 2015:2020,
#'               pay = 1000:1005) |>
#' change_year(pay, year)
#' @autoglobal
#' @export
change_year <- function(df, col, by = year) {

  newcol <- rlang::englue("{{col}}_chg")
  newcol <- rlang::sym(newcol)

  df |>
    dplyr::mutate(
      "{{ col }}_chg" := {{ col }} - dplyr::lag({{ col }},
                                                order_by = {{ by }}),
      "{{ col }}_pct" := !!newcol / dplyr::lag({{ col }}, order_by = {{ by }}),
      .after = {{ col }})
}

#' Calculate number of years since today's date
#' @param df data frame
#' @param date_col date column
#' @returns number of years since today's date
#' @examples
#' dplyr::tibble(date = lubridate::today() - 366) |>
#' years_df(date_col = date)
#' @autoglobal
#' @export
years_df <- function(df, date_col) {

  df |>
    dplyr::mutate(
      years_passed = round(
        as.double(
          difftime(
            lubridate::today(),
            {{ date_col }},
            units = "weeks",
            tz = "UTC")) / 52.17857, 2),
      .after = {{ date_col }})
}


#' Calculate number of years since today's date
#' @param date date column
#' @returns number of years since today's date
#' @examples
#' dplyr::tibble(date = lubridate::today() - 366) |>
#' dplyr::mutate(years_passed = years_vec(date = date))
#' @autoglobal
#' @export
years_vec <- function(date) {
  round(
    as.double(
      difftime(
        lubridate::today(),
        date,
        units = "weeks",
        tz = "UTC")) / 52.17857, 2)
}
