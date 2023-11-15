#' Utility Functions
#'
#' @description Common utility functions
#'
#' @examples
#' # Example data
#' ex <- gen_data(2020:2025)
#' head(ex)
#'
#' # Lagged absolute/percentage change, rate of return and cumulative sum
#' # `change()`
#' dplyr::filter(ex, group == "A") |>
#' change(pay)
#'
#' # `geomean()` # Geometric mean
#' ex |>
#' dplyr::filter(group == "A") |>
#' ror(pay) |>
#' dplyr::summarise(gmean = geomean(pay_ror))
#'
#' # When performing a `group_by()`, watch for
#' # the correct order of the variables
#' ex |>
#' dplyr::group_by(group) |>
#' change(pay)
#'
#' ex |>
#' dplyr::group_by(group) |>
#' change(pay) |>
#' dplyr::summarise(mean_pay = mean(pay, na.rm = TRUE),
#'                  csm_chg  = sum(pay_chg),
#'                  csm_pct  = sum(pay_pct),
#'                  mean_ror = mean(pay_ror, na.rm = TRUE),
#'                  geomean  = geomean(pay_ror))
#'
#' # Timespans
#' dt <- dplyr::tibble(date = lubridate::today() - 366)
#'
#' # `years_df()`
#' years_df(dt, date)
#'
#' # `duration_vec()`
#' dplyr::mutate(dt, dur = duration_vec(date))
#'
#' # `make_interval()`
#' dplyr::tibble(date = lubridate::today() - 1000) |>
#' make_interval(start = date, end = lubridate::today() - 500)
#'
#'
#' # `summary_stats()`
#' sm <- dplyr::tibble(provider = sample(c("A", "B", "C"), size = 200, replace = TRUE),
#'                     city = sample(c("ATL", "NYC"), size = 200, replace = TRUE),
#'                     charges = sample(1000:2000, size = 200),
#'                     payment = sample(1000:2000, size = 200))
#'
#' head(sm)
#'
#' summary_stats(sm,
#'               condition    = city == "ATL",
#'               group_vars   = provider,
#'               summary_vars = c(charges, payment),
#'               arr          = provider)
#'
#' @returns [tibble()] or vector
#' @name calculations
#' @keywords internal
NULL

#' @param df data frame
#' @param cols numeric columns to calculate absolute/relative change & rate of return
#' @param csm numeric cols to calculate cumulative sum for
#' @param digits Number of digits to round to, default is 3
#' @rdname calculations
#' @examplesIf interactive()
#' dplyr::filter(ex, group == "A") |>
#' change(pay)
#' @autoglobal
#' @export
#' @keywords internal
change <- function(df, cols, csm = NULL, digits = 5) {

  results <- dplyr::mutate(df,
    dplyr::across({{ cols }}, list(
      chg = \(x) chg(x),
      pct = \(x) pct(x)),
      .names = "{.col}_{.fn}")) |>
    dplyr::mutate(dplyr::across(dplyr::ends_with("_pct"), ~ .x + 1, .names = "{.col}_ror")) |>
    dplyr::mutate(dplyr::across(dplyr::where(is.double), ~janitor::round_half_up(., digits = digits))) |>
    dplyr::relocate(dplyr::ends_with("_chg"), dplyr::ends_with("_pct"), dplyr::ends_with("_pct_ror"), .after = {{ cols }})

  names(results) <- gsub("_pct_ror", "_ror", names(results))

  if (!is.null(csm)) {
    results <- dplyr::mutate(results,
               dplyr::across(dplyr::ends_with({{ csm }}), list(cusum = \(x) cumsum(x)), .names = "{.col}_{.fn}"))
  }
  return(results)
}

#' Lagged absolute change
#' @param x numeric vector
#' @param n values to offset
#' @param fill_na fill value for any NAs; default is 0
#' @rdname calculations
#' @examplesIf interactive()
#' dplyr::filter(ex, group == "A") |>
#' dplyr::mutate(change = chg(pay))
#' @autoglobal
#' @export
#' @keywords internal
chg <- function(x, n = 1L, fill_na = 0L) {
  lg  <- dplyr::lag(x, n = n)
  res <- (x - lg)
  if (!is.na(fill_na)) res[is.na(res)] <- fill_na
  return(res)
}

#' Lagged percentage change
#' @param x numeric vector
#' @param n values to offset
#' @param fill_na fill value for any NAs; default is 0
#' @rdname calculations
#' @examplesIf interactive()
#' dplyr::filter(ex, group == "A") |>
#' dplyr::mutate(pct_change = pct(pay))
#' @autoglobal
#' @export
#' @keywords internal
pct <- function(x, n = 1L, fill_na = 0L) {
  lg <- dplyr::lag(x, n = n)
  res <- (x - lg) / lg
  if (!is.na(fill_na)) res[is.na(res)] <- fill_na
  return(res)
}

