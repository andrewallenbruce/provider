#' Update CMS.gov API distribution IDs
#' @param api name of the api
#' @param check `"base"`, `"id"`, or `"years"`, default is `"id"`
#' @return A [tibble][tibble::tibble-package] containing the updated ids.
#' @examplesIf interactive()
#' cms_update("Provider of Services File - Clinical Laboratories", "base")
#' cms_update("Provider of Services File - Clinical Laboratories", "id")
#' cms_update("Provider of Services File - Clinical Laboratories", "years")
#' @autoglobal
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

#' Update CMS.gov API distribution IDs
#' @param api name of the api
#' @param year int, year of the data distribution to return
#' @return A [tibble][tibble::tibble-package] containing the updated ids.
#' @noRd
#' @autoglobal
cms_match <- function(api, year) {
  cms_update(api = {{ api }}, check = "id") |>
    dplyr::filter(year == {{ year }}) |>
    dplyr::pull(distro)
}

#' Update CMS.gov API distribution IDs
#' @param api name of the api
#' @return A [tibble][tibble::tibble-package] containing the updated ids.
#' @examplesIf interactive()
#' cms_update_ids(api = "Medicare Physician & Other Practitioners - by Provider")
#' cms_update_ids(api = "Specific Chronic Conditions")
#' @autoglobal
#' @noRd
cms_update_ids <- function(api = NULL) {

  id_resp <- httr2::request("https://data.cms.gov/data.json") |>
    httr2::req_perform() |>
    httr2::resp_body_json(check_type = FALSE,
                          simplifyVector = TRUE)

  ids <- id_resp$dataset |>
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

  return(ids)
}


#' Browse full CMS.gov API datasets
#' @autoglobal
#' @noRd
cms_dataset_full <- function() {

  resp <- httr2::request("https://data.cms.gov/data.json") |>
    httr2::req_perform() |>
    httr2::resp_body_json(check_type = FALSE,
                          simplifyVector = TRUE)

  ids <- resp$dataset |>
    dplyr::tibble() |>
    dplyr::select(title,
                  description)

  return(ids)
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

#' Search CMS.gov API datasets by keyword
#' @param api search api distribution dates
#' @autoglobal
#' @noRd
cms_get_dates <- function(api = NULL) {

  cms_update_ids(api = {{ api }}) |>
    dplyr::select(distribution_title,
                  distribution) |>
    tidyr::separate_wider_delim(distribution_title,
                                delim = " : ",
                                names = c("title", "date"),
                                cols_remove = TRUE) |>
    dplyr::mutate(year = lubridate::year(date)) |>
    dplyr::select(year, distribution)

}
