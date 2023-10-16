#' Utility Functions
#'
#' @description Common utility functions
#'
#' @examplesIf interactive()
#'
#' # Lagged absolute/relative change
#' # and cumulative sum of both:
#'
#' dplyr::tibble(year = 2015:2020,
#'               pay  = sample(1000:2000, 6)) |>
#' change(c(pay))
#'
#' # When performing a `group_by()`, watch for
#' # the correct order of the variables you're
#' # lagging by:
#'
#' dplyr::tibble(year = rep(2020:2021, each = 2),
#'               grp = rep(c("a", "b"), 2),
#'               pay = sample(1000:2000, 4)) |>
#' dplyr::arrange(year) |>
#' dplyr::group_by(grp) |>
#' change(c(pay))
#'
#' @examples
#' # Count of the number of years between dates:
#'
#' dplyr::tibble(date = lubridate::today() - 366) |>
#' years_df(date)
#'
#' @name calculations
#' @keywords internal
NULL

#' @param df data frame
#' @param cols numeric columns
#' @param digits Number of digits to round to, default is 3
#' @returns A `tibble`
#' @rdname calculations
#' @keywords internal
#' @autoglobal
#' @export
change <- function(df, cols, digits = 3) {

  dplyr::mutate(df,
  dplyr::across({{ cols }}, list(chg = \(x) chg(x), pct = \(x) pct(x)),
                .names = "{.col}_{.fn}")) |>
  dplyr::mutate(
  dplyr::across(dplyr::where(is.double), ~janitor::round_half_up(.,
                digits = digits))) |>
  dplyr::mutate(
  dplyr::across(dplyr::contains(c("_chg", "_pct")), ~cumsum(.),
                .names = "{.col}_cum")) |>
  dplyr::relocate(dplyr::contains("_chg"), dplyr::contains("_pct"),
                .after = dplyr::last_col())

}

#' Calculate absolute change
#' @param x numeric vector
#' @param n values to offset
#' @param fill_na fill value for any NAs; default is 0
#' @returns numeric vector
#' @examples
#' dplyr::tibble(year = 2015:2020,
#'               pay = 1000:1005) |>
#' dplyr::mutate(change = chg(pay)
#' @autoglobal
#' @noRd
chg <- function(x, n = 1L, fill_na = 0L) {
  lg  <- dplyr::lag(x, n = n)
  res <- (x - lg)
  if (!is.na(fill_na)) res[is.na(res)] <- fill_na
  return(res)
}

#' Calculate relative change
#' @param x numeric vector
#' @param n values to offset
#' @param fill_na fill value for any NAs; default is 0
#' @returns numeric vector
#' @examples
#' dplyr::tibble(year = 2015:2020,
#'               pay = 1000:1005) |>
#' dplyr::mutate(pct_change = pct(pay)
#' @autoglobal
#' @noRd
pct <- function(x, n = 1L, fill_na = 0L) {
  lg <- dplyr::lag(x, n = n)
  res <- (x - lg) / lg
  if (!is.na(fill_na)) res[is.na(res)] <- fill_na
  return(res)
}

#' Calculate lagged values by column
#' @param df data frame
#' @param col column of numeric values to calculate lag
#' @param by column to calculate lag by
#' @param digits Number of digits to round to
#' @returns A `tibble`
#' @examples
#' dplyr::tibble(year = 2015:2020,
#'               pay = 1000:1005) |>
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
#' @returns number of years since today's date
#' @rdname calculations
#' @keywords internal
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
#' @noRd
years_vec <- function(date) {
  round(
    as.double(
      difftime(
        lubridate::today(),
        date,
        units = "weeks",
        tz = "UTC")) / 52.17857, 2)
}

#' Calculate number of years since today's date
#' @param date date column
#' @returns number of years since today's date
#' @examples
#' dplyr::tibble(date = lubridate::today() - 366) |>
#' dplyr::mutate(years_passed = years_vec(date = date))
#' @autoglobal
#' @noRd
duration_vec <- function(date) {

  date <- difftime(date, lubridate::today(), units = "auto", tz = "UTC")
  date <- lubridate::as.duration(date)
  return(date)
}

#' Summary stats
#' @description Returns a tibble of summary stats
#' @param df data frame
#' @param condition filter condition, i.e. `patient == "new"`
#' @param group_vars variables to group by, i.e. `c(specialty, state, hcpcs, cost)`
#' @param summary_vars variables to summarise, i.e. `c(min, max, mode, range)`
#' @param arr column to arrange data by, i.e. `cost`
#' @param digits Number of digits to round to, default is 3
#' @return A `tibble` containing the summary stats
#' @examplesIf interactive()
#' dplyr::tibble(
#' provider = sample(c("A", "B", "C"), size = 200, replace = TRUE),
#' city = sample(c("ATL", "NYC"), size = 200, replace = TRUE),
#' charges = sample(1000:2000, size = 200),
#' payment = sample(1000:2000, size = 200)) |>
#' summary_stats(condition = city == "ATL",
#'               group_vars = provider,
#'               summary_vars = c(charges, payment),
#'               arr = provider)
#' @autoglobal
#' @noRd
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
