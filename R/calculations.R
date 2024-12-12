#' @param df data.frame
#'
#' @param cols numeric columns to calculate absolute/relative change & rate of return
#'
#' @param csm numeric cols to calculate cumulative sum for
#'
#' @autoglobal
#'
#' @noRd
change <- function(df, cols, csm = NULL, digits = 5) {

  results <- dplyr::mutate(df,
    dplyr::across(
      {{ cols }},
      list(
        chg = \(x) chg(x),
        pct = \(x) pct(x)),
      .names = "{.col}_{.fn}")) |>
    dplyr::mutate(
      dplyr::across(
        dplyr::ends_with("_pct"), ~ .x + 1,
        .names = "{.col}_ror")
      ) |>
    dplyr::relocate(
      dplyr::ends_with("_chg"),
      dplyr::ends_with("_pct"),
      dplyr::ends_with("_pct_ror"),
      .after = {{ cols }}
      )

  names(results) <- gsub("_pct_ror", "_ror", names(results))

  if (!is.null(csm)) {
    results <- dplyr::mutate(
      results,
      dplyr::across(
        dplyr::ends_with({{ csm }}),
        list(
          cusum = \(x) cumsum(x)),
        .names = "{.col}_{.fn}")
      )
  }
  return(results)
}

#' @param x numeric vector
#'
#' @param n values to offset
#'
#' @param fill_na fill value for any NAs; default is 0
#'
#' @autoglobal
#'
#' @noRd
chg <- function(x, n = 1L, fill_na = 0L) {
  lg  <- dplyr::lag(x, n = n)
  res <- (x - lg)
  if (!is.na(fill_na)) res[is.na(res)] <- fill_na
  return(res)
}

#' @param x numeric vector
#'
#' @param n values to offset
#'
#' @param fill_na fill value for any NAs; default is 0
#'
#' @autoglobal
#'
#' @keywords internal
#'
#' @noRd
pct <- function(x, n = 1L, fill_na = 0L) {
  lg <- dplyr::lag(x, n = n)
  res <- (x - lg) / lg
  if (!is.na(fill_na)) res[is.na(res)] <- fill_na
  return(res)
}

#' @param df data frame
#'
#' @param col numeric column
#'
#' @param n values to offset
#'
#' @autoglobal
#'
#' @keywords internal
#'
#' @noRd
ror <- function(df, col, n = 1L) {
  dplyr::mutate(
    df,
    copy = dplyr::if_else(
      {{ col }} == 0,
      1,
      {{ col }}),
    lg = dplyr::lag(copy, n = n),
    "{{ col }}_ror" := copy / lg,
    copy = NULL,
    lg = NULL,
    .after = {{ col }})
}

#' @param x numeric vector
#'
#' @autoglobal
#'
#' @keywords internal
#'
#' @noRd
geomean <- function(x) exp(mean(log(x), na.rm = TRUE))

#' @param df data frame
#'
#' @param col column of numeric values to calculate lag
#'
#' @param by column to calculate lag by
#'
#' @param digits Number of digits to round to
#'
#' @autoglobal
#'
#' @noRd
change_year <- function(df, col, by = year, digits = 3) {

  newcol <- rlang::englue("{{col}}_chg")
  newcol <- rlang::sym(newcol)

  df |>
    dplyr::mutate(
      "{{ col }}_chg" := {{ col }} - dplyr::lag({{ col }},
                                                order_by = {{ by }}),
      "{{ col }}_pct" := !!newcol / dplyr::lag({{ col }}, order_by = {{ by }}),
      .after = {{ col }}) |>
    dplyr::mutate(dplyr::across(
      dplyr::where(is.double), ~janitor::round_half_up(., digits = digits)))
}

#' @param df data frame
#'
#' @param date_col date column
#'
#' @autoglobal
#'
#' @noRd
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

#' @param date_col date column
#'
#' @autoglobal
#'
#' @noRd
years_vec <- function(date_col) {
  round(
    as.double(
      difftime(
        lubridate::today(),
        date_col,
        units = "weeks",
        tz = "UTC")) / 52.17857, 2)
}

#' @param date_col date column
#'
#' @autoglobal
#'
#' @noRd
duration_vec <- function(date_col) {

  date <- difftime(
    date_col,
    lubridate::today(),
    units = "auto",
    tz = "UTC")

  date <- lubridate::as.duration(date)

  return(date)
}

#' @param df data frame
#'
#' @param start start date column
#'
#' @param end end date column
#'
#' @autoglobal
#'
#' @noRd
make_interval <- function(df, start, end = lubridate::today()) {
  dplyr::mutate(
    df,
    interval = lubridate::interval(
      lubridate::ymd({{ end }})),
    period = lubridate::as.period(interval),
    timelength_days = lubridate::time_length(
      interval,
      unit = "days"))
}
# nocov end
