#' Calculate Number of Days Between Two Dates
#'
#' Note: This calculation includes the end date in the sum (see example)
#'
#' @param df data frame containing date columns
#' @param start column containing date(s) prior to end_date column
#' @param end column containing date(s) after start_date column
#' @param colname desired column name of output; default is "age"
#'
#' @return A [tibble][tibble::tibble-package] with a named column
#'    containing the calculated number of days.
#'
#' @examples
#' date_ex <- tibble::tibble(x = seq.Date(as.Date("2021-01-01"),
#'                           by = "month", length.out = 3),
#'                           y = seq.Date(as.Date("2022-01-01"),
#'                           by = "month", length.out = 3))
#'
#' age_days(df = date_ex,
#'          start = x,
#'          end = y)
#'
#' date_ex |>
#' age_days(x,
#'          y,
#'          colname = "days_between_x_y")
#'
#' date_ex |>
#' age_days(start = x,
#' end = lubridate::today(),
#' colname = "days_since_x")
#'
#' date_ex |>
#' age_days(x, y, "days_between_x_y") |>
#' age_days(x, lubridate::today(), "days_since_x") |>
#' age_days(y, lubridate::today(), colname = "days_since_y")
#' @autoglobal
#' @keyword internal
#' @export

age_days <- function(df,
                     start,
                     end,
                     colname = "age") {

  stopifnot(inherits(df, "data.frame"))

  results <- df |>
    dplyr::mutate(start = as.Date({{ start }},
                                  "%yyyy-%mm-%dd",
                                  tz = "EST"),
                  end = as.Date({{ end }},
                                "%yyyy-%mm-%dd",
                                tz = "EST")) |>
    dplyr::mutate("{colname}" := ((as.numeric(
      lubridate::days(end) - lubridate::days(start),
      "hours") / 24) + 1)) |>
    dplyr::select(!c(end, start))

  return(results)
}
