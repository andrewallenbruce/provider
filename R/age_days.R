#' Calculate Number of Days Between Two Dates
#'
#' Note: This calculation includes the end date in the sum (see example)
#'
#' @param df data frame containing two date columns
#' @param start_date column containing date(s) prior to end_date column
#' @param end_date column containing date(s) after start_date column
#'
#' @return data frame with an age column containing the number of days
#'    calculated.
#'
#' @examples
#' date_ex <- data.frame(x = seq.Date(as.Date("2021-01-01"),
#'                     by = "month", length.out = 3),
#'                     y = seq.Date(as.Date("2022-01-01"),
#'                     by = "month", length.out = 3))
#'
#' date_ex |> age_days(x, y)
#'
#' date_ex |> age_days(start_date = x, end_date = lubridate::today())
#' @export

age_days <- function(df, start_date = start_date, end_date = end_date){

  stopifnot(inherits(df, "data.frame"))

  dates <- dplyr::mutate(df,
      end_date = as.Date({{ end_date }}, "%yyyy-%mm-%dd", tz = "EST"),
      start_date = as.Date({{ start_date }}, "%yyyy-%mm-%dd", tz = "EST"))

  results <- dates |>
    dplyr::mutate(age = ((
      as.numeric(lubridate::days(
        end_date) - lubridate::days(
          start_date), "hours") / 24) + 1)) |>
    dplyr::select(!c(end_date, start_date))

  return(results)
}
