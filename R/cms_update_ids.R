#' Update CMS.gov API distribution IDs
#'
#' @description [cms_update_ids()] allows you to update CMS.gov APIs
#'    distribution IDs.
#'
#' @details The Open Payments program is a national disclosure program that
#'    promotes a more transparent and accountable health care system. Open
#'    Payments houses a publicly accessible database of payments that reporting
#'    entities, including drug and medical device companies, make to covered
#'    recipients like physicians. Please note that CMS does not comment on
#'    what relationships may be beneficial or potential conflicts of interest.
#'    CMS publishes the data attested to by reporting entities. The data is
#'    open to individual interpretation.
#'
#' @param api name of the api
#'
#' @return A [tibble][tibble::tibble-package] containing the updated ids.
#'
#' @examples
#' \dontrun{
#' cms_update_ids(api = "Medicare Physician & Other Practitioners - by Provider")
#' }
#' @autoglobal
#' @noRd
cms_update_ids <- function(api = NULL) {

  id_resp <- httr2::request("https://data.cms.gov/data.json") |>
    httr2::req_perform() |>
    httr2::resp_body_json(check_type = FALSE,
                          simplifyVector = TRUE)

  ids <- id_resp$dataset |>
    tibble::tibble() |>
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
