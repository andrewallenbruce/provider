#' Calculate Number of Days Between Two Dates
#'
#' Note: This calculation includes the end date in the sum (see example)
#'
#' @param df data frame containing two date columns
#' @param start column containing date(s) prior to end_date column
#' @param end column containing date(s) after start_date column
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
#' age_days(df = date_ex, start = x, end = y)
#'
#' date_ex |> age_days(x, y)
#' @export

age_days <- function(df, start, end){

  stopifnot(inherits(df, "data.frame"))

  dates <- dplyr::mutate(df,
                         end = as.Date({{ end }}, "%yyyy-%mm-%dd", tz = "EST"),
                         start = as.Date({{ start }}, "%yyyy-%mm-%dd", tz = "EST"))

  results <- dates |>
    dplyr::mutate(age = ((
      as.numeric(lubridate::days(
        end) - lubridate::days(
          start), "hours") / 24) + 1)) |>
    dplyr::select(!c(end, start))

  return(results)
}
