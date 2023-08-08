#' Returns a tidytable of summary stats
#' @description Returns a tidy table of summary stats
#' @param df data frame
#' @param condition filter condition, i.e. `patient == "new"`
#' @param group_vars variables to group by, i.e. `c(specialty, state, hcpcs, cost)`
#' @param summary_vars variables to summarise, i.e. `c(min, max, mode, range)`
#' @param arr column to arrange data by, i.e. `cost`
#' @return A `tibble` containing the summary stats
#' @examplesIf interactive()
#' summary_stats(condition = patient == "new",
#'               group_vars = c(specialty, state, hcpcs, cost),
#'               summary_vars = c(min, max, mode, range),
#'               arr = cost)
#' @autoglobal
#' @export
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
            mean = \(x) mean(x, na.rm = TRUE)),
       .names = "{.fn}_{.col}"),
       n = dplyr::n(),
       .by = ({{ group_vars }}) ) |>
    dplyr::arrange(dplyr::desc({{ arr }}))

  return(results)
}

#' Format US ZIP codes -----------------------------------------------------
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

    zip <- paste0(stringr::str_sub(zip, 1, 5), "-", stringr::str_sub(zip, 6, 9))

    return(zip)

    } else {
      return(zip)
    }
  }

#' Remove NULL elements from vector ----------------------------------------
#' @autoglobal
#' @noRd
remove_null <- function(x) {Filter(Negate(is.null), x)}

#' Clean up credentials ----------------------------------------------------
#' @param x Character vector of credentials
#' @return List of cleaned character vectors, with one list element per element
#'   of `x`
#' @autoglobal
#' @noRd
clean_credentials <- function(x) {

  if (!is.character(x)) {stop("x must be a character vector")}

  out <- gsub("\\.", "", x)

  return(out)
}

#' Calculate number of years since today's date -----------------------------------------------------
#' @param df data frame
#' @param date_col date column
#' @return number of years since today's date
#' @autoglobal
#' @noRd
years_passed <- function(df, date_col) {

  df |>
    dplyr::mutate(
      years_passed = round(as.double(difftime(lubridate::today(),
                                              {{ date_col }},
                                              units = "weeks",
                                  tz = "UTC")) / 52.17857, 2),
      .after = {{ date_col }})
}

years <- function(date_col) {
  round(
    as.double(
      difftime(
        lubridate::today(),
        date_col,
        units = "weeks",
        tz = "UTC")) / 52.17857, 2)
}

