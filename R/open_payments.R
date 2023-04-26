#' Search CMS' Open Payments Program API
#'
#' @description [open_payments()] allows you to search CMS' Open Payments
#'    Program API.
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
#'    Open Payments is a national transparency program that collects and
#'    publishes information about financial relationships between drug and
#'    medical device companies (referred to as "reporting entities") and
#'    certain health care providers (referred to as "covered recipients").
#'    These relationships may involve payments to providers for things
#'    including but not limited to research, meals, travel, gifts or speaking
#'    fees.
#'
#'    The purpose of the program is to provide the public with a more
#'    transparent health care system. All information available on the Open
#'    Payments database is open to personal interpretation and if there are
#'    questions about what the data means, patients and their advocates should
#'    speak directly to the health care provider for a better understanding.
#'
#' ## Links
#'  * [What is the Open Payments Program?](https://www.cms.gov/OpenPayments)
#'  * [OpenPaymentsData.cms.gov](https://www.cms.gov/OpenPaymentsData.cms.gov)
#'  * [2021 General Payment Data](https://openpaymentsdata.cms.gov/dataset/0380bbeb-aea1-58b6-b708-829f92a48202)
#'  * [2020 General Payment Data](https://openpaymentsdata.cms.gov/dataset/a08c4b30-5cf3-4948-ad40-36f404619019)
#'  * [2019 General Payment Data](https://openpaymentsdata.cms.gov/dataset/4e54dd6c-30f8-4f86-86a7-3c109a89528e)
#'  * [2018 General Payment Data](https://openpaymentsdata.cms.gov/dataset/f003634c-c103-568f-876c-73017fa83be0)
#'  * [2017 General Payment Data](https://openpaymentsdata.cms.gov/dataset/74e3a32c-e8f8-595c-899c-35f9bffa828f)
#'  * [2016 General Payment Data](https://openpaymentsdata.cms.gov/dataset/4c774e90-7f9e-5d19-b168-ff9be1e69034)
#'  * [2015 General Payment Data](https://openpaymentsdata.cms.gov/dataset/e657f6f0-7abb-5e82-8b42-23bff09f0763)
#'
#' @source Centers for Medicare & Medicaid Services
#' @note Update Frequency: **Yearly**
#'
#' @param recipient_npi 10-digit National Provider Identifier (NPI).
#' @param recipient_type e.g.,
#'    * `Covered Recipient Physician`
#'    * `Covered Recipient Non-Physician Practitioner`
#'    * `Covered Recipient Teaching Hospital`
#' @param teaching_hospital_name Name of teaching hospital, e.g.
#'    `Vanderbilt University Medical Center`
#' @param recipient_id Payment recipient's unique Open Payments ID
#' @param recipient_first_name Recipient's first name
#' @param recipient_last_name Recipient's last name
#' @param recipient_city City
#' @param recipient_state State, abbreviation
#' @param recipient_zip_code Zip code
#' @param manufacturer_gpo_name Paying entity's name. Examples:
#'    * `Pharmacosmos Therapeutics Inc.`
#'    * `Getinge USA Sales, LLC`
#'    * `Agiliti Health, Inc.`
#'    * `OrthoScan, Inc.`
#' @param manufacturer_gpo_id Paying entity's unique Open Payments ID
#' @param form_of_payment Form of payment, examples:
#'    * `Stock option`
#'    * `Cash or cash equivalent`
#'    * `In-kind items and services`
#' @param nature_of_payment Nature of payment or transfer of value, examples:
#'    * `Royalty or License`
#'    * `Charitable Contribution`
#'    * `Current or prospective ownership or investment interest`
#'    * `Food and Beverage`
#' @param year Reporting year, 2015-2021, default is `2021`
#' @param offset offset; API pagination
#' @param clean_names Convert column names to snakecase; default is `TRUE`.
#' @param nest Nest related columns together; default is `TRUE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examples
#' \dontrun{
#' open_payments(recipient_npi = 1043218118, year = 2021)
#' open_payments(nature_of_payment = "Royalty or License")
#' open_payments(form_of_payment = "Stock option")
#' open_payments(manufacturer_gpo_name = "Adaptive Biotechnologies Corporation")
#' open_payments(teaching_hospital_name = "Nyu Langone Hospitals")
#' }
#' @autoglobal
#' @export
open_payments <- function(recipient_npi          = NULL,
                          recipient_type         = NULL,
                          recipient_id           = NULL,
                          recipient_first_name   = NULL,
                          recipient_last_name    = NULL,
                          recipient_city         = NULL,
                          recipient_state        = NULL,
                          recipient_zip_code     = NULL,
                          teaching_hospital_name = NULL,
                          manufacturer_gpo_name  = NULL,
                          manufacturer_gpo_id    = NULL,
                          form_of_payment        = NULL,
                          nature_of_payment      = NULL,
                          year                   = 2021,
                          offset                 = 0,
                          clean_names            = TRUE,
                          nest                   = FALSE) {
  # args tribble ------------------------------------------------------------
  args <- tibble::tribble(
    ~x,                              ~y,
    "covered_recipient_profile_id",  recipient_id,
    "covered_recipient_npi",         recipient_npi,
    "covered_recipient_type",        recipient_type,
    "covered_recipient_first_name",  recipient_first_name,
    "covered_recipient_last_name",   recipient_last_name,
    "recipient_city",                recipient_city,
    "recipient_state",               recipient_state,
    "recipient_zip_code",            recipient_zip_code,
    "teaching_hospital_name",        teaching_hospital_name,
    "form_of_payment_or_transfer_of_value", form_of_payment,
    "nature_of_payment_or_transfer_of_value", nature_of_payment,
    "applicable_manufacturer_or_applicable_gpo_making_payment_name", manufacturer_gpo_name,
    "applicable_manufacturer_or_applicable_gpo_making_payment_id", manufacturer_gpo_id)

  # map param_format and collapse -------------------------------------------
  params_args <- purrr::map2(args$x, args$y, sql_format) |>
    unlist() |> stringr::str_flatten()

  # update distribution ids -------------------------------------------------
  ids <- open_payments_update_ids()

  id <- dplyr::case_when(
    year == ids$year[1] ~ ids$identifier[1],
    year == ids$year[2] ~ ids$identifier[2],
    year == ids$year[3] ~ ids$identifier[3],
    year == ids$year[4] ~ ids$identifier[4],
    year == ids$year[5] ~ ids$identifier[5],
    year == ids$year[6] ~ ids$identifier[6],
    year == ids$year[7] ~ ids$identifier[7])

  id_fmt <- paste0("[SELECT * FROM ", id, "]")

  # build URL ---------------------------------------------------------------
  http   <- "https://openpaymentsdata.cms.gov/api/1/datastore/sql?query="
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
      dplyr::mutate(dplyr::across(dplyr::contains("date"), ~parsedate::parse_date(.)),
                    dplyr::across(dplyr::contains("dollars"), ~as.double(.)),
                    dplyr::across(tidyselect::where(is.character), ~dplyr::na_if(., "")),
                    dplyr::across(tidyselect::where(is.character), ~dplyr::na_if(., "N/A"))) |>
      dplyr::relocate(program_year)

  }

  # clean names -------------------------------------------------------------
  if (isTRUE(clean_names)) {results <- dplyr::rename_with(results, str_to_snakecase)}

  # nest columns ------------------------------------------------------------
  if (isTRUE(nest)) {
    results <- results |>
      tidyr::nest(covered_recipient = dplyr::starts_with("covered_recipient_"),
                  recipient_address = dplyr::starts_with("recipient_"),
                  applicable_mfg_gpo = dplyr::contains("applicable_manufacturer_or_applicable_gpo"),
                  associated_drug_device = dplyr::ends_with(c("_1", "_2", "_3", "_4", "_5")),
                  payment_related_data = c(contextual_information,
                                           number_of_payments_included_in_total_amount,
                                           related_product_indicator,
                                           physician_ownership_indicator,
                                           third_party_payment_recipient_indicator,
                                           name_of_third_party_entity_receiving_payment_or_transfer_of_ccfc,
                                           charity_indicator,
                                           third_party_equals_covered_recipient_indicator,
                                           city_of_travel,
                                           state_of_travel,
                                           country_of_travel,
                                           payment_publication_date,
                                           delay_in_publication_indicator,
                                           dispute_status_for_publication),
                  teaching_hospital = dplyr::contains("teaching_hospital"))
  }
  return(results)
}


#' Update Open Payments API distribution IDs
#'
#' @description [open_payments_update_ids()] allows you to update the Open Payments
#'    API's distribution IDs for each year's dataset.
#'
#' @return A [tibble][tibble::tibble-package] containing the updated ids.
#'
#' @examples
#' open_payments_update_ids()
#' @autoglobal
#' @noRd
open_payments_update_ids <- function() {

  resp <- httr2::request("https://openpaymentsdata.cms.gov/api/1/metastore/schemas/dataset/items?show-reference-ids") |>
    httr2::req_perform()

  ids <- tibble::tibble(httr2::resp_body_json(resp,
                                              check_type = FALSE, simplifyVector = TRUE))

  ids <- ids |>
    dplyr::select(title, modified, distribution) |>
    tidyr::unnest(cols = distribution) |>
    tidyr::unnest(cols = data, names_sep = "_") |>
    dplyr::filter(stringr::str_detect(title, "General Payment")) |>
    dplyr::arrange(dplyr::desc(title)) |>
    dplyr::mutate(year = strex::str_before_first(title, " "), .before = 1) |>
    dplyr::mutate(year = as.integer(year)) |>
    dplyr::select(year, identifier)

  return(ids)
}
