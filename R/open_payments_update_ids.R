#' Update Open Payments API distribution IDs
#'
#' @description [open_payments_update_ids()] allows you to update the Open Payments
#'    API's distribution IDs for each year's dataset.
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
#' @return A [tibble][tibble::tibble-package] containing the updated ids.
#'
#' @examples
#' \dontrun{
#' open_payments_update_ids()
#' }
#' @autoglobal
#' @noRd
open_payments_update_ids <- function() {

  id_resp <- httr2::request("https://openpaymentsdata.cms.gov/api/1/metastore/schemas/dataset/items?show-reference-ids") |>
    httr2::req_perform()

  id_tibble <- tibble::tibble(httr2::resp_body_json(id_resp,
               check_type = FALSE, simplifyVector = TRUE))


  ids <- id_tibble |>
    dplyr::select(title,
                  modified,
                  distribution) |>
    tidyr::unnest(cols = distribution) |>
    tidyr::unnest(cols = data, names_sep = "_") |>
    dplyr::select(title,
                  identifier,
                  modified) |>
    dplyr::filter(title == "2021 General Payment Data" |
                  title == "2020 General Payment Data" |
                  title == "2019 General Payment Data" |
                  title == "2018 General Payment Data" |
                  title == "2017 General Payment Data" |
                  title == "2016 General Payment Data" |
                  title == "2015 General Payment Data") |>
    dplyr::arrange(dplyr::desc(title)) |>
    dplyr::mutate(year = strex::str_before_first(title, " "), .before = 2)

  return(ids)
}