#' luhn check npis ---------------------------------------------------------
#' @description checks NPIs against the Luhn algorithm for
#' compliance with the CMS requirements stated in the linked PDF below.
#'
#' # Requirements for NPI Check Digit
#'
#' The National Provider Identifier (NPI) check digit is calculated using
#' the Luhn formula for computing the modulus 10 “double-add-double” check
#' digit. This algorithm is recognized as an ISO standard and is the specified
#' check digit algorithm to be used for the card issuer identifier on a
#' standard health identification card.
#'
#' When an NPI is used as a card issuer identifier on a standard health
#' identification card, it is preceded by the prefix `80840`, in which `80`
#' indicates health applications and `840` indicates the United States.
#'
#' The prefix is required only when the NPI is used as a card issuer
#' identifier. However, in order that any NPI could be used as a card issuer
#' identifier on a standard health identification card, the check digit will
#' always be calculated as if the prefix is present. This is accomplished by
#' adding the constant `24` in step 2 of the check digit calculation (as shown
#' in the second example below) when the NPI is used without the prefix.
#'
#' ## Example NPI Check Digit Calculation (Card Issuer Identifier)
#'
#' Assume that the NPI is `123456789`. If used as a card issuer identifier on
#' a standard health identification card, the full number would be
#' `80840123456789`. Using the Luhn formula on the identifier portion, the
#' check digit is calculated as follows:
#'
#' 1. Card issuer identifier without check digit: `80840123456789`
#' 2. Double the value of alternate digits, beginning with the rightmost
#'    digit: `0 8 2 6 10 14 18`
#' 3. Add the individual digits of products of doubling, plus unaffected
#'    digits:
#'    `8 + 0 + 8 + 8 + 0 + 2 + 2 + 6 + 4 + 1 + 0 + 6 + 1 + 4 + 8 + 1 + 8 = 67`
#' 4. Subtract from next higher number ending in zero: `70 – 67 = 3`
#' 5. The check digit equals 3, thus the card issuer identifier with check
#'    digit is **80840**123456789**3**.
#'
#' ## Example NPI Check Digit Calculation (without Prefix)
#'
#' Assume that the NPI is `123456789`. Using the Luhn formula on the
#' identifier portion, the check digit is calculated as follows:
#'
#' 1. NPI without check digit: `123456789`
#' 2. Double the value of alternate digits, beginning with the rightmost
#'    digit: `2 6 10 14 18`
#' 3. Add constant `24`, to account for the `80840` prefix that would be
#'    present on a card issuer identifier, plus the individual digits of
#'    products of doubling, plus unaffected digits:
#'    `24 + 2 + 2 + 6 + 4 + 1 + 0 + 6 + 1 + 4 + 8 + 1 + 8 = 67`
#' 4. Subtract from next higher number ending in zero: `70 – 67 = 3`
#' 5. The check digit equals **3**, thus the NPI with check digit
#'    is 123456789**3**.
#'
#' ## Links
#'  * [The Luhn Algorithm](https://en.wikipedia.org/wiki/Luhn_algorithm)
#'  * [CMS NPI Standard](https://www.cms.gov/Regulations-and-Guidance/Administrative-Simplification/NationalProvIdentStand/Downloads/NPIcheckdigit.pdf)
#'
#' @param npi 10-digit National Provider Identifier (NPI).
#' @return boolean, `TRUE` or `FALSE`
#' @examples
#' # Valid NPI:
#' luhn_check(npi = 1528060837)
#'
#' # Quoted NPIs are valid:
#' luhn_check(npi = "1528060837")
#'
#' # Invalid NPI (per Luhn algorithm):
#' luhn_check(npi = 1234567891)
#'
#' \dontrun{
#' # NPIs with less than 10 digits throw an error:
#' luhn_check(npi = 123456789)
#'
#' # Inputting letters will throw an error, quoted or not:
#' luhn_check(npi = abcdefghij)
#' luhn_check(npi = "abcdefghij")
#' }
#' @autoglobal
#' @noRd
npi_check <- function(npi,
                      arg = rlang::caller_arg(npi),
                      call = rlang::caller_env()) {

  # Return FALSE if not a number
  if (grepl("^[[:digit:]]+$", npi) == FALSE) {
    cli::cli_abort(c(
      "NPI may be incorrect or invalid",
      "i" = "NPIs must be numeric.",
      "x" = "NPI: {.val {npi}} has non-numeric characters."), call = call)
  }

  # Must be 10 char length
  if (nchar(npi) != 10L) {
    cli::cli_abort(c(
      "NPI may be incorrect or invalid",
      "i" = "NPIs are 10 characters long.",
      "x" = "NPI: {.val {npi}} is {.val {nchar(npi)}} characters long."), call = call)
    }

  # Strip whitespace
  npi_luhn <- gsub(pattern = " ", replacement = "", npi)

  # Paste 80840 to each NPI number, per CMS documentation
  npi_luhn <- paste0("80840", npi_luhn)

  # Split string, Convert to list and reverse
  npi_luhn <- unlist(strsplit(npi_luhn, ""))
  npi_luhn <- npi_luhn[length(npi_luhn):1]
  to_replace <- seq(2, length(npi_luhn), 2)
  npi_luhn[to_replace] <- as.numeric(npi_luhn[to_replace]) * 2

  # Convert to numeric
  npi_luhn <- as.numeric(npi_luhn)

  # Must be a single digit, any that are > 9, subtract 9
  npi_luhn <- ifelse(npi_luhn > 9, npi_luhn - 9, npi_luhn)

  # Check if the sum divides by 10
  if ((sum(npi_luhn) %% 10) != 0) {
    cli::cli_abort(c(
      "NPI may be incorrect or invalid",
      "i" = "NPIs must pass {.emph Luhn algorithm}.",
      "x" = "NPI {.val {npi}} {.strong fails} Luhn check."), call = call)
  }
}

#' param_format ------------------------------------------------------------
#' @param param API parameter
#' @param arg API function arg
#' @return formatted API filters
#' @autoglobal
#' @noRd
param_format <- function(param, arg) {

  if (is.null(arg)) {
    param <- NULL
  } else {
      paste0("filter[", param, "]=", arg, "&")
    }
  }

