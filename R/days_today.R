#' Calculate Number of Days Between a Date and Today
#'
#' @param df data frame containing date columns
#' @param date date column
#' @param name desired column name of output
#'
#' @return data frame with a column containing the number of days
#'    calculated.
#'
#' @examples
#' ex <- data.frame(x = c("02/05/92",
#'                        "01-04-2020",
#'                        "1996/05/01",
#'                        "2020-05-01",
#'                        "02-04-96"))
#'
#' days_today(df = ex, date = x, name = days)
#'
#' ex |> days_today(x)
#' @export

days_today <- function(df, date, name = days) {

  stopifnot(inherits(df, "data.frame"))

  results <- df |>
    dplyr::mutate(date = datefixR::fix_date_char({{date}}, format = "mdy"),
                  int = lubridate::interval(date, lubridate::today()),
                  secs = lubridate::int_length(int),
                  mins = secs/60,
                  hrs = mins/60,
                  "{{name}}" := abs(hrs/24)) |>
    dplyr::select(!c(date, int, secs, mins, hrs))

  return(results)

}
