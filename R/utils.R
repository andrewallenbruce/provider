#' Calculate Number of Days Between Two Dates ------------------------------
#' Note: Calculation includes end date in the sum (see example)
#' @param df data frame containing date columns
#' @param start column containing date(s) prior to end_date column
#' @param end column containing date(s) after start_date column
#' @param colname desired column name of output; default is "age"
#' @return A [tibble][tibble::tibble-package] with a named column
#'    containing the calculated number of days.
#' @examples
#' date_ex <- tibble::tibble(x = seq.Date(as.Date("2021-01-01"),
#'                           by = "month", length.out = 3),
#'                           y = seq.Date(as.Date("2022-01-01"),
#'                           by = "month", length.out = 3))
#' age_days(df = date_ex,
#'          start = x,
#'          end = y)
#'
#' date_ex |>
#' age_days(x, y, colname = "days_between_x_y")
#'
#' date_ex |>
#' age_days(start = x,
#' end = lubridate::today(),
#' colname = "days_since_x")
#'
#' date_ex |>
#' age_days(x, y, "days_between_x_y") |>
#' age_days(x, lubridate::today(), "days_since_x") |>
#' age_days(y, lubridate::today(), colname = "days_since_y")
#' @autoglobal
#' @noRd
age_days <- function(df,
                     start,
                     end,
                     colname = "age") {

  results <- df |>
    dplyr::mutate(start = as.Date({{ start }},
                                  "%yyyy-%mm-%dd",
                                  tz = "EST"),
                  end = as.Date({{ end }},
                                "%yyyy-%mm-%dd",
                                tz = "EST")) |>
    dplyr::mutate("{colname}" := ((as.numeric(
      lubridate::days(end) - lubridate::days(start),
      "hours") / 24) + 1)) |>
    dplyr::select(!c(end, start))

  return(results)
}

#' Calculate Number of Days Between a Date and Today -----------------------
#' @param df data frame containing date columns
#' @param start date column
#' @param colname desired column name of output
#' @return data frame with a column containing the number of days
#'    calculated.
#' @examples
#' ex <- data.frame(x = c("1992-02-05",
#'                        "2020-01-04",
#'                        "1996-05-01",
#'                        "2020-05-01",
#'                        "1996-02-04"))
#'
#' days_today(df = ex, start = x)
#'
#' ex |> days_today(x)
#' @autoglobal
#' @noRd
days_today <- function(df, start, colname = "age") {

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

#' Format US ZIP codes -----------------------------------------------------
#' @param zip Nine-digit US ZIP code
#' @return ZIP code, hyphenated for ZIP+4 or 5-digit ZIP.
#' @examples
#' format_zipcode(123456789)
#' format_zipcode(12345)
#' @autoglobal
#' @noRd
format_zipcode <- function(zip) {zip <- as.character(zip)
  if (stringr::str_detect(zip, "^[[:digit:]]{9}$") == TRUE) {
  zip <- paste0(stringr::str_sub(zip, 1, 5), "-", stringr::str_sub(zip, 6, 9))
  return(zip)} else {return(zip)}}

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
  out <- stringr::str_split(out, "[,\\s;]+", simplify = FALSE)
  return(out)
}