#' param_space --------------------------------------------------------------
#' Some API parameters have spaces, these must be converted to "%20".
#' @param param parameter with a space
#' @return parameter formatted with "%20" in lieu of a space
#' @autoglobal
#' @noRd
param_space <- function(param) {gsub(" ", "%20", param)}

#' param_brackets -----------------------------------------------------------
#' Some API parameters have spaces, these must be converted to "%20".
#' @param param parameter with a space
#' @return parameter formatted with "%20" in lieu of a space
#' @autoglobal
#' @noRd
param_brackets <- function(param,
                           right = TRUE,
                           left = TRUE,
                           asterisk = TRUE) {
  param <- gsub("[", "%5B", param, fixed = TRUE)
  param <- gsub("*", "%2A", param, fixed = TRUE)
  param <- gsub("]", "%5D", param, fixed = TRUE)
  return(param)
}

#' sql_format ------------------------------------------------------------
#' @param param API parameter
#' @param arg API function arg
#' @return formatted API filters
#' @autoglobal
#' @noRd
sql_format <- function(param, arg) {
  if (is.null(arg)) {param <- NULL} else {
    paste0("[WHERE ", param, " = ", "%22", arg, "%22", "]")}}

#' str_to_snakecase --------------------------------------------------------
#' @param string string
#' @return string formatted to snakecase
#' @autoglobal
#' @noRd
str_to_snakecase <- function(string) {

  string |>
    purrr::map_chr(function(string) {
      string |> stringr::str_to_lower() |>
                stringr::str_c(collapse = "_")}) |>
    stringr::str_remove("^_") |>
    stringr::str_replace_all(c(" " = "_",
                               "/" = "_",
                               "-" = "_",
                               "__" = "_",
                               ":" = ""))
}

#' Convert Y/N char values to logical ----------------------
#' @param x vector
#' @autoglobal
#' @noRd
tf_logical <- function(x){
  dplyr::case_when(
    x == "True" ~ as.logical(TRUE),
    x == "False" ~ as.logical(FALSE),
    .default = NA)
}

#' Convert Y/N char values to logical ----------------------
#' @param x vector
#' @autoglobal
#' @noRd
yn_logical <- function(x){
  dplyr::case_when(
    x == as.character("Y") ~ as.logical(TRUE),
    x == as.character("N") ~ as.logical(FALSE),
    x == as.character("YES") ~ as.logical(TRUE),
    x == as.character("NO") ~ as.logical(FALSE),
    x == as.character("Yes") ~ as.logical(TRUE),
    x == as.character("No") ~ as.logical(FALSE),
    .default = NA)
}

#' Convert I/O char values to logical ----------------------
#' @param x vector
#' @autoglobal
#' @noRd
entype_char <- function(x){
  dplyr::case_when(
    x == "NPI-1" ~ "Individual",
    x == "I" ~ "Individual",
    x == "NPI-2" ~ "Organization",
    x == "O" ~ "Organization"
    )
}

#' Convert I/O char values to logical ----------------------
#' @param x vector
#' @autoglobal
#' @noRd
entype_arg <- function(x) {
  x <- if (is.numeric(x)) as.character(x)
  dplyr::case_match(
    x,
    c("I", "i", "Ind", "ind", "1") ~ "NPI-1",
    c("O", "o", "Org", "org", "2") ~ "NPI-2",
    .default = NULL
  )
}

#' Convert Place of Service values ----------------------
#' @param x vector
#' @autoglobal
#' @noRd
pos_char <- function(x){
  dplyr::case_when(
    x == "facility" ~ "F",
    x == "Facility" ~ "F",
    x == "F" ~ "F",
    x == "f" ~ "F",
    x == "office" ~ "O",
    x == "Office" ~ "O",
    x == "O" ~ "O",
    x == "o" ~ "O",
    .default = NULL)
}

#' Convert Open Payments Changed col to logical ----------------------
#' @param x vector
#' @autoglobal
#' @noRd
changed_logical <- function(x){
  dplyr::case_when(
    x == "CHANGED" ~ as.logical(TRUE),
    x == "UNCHANGED" ~ as.logical(FALSE),
    TRUE ~ NA
  )
}

#' display_long ------------------------------------------------------------
#' @param df data frame
#' @autoglobal
#' @noRd
display_long <- function(df){

  df |> dplyr::mutate(dplyr::across(dplyr::everything(), as.character)) |>
        tidyr::pivot_longer(dplyr::everything())
}

