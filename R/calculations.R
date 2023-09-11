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

#' Calculate lagged values by columns
#' @param df data frame
#' @param cols numeric columns
#' @returns A `tibble`
#' @examples
#' dplyr::tibble(year = 2015:2020,
#' charges = sample(1000:2000, size = 6),
#' payment = sample(1000:2000, size = 6)) |>
#' change(c(charges, payment))
#' @autoglobal
#' @export
change <- function(df, cols) {

  dplyr::mutate(df,
    dplyr::across({{ cols }},
      list(chg = \(x) chg(x),
           pct = \(x) pct(x)),
      .names = "{.col}_{.fn}"))
}

#' Calculate absolute change
#' @param x numeric vector
#' @param n values to offset
#' @returns numeric vector
#' @examples
#' dplyr::tibble(year = 2015:2020,
#'               pay = 1000:1005) |>
#' dplyr::mutate(change = chg(pay)
#' @autoglobal
#' @export
chg <- function(x, n = 1L) {
  lg  <- dplyr::lag(x, n = n)
  res <- (x - lg)
  return(res)
}

#' Calculate relative change
#' @param x numeric vector
#' @param n values to offset
#' @returns numeric vector
#' @examples
#' dplyr::tibble(year = 2015:2020,
#'               pay = 1000:1005) |>
#' dplyr::mutate(pct_change = pct(pay)
#' @autoglobal
#' @export
pct <- function(x, n = 1L) {
  lg <- dplyr::lag(x, n = n)
  res <- (x - lg) / lg
  return(res)
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

#' Summary stats
#' @description Returns a tibble of summary stats
#' @param df data frame
#' @param condition filter condition, i.e. `patient == "new"`
#' @param group_vars variables to group by, i.e. `c(specialty, state, hcpcs, cost)`
#' @param summary_vars variables to summarise, i.e. `c(min, max, mode, range)`
#' @param arr column to arrange data by, i.e. `cost`
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
                          arr = NULL) {

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
    dplyr::arrange(dplyr::desc({{ arr }}))

  return(results)
}
