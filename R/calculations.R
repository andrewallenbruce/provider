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
#' @return number of years since today's date
#' @autoglobal
#' @noRd
years_passed <- function(df, date_col) {

  df |>
    dplyr::mutate(
      years_passed = round(as.double(difftime(lubridate::today(),
                                              {{ date_col }},
                                              units = "weeks",
                                              tz = "UTC")) / 52.17857, 2),
      .after = {{ date_col }})
}

years_diff <- function(date_col) {
  round(
    as.double(
      difftime(
        lubridate::today(),
        date_col,
        units = "weeks",
        tz = "UTC")) / 52.17857, 2)
}