#' @param df df
#' @param col col
#' @param by by
#' @return A `tibble`
#' @autoglobal
#' @noRd
change_abs <- function(df, col, by) {

  df |> dplyr::mutate(
    "{{ col }}_chg" := {{ col }} - dplyr::lag({{ col }}, order_by = {{ by }}),
    .after = {{ col }})
}

#' @param df df
#' @param col col
#' @param col_abs col_abs_chng
#' @param by by
#' @return A `tibble`
#' @autoglobal
#' @noRd
change_pct <- function(df, col, col_abs, by) {

  df |> dplyr::mutate(
    "{{ col }}_pct" := {{ col_abs }} / dplyr::lag({{ col }}, order_by = {{ by }}),
    .after = {{ col_abs }})
}

#' @param df df
#' @param col col
#' @param by by
#' @return A `tibble`
#' @autoglobal
#' @noRd
change_year <- function(df, col, by) {

  df |>
    dplyr::mutate(
      "{{ col }}_chg" := {{ col }} - dplyr::lag({{ col }}, order_by = {{ by }}),
      "{{ col }}_pct" := "{{ col }}_chg" / dplyr::lag({{ col }}, order_by = {{ by }}),
      .after = {{ col }})
}

#' convert_breaks ------------------------------------------------------------
#' @param x vector
#' @param decimal TRUE or FALSE
#' @autoglobal
#' @noRd
convert_breaks <- function(x, decimal = FALSE) {

  rx <- "(\\d{1,3}(?:,\\d{3})*(?:\\.\\d+)?)"

  p <- all(stringr::str_detect(x, "%"))

  if (length(unique(x)) == 1) {

    return(TRUE)

  } else if (all(stringr::str_detect(x, "\\d", negate = TRUE))) {

    return(factor(x, ordered = FALSE))

  }

  x <- stringr::str_replace(x, "\\sor\\s(fewer|lower)", "-")
  x <- stringr::str_replace(x, "\\sor\\s(more|higher)", "+")
  x <- stringr::str_replace(x, "\\sto\\s", " - ")
  x <- stringr::str_remove_all(x, "[^[\\+\\d\\s\\.-]]")
  x <- stringr::str_remove(x, "(?<=\\d)(\\.0)(?=\\D)")

  if (any(stringr::str_detect(x, sprintf("^%s$", rx)))) {

    x <- stringr::str_replace(x, paste0(rx, "(?:-$)"), "[0,\\1]")
    x <- stringr::str_replace(x, paste0(rx, "(?:\\+$)"), "[\\1, Inf)")
    x <- stringr::str_replace(x, sprintf("^%s$", rx), "[\\1,\\1]")

  } else if (p) {

    x <- stringr::str_replace(x, paste0(rx, "(?:-$)"), "[0,\\1)")
    x <- stringr::str_replace(x, paste0(rx, "(?:\\+$)"), "[\\1,100]")
    x <- stringr::str_replace(x, paste(rx, "-", rx), "[\\1,\\2)")

    if (decimal) {

      x <- stringr::str_replace_all(x, rx, function(p) as.numeric(p)/100)

    }

    n <- stringr::str_extract_all(x, "(\\d{1,3}(?:\\.\\d+)?)|Inf")

    if (length(n) >= 2) {

      d <- abs(diff(as.numeric(c(n[[2]][1], n[[1]][2]))))

      if (p & round(d, digits = 2) == 0.1) {

        x <- stringr::str_replace_all(string = x,
                                      pattern = paste0(rx, "(?=\\)$)"),
          replacement = function(n) as.numeric(n) + 0.1)
      }
    }
  } else if (any(stringr::str_detect(x, paste(rx, "-", rx)))) {

    x <- stringr::str_replace(x, paste0(rx, "(?:-$)"), "[0,\\1]")
    x <- stringr::str_replace(x, paste(rx, "(?:-|to)", rx), "[\\1,\\2]")
    x <- stringr::str_replace(x, paste0(rx, "(?:\\+$)"), "[\\1, Inf)")

  }

  z <- unique(x)
  a <- stringr::str_extract_all(z, "(\\d{1,3}(?:\\.\\d+)?)|Inf")
  a <- vapply(a, FUN = function(i) sum(as.numeric(i)), FUN.VALUE = double(1))
  a <- match(a, sort(a))
  factor(x, levels = z[order(sort(z)[a])], ordered = TRUE)

}

