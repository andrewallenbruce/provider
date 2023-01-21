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
#' @param covered_recipient_type "Covered Recipient Physician"
#' @param covered_recipient_profile_id Payment recipient's unique Open Payments ID
#' @param covered_recipient_npi 10-digit National Provider Identifier (NPI).
#' @param covered_recipient_first_name Recipient's first name
#' @param covered_recipient_middle_name Recipient's middle name
#' @param covered_recipient_last_name Recipient's last name
#' @param recipient_city City
#' @param recipient_state State
#' @param recipient_zip_code Zip code
#' @param applicable_manufacturer_or_applicable_gpo_making_payment_id Paying entity's unique Open Payments ID
#' @param year Reporting year, 2015-2021, default is 2021
#' @param clean_names Clean column names with {janitor}'s
#'    `clean_names()` function; default is `TRUE`.
#' @param lowercase Convert column names to lowercase; default is `TRUE`.
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @examples
#' \dontrun{
#' open_payments(covered_recipient_npi = "1043218118")
#' }
#' @autoglobal
#' @export
open_payments <- function(covered_recipient_type = NULL,
                          covered_recipient_profile_id = NULL,
                          covered_recipient_npi = NULL,
                          covered_recipient_first_name = NULL,
                          covered_recipient_middle_name = NULL,
                          covered_recipient_last_name = NULL,
                          recipient_city = NULL,
                          recipient_state = NULL,
                          recipient_zip_code = NULL,
                          applicable_manufacturer_or_applicable_gpo_making_payment_id = NULL,
                          year = 2021,
                          clean_names = TRUE,
                          lowercase   = TRUE) {
  # args tribble ------------------------------------------------------------
  args <- tibble::tribble(
    ~x,                              ~y,
    "covered_recipient_type",        covered_recipient_type,
    "covered_recipient_profile_id",  covered_recipient_profile_id,
    "covered_recipient_npi",         covered_recipient_npi,
    "covered_recipient_first_name",  covered_recipient_first_name,
    "covered_recipient_middle_name", covered_recipient_middle_name,
    "covered_recipient_last_name",   covered_recipient_last_name,
    "recipient_city",                recipient_city,
    "recipient_state",               recipient_state,
    "recipient_zip_code",            recipient_zip_code,
    "applicable_manufacturer_or_applicable_gpo_making_payment_id", applicable_manufacturer_or_applicable_gpo_making_payment_id)

  # map param_format and collapse -------------------------------------------
  params_args <- purrr::map2(args$x, args$y, sql_format) |>
    unlist() |> stringr::str_flatten()


  # update distribution ids -------------------------------------------------
  ids <- open_payments_update_ids()

  id <- dplyr::case_when(
    year == 2021 ~ ids$identifier[1],
    year == 2020 ~ ids$identifier[2],
    year == 2019 ~ ids$identifier[3],
    year == 2018 ~ ids$identifier[4],
    year == 2017 ~ ids$identifier[5],
    year == 2016 ~ ids$identifier[6],
    year == 2015 ~ ids$identifier[7])

  id_fmt <- paste0("[SELECT * FROM ", id, "]")

  # build URL ---------------------------------------------------------------
  http   <- "https://openpaymentsdata.cms.gov/api/1/datastore/sql?query="
  post   <- "[LIMIT 10000 OFFSET 0]&show_db_columns"
  url    <- paste0(http, id_fmt, params_args, post) |>
    param_brackets() |> param_space()

  # send request ----------------------------------------------------------
  resp <- httr2::request(url) |> httr2::req_perform()

  # no search results returns empty tibble ----------------------------------
  if (as.numeric(httr2::resp_header(resp, "content-length")) == 0) {

    results <- tibble::tibble(record_number = NA,
                              change_type = NA,
                              covered_recipient_type = NA,
                              teaching_hospital_ccn = NA,
                              teaching_hospital_id = NA,
                              teaching_hospital_name = NA,
                              covered_recipient_profile_id = NA,
                              covered_recipient_npi = NA,
                              covered_recipient_first_name = NA,
                              covered_recipient_middle_name = NA,
                              covered_recipient_last_name = NA,
                              covered_recipient_name_suffix = NA,
                              recipient_primary_business_street_address_line1 = NA,
                              recipient_primary_business_street_address_line2 = NA,
                              recipient_city = NA,
                              recipient_state = NA,
                              recipient_zip_code = NA,
                              recipient_country = NA,
                              recipient_province = NA,
                              recipient_postal_code = NA,
                              covered_recipient_primary_type_1 = NA,
                              covered_recipient_primary_type_2 = NA,
                              covered_recipient_primary_type_3 = NA,
                              covered_recipient_primary_type_4 = NA,
                              covered_recipient_primary_type_5 = NA,
                              covered_recipient_primary_type_6 = NA,
                              covered_recipient_specialty_1 = NA,
                              covered_recipient_specialty_2 = NA,
                              covered_recipient_specialty_3 = NA,
                              covered_recipient_specialty_4 = NA,
                              covered_recipient_specialty_5 = NA,
                              covered_recipient_specialty_6 = NA,
                              covered_recipient_license_state_code1 = NA,
                              covered_recipient_license_state_code2 = NA,
                              covered_recipient_license_state_code3 = NA,
                              covered_recipient_license_state_code4 = NA,
                              covered_recipient_license_state_code5 = NA,
                              submitting_applicable_manufacturer_or_applicable_gpo_name = NA,
                              applicable_manufacturer_or_applicable_gpo_making_payment_id = NA,
                              applicable_manufacturer_or_applicable_gpo_making_payment_name = NA,
                              applicable_manufacturer_or_applicable_gpo_making_payment_state = NA,
                              applicable_manufacturer_or_applicable_gpo_making_payment_country = NA,
                              total_amount_of_payment_usdollars = NA,
                              date_of_payment = NA,
                              number_of_payments_included_in_total_amount = NA,
                              form_of_payment_or_transfer_of_value = NA,
                              nature_of_payment_or_transfer_of_value = NA,
                              city_of_travel = NA,
                              state_of_travel = NA,
                              country_of_travel = NA,
                              physician_ownership_indicator = NA,
                              third_party_payment_recipient_indicator = NA,
                              name_of_third_party_entity_receiving_payment_or_transfer_of_ccfc = NA,
                              charity_indicator = NA,
                              third_party_equals_covered_recipient_indicator = NA,
                              contextual_information = NA,
                              delay_in_publication_indicator = NA,
                              record_id = NA,
                              dispute_status_for_publication = NA,
                              related_product_indicator = NA,
                              covered_or_noncovered_indicator_1 = NA,
                              indicate_drug_or_biological_or_device_or_medical_supply_1 = NA,
                              product_category_or_therapeutic_area_1 = NA,
                              name_of_drug_or_biological_or_device_or_medical_supply_1 = NA,
                              associated_drug_or_biological_ndc_1 = NA,
                              associated_device_or_medical_supply_pdi_1 = NA,
                              covered_or_noncovered_indicator_2 = NA,
                              indicate_drug_or_biological_or_device_or_medical_supply_2 = NA,
                              product_category_or_therapeutic_area_2 = NA,
                              name_of_drug_or_biological_or_device_or_medical_supply_2 = NA,
                              associated_drug_or_biological_ndc_2 = NA,
                              associated_device_or_medical_supply_pdi_2 = NA,
                              covered_or_noncovered_indicator_3 = NA,
                              indicate_drug_or_biological_or_device_or_medical_supply_3 = NA,
                              product_category_or_therapeutic_area_3 = NA,
                              name_of_drug_or_biological_or_device_or_medical_supply_3 = NA,
                              associated_drug_or_biological_ndc_3 = NA,
                              associated_device_or_medical_supply_pdi_3 = NA,
                              covered_or_noncovered_indicator_4 = NA,
                              indicate_drug_or_biological_or_device_or_medical_supply_4 = NA,
                              product_category_or_therapeutic_area_4 = NA,
                              name_of_drug_or_biological_or_device_or_medical_supply_4 = NA,
                              associated_drug_or_biological_ndc_4 = NA,
                              associated_device_or_medical_supply_pdi_4 = NA,
                              covered_or_noncovered_indicator_5 = NA,
                              indicate_drug_or_biological_or_device_or_medical_supply_5 = NA,
                              product_category_or_therapeutic_area_5 = NA,
                              name_of_drug_or_biological_or_device_or_medical_supply_5 = NA,
                              associated_drug_or_biological_ndc_5 = NA,
                              associated_device_or_medical_supply_pdi_5 = NA,
                              program_year = year,
                              payment_publication_date = NA)
    return(results)

  } else {

    # parse response ---------------------------------------------------------
    results <- tibble::tibble(httr2::resp_body_json(resp,
               check_type = FALSE, simplifyVector = TRUE)) |>
      dplyr::mutate(dplyr::across(tidyselect::where(is.character), ~dplyr::na_if(., "")),
                    dplyr::across(tidyselect::where(is.character), ~dplyr::na_if(., "N/A")),
                    dplyr::across(dplyr::contains("date"), ~parsedate::parse_date(.)),
                    dplyr::across(dplyr::contains("dollars"), ~as.numeric(.))) |>
      dplyr::relocate(record_id, program_year, .after = record_number)

  }

  # clean names -------------------------------------------------------------
  if (isTRUE(clean_names)) {results <- janitor::clean_names(results)}
  # lowercase ---------------------------------------------------------------
  if (isTRUE(lowercase)) {results <- dplyr::rename_with(results, tolower)}

  return(results)
}
