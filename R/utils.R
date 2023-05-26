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
  return(out)
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
param_format <- function(param, arg) {if (is.null(arg)) {param <- NULL}
  else {paste0("filter[", param, "]=", arg, "&")}}

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
    x == "NPI-1" ~ "Ind",
    x == "I" ~ "Ind",
    x == "NPI-2" ~ "Org",
    x == "O" ~ "Org"
    )
}

#' Convert I/O char values to logical ----------------------
#' @param x vector
#' @autoglobal
#' @noRd
entype_arg <- function(x){
  dplyr::case_when(
    x == "I" ~ "NPI-1",
    x == "i" ~ "NPI-1",
    x == "O" ~ "NPI-2",
    x == "o" ~ "NPI-2",
    .default = NULL
  )
}

#' Convert Place of Service values ----------------------
#' @param x vector
#' @autoglobal
#' @noRd
pos_char <- function(x){
  dplyr::case_when(
    x == "F" ~ "Facility",
    x == "O" ~ "Office"
  )
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


#' gt functions --------------------------------------------------------------
#' @param data data frame
#' @autoglobal
#' @noRd
gt_theme_provider <- function(data,...){

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

#' @param x column
#' @autoglobal
#' @noRd
gt_entype_badge <- function(x) {

  add_color <- if (x == "Ind") {

    "background: hsl(116, 60%, 90%); color: hsl(116, 30%, 25%);"

    } else if (x == "Org") {

      "background: hsl(350, 70%, 90%); color: hsl(350, 45%, 30%);"

      } else if (x != "Ind" | x != "Org") {
        x
        }

  div_out <- htmltools::div(
    style = paste("display: inline-block; padding: 2px 12px; border-radius: 15px; font-weight: 600; font-size: 16px;",
                  add_color),
    x)

  as.character(div_out) |> gt::html()
}

#' @param gt_tbl gt_tbl object
#' @param cols columns in data frame
#' @autoglobal
#' @noRd
gt_check_xmark <- function(gt_tbl, cols) {

  gt_tbl |>
    gt::text_case_when(
      x == TRUE ~ gt::html(
        fontawesome::fa("circle-check",
                      prefer_type = "solid",
                      fill = "black",
                      height = "1.75em",
                      width = "1.75em")),
    x == FALSE ~ gt::html(
      fontawesome::fa("circle-xmark",
                      prefer_type = "solid",
                      fill = "red",
                      height = "1.75em",
                      width = "1.75em")),
    .default = NA,
    .locations = gt::cells_body(
      columns = {{ cols }}))
}

#' @param gt_tbl gt_tbl object
#' @param cols columns in data frame
#' @autoglobal
#' @noRd
gt_qmark <- function(gt_tbl, cols) {

  gt_tbl |>
    gt::text_case_when(
      x == "Y" ~ gt::html(
        fontawesome::fa("circle-check",
                        prefer_type = "solid",
                        fill = "black",
                        height = "1.75em",
                        width = "1.75em")),
      x == "N" ~ gt::html(
        fontawesome::fa("circle-xmark",
                        prefer_type = "solid",
                        fill = "red",
                        height = "1.75em",
                        width = "1.75em")),
      x == "M" ~ gt::html(
        fontawesome::fa("circle-question",
                        prefer_type = "solid",
                        fill = "red",
                        height = "1.75em",
                        width = "1.75em")),
      .default = "",
      .locations = gt::cells_body(
        columns = {{ cols }}))
}

#' @param df data frame
#' @autoglobal
#' @noRd
gt_datadict <- function(df) {

  df |>
    gt::gt() |>
    gt::fmt_markdown(columns = Variable) |>
    gtExtras::gt_add_divider(
      columns = c("Variable"),
      style = "solid",
      color = "gray",
      weight = gt::px(2),
      include_labels = FALSE) |>
    gtExtras::gt_merge_stack(col1 = Description,
                             col2 = Definition,
                             small_cap = FALSE,
                             font_size = c("16px", "14px"),
                             font_weight = c("bold", "normal"),
                             palette = c("black", "darkgray")) |>
    gt::opt_stylize(style = 6,
                    color = "red",
                    add_row_striping = FALSE) |>
    gt::opt_table_lines(extent = "default") |>
    gt::opt_table_outline(style = "none") |>
    gt::opt_table_font(font = gt::google_font(name = "Karla")) |>
    gt::tab_options(table.width = gt::pct(100))

  }

#' @param df data frame
#' @param divider description
#' @param title description
#' @param subtitle description
#' @param source description
#' @param checkmark description
#' @param qmark description
#' @param dollars description
#' @param pct description
#' @param pctchg description
#' @autoglobal
#' @noRd
gt_prov <- function(df,
                    divider   = NULL,
                    title     = NULL,
                    subtitle  = NULL,
                    source    = NULL,
                    checkmark = NULL,
                    qmark     = NULL,
                    dollars   = NULL,
                    pct       = NULL,
                    pctchg    = NULL,
                    clean     = TRUE) {

  results <- df |>
    gt::gt() |>
    gtExtras::gt_theme_538() |>
    gt::sub_missing(columns = dplyr::everything(), missing_text = "--") |>
    gt::tab_options(table.width = gt::pct(100))

  if (clean) {
    results <- results |>
      gt::cols_label_with(fn = ~ janitor::make_clean_names(., case = "title"))
    }

  if (!is.null(divider)) {
    results <- results |>
      gtExtras::gt_add_divider(
        columns = {{ divider }},
        style = "solid",
        color = "black",
        weight = gt::px(3),
        include_labels = FALSE)
    }

  if (!is.null(title)) {
    results <- results |>
      gt::tab_header(title = title)
    }

  if (!is.null(subtitle)) {
    results <- results |>
      gt::tab_header(title = title, subtitle = subtitle)
    }

  if (!is.null(source)) {
    results <- results |> gt::tab_source_note(source_note = source)
    }

  if (!is.null(checkmark)) {
    results <- results |> gt_check_xmark(cols = checkmark)
    }

  if (!is.null(qmark)) {
    results <- results |> gt_qmark(cols = qmark)
    }

  if (!is.null(dollars)) {
    results <- results |>
      gt::fmt_currency(columns = {{ dollars }},
                       currency = "USD",
                       suffixing = TRUE,
                       sep_mark = ",",
                       incl_space = TRUE)
    }

  if (!is.null(pct)) {
    results <- results |>
      gt::fmt_percent(columns = {{ pct }},
                      decimals = 0)
  }

  if (!is.null(pctchg)) {
    results <- results |>
      gt::fmt_percent(columns = {{ pctchg }},
                      decimals = 1,
                      force_sign = TRUE)
  }
  return(results)
}


#' readme function table ---------------------------------------------------
#' @autoglobal
#' @noRd
function_tbl    <- function() {
  nppes_func    <- gluedown::md_code("nppes_npi()")
  nppes_link    <- gluedown::md_link(
    "NPPES National Provider Identifier (NPI) Registry" = "https://npiregistry.cms.hhs.gov/search")
  open_func     <- gluedown::md_code("open_payments()")
  open_link     <- gluedown::md_link(
    "CMS Open Payments Program" = "https://openpaymentsdata.cms.gov/dataset/0380bbeb-aea1-58b6-b708-829f92a48202")
  mppe_func     <- gluedown::md_code("provider_enrollment()")
  mppe_link     <- gluedown::md_link(
    "Medicare Fee-For-Service Public Provider Enrollment" = "https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/medicare-fee-for-service-public-provider-enrollment")
  mme_func      <- gluedown::md_code("beneficiary_enrollment()")
  mme_link      <- gluedown::md_link(
    "Medicare Monthly Enrollment" = "https://data.cms.gov/summary-statistics-on-beneficiary-enrollment/medicare-and-medicaid-reports/medicare-monthly-enrollment")
  miss_func     <- gluedown::md_code("missing_information()")
  miss_link     <- gluedown::md_link(
    "CMS Public Reporting of Missing Digital Contact Information" = "https://data.cms.gov/provider-compliance/public-reporting-of-missing-digital-contact-information")
  order_func    <- gluedown::md_code("order_refer()")
  order_link    <- gluedown::md_link(
    "Medicare Order and Referring" = "https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/order-and-referring")
  opt_func      <- gluedown::md_code("opt_out()")
  opt_link      <- gluedown::md_link(
    "Medicare Opt Out Affidavits" = "https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/opt-out-affidavits")
  pbp_func      <- gluedown::md_code("physician_by_provider()")
  pbp_link      <- gluedown::md_link(
    "Medicare Physician & Other Practitioners: by Provider" = "https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-provider")
  pbs_func      <- gluedown::md_code("physician_by_service()")
  pbs_link      <- gluedown::md_link(
    "Medicare Physician & Other Practitioners: by Provider and Service" = "https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-provider-and-service")
  pbg_func      <- gluedown::md_code("physician_by_geography()")
  pbg_link      <- gluedown::md_link(
    "Medicare Physician & Other Practitioners: by Geography and Service" = "https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-geography-and-service")
  redd_func     <- gluedown::md_code("revalidation_date()")
  redd_link     <- gluedown::md_link(
    "Medicare Revalidation Due Date" = "https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-due-date-list")
  rere_func     <- gluedown::md_code("revalidation_reassign()")
  rere_link     <- gluedown::md_link(
    "Medicare Revalidation Reassignment" = "https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-reassignment-list")
  recl_func     <- gluedown::md_code("revalidation_group()")
  recl_link     <- gluedown::md_link(
    "Medicare Revalidation Clinic Group Practice Reassignment" = "https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-clinic-group-practice-reassignment")
  ccs_func      <- gluedown::md_code("cc_specific()")
  ccs_link      <- gluedown::md_link(
    "Medicare Specific Chronic Conditions" = "https://data.cms.gov/medicare-chronic-conditions/specific-chronic-conditions")
  ccm_func      <- gluedown::md_code("cc_multiple()")
  ccm_link      <- gluedown::md_link(
    "Medicare Multiple Chronic Conditions" = "https://data.cms.gov/medicare-chronic-conditions/multiple-chronic-conditions")
  clia_func     <- gluedown::md_code("clia_labs()")
  clia_link     <- gluedown::md_link(
    "Medicare Provider of Services File - Clinical Laboratories" = "https://data.cms.gov/provider-characteristics/hospitals-and-other-facilities/provider-of-services-file-clinical-laboratories")
  tax_func      <- gluedown::md_code("taxonomy_crosswalk()")
  tax_link      <- gluedown::md_link(
    "Medicare Provider and Supplier Taxonomy Crosswalk" = "https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/medicare-provider-and-supplier-taxonomy-crosswalk")
  pend_func     <- gluedown::md_code("pending_applications()")
  pend_link     <- gluedown::md_link(
    "Medicare Pending Initial Logging and Tracking" = "https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/pending-initial-logging-and-tracking-physicians")
  affil_func    <- gluedown::md_code("facility_affiliations()")
  affil_link    <- gluedown::md_link(
    "CMS Physician Facility Affiliations" = "https://data.cms.gov/provider-data/dataset/27ea-46a8")
  drclin_func   <- gluedown::md_code("doctors_and_clinicians()")
  drclin_link   <- gluedown::md_link(
    "Doctors and Clinicians National Downloadable File" = "https://data.cms.gov/provider-data/dataset/mj5m-pzi6")
  addph_func   <- gluedown::md_code("addl_phone_numbers()")
  addph_link   <- gluedown::md_link(
    "Physician Additional Phone Numbers" = "https://data.cms.gov/provider-data/dataset/phys-phon")
  hspen_func   <- gluedown::md_code("hospital_enrollment()")
  hspen_link   <- gluedown::md_link(
    "Hospital Enrollments" = "https://data.cms.gov/provider-characteristics/hospitals-and-other-facilities/hospital-enrollments")

  func_tbl <- data.frame(Function = c(nppes_func,
                                      open_func,
                                      mppe_func,
                                      mme_func,
                                      order_func,
                                      opt_func,
                                      pbp_func,
                                      pbs_func,
                                      pbg_func,
                                      redd_func,
                                      recl_func,
                                      rere_func,
                                      ccs_func,
                                      ccm_func,
                                      #clia_func,
                                      tax_func,
                                      miss_func,
                                      pend_func,
                                      affil_func,
                                      drclin_func,
                                      #addph_func,
                                      hspen_func
  ),
  API      = c(nppes_link,
               open_link,
               mppe_link,
               mme_link,
               order_link,
               opt_link,
               pbp_link,
               pbs_link,
               pbg_link,
               redd_link,
               recl_link,
               rere_link,
               ccs_link,
               ccm_link,
               #clia_link,
               tax_link,
               miss_link,
               pend_link,
               affil_link,
               drclin_link,
               #addph_link,
               hspen_link
  ))

  return(func_tbl)
}


#' Search the CMS Physician - Additional Phone Numbers API
#' #### Dataset API no longer available ##################
#' @description Dataset of additional phone numbers when clinicians have more
#'   than one phone number at a single practice address.
#'
#'   ## Links
#'   * [Physician - Additional Phone Numbers](https://data.cms.gov/provider-data/dataset/phys-phon)
#'
#' @source Centers for Medicare & Medicaid Services
#' @note Update Frequency: **Monthly**
#'
#' @param npi Unique clinician ID assigned by NPPES
#' @param pac_id_ind Unique individual clinician ID assigned by PECOS
#' @param pac_id_org Unique group ID assigned by PECOS to the group
#' @param first_name Individual clinician first name
#' @param last_name Individual clinician last name
#' @param middle_name Individual clinician middle name
#' @param city Group or individual's city
#' @param state Group or individual's state
#' @param zip Group or individual's ZIP code (9 digits when available)
#' @param offset offset; API pagination
#' @param clean_names Convert column names to snake case; default is `TRUE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examples
#' \dontrun{
#' #addl_phone_numbers(npi = 1407263999)
#' #addl_phone_numbers(pac_id_ind = "0042100190")
#' #addl_phone_numbers(pac_id_org = 6608028899)
#' #addl_phone_numbers(city = "Atlanta")
#' addl_phone_numbers(zip = 303421606)
#' }
#' @noRd

addl_phone_numbers <- function(npi           = NULL,
                               pac_id_ind   = NULL,
                               pac_id_org    = NULL,
                               first_name    = NULL,
                               middle_name   = NULL,
                               last_name     = NULL,
                               city          = NULL,
                               state         = NULL,
                               zip           = NULL,
                               offset        = 0,
                               clean_names   = TRUE) {

  # args tribble ------------------------------------------------------------
  args <- tibble::tribble(
    ~x,           ~y,
    "npi",        npi,
    "prvdr_id",   pac_id_ind,
    "frst_nm",    first_name,
    "mid_nm",     middle_name,
    "lst_nm",     last_name,
    "cty",        city,
    "st",         state,
    "zip",        zip,
    "org_pac_id", pac_id_org)

  # map param_format and collapse -------------------------------------------
  params_args <- purrr::map2(args$x, args$y, sql_format) |>
    unlist() |> stringr::str_flatten()

  id <- "a12b0ee3-db05-5603-bd3e-e6f449797cb0"

  id_fmt <- paste0("[SELECT * FROM ", id, "]")

  # build URL ---------------------------------------------------------------
  http   <- "https://data.cms.gov/provider-data/api/1/datastore/sql?query="
  post   <- paste0("[LIMIT 10000 OFFSET ", offset, "]&show_db_columns")
  url    <- paste0(http, id_fmt, params_args, post) |>
    param_brackets() |> param_space()

  # send request ----------------------------------------------------------
  resp <- httr2::request(url) |> httr2::req_perform()

  # no search results returns empty tibble ----------------------------------
  if (as.numeric(httr2::resp_header(resp, "content-length")) == 0) {
    return(tibble::tibble())
  } else {

    # parse response ---------------------------------------------------------
    results <- tibble::tibble(httr2::resp_body_json(resp,
                                                    check_type = FALSE, simplifyVector = TRUE)) |>
      dplyr::mutate(dplyr::across(tidyselect::where(is.character), ~dplyr::na_if(., "")),
                    dplyr::across(tidyselect::where(is.character), ~dplyr::na_if(., "N/A")))

  }

  # clean names -------------------------------------------------------------
  if (isTRUE(clean_names)) {results <- dplyr::rename_with(results, str_to_snakecase)}

  return(results)
}

