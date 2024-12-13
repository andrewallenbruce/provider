#' CMS API Dataset Names Lookup
#'
#' @param fn_name `<chr>` function name, can be a regex pattern
#'
#' @returns `<chr>` API dataset name
#'
#' @examples
#' api_names("quality_payment")
#'
#' api_names("utilization")
#'
#' api_names("provider")
#'
#' api_names("provider$")
#'
#' @autoglobal
#'
#' @keywords internal
#'
#' @export
api_names <- \(fn_name) {

  apinms <- c(
    main = c(
      beneficiaries   = "Medicare Monthly Enrollment",
      crosswalk       = "Medicare Provider and Supplier Taxonomy Crosswalk",
      hospitals       = "Hospital Enrollments",
      laboratories    = "Provider of Services File - Clinical Laboratories",
      order_refer     = "Order and Referring",
      providers       = "Medicare Fee-For-Service  Public Provider Enrollment",
      quality_payment = "Quality Payment Program Experience",
      betos           = "Restructured BETOS Classification System",
      reassignments   = "Revalidation Reassignment List",
      opt_out         = "Opt Out Affidavits",
      outpatient      = list(service       = "Medicare Outpatient Hospitals - by Provider and Service",
                             geography     = "Medicare Outpatient Hospitals - by Geography and Service"),
      pending         = list(physicians    = "Pending Initial Logging and Tracking",
                             nonphysicians = "Pending Initial Logging and Tracking Non Physicians"),
      prescribers     = list(provider      = "Medicare Part D Prescribers - by Provider",
                             drug          = "Medicare Part D Prescribers - by Provider and Drug",
                             geography     = "Medicare Part D Prescribers - by Geography and Drug"),
      utilization     = list(provider      = "Medicare Physician & Other Practitioners - by Provider",
                             service       = "Medicare Physician & Other Practitioners - by Provider and Service",
                             geography     = "Medicare Physician & Other Practitioners - by Geography and Service")
      ),
    other = c(
      affiliations    = "Facility Affiliation Data",
      clinicians      = "National Downloadable File",
      open_payments   = "General Payment Data")
    )

  if (fn_name == "all")
    return(apinms)

  getelem(apinms, fn_name)
}

#' Encode string as URL
#'
#' @param x `<chr>` string
#'
#' @returns `<chr>` string with encoded characters
#'
#' @autoglobal
#'
#' @noRd
encode_api_url <- function(x) {

  x <- gsub(" ", "%20", x)
  x <- gsub("[", "%5B", x, fixed = TRUE)
  x <- gsub("*", "%2A", x, fixed = TRUE)
  x <- gsub("]", "%5D", x, fixed = TRUE)
  x <- gsub("<", "%3C", x, fixed = TRUE)
  x <- gsub("+", "%2B", x, fixed = TRUE)

  return(x)
}

#' Format API parameters as a URL
#'
#' "%22" url encoding for double quote (")
#'
#' @param x tibble with two columns: `param` and `args`
#'
#' @param fmt format type, `filter`, `sql`, default is `filter`
#'
#' @returns formatted URL string
#'
#' @autoglobal
#'
#' @noRd
format_api_params <- function(x, fmt = "filter") {

  x <- purrr::discard(x, is_null)

  fmt <- match.arg(fmt, c("filter", "sql"))

  x <- switch(
    fmt,
    filter = paste0(
      paste0("filter[", names(x), "]=", x), collapse = "&"),
    sql = paste0(
      paste0("[WHERE ", names(x), " = %22", x, "%22]" ), collapse = ""))

  encode_api_url(x)
}

#' Build url for http requests
#'
#' @param api abbreviation for function name
#'
#' @param args tibble of parameter arguments
#'
#' @autoglobal
#'
#' @noRd
build_url2 <- function(api, args = NULL) {

  api <- dplyr::case_match(
    api,
    "ben" ~ "Medicare Monthly Enrollment",
    "hos" ~ "Hospital Enrollments",
    "lab" ~ "Provider of Services File - Clinical Laboratories",
    "end" ~ "Public Reporting of Missing Digital Contact Information",
    "pro" ~ "Medicare Fee-For-Service  Public Provider Enrollment",
    # "rdt" ~ "Revalidation Due Date List",
    "ras" ~ "Revalidation Reassignment List",
    "ord" ~ "Order and Referring",
    "opt" ~ "Opt Out Affidavits",
    "ppe" ~ "Pending Initial Logging and Tracking Physicians",
    "npe" ~ "Pending Initial Logging and Tracking Non Physicians",
    "tax" ~ "Medicare Provider and Supplier Taxonomy Crosswalk",
    "bet" ~ "Restructured BETOS Classification System",
    .default = NULL)

  url <- "https://data.cms.gov/data-api/v1/dataset/"
  url <- paste0(url, cms_update(api)$distro[1])

  crosskey <- (abb %in% "tax" & null(args))

  if (crosskey)
    return(paste0(url, "/data?keyword="))

  if (!crosskey)
    return(paste0(
      url,
      dplyr::if_else(
        abb %in% c("end", "tax"),
        "/data?",
        "/data.json?"),
      encode_param(args)))
}

#' Build url for affiliations & clinicians
#' @param fn `"a"` for affiliations, `"c"` for clinicians
#' @param args tibble of parameter arguments
#' @param offset API offset
#' @autoglobal
#' @noRd
file_url2 <- function(fn = c("c", "a"), args, offset) {

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
#'
#' @param abb abbreviation for function name
#'
#' @param year year of data distribution
#'
#' @autoglobal
#'
#' @noRd
api_years2 <- function(abb, year) {

  api <- dplyr::case_match(
    abb,
    "geo" ~ "Medicare Physician & Other Practitioners - by Geography and Service",
    "srv" ~ "Medicare Physician & Other Practitioners - by Provider and Service",
    "prv" ~ "Medicare Physician & Other Practitioners - by Provider",
    "rxg" ~ "Medicare Part D Prescribers - by Geography and Drug",
    "rxd" ~ "Medicare Part D Prescribers - by Provider and Drug",
    "rxp" ~ "Medicare Part D Prescribers - by Provider",
    "outps" ~ "Medicare Outpatient Hospitals - by Provider and Service",
    "outgs" ~ "Medicare Outpatient Hospitals - by Geography and Service",
    "qpp" ~ "Quality Payment Program Experience",
    .default = NULL
  )

  api <- cms_update(api)

  search_in(api, api[["year"]], year)
}