#' Lagged rate of return
#' @param df data frame
#' @param col numeric column
#' @param n values to offset
#' @rdname calculations
#' @examplesIf interactive()
#' dplyr::filter(ex, group == "A") |>
#' ror(pay)
#'
#' ex |>
#' dplyr::group_by(group) |>
#' ror(pay)
#' @autoglobal
#' @export
#' @keywords internal
ror <- function(df, col, n = 1L) {
  dplyr::mutate(df,
                copy = dplyr::if_else({{ col }} == 0, 1, {{ col }}),
                lg = dplyr::lag(copy, n = n),
                "{{ col }}_ror" := copy / lg,
                copy = NULL,
                lg = NULL, .after = {{ col }})
}

#' Calculate geometric mean (average rate of return)
#' For use in conjunction with [ror()]
#' @param x numeric vector
#' @rdname calculations
#' @examplesIf interactive()
#' dplyr::filter(ex, group == "A") |>
#' ror(pay) |>
#' dplyr::summarise(gmean = geomean(pay_ror))
#'
#' ex |>
#' dplyr::group_by(group) |>
#' ror(pay) |>
#' dplyr::summarise(gmean = geomean(pay_ror))
#' @autoglobal
#' @export
#' @keywords internal
geomean <- function(x) exp(mean(log(x), na.rm = TRUE))

#' Calculate lagged values by column
#' @param df data frame
#' @param col column of numeric values to calculate lag
#' @param by column to calculate lag by
#' @param digits Number of digits to round to
#' @rdname calculations
#' @examplesIf interactive()
#' dplyr::filter(ex, group == "A") |>
#' change_year(pay, year)
#' @autoglobal
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

#' Calculate number of years since today's date
#' @param df data frame
#' @param date_col date column
#' @rdname calculations
#' @autoglobal
#' @export
#' @keywords internal
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
#' @param date_col date column
#' @rdname calculations
#' @examplesIf interactive()
#' dt <- dplyr::tibble(date = lubridate::today() - 366)
#' dplyr::mutate(dt, years = years_vec(date))
#' @autoglobal
#' @export
#' @keywords internal
years_vec <- function(date_col) {
  round(
    as.double(
      difftime(
        lubridate::today(),
        date_col,
        units = "weeks",
        tz = "UTC")) / 52.17857, 2)
}

#' Calculate duration since today's date
#' @param date_col date column
#' @rdname calculations
#' @examplesIf interactive()
#' dplyr::tibble(date = lubridate::today() - 366,
#'               date2 = date - 789) |>
#' dplyr::mutate(dur = duration_vec(date),
#'               dur2 = duration_vec(date2))
#' @autoglobal
#' @export
#' @keywords internal
duration_vec <- function(date_col) {
  date <- difftime(date_col, lubridate::today(), units = "auto", tz = "UTC")
  date <- lubridate::as.duration(date)
  return(date)
}

#' Create interval and period columns from a start and end date
#' @param df data frame
#' @param start start date column
#' @param end end date column
#' @rdname calculations
#' @examplesIf interactive()
#' dt <- dplyr::tibble(date = lubridate::today() - 366)
#' make_interval(dt, start = lubridate::today() - 1000)
#' @autoglobal
#' @export
#' @keywords internal
# nocov start
make_interval <- function(df, start, end = lubridate::today()) {
  dplyr::mutate(df,
                interval = lubridate::interval(
                  lubridate::ymd({{ start }}), lubridate::ymd({{ end }})),
                period = lubridate::as.period(interval),
                timelength_days = lubridate::time_length(interval, unit = "days"))
}
# nocov end
#' Summary stats
#' @param df data frame
#' @param condition filter condition, i.e. `patient == "new"`
#' @param group_vars variables to group by, i.e. `c(specialty, state, hcpcs, cost)`
#' @param summary_vars variables to summarise, i.e. `c(min, max, mode, range)`
#' @param arr column to arrange data by, i.e. `cost`
#' @param digits Number of digits to round to, default is 3
#' @rdname calculations
#' @autoglobal
#' @export
#' @keywords internal
summary_stats <- function(df,
                          condition = NULL,
                          group_vars = NULL,
                          summary_vars = NULL,
                          arr = NULL,
                          digits = 3) {

  results <- df |>
    dplyr::filter({{ condition }}) |>
    dplyr::summarise(
      dplyr::across({{ summary_vars }},
                    list(median = \(x) stats::median(x, na.rm = TRUE),
                         mean = \(x) mean(x, na.rm = TRUE),
                         sd = \(x) stats::sd(x, na.rm = TRUE)),
                    .names = "{.col}_{.fn}"),
      n = dplyr::n(),
      .by = ({{ group_vars }})) |>
    dplyr::arrange(dplyr::desc({{ arr }})) |>
    dplyr::mutate(dplyr::across(
      dplyr::where(is.double), ~janitor::round_half_up(., digits = digits)))

  return(results)
}


#' Generate tibble of data for testing
#' @param years sequence of years, e.g. `2010:2020`
#' @rdname calculations
#' @returns tibble
#' @autoglobal
#' @export
#' @keywords internal
# nocov start
gen_data <- function(years) {
  lng <- length(years) * 2
  vctrs::vec_rbind(
    dplyr::tibble(year = {{ years }}, group = "A"),
    dplyr::tibble(year = {{ years }}, group = "B")) |>
    dplyr::mutate(pay = sample(1000:2000, lng))
}
# nocov end
