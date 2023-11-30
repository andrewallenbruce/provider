#' Infix operator for `if (!is.null(x)) y else x` statements
#' @param x,y description
#' @return description
#' @examples
#' ccn <- 123456
#' ccn <- ccn %nn% as.character(ccn)
#' ccn
#' @autoglobal
#' @noRd
`%nn%` <- function(x, y) if (!is.null(x)) y else x

#' Infix operator for `not in` statements
#' @return description
#' @autoglobal
#' @noRd
`%nin%` <- function(x, table) match(x, table, nomatch = 0L) == 0L

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

#' @param param API parameter
#' @param arg API function arg
#' @param type format type, `filter`, `sql`, default is `filter`
#' @return formatted API filters
#' @autoglobal
#' @noRd
format_param <- function(param, arg, type = "filter") {

  rlang::check_required(param)
  rlang::check_required(arg)
  rlang::arg_match(type, c("filter", "sql"))

  if (type %in% 'filter') {out <- paste0("filter[", param, "]=", arg)}
  if (type %in% 'sql')    {out <- paste0("[WHERE ", param, " = ", "%22", arg, "%22", "]")}
  # %22 url encoding for double quote (")

  return(out)
}

#' @param args tibble with two columns: `param` and `args`
#' @param type format type, `filter`, `sql`, default is `filter`
#' @examples
#' args <- dplyr::tribble(
#' ~param,      ~arg,
#' "NPI",        npi,
#' "FIRST_NAME", first_name)
#'
#' encode_param(args)
#'
#' encode_param(args, "sql")
#' @return formatted string
#' @autoglobal
#' @noRd
encode_param <- function(args, type = "filter") {

  rlang::check_required(args)
  rlang::arg_match(type, c("filter", "sql"))

  args <- tidyr::unnest(args, arg)

  if (type == "filter") {
    args <- purrr::pmap(args, format_param) |>
      unlist() |>
      stringr::str_c(collapse = "&")
  }

  if (type == "sql") {
    args$type <- "sql"

    args <- purrr::pmap(args, format_param) |>
      unlist() |>
      stringr::str_flatten()
  }

  args <- gsub(" ", "%20", args)
  args <- gsub("[", "%5B", args, fixed = TRUE)
  args <- gsub("*", "%2A", args, fixed = TRUE)
  args <- gsub("]", "%5D", args, fixed = TRUE)
  args <- gsub("<", "%3C", args, fixed = TRUE)
  args <- gsub("+", "%2B", args, fixed = TRUE)

  return(args)
}

#' @param url parameter with a space
#' @return parameter formatted with "%20" in lieu of a space
#' @autoglobal
#' @noRd
encode_url <- function(url) {

  url <- gsub(" ", "%20", url)
  url <- gsub("[", "%5B", url, fixed = TRUE)
  url <- gsub("*", "%2A", url, fixed = TRUE)
  url <- gsub("]", "%5D", url, fixed = TRUE)

  return(url)
}

#' Build url for affiliations & clinicians
#' @param fn `"a"` for affiliations, `"c"` for clinicians
#' @param args tibble of parameter arguments
#' @param offset API offset
#' @autoglobal
#' @noRd
file_url <- function(fn = c("c", "a"), args, offset) {

  if (fn == "a") {uuid <- "27ea-46a8"}
  if (fn == "c") {uuid <- "mj5m-pzi6"}

  id <- httr2::request(
    glue::glue("https://data.cms.gov/provider-data/api/1/metastore/schemas/dataset/items/{uuid}?show-reference-ids=true")) |>
    httr2::req_perform() |>
    httr2::resp_body_json(simplifyVector = TRUE)

  url <- paste0("https://data.cms.gov/provider-data/api/1/datastore/sql?query=",
                "[SELECT * FROM ", id$distribution$identifier, "]",
                encode_param(args, type = "sql"),
                "[LIMIT 10000 OFFSET ", offset, "];&show_db_columns")

  encode_url(url)
}

#' Build url for http requests
#' @param fn abbreviation for function name
#' @param args tibble of parameter arguments
#' @autoglobal
#' @noRd
build_url <- function(fn, args = NULL) {

  api <- dplyr::case_match(fn,
                           "ben" ~ "Medicare Monthly Enrollment",
                           "hos" ~ "Hospital Enrollments",
                           "lab" ~ "Provider of Services File - Clinical Laboratories",
                           "end" ~ "Public Reporting of Missing Digital Contact Information",
                           "pro" ~ "Medicare Fee-For-Service  Public Provider Enrollment",
                           "rdt" ~ "Revalidation Due Date List",
                           "ras" ~ "Revalidation Reassignment List",
                           "ord" ~ "Order and Referring",
                           "opt" ~ "Opt Out Affidavits",
                           "ppe" ~ "Pending Initial Logging and Tracking Physicians",
                           "npe" ~ "Pending Initial Logging and Tracking Non Physicians",
                           "tax" ~ "Medicare Provider and Supplier Taxonomy Crosswalk",
                           "bet" ~ "Restructured BETOS Classification System")

  if (fn %in% "tax" && is.null(args)) {
    url <- paste0("https://data.cms.gov/data-api/v1/dataset/", cms_update(api)$distro[1], "/data?keyword=")
    }

  if (!is.null(args)) {
    json <- dplyr::case_match(fn,
                              c("end", "tax") ~ "/data?",
                              .default = "/data.json?")

    url <- paste0("https://data.cms.gov/data-api/v1/dataset/",
                  cms_update(api)$distro[1],
                  json,
                  encode_param(args))
  }
  return(url)
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

#' Build url for http requests
#' @param fn abbreviation for function name
#' @param year tibble of parameter arguments
#' @autoglobal
#' @noRd
api_years <- function(fn) {

  api <- dplyr::case_match(fn,
                           "geo" ~ "Medicare Physician & Other Practitioners - by Geography and Service",
                           "srv" ~ "Medicare Physician & Other Practitioners - by Provider and Service",
                           "prv" ~ "Medicare Physician & Other Practitioners - by Provider",
                           "rxg" ~ "Medicare Part D Prescribers - by Geography and Drug",
                           "rxd" ~ "Medicare Part D Prescribers - by Provider and Drug",
                           "rxp" ~ "Medicare Part D Prescribers - by Provider",
                           "outps" ~ "Medicare Outpatient Hospitals - by Provider and Service",
                           "outgs" ~ "Medicare Outpatient Hospitals - by Geography and Service",
                           "scc" ~ "Specific Chronic Conditions",
                           "mcc" ~ "Multiple Chronic Conditions",
                           "qpp" ~ "Quality Payment Program Experience",
                           .default = NULL)

  cms_update(api)
}
