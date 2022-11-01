#' Calculate Number of Days Between a Date and Today
#'
#' @param df data frame containing date columns
#' @param start date column
#' @param colname desired column name of output
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
#' days_today(df = ex, start = x)
#'
#' ex |> days_today(x)
#' @autoglobal
#' @keyword internal
#' @export

days_today <- function(df, start, colname = "age") {

  stopifnot(inherits(df, "data.frame"))

  results <- df |>
    dplyr::mutate(int = lubridate::interval({{ start }},
                        lubridate::today()),
                  secs = lubridate::int_length(int),
                  mins = secs/60,
                  hrs = mins/60,
                  "{colname}" := abs(hrs/24)) |>
    dplyr::select(!c(int, secs, mins, hrs))

  return(results)

}