#' Create full address -----------------------------------------------------
#' @param df data frame
#' @param address_1 Quoted column containing first-street address
#' @param address_2 Quoted column containing second-street address
#' @param city Quoted column containing city
#' @param state Quoted column containing two-letter state abbreviation
#' @param postal_code Quoted column containing postal codes
#' @return Character vector containing full one-line address
#' @autoglobal
#' @noRd
full_address1 <- function(df, address_1, address_2, city, state, postal_code) {
  stringr::str_c(stringr::str_trim(df[[address_1]], "both"),
  ifelse(df[[address_2]] == "", "", " "),
  stringr::str_trim(df[[address_2]], "both"), ", ",
  stringr::str_trim(df[[city]], "both"), ", ",
  stringr::str_trim(df[[state]], "both"), " ",
  stringr::str_trim(df[[postal_code]], "both"))}

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
luhn_check <- function(npi = NULL) {

  # Number of digits should be 10
  attempt::stop_if_not(nchar(npi) == 10,
  msg = c("NPIs must have 10 digits.
  Provided NPI has ", nchar(npi), " digits."))

  # Return FALSE if not a number
  if (!grepl("^[[:digit:]]+$", npi)) {return(FALSE)}

  # Strip whitespace
  npi <- gsub(pattern = " ", replacement = "", npi)

  # Paste 80840 to each NPI number, per CMS documentation
  npi <- paste0("80840", npi)

  # Split string, Convert to list and reverse
  npi <- unlist(strsplit(npi, ""))
  npi <- npi[length(npi):1]
  to_replace <- seq(2, length(npi), 2)
  npi[to_replace] <- as.numeric(npi[to_replace]) * 2

  # Convert to numeric
  npi <- as.numeric(npi)

  # Must be a single digit, any that are > 9, subtract 9
  npi <- ifelse(npi > 9, npi - 9, npi)

  # Check if the sum divides by 10
  ((sum(npi) %% 10) == 0)
}

#' param_format ------------------------------------------------------------
#' @param param API parameter
#' @param arg API function arg
#' @return formatted API filters
#' @autoglobal
#' @noRd
param_format <- function(param, arg) {if (is.null(arg)) {param <- NULL}
  else {paste0("filter[", param, "]=", arg, "&")}}

#' param_space --------------------------------------------------------------
#' Some API parameters have spaces, these must be converted to "%20".
#' @param param parameter with a space
#' @return parameter formatted with "%20" in lieu of a space
#' @autoglobal
#' @noRd
param_space <- function(param) {gsub(" ", "%20", param)}

#' is_empty_list -----------------------------------------------------------
#' @param df data frame
#' @param col quoted list-column in data frame
#' @return boolean, TRUE or FALSE
#' @autoglobal
#' @noRd
is_empty_list <- function(df, col){list <- df[col][[1]][[1]]
  if (is.list(list) == TRUE && length(list) == 0) {return(TRUE)}
  else {return(FALSE)}}


#' is_empty_list2 -----------------------------------------------------------
#' @param df data frame
#' @return boolean, TRUE or FALSE
#' @autoglobal
#' @noRd
is_empty_list2 <- function(df){list <- df[[1]]
if (is.list(list) == TRUE && length(list) == 0) {return(TRUE)}
else {return(FALSE)}}

#' re_nest -----------------------------------------------------------------
#' @param df data frame
#' @param col quoted list-column in data frame
#' @return A [tibble][tibble::tibble-package]
#' @autoglobal
#' @noRd
re_nest <- function(df, col){

  if (isTRUE(is_empty_list(df, col))) {

    results <- dplyr::mutate(df, "{col}" := NA)

  } else {

    nested <- df[col]
    unnested <- tidyr::unnest(nested, cols = c({{ col }}))
    colnames(unnested) <- paste0(col, "_", colnames(unnested))

    bind <- dplyr::bind_cols(df, unnested)

    results <- bind |>
      dplyr::select(!{{ col }}) |>
      tidyr::nest("{col}" := dplyr::contains({{ col }}))
  }

  return(results)
}

#' Calculate the percent difference between two values ----------------------
#' @param x,y Values to determine the percent difference between.
#' @autoglobal
#' @noRd
#' @examples
#' pct_diff(265, 4701)
pct_diff <- function(x, y) {abs(x - y) / mean(c(x, y))}

#' Convert Y/N char values to logical ----------------------
#' @param x vector
#' @autoglobal
#' @noRd
yn_logical <- function(x){
  dplyr::case_when(
    x == as.character("Y") ~ as.logical(TRUE),
    x == as.character("N") ~ as.logical(FALSE),
    TRUE ~ NA)
}

#' gt functions --------------------------------------------------------------
#' @param data data frame
#' @autoglobal
#' @noRd
gt_theme_provider <- function(data,...) {
  data |>
    gt::opt_all_caps() |>
    gt::opt_row_striping() |>
    gt::opt_table_font(
      font = list(
        gt::google_font("Chivo"),
        gt::default_fonts())) |>
    gt::tab_style(
      style = gt::cell_borders(
        sides = "bottom",
        color = "transparent",
        weight = gt::px(2)),
      locations = gt::cells_body(
        columns = dplyr::everything(),
        rows = nrow(data$`_data`)))  |>
    gt::tab_options(
      footnotes.multiline = FALSE,
      footnotes.font.size = 12,
      footnotes.padding = gt::px(3),
      row_group.as_column = FALSE,
      row.striping.background_color = "#fafafa",
      table_body.hlines.color = "#f6f7f7",
      table.border.top.width = gt::px(3),
      table.border.top.color = "gray",
      table.border.bottom.color = "gray",
      table.border.bottom.width = gt::px(3),
      column_labels.border.top.width = gt::px(3),
      column_labels.border.top.color = "gray",
      column_labels.border.bottom.width = gt::px(3),
      column_labels.border.bottom.color = "#440D0D",
      column_labels.background.color = "#FDD4D0",
      data_row.padding = gt::px(3),
      source_notes.multiline = FALSE,
      source_notes.font.size = 12,
      source_notes.border.bottom.color = "#440D0D",
      source_notes.border.bottom.width = gt::px(3),
      table.font.size = 16,
      heading.background.color = "#FDD4D0",
      heading.align = "left",
      heading.title.font.size = 16,
      heading.title.font.weight = "bold",
      heading.subtitle.font.size = 14,
      heading.subtitle.font.weight = NULL,
      heading.padding = NULL,
      heading.padding.horizontal = NULL,
      heading.border.bottom.style = NULL,
      heading.border.bottom.width = NULL,
      heading.border.bottom.color = NULL,
      heading.border.lr.style = NULL,
      heading.border.lr.width = NULL,
      heading.border.lr.color = NULL,
      ...)
}

#' @noRd
gt_add_badge <- function(x){
  add_color <- if (x == "Individual") {
    "background: hsl(116, 60%, 90%); color: hsl(116, 30%, 25%);"
  } else if (x == "Organization") {
    "background: hsl(350, 70%, 90%); color: hsl(350, 45%, 30%);"
  } else if (x != "Individual" | x != "Organization") { x
  }
  div_out <- htmltools::div(
    style = paste("display: inline-block; padding: 2px 12px; border-radius: 15px; font-weight: 600; font-size: 16px;", add_color), x)
  as.character(div_out) |> gt::html()
}

#' @noRd
gt_check_xmark <- function(x) {
  add_checkx <- if (x == TRUE) {
    fontawesome::fa("circle-check", prefer_type = "solid", fill = "#F24141", height = "1.5em", width = "1.5em")
  } else if (x == "FALSE") {
    fontawesome::fa("circle-xmark", prefer_type = "solid", fill = "#F54444")
  } else if (x != "Individual" | x != "Organization") {
    x
  }
  div_out <- htmltools::div(style = paste("display: inline-block; padding: 2px 12px; border-radius: 15px; font-weight: 600; font-size: 16px;", add_checkx), x)
  as.character(div_out) |> gt::html()
}
