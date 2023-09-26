#' Format Parameters and Arguments
#' @param param API parameter
#' @param arg API function arg
#' @param filter description
#' @param sql description
#' @return formatted API filters
#' @autoglobal
#' @noRd
format_param <- function(param,
                         arg,
                         filter = FALSE,
                         sql = FALSE) {

  if (isTRUE(filter)) {param <- paste0("filter[", param, "]=", arg)}
  if (isTRUE(sql))    {param <- paste0("[WHERE ", param, " = ", "%22", arg, "%22", "]")}
  # %22 url encoding for double quote (")

  return(param)
}

#' encode_param
#' @param args tibble with two columns: param and args
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

  args <- tidyr::unnest(args, arg)

  if (type == "filter") {
    args$filter <- TRUE
    args$sql    <- FALSE

    args <- purrr::pmap(args, format_param) |>
      unlist() |>
      stringr::str_c(collapse = "&")
  }

  if (type == "sql") {
    args$filter <- FALSE
    args$sql    <- TRUE

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

#' encode_url
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
                "[LIMIT 10000 OFFSET ", offset, "]")

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
        "tax" ~ "Medicare Provider and Supplier Taxonomy Crosswalk")

  if (fn %in% c("tax") && is.null(args)) {

    url <- paste0("https://data.cms.gov/data-api/v1/dataset/",
                  cms_update(api)$distro[1],
                  "/data?keyword=")

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
#' @param name function name
#' @autoglobal
#' @noRd
format_cli <- function(df, name) {

  x <- purrr::map2(df$x,
                   df$y,
                   stringr::str_c,
                   sep = " = ",
                   collapse = "")

  cli::cli_alert_danger("{.fn {name}}: No results for {.val {x}}",
                        wrap = TRUE)

}

#' Build url for http requests
#' @param fn abbreviation for function name
#' @param year tibble of parameter arguments
#' @autoglobal
#' @noRd
api_years <- function(fn, year) {

  api <- dplyr::case_match(fn,
    "geo" ~ "Medicare Physician & Other Practitioners - by Geography and Service",
    "srv" ~ "Medicare Physician & Other Practitioners - by Provider and Service",
    "prv" ~ "Medicare Physician & Other Practitioners - by Provider",
    "scc" ~ "Specific Chronic Conditions",
    "mcc" ~ "Multiple Chronic Conditions",
    "qpp" ~ "Quality Payment Program Experience",
    .default = NULL)

  cms_update(api) |>
    dplyr::filter(year == {{ year }}) |>
    dplyr::pull(distro)
}



