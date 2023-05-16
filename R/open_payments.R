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
#' @param year Program reporting year. Run the helper function `years_openpay()`
#'    to return a vector of currently available years.
#' @param npi Covered recipient's National Provider Identifier (NPI).
#' @param covered_type Type of covered recipient, e.g.,
#'    * `Covered Recipient Physician`
#'    * `Covered Recipient Non-Physician Practitioner`
#'    * `Covered Recipient Teaching Hospital`
#' @param teaching_hospital Name of teaching hospital, e.g.
#'    `Vanderbilt University Medical Center`
#' @param profile_id Covered recipient's  unique Open Payments ID
#' @param first_name Covered recipient's first name
#' @param last_name Covered recipient's last name
#' @param city City
#' @param state State, abbreviation
#' @param zipcode Zip code
#' @param payer_name Paying entity's name. Examples:
#'    * `Pharmacosmos Therapeutics Inc.`
#'    * `Getinge USA Sales, LLC`
#'    * `Agiliti Health, Inc.`
#'    * `OrthoScan, Inc.`
#' @param payer_id Paying entity's unique Open Payments ID
#' @param payment_form Form of payment, examples:
#'    * `Stock option`
#'    * `Cash or cash equivalent`
#'    * `In-kind items and services`
#' @param payment_nature Nature of payment or transfer of value, examples:
#'    * `Royalty or License`
#'    * `Charitable Contribution`
#'    * `Current or prospective ownership or investment interest`
#'    * `Food and Beverage`
#' @param offset offset; API pagination
#' @param tidy Tidy output; default is `TRUE`.
#' @return A [tibble][tibble::tibble-package] containing the search results.
#' @examplesIf interactive()
#' open_payments(npi = 1043218118, year = 2021)
#' open_payments(payment_nature = "Royalty or License")
#' open_payments(payment_form = "Stock option")
#' open_payments(payer_name = "Adaptive Biotechnologies Corporation")
#' open_payments(teaching_hospital = "Nyu Langone Hospitals")
#' @autoglobal
#' @export
open_payments <- function(year,
                          npi               = NULL,
                          profile_id        = NULL,
                          covered_type      = NULL,
                          first_name        = NULL,
                          last_name         = NULL,
                          city              = NULL,
                          state             = NULL,
                          zipcode           = NULL,
                          teaching_hospital = NULL,
                          payer_name        = NULL,
                          payer_id          = NULL,
                          payment_form      = NULL,
                          payment_nature    = NULL,
                          offset            = 0,
                          tidy              = TRUE) {

  if (!is.null(npi)) {npi_check(npi)}

  # args tribble ------------------------------------------------------------
  args <- tibble::tribble(
    ~x,                              ~y,
    "covered_recipient_npi",         npi,
    "covered_recipient_profile_id",  profile_id,
    "covered_recipient_type",        covered_type,
    "covered_recipient_first_name",  first_name,
    "covered_recipient_last_name",   last_name,
    "recipient_city",                city,
    "recipient_state",               state,
    "recipient_zip_code",            zipcode,
    "teaching_hospital_name",        teaching_hospital,
    "form_of_payment_or_transfer_of_value", payment_form,
    "nature_of_payment_or_transfer_of_value", payment_nature,
    "applicable_manufacturer_or_applicable_gpo_making_payment_name", payer_name,
    "applicable_manufacturer_or_applicable_gpo_making_payment_id", payer_id)

  # map param_format and collapse -------------------------------------------
  params_args <- purrr::map2(args$x, args$y, sql_format) |>
    unlist() |>
    stringr::str_flatten()

  # update distribution ids -------------------------------------------------
  id <- open_payments_ids("General Payment Data") |>
    dplyr::filter(year == {{ year }}) |>
    dplyr::pull(identifier)

  id <- paste0("[SELECT * FROM ", id, "]")

  # build URL ---------------------------------------------------------------
  http   <- "https://openpaymentsdata.cms.gov/api/1/datastore/sql?query="
  post   <- paste0("[LIMIT 10000 OFFSET ", offset, "]&show_db_columns")
  url    <- paste0(http, id, params_args, post) |>
    param_brackets() |> param_space()

  # send request ----------------------------------------------------------
  response <- httr2::request(url) |> httr2::req_perform()

  # no search results returns empty tibble ----------------------------------
  if (httr2::resp_header(response, "content-length") == "0") {

    cli_args <- tibble::tribble(
      ~x,               ~y,
      "npi",            as.character(npi),
      "profile_id",     as.character(profile_id),
      "first_name",     first_name,
      "last_name",      last_name,
      "city",           city,
      "state",          state,
      "zipcode",        as.character(zipcode),
      "teaching_hospital", teaching_hospital,
      "payment_form",   payment_form,
      "payment_nature", payment_nature,
      "payer_name",     payer_name,
      "payer_id",       as.character(payer_id)) |>
      tidyr::unnest(cols = c(y))

    cli_args <- purrr::map2(cli_args$x,
                            cli_args$y,
                            stringr::str_c,
                            sep = ": ",
                            collapse = "")

    cli::cli_alert_danger("No results for {.val {cli_args}}",
                          wrap = TRUE)
    return(invisible(NULL))
  }

  # parse response ----------------------------------------------------------
  results <- tibble::tibble(httr2::resp_body_json(response,
              check_type = FALSE, simplifyVector = TRUE))

  # clean names -------------------------------------------------------------
  if (tidy) {
    results <- dplyr::rename_with(results, str_to_snakecase) |>
      dplyr::mutate(dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., ""))) |>
      tidyr::unite("address",
                   dplyr::any_of(c("recipient_primary_business_street_address_line1",
                                   "recipient_primary_business_street_address_line1")),
                   remove = TRUE, na.rm = TRUE, sep = " ") |>
      tidyr::unite("primary_other",
                   dplyr::any_of(c("covered_recipient_primary_type_2",
                                   "covered_recipient_primary_type_3",
                                   "covered_recipient_primary_type_4",
                                   "covered_recipient_primary_type_5",
                                   "covered_recipient_primary_type_6")),
                   remove = TRUE, na.rm = TRUE, sep = ", ") |>
      tidyr::unite("specialty_other",
                   dplyr::any_of(c("covered_recipient_specialty_2",
                                   "covered_recipient_specialty_3",
                                   "covered_recipient_specialty_4",
                                   "covered_recipient_specialty_5",
                                   "covered_recipient_specialty_6")),
                   remove = TRUE, na.rm = TRUE, sep = ", ") |>
      tidyr::unite("license_state_other",
                   dplyr::any_of(c("covered_recipient_license_state_code2",
                                   "covered_recipient_license_state_code3",
                                   "covered_recipient_license_state_code4",
                                   "covered_recipient_license_state_code5")),
                   remove = TRUE, na.rm = TRUE, sep = ", ") |>
      dplyr::select(year = program_year,
                    #record_number,
                    changed = change_type,
                    cov_type = covered_recipient_type,
                    teach_hosp_ccn = teaching_hospital_ccn,
                    teach_hosp_id = teaching_hospital_id,
                    teach_hosp_name = teaching_hospital_name,
                    profile_id = covered_recipient_profile_id,
                    npi = covered_recipient_npi,
                    first_name = covered_recipient_first_name,
                    middle_name = covered_recipient_middle_name,
                    last_name = covered_recipient_last_name,
                    suffix = covered_recipient_name_suffix,
                    address,
                    city = recipient_city,
                    state = recipient_state,
                    zipcode = recipient_zip_code,
                    postal_code = recipient_postal_code,
                    country = recipient_country,
                    province = recipient_province,
                    primary_type = covered_recipient_primary_type_1,
                    primary_other,
                    specialty = covered_recipient_specialty_1,
                    specialty_other,
                    license_state = covered_recipient_license_state_code1,
                    license_state_other,
                    payer_sub = submitting_applicable_manufacturer_or_applicable_gpo_name,
                    payer_id = applicable_manufacturer_or_applicable_gpo_making_payment_id,
                    payer_name = applicable_manufacturer_or_applicable_gpo_making_payment_name,
                    payer_state = applicable_manufacturer_or_applicable_gpo_making_payment_state,
                    payer_country = applicable_manufacturer_or_applicable_gpo_making_payment_country,
                    pay_total = total_amount_of_payment_usdollars,
                    pay_date = date_of_payment,
                    pay_count = number_of_payments_included_in_total_amount,
                    pay_form = form_of_payment_or_transfer_of_value,
                    pay_nature = nature_of_payment_or_transfer_of_value,
                    travel_city = city_of_travel,
                    travel_state = state_of_travel,
                    travel_country = country_of_travel,
                    phys_own = physician_ownership_indicator,
                    third_par_pay = third_party_payment_recipient_indicator,
                    third_par_name = name_of_third_party_entity_receiving_payment_or_transfer_of_ccfc,
                    third_par_cov = third_party_equals_covered_recipient_indicator,
                    charity = charity_indicator,
                    context = contextual_information,
                    pub_date = payment_publication_date,
                    pub_delay = delay_in_publication_indicator,
                    pub_dispute = dispute_status_for_publication,
                    #record_id,
                    related_product = related_product_indicator,
                    cov_1 = covered_or_noncovered_indicator_1,
                    type_1 = indicate_drug_or_biological_or_device_or_medical_supply_1,
                    cat_1 = product_category_or_therapeutic_area_1,
                    name_1 = name_of_drug_or_biological_or_device_or_medical_supply_1,
                    ndc_1 = associated_drug_or_biological_ndc_1,
                    pdi_1 = associated_device_or_medical_supply_pdi_1,
                    cov_2 = covered_or_noncovered_indicator_2,
                    type_2 = indicate_drug_or_biological_or_device_or_medical_supply_2,
                    cat_2 = product_category_or_therapeutic_area_2,
                    name_2 = name_of_drug_or_biological_or_device_or_medical_supply_2,
                    ndc_2 = associated_drug_or_biological_ndc_2,
                    pdi_2 = associated_device_or_medical_supply_pdi_2,
                    cov_3 = covered_or_noncovered_indicator_3,
                    type_3 = indicate_drug_or_biological_or_device_or_medical_supply_3,
                    cat_3 = product_category_or_therapeutic_area_3,
                    name3 = name_of_drug_or_biological_or_device_or_medical_supply_3,
                    ndc_3 = associated_drug_or_biological_ndc_3,
                    pdi_3 = associated_device_or_medical_supply_pdi_3,
                    cov_4 = covered_or_noncovered_indicator_4,
                    type_4 = indicate_drug_or_biological_or_device_or_medical_supply_4,
                    cat_4 = product_category_or_therapeutic_area_4,
                    name_4 = name_of_drug_or_biological_or_device_or_medical_supply_4,
                    ndc_4 = associated_drug_or_biological_ndc_4,
                    pdi_4 = associated_device_or_medical_supply_pdi_4,
                    cov_5 = covered_or_noncovered_indicator_5,
                    type_5 = indicate_drug_or_biological_or_device_or_medical_supply_5,
                    cat_5 = product_category_or_therapeutic_area_5,
                    name_5 = name_of_drug_or_biological_or_device_or_medical_supply_5,
                    ndc_5 = associated_drug_or_biological_ndc_5,
                    pdi_5 = associated_device_or_medical_supply_pdi_5) |>
      dplyr::mutate(dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., "")),
                    dplyr::across(dplyr::where(is.character), ~dplyr::na_if(., "N/A")),
                    dplyr::across(dplyr::contains("date"), ~parsedate::parse_date(.)),
                    dplyr::across(dplyr::contains("date"), ~lubridate::ymd(.)),
                    dplyr::across(dplyr::contains("dollars"), ~as.double(.)),
                    changed = changed_logical(changed))
    }
  return(results)
}


#' Update Open Payments API distribution IDs
#' @param search term to search for in open payments database
#' @autoglobal
#' @noRd
open_payments_ids <- function(search) {

  response <- httr2::request("https://openpaymentsdata.cms.gov/api/1/metastore/schemas/dataset/items?show-reference-ids") |>
    httr2::req_perform()

  results <- tibble::tibble(
    httr2::resp_body_json(response,
                          check_type = FALSE, simplifyVector = TRUE)) |>
    dplyr::select(title, modified, distribution) |>
    tidyr::unnest(cols = distribution) |>
    tidyr::unnest(cols = data, names_sep = ".") |>
    dplyr::filter(stringr::str_detect(title, {{ search }})) |>
    dplyr::arrange(dplyr::desc(title)) |>
    dplyr::mutate(year = strex::str_before_first(title, " "),
                  set = strex::str_after_first(title, " "), .before = 1,
                  year = as.integer(year)) |>
    dplyr::select(year, set, identifier)

  return(results)
}


#' Check the current years available for the Open Payments API
#' @autoglobal
#' @noRd
years_openpay <- function() {
  open_payments_ids("General Payment Data") |>
    dplyr::pull(year)
  }


