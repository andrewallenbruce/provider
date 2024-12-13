#' Update CMS.gov API distribution IDs
#'
#' @param api name of the api
#'
#' @param check `"base"`, `"id"`, or `"years"`, default is `"id"`
#'
#' @return A [tibble()] containing the updated ids.
#'
#' @examplesIf interactive()
#' cms_update("Provider of Services File - Clinical Laboratories", "base")
#' cms_update("Provider of Services File - Clinical Laboratories", "id")
#' cms_update("Provider of Services File - Clinical Laboratories", "years")
#'
#' @autoglobal
#'
#' @noRd
cms_update <- function(api, check = "id") {

  id_resp <- httr2::request("https://data.cms.gov/data.json") |>
    httr2::req_perform() |>
    httr2::resp_body_json(check_type = FALSE,
                          simplifyVector = TRUE)

  results <- id_resp$dataset |>
    dplyr::tibble() |>
    dplyr::select(title,
                  modified,
                  distribution) |>
    tidyr::unnest(cols = distribution, names_sep = "_") |>
    dplyr::filter(distribution_format == "API") |>
    dplyr::select(title,
                  modified,
                  distribution_title,
                  distribution_modified,
                  distribution_accessURL) |>
    dplyr::mutate(distribution_accessURL = strex::str_after_last(distribution_accessURL, "dataset/"),
                  distribution_accessURL = strex::str_before_last(distribution_accessURL, "/data")) |>
    dplyr::rename(distribution = distribution_accessURL) |>
    dplyr::filter(title == {{ api }})

  if (check == "base") {return(results)}

  results <- results |>
    dplyr::select(distribution_title,
                  distro = distribution) |>
    tidyr::separate_wider_delim(distribution_title,
                                delim = " : ",
                                names = c(NA, "year")) |>
    dplyr::mutate(id = dplyr::row_number(),
                  year = as.integer(lubridate::year(year))) |>
    dplyr::filter(id != 1) |>
    dplyr::select(-id)

  if (check == "id") {return(results)}

  if (check == "years") {
    return(results |>
             dplyr::distinct(year) |>
             dplyr::arrange(year) |>
             dplyr::pull(year) |>
             as.character())
  }
}

#' Search CMS.gov API datasets by keyword
#' @param keyword search term
#' @autoglobal
#' @noRd
cms_dataset_search <- function(search = NULL) {

  resp <- httr2::request("https://data.cms.gov/data.json") |>
    httr2::req_perform() |>
    httr2::resp_body_json(check_type = FALSE,
                          simplifyVector = TRUE)

  ids <- resp$dataset |>
    dplyr::tibble() |>
    dplyr::select(title,
                  modified,
                  keyword,
                  identifier,
                  description) |>
    tidyr::unnest(keyword)

  if (!is.null(search)) {
    ids <- ids |> dplyr::filter(keyword == {{ search }})
  }
  return(ids)
}

#' "%22" url encoding for double quote (")
#'
#' @param param API parameter
#'
#' @param arg API function arg
#'
#' @param type format type, `filter`, `sql`, default is `filter`
#'
#' @returns formatted API filters
#'
#' @autoglobal
#'
#' @noRd
format_param <- function(param, arg, type = "filter") {

  rlang::check_required(param)
  rlang::check_required(arg)
  rlang::arg_match0(type, c("filter", "sql"))

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

  type <- rlang::arg_match0(type, c("filter", "sql"))

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
#' @param abb abbreviation for function name
#' @param args tibble of parameter arguments
#' @autoglobal
#' @noRd
build_url <- function(abb, args = NULL) {

  api <- dplyr::case_match(
    abb,
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
    "bet" ~ "Restructured BETOS Classification System",
    .default = NULL)

  url <- "https://data.cms.gov/data-api/v1/dataset/"
  url <- paste0(url, cms_update(api)$distro[1])

  crosswalkkey <- (abb %in% "tax" & null(args))

  if (crosswalkkey) return(paste0(url, "/data?keyword="))

  if (!crosswalkkey)
    return(
      paste0(
        url,
        dplyr::if_else(
          abb %in% c("end", "tax"),
          "/data?",
          "/data.json?"
          ),
        encode_param(args)
        )
      )
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
api_years <- function(abb, year = NULL) {

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
