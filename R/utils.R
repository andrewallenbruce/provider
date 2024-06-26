#' Infix operator for `if (!is.null(x)) y else x` statements
#' @param x,y description
#' @return description
#' @examples
#' ccn <- 123456
#' ccn <- ccn %nn% as.character(ccn)
#' ccn
#' @autoglobal
#' @noRd
`%nn%` <- function(x, y) if (!is.null(x)) y else x #nocov

#' Infix operator for `not in` statements
#' @return description
#' @autoglobal
#' @noRd
`%nin%` <- function(x, table) match(x, table, nomatch = 0L) == 0L #nocov

#' Format US ZIP codes
#' @param zip Nine-digit US ZIP code
#' @return ZIP code, hyphenated for ZIP+4 or 5-digit ZIP.
#' @examples
#' format_zipcode(123456789)
#' format_zipcode(12345)
#' @autoglobal
#' @noRd
format_zipcode <- function(zip) {

  zip <- as.character(zip)

  if (stringr::str_detect(zip, "^[[:digit:]]{9}$") == TRUE) {
    zip <- paste0(stringr::str_sub(zip, 1, 5), "-",
                  stringr::str_sub(zip, 6, 9))
    return(zip)
    } else {
      return(zip)
  }
}

#' Remove periods from credentials
#' @param x Character vector
#' @return Character vector with periods removed
#' @autoglobal
#' @noRd
clean_credentials <- function(x) {
  gsub("\\.", "", x)
}

#' Remove commas from dollar amounts
#' @param x Character vector
#' @return Character vector with commas removed
#' @autoglobal
#' @noRd
clean_dollars <- function(x) {
  gsub(",", "", x)
}

#' Convert empty char values to NA
#' @param x vector
#' @autoglobal
#' @noRd
na_blank <- function(x) {

  x <- dplyr::na_if(x, "")
  x <- dplyr::na_if(x, " ")
  x <- dplyr::na_if(x, "*")
  x <- dplyr::na_if(x, "--")
  x <- dplyr::na_if(x, "N/A")
  return(x)
}

#' Convert Y/N char values to logical
#' @param x vector
#' @autoglobal
#' @noRd
yn_logical <- function(x) {

  dplyr::case_match(
    x,
    c("Y", "YES", "Yes", "yes", "y", "True") ~ TRUE,
    c("N", "NO", "No", "no", "n", "False") ~ FALSE,
    .default = NA
  )
}

#' Convert TRUE/FALSE values to Y/N
#' @param x vector
#' @autoglobal
#' @noRd
tf_2_yn <- function(x) {

  dplyr::case_match(
    x,
    TRUE ~ "Y",
    FALSE ~ "N",
    .default = NULL
  )
}

#' @param abb state abbreviation
#' @return state full name
#' @autoglobal
#' @noRd
abb2full <- function(abb,
                     arg = rlang::caller_arg(abb),
                     call = rlang::caller_env()) {

  results <- dplyr::tibble(x = c(state.abb[1:8],
                                 'DC',
                                 state.abb[9:50],
                                 'AS', 'GU', 'MP', 'PR', 'VI', 'UK'),
                           y = c(state.name[1:8],
                                 'District of Columbia',
                                 state.name[9:50],
                                 'American Samoa',
                                 'Guam',
                                 'Northern Mariana Islands',
                                 'Puerto Rico',
                                 'Virgin Islands',
                                 'Unknown')) |>
    dplyr::filter(x == abb) |>
    dplyr::pull(y)

  if (vctrs::vec_is_empty(results)) {
    cli::cli_abort(c("{.val {abb}} is not a valid state abbreviation."), # nolint
                   call = call)
  }
  return(results)
}

#' Pivot data frame to long format for easy printing
#' @param df data frame
#' @param cols columns to pivot long, default is [dplyr::everything()]
#' @autoglobal
#' @export
#' @keywords internal
display_long <- function(df, cols = dplyr::everything()) {

  df |> dplyr::mutate(dplyr::across(dplyr::everything(), as.character)) |>
        tidyr::pivot_longer({{ cols }})
}

#' Convert data.frame cols to character
#' @param df data frame
#' @autoglobal
#' @export
#' @keywords internal
df2chr <- function(df) {
  df |>
    dplyr::mutate(
      dplyr::across(
        dplyr::where(is.numeric), as.character))
}

#' Tidy a Data Frame
#' @param df data frame
#' @param dtype `mdy` or `ymd`
#' @param dt convert to date, default is 'date'
#' @param yn convert to logical
#' @param int convert to integer
#' @param dbl convert to double
#' @param chr convert to character
#' @param up convert to upper case
#' @param cred remove periods
#' @param zip normalize zip code
#' @param lgl convert to logical
#' @param cma remove commas
#' @returns tidy data frame
#' @autoglobal
#' @export
#' @keywords internal
tidyup <- function(df,
                   dtype = NULL,
                   dt = "date",
                   yn = NULL,
                   int = NULL,
                   dbl = NULL,
                   chr = NULL,
                   up = NULL,
                   cred = NULL,
                   zip = NULL,
                   lgl = NULL,
                   cma = NULL) {

  x <- janitor::clean_names(df) |>
    dplyr::tibble() |>
    dplyr::mutate(dplyr::across(dplyr::everything(), stringr::str_squish),
                  dplyr::across(dplyr::where(is.character), na_blank))

  if (!is.null(dtype)) {
    if (dtype == 'mdy') x <- dplyr::mutate(x, dplyr::across(dplyr::contains(dt), ~ lubridate::mdy(.x, quiet = TRUE)))
    if (dtype == 'ymd') x <- dplyr::mutate(x, dplyr::across(dplyr::contains(dt), ~ lubridate::ymd(.x, quiet = TRUE)))
  }

  if (!is.null(cma))  x <- dplyr::mutate(x, dplyr::across(dplyr::contains(cma),  clean_dollars))
  if (!is.null(yn))   x <- dplyr::mutate(x, dplyr::across(dplyr::contains(yn),   yn_logical))
  if (!is.null(int))  x <- dplyr::mutate(x, dplyr::across(dplyr::contains(int),  as.integer))
  if (!is.null(dbl))  x <- dplyr::mutate(x, dplyr::across(dplyr::contains(dbl),  as.double))
  if (!is.null(chr))  x <- dplyr::mutate(x, dplyr::across(dplyr::contains(chr),  as.character))
  if (!is.null(up))   x <- dplyr::mutate(x, dplyr::across(dplyr::contains(up),   toupper))
  if (!is.null(cred)) x <- dplyr::mutate(x, dplyr::across(dplyr::contains(cred), clean_credentials))
  if (!is.null(zip))  x <- dplyr::mutate(x, dplyr::across(dplyr::contains(zip),  zipcodeR::normalize_zip))
  if (!is.null(lgl))  x <- dplyr::mutate(x, dplyr::across(dplyr::contains(lgl),  as.logical))

  return(x)
}

#' @param df data frame
#' @param nm new col name, unquoted
#' @param cols columns to combine
#' @param sep separator
#' @autoglobal
#' @noRd
combine <- function(df, nm, cols, sep = " ") {

  return(tidyr::unite(df, col = {{ nm }},
                      dplyr::any_of(cols),
                      remove = TRUE,
                      na.rm = TRUE,
                      sep = sep))
}

#' Remove empty rows and columns
#' @param df data frame
#' @autoglobal
#' @noRd
narm <- function(df) {
  janitor::remove_empty(df, which = c("rows", "cols"))
}

#' Return GitHub raw url
#' @param x url
#' @returns raw url
#' @examplesIf interactive()
#' github_raw("andrewallenbruce/provider/")
#' @autoglobal
#' @noRd
github_raw <- function(x) {
  paste0("https://raw.githubusercontent.com/", x)
}

#' Format empty search results
#' @param df data frame of parameter arguments
#' @autoglobal
#' @noRd
format_cli <- function(df) {

  x <- purrr::map2(df$x,
                   df$y,
                   stringr::str_c,
                   sep = " = ",
                   collapse = "")

  cli::cli_alert_danger("No results for {.val {x}}",
                        wrap = TRUE)

}

#' Mount [pins][pins::pins-package] board
#'
#' @param source `"local"` or `"remote"`
#'
#' @return `<pins_board_folder>` or `<pins_board_url>`
#'
#' @noRd
mount_board <- function(source = c("local", "remote")) {

  source <- match.arg(source)

  switch(
    source,
    local  = pins::board_folder(
      fs::path_package(
        "extdata/pins",
        package = "provider")
    ),
    remote = pins::board_url(
      fuimus::gh_raw(
        "andrewallenbruce/provider/master/inst/extdata/pins/")
    )
  )
}
