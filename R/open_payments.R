#' Relationships with Drug & Medical Device Companies
#'
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' [open_payments()] allows the user access to CMS' Open Payments Program API
#'
#' The __Open Payments__ program is a national disclosure program that collects and
#' publishes information about financial relationships between drug and medical
#' device companies (referred to as "reporting entities") and certain health
#' care providers (referred to as "covered recipients"). These relationships may
#' involve payments to providers for things including but not limited to
#' research, meals, travel, gifts or speaking fees.
#'
#' @section Terminology:
#' __Reporting Entities__: Applicable manufacturers or GPOs.
#'
#' __Applicable Group Purchasing Organizations__ (GPOs) are entities that operate
#' in the United States and purchase, arrange for or negotiate the purchase of
#' covered drugs, devices, biologicals, or medical supplies for a group of
#' individuals or entities, but not solely for use by the entity itself.
#'
#' __Applicable Manufacturers__ are entities that operate in the United States and
#' are (1) engaged in the production, preparation, propagation, compounding, or
#' conversion of a covered drug, device, biological, or medical supply, but not
#' if such covered drug, device, biological or medical supply is solely for use
#' by or within the entity itself or by the entity's own patients (this
#' definition does not include distributors or wholesalers (including, but not
#' limited to, re-packagers, re-labelers, and kit assemblers) that do not hold
#' title to any covered drug, device, biological or medical supply); or are (2)
#' entities under common ownership with an entity described in part (1) of this
#' definition, which provides assistance or support to such entities with
#' respect to the production, preparation, propagation, compounding, conversion,
#' marketing, promotion, sale, or distribution of a covered drug, device,
#' biological or medical supply.
#'
#' __Covered Recipients__ are any physician, physician assistant, nurse
#' practitioner, clinical nurse specialist, certified registered nurse
#' anesthetist, or certified nurse-midwife who is not a bona fide employee of
#' the applicable manufacturer that is reporting the payment; or a teaching
#' hospital, which is any institution that received a payment.
#'
#' __Teaching Hospitals__ are hospitals that receive payment for Medicare direct
#' graduate medical education (GME), IPPS indirect medical education (IME), or
#' psychiatric hospital IME programs.
#'
#' __Natures of Payment__ are categories that must be used to describe why a
#' payment or other transfer of value was made. They are only applicable to
#' the “general” payment type, not research or ownership. The categories are:
#'
#' + Acquisitions (2021 - current)
#' + Charitable contributions:
#'   + Compensation for services other than consulting
#'   + Compensation for serving as faculty or speaker for an/a:
#'      + Accredited/certified continuing education program (2013 - 2020)
#'      + Unaccredited/non-certified continuing education program (2013 - 2020)
#'      + Medical education program (2021 - current)
#' + Consulting fees
#' + Current or prospective ownership or investment interest (prior to 2023)
#' + Debt Forgiveness (2021 - current)
#' + Education
#' + Entertainment
#' + Food and beverage
#' + Gift
#' + Grant
#' + Honoraria
#' + Long-term medical supply or device loan (2021 - current)
#' + Royalty or license
#' + Space rental or facility fees (Teaching Hospitals only)
#' + Travel and lodging
#'
#' __Transfers of Value__ are anything of value given by an applicable manufacturer
#' or applicable GPO to a covered recipient or physician owner/investor that
#' does not fall within one of the excluded categories in the rule.
#'
#' __Ownership and Investment Interests__ include, but are not limited to:
#' + Stock
#' + Stock option(s) (not received as compensation, until they are exercised)
#' + Partnership share(s)
#' + Limited liability company membership(s)
#' + Loans
#' + Bonds
#' + Financial instruments secured with an entity’s property or revenue
#'
#' This may be direct or indirect and through debt, equity or other means.
#'
#' @section Links:
#' + [What is the Open Payments Program?](https://www.cms.gov/priorities/key-initiatives/open-payments)
#' + [Open Payments: General Resources](https://www.cms.gov/OpenPayments/Resources)
#'
#' @section Update Frequency:
#' Yearly
#'
#' @name open_payments
NULL


#' @param year < *integer* > // **required** Year data was reported, in `YYYY`
#' format. Run [open_years()] to return a vector of the years currently available.
#' @param npi < *integer* > Covered recipient's 10-digit National Provider Identifier
#' @param covered_type < *character* > Type of covered recipient, e.g.:
#' + `"Physician"`
#' + `"Non-Physician Practitioner"`
#' + `"Teaching Hospital"`
#' @param teaching_hospital < *character* > Name of teaching hospital, e.g.:
#' + `"Vanderbilt University Medical Center"`
#' @param first,last < *character* > Covered recipient's name
#' @param city < *character* > Covered recipient's city
#' @param state < *character* > Covered recipient's state abbreviation
#' @param zip < *character* > Covered recipient's zip code
#' @param payer < *character* > Paying entity's name, e.g.:
#' + `"Pharmacosmos Therapeutics Inc."`
#' + `"Getinge USA Sales, LLC"`
#' + `"Agiliti Health, Inc."`
#' + `"OrthoScan, Inc."`
#' @param payer_id < *integer* > Paying entity's unique 10-digit Open Payments ID
#' @param pay_form < *character* > Form of payment, e.g.:
#' + `"Stock option"`
#' + `"Cash or cash equivalent"`
#' + `"In-kind items and services"`
#' @param pay_nature < *character* > Nature of payment or transfer of value, e.g.:
#' + `"Royalty or License"`
#' + `"Charitable Contribution"`
#' + `"Current or prospective ownership or investment interest"`
#' + `"Food and Beverage"`
#' @param offset < *integer* > // __default:__ `0L` API pagination
#' @param tidy < *boolean* > // __default:__ `TRUE` Tidy output
#' @param pivot < *boolean* > // __default:__ `TRUE` Pivot output
#' @param add.ndc < *boolean* > // __default:__ `TRUE` Add output from [ndc_lookup()]
#' @param na.rm < *boolean* > // __default:__ `FALSE` Remove empty rows and columns
#' @param ... Pass arguments to [open_payments()].
#'
#' @return A [tibble][tibble::tibble-package] containing the search results.
#'
#' @rdname open_payments
#'
#' @examplesIf interactive()
#' open_payments(year = 2021, npi = 1043218118)
#' open_payments(year = 2021, pay_nature = "Royalty or License")
#' open_payments(year = 2021, pay_form = "Stock option")
#' open_payments(year = 2021, payer = "Adaptive Biotechnologies Corporation")
#' open_payments(year = 2021, teaching_hospital = "Nyu Langone Hospitals")
#'
#' # Use the years helper function to retrieve results for all available years:
#' open_years() |>
#' map(\(x) open_payments(year = x, npi = 1043477615)) |>
#' list_rbind()
#'
#' # Or simply use the parallelized version
#' open_payments_(npi = 1043218118)
#'
#' @autoglobal
#' @export
open_payments <- function(year,
                          npi = NULL,
                          covered_type = NULL,
                          first = NULL,
                          last  = NULL,
                          city = NULL,
                          state = NULL,
                          zip = NULL,
                          teaching_hospital = NULL,
                          payer = NULL,
                          payer_id = NULL,
                          pay_form = NULL,
                          pay_nature = NULL,
                          offset = 0L,
                          tidy = TRUE,
                          pivot = TRUE,
                          add.ndc = TRUE,
                          na.rm = FALSE,
                          ...) {


  rlang::check_required(year)
  year <- as.character(year)
  rlang::arg_match(year, as.character(open_years()))

  npi <- npi %nn% validate_npi(npi)
  zip <- zip %nn% as.character(zip)

  if (!is.null(covered_type)) {
    covered_type <- rlang::arg_match(
      covered_type, c("Physician",
                      "Non-Physician Practitioner",
                      "Teaching Hospital"))
    covered_type <- paste0("Covered Recipient ", covered_type)
  }

  args <- dplyr::tribble(
    ~param,                                                         ~arg,
    "covered_recipient_npi",                                         npi,
    "covered_recipient_type",                                        covered_type,
    "covered_recipient_first_name",                                  first,
    "covered_recipient_last_name",                                   last,
    "recipient_city",                                                city,
    "recipient_state",                                               state,
    "recipient_zip_code",                                            zip,
    "teaching_hospital_name",                                        teaching_hospital,
    "form_of_payment_or_transfer_of_value",                          pay_form,
    "nature_of_payment_or_transfer_of_value",                        pay_nature,
    "applicable_manufacturer_or_applicable_gpo_making_payment_name", payer,
    "applicable_manufacturer_or_applicable_gpo_making_payment_id",   payer_id)

  id <- open_ids("General Payment Data") |>
    dplyr::filter(year == {{ year }}) |>
    dplyr::pull(identifier)

  url <- paste0("https://openpaymentsdata.cms.gov/api/1/datastore/sql?query=",
                "[SELECT * FROM ", id, "]",
                encode_param(args, type = "sql"),
                "[LIMIT 10000 OFFSET ", offset, "]")

  response <- httr2::request(encode_url(url)) |>
    httr2::req_error(body = open_payments_error) |>
    httr2::req_perform()

  results <- httr2::resp_body_json(response, simplifyVector = TRUE)

  if (vctrs::vec_is_empty(results)) {

    cli_args <- dplyr::tribble(
      ~x,                  ~y,
      "npi",               npi,
      "covered_type",      covered_type,
      "first",             first,
      "last",              last,
      "city",              city,
      "state",             state,
      "zip",               zip,
      "teaching_hospital", teaching_hospital,
      "pay_form",          pay_form,
      "pay_nature",        pay_nature,
      "payer",             payer,
      "payer_id",          payer_id) |>
      tidyr::unnest(cols = c(y))

    format_cli(cli_args)
    return(invisible(NULL))
  }

  if (!tidy) results <- df2chr(results)

  if (tidy) {
    yncols <- c('physician_ownership_indicator',
                'charity_indicator',
                'delay_in_publication_indicator',
                'dispute_status_for_publication',
                'related_product_indicator')

    results <- tidyup(results,
                      dtype = 'mdy',
                      yn = c(yncols), #nolint
                      dbl = 'dollars',
                      int = c('program_year',
                              'number_of_payments_included_in_total_amount'),
                      zip = 'recipient_zip_code') |>
      dplyr::mutate(covered_recipient_type                                         = fct_cov(covered_recipient_type),
                    recipient_state                                                = fct_stabb(recipient_state),
                    applicable_manufacturer_or_applicable_gpo_making_payment_state = fct_stabb(applicable_manufacturer_or_applicable_gpo_making_payment_state),
                    covered_recipient_license_state_code1                          = fct_stabb(covered_recipient_license_state_code1),
                    state_of_travel                                                = fct_stabb(state_of_travel),
                    nature_of_payment_or_transfer_of_value                         = nature(nature_of_payment_or_transfer_of_value)) |>
      combine(address,
              c('recipient_primary_business_street_address_line1',
                'recipient_primary_business_street_address_line2')) |>
      cols_open()

    if (pivot) {
      results <- results |>
        dplyr::mutate(row_id  = dplyr::row_number(),
                      .name_1 = dplyr::if_else(is.na(name_1), TRUE, FALSE),
                      .cov_1  = dplyr::if_else(is.na(covered_1), TRUE, FALSE),
                      .type_1 = dplyr::if_else(is.na(type_1), TRUE, FALSE),
                      .cat_1  = dplyr::if_else(is.na(category_1), TRUE, FALSE),
                      .ndc_1  = dplyr::if_else(is.na(ndc_1), TRUE, FALSE),
                      .pdi_1  = dplyr::if_else(is.na(pdi_1), TRUE, FALSE),
                      .before = name_1) |>
        dplyr::rowwise() |>
        dplyr::mutate(total  = sum(dplyr::c_across(.name_1:.pdi_1), na.rm = TRUE),
                      name_1 = dplyr::if_else(total == 6, 'Blank', name_1),
                      total  = NULL) |>
        dplyr::ungroup()

      results$.name_1 <- NULL; results$.cov_1  <- NULL; results$.type_1 <- NULL
      results$.cat_1  <- NULL; results$.ndc_1  <- NULL; results$.pdi_1  <- NULL

      pcol <- c('name_', 'covered_',
                'type_', 'category_',
                'ndc_', 'pdi_') %s+% rep(1:5, each = 6)

      results <- results |>
        tidyr::pivot_longer(dplyr::any_of(pcol)) |>
        dplyr::filter(!is.na(value)) |>
        tidyr::separate_wider_delim(name,
                                    delim = "_",
                                    names = c("attr", "group_id")) |>
        tidyr::pivot_wider(names_from = "attr",
                           values_from = "value") |>
        dplyr::mutate(covered = dplyr::case_match(covered,
                                                  "Covered" ~ TRUE,
                                                  "Non-Covered" ~ FALSE,
                                                  .default = NA),
                      group_id  = as.integer(group_id),
                      pay_total = dplyr::if_else(group_id > 1, NA, pay_total),
                      pay_count = dplyr::if_else(group_id > 1, NA, pay_count))

      if (add.ndc) {
      ndcs <- unique(results$ndc)
      ndcs <- ndcs[!is.na(ndcs)]
      rx <- ndcs |> purrr::map(\(x) rxnorm(ndc = x)) |>
                    purrr::list_rbind()
      results <- dplyr::left_join(results, rx,
                 by = dplyr::join_by(ndc == ndc)) |>
        cols_open2()
      }
    }
    if (na.rm) results <- narm(results)
  }
  return(results)
}

#' Parallelized [open_payments()]
#' @param year < *integer* > // **required** Year data was reported, in `YYYY`
#' format. Run [open_years()] to return a vector of the years currently available.
#' @param ... Pass arguments to [open_payments()].
#' @rdname open_payments
#' @autoglobal
#' @export
open_payments_ <- function(year = open_years(),
                           ...) {
  results <- furrr::future_map_dfr(year,
                                   open_payments,
                                   ...,
                                   .options = furrr::furrr_options(seed = NULL))
  results <- narm(results)
  return(results)
}

#' Update Open Payments API distribution IDs
#' @param search term to search for in open payments database
#' @autoglobal
#' @noRd
open_ids <- function(search) {

  response <- httr2::request("https://openpaymentsdata.cms.gov/api/1/metastore/schemas/dataset/items?show-reference-ids") |>
    httr2::req_perform()

  results <- dplyr::tibble(
    httr2::resp_body_json(response,
                          check_type = FALSE, simplifyVector = TRUE)) |>
    dplyr::select(title, modified, distribution) |>
    tidyr::unnest(cols = distribution) |>
    tidyr::unnest(cols = data, names_sep = ".") |>
    dplyr::filter(stringr::str_detect(title, {{ search }})) |>
    dplyr::arrange(dplyr::desc(title)) |>
    dplyr::mutate(year = strex::str_before_first(title, " "),
                  set  = strex::str_after_first(title, " "), .before = 1,
                  year = as.integer(year)) |>
    dplyr::select(year, set, identifier)

  return(results)
}

#' HTTP Error 404 Handling
#' @autoglobal
#' @noRd
open_payments_error <- function(response) {
  httr2::resp_body_json(response)$message |>
    strex::str_after_first(": ") |>
    strex::str_before_nth(":", 2)
}

#' @param x vector
#' @autoglobal
#' @noRd
nature <- function(x){
  dplyr::case_match(
    x,
    paste("Compensation for services other than consulting, including serving",
          "as faculty or as a speaker at a venue other than a continuing",
          "education program") ~ "Compensation Other Than Consulting",
    .default = x)
}

#' @param df data frame
#' @autoglobal
#' @noRd
cols_open <- function(df) {

  cols <- c('program_year',
            'npi'                   = 'covered_recipient_npi',
            # 'changed'             = 'change_type',
            'covered_recipient'     = 'covered_recipient_type',
            'teaching_ccn'          = 'teaching_hospital_ccn',
            'teaching_id'           = 'teaching_hospital_id',
            'teaching_name'         = 'teaching_hospital_name',
            'first'                 = 'covered_recipient_first_name',
            'middle'                = 'covered_recipient_middle_name',
            'last'                  = 'covered_recipient_last_name',
            'suffix'                = 'covered_recipient_name_suffix',
            'address',
            'city'                  = 'recipient_city',
            'state'                 = 'recipient_state',
            'zip'                   = 'recipient_zip_code',
            'postal'                = 'recipient_postal_code',
            'country'               = 'recipient_country',
            'province'              = 'recipient_province',
            'primary'               = 'covered_recipient_primary_type_1',
            'primary2'              = 'covered_recipient_primary_type_2',
            'primary3'              = 'covered_recipient_primary_type_3',
            'primary4'              = 'covered_recipient_primary_type_4',
            'primary5'              = 'covered_recipient_primary_type_5',
            'primary6'              = 'covered_recipient_primary_type_6',
            # 'primary_other',
            'specialty'             = 'covered_recipient_specialty_1',
            'specialty2'            = 'covered_recipient_specialty_2',
            'specialty3'            = 'covered_recipient_specialty_3',
            'specialty4'            = 'covered_recipient_specialty_4',
            'specialty5'            = 'covered_recipient_specialty_5',
            'specialty6'            = 'covered_recipient_specialty_6',
            # 'specialty_other',
            'license_state'         = 'covered_recipient_license_state_code1',
            'license_state2'        = 'covered_recipient_license_state_code2',
            'license_state3'        = 'covered_recipient_license_state_code3',
            'license_state4'        = 'covered_recipient_license_state_code4',
            'license_state5'        = 'covered_recipient_license_state_code5',
            # 'license_state_other',
            'payer_id'              = 'applicable_manufacturer_or_applicable_gpo_making_payment_id',
            'payer_sub'             = 'submitting_applicable_manufacturer_or_applicable_gpo_name',
            'payer_name'            = 'applicable_manufacturer_or_applicable_gpo_making_payment_name',
            'payer_state'           = 'applicable_manufacturer_or_applicable_gpo_making_payment_state',
            'payer_country'         = 'applicable_manufacturer_or_applicable_gpo_making_payment_country',
            'pay_total'             = 'total_amount_of_payment_us_dollars',
            'pay_date'              = 'date_of_payment',
            'pay_count'             = 'number_of_payments_included_in_total_amount',
            'pay_form'              = 'form_of_payment_or_transfer_of_value',
            'pay_nature'            = 'nature_of_payment_or_transfer_of_value',
            'travel_city'           = 'city_of_travel',
            'travel_state'          = 'state_of_travel',
            'travel_country'        = 'country_of_travel',
            'physician_ownership'   = 'physician_ownership_indicator',
            'third_party_payment'   = 'third_party_payment_recipient_indicator',
            'third_party_name'      = 'name_of_third_party_entity_receiving_payment_or_transfer_of_value',
            'third_party_recipient' = 'third_party_equals_covered_recipient_indicator',
            'charity'               = 'charity_indicator',
            'context'               = 'contextual_information',
            'publish_date'          = 'payment_publication_date',
            'publish_delay'         = 'delay_in_publication_indicator',
            'publish_dispute'       = 'dispute_status_for_publication',
            'related_product'       = 'related_product_indicator',
            'name_1'                = 'name_of_drug_or_biological_or_device_or_medical_supply_1',
            'covered_1'             = 'covered_or_noncovered_indicator_1',
            'type_1'                = 'indicate_drug_or_biological_or_device_or_medical_supply_1',
            'category_1'            = 'product_category_or_therapeutic_area_1',
            'ndc_1'                 = 'associated_drug_or_biological_ndc_1',
            'pdi_1'                 = 'associated_device_or_medical_supply_pdi_1',
            'name_2'                = 'name_of_drug_or_biological_or_device_or_medical_supply_2',
            'covered_2'             = 'covered_or_noncovered_indicator_2',
            'type_2'                = 'indicate_drug_or_biological_or_device_or_medical_supply_2',
            'category_2'            = 'product_category_or_therapeutic_area_2',
            'ndc_2'                 = 'associated_drug_or_biological_ndc_2',
            'pdi_2'                 = 'associated_device_or_medical_supply_pdi_2',
            'name_3'                = 'name_of_drug_or_biological_or_device_or_medical_supply_3',
            'covered_3'             = 'covered_or_noncovered_indicator_3',
            'type_3'                = 'indicate_drug_or_biological_or_device_or_medical_supply_3',
            'category_3'            = 'product_category_or_therapeutic_area_3',
            'ndc_3'                 = 'associated_drug_or_biological_ndc_3',
            'pdi_3'                 = 'associated_device_or_medical_supply_pdi_3',
            'name_4'                = 'name_of_drug_or_biological_or_device_or_medical_supply_4',
            'covered_4'             = 'covered_or_noncovered_indicator_4',
            'type_4'                = 'indicate_drug_or_biological_or_device_or_medical_supply_4',
            'category_4'            = 'product_category_or_therapeutic_area_4',
            'ndc_4'                 = 'associated_drug_or_biological_ndc_4',
            'pdi_4'                 = 'associated_device_or_medical_supply_pdi_4',
            'name_5'                = 'name_of_drug_or_biological_or_device_or_medical_supply_5',
            'covered_5'             = 'covered_or_noncovered_indicator_5',
            'type_5'                = 'indicate_drug_or_biological_or_device_or_medical_supply_5',
            'category_5'            = 'product_category_or_therapeutic_area_5',
            'ndc_5'                 = 'associated_drug_or_biological_ndc_5',
            'pdi_5'                 = 'associated_device_or_medical_supply_pdi_5')

    dplyr::select(df, dplyr::any_of(cols))
}

#' @param df data frame
#' @autoglobal
#' @noRd
cols_open2 <- function(df) {

  cols <- c(
      'program_year',
      'npi',
      'covered_recipient',
      'teaching_ccn',
      'teaching_id',
      'teaching_name',
      'first',
      'middle',
      'last',
      'suffix',
      'address',
      'city',
      'state',
      'zip',
      'postal',
      'country',
      'province',
      'primary',
      'primary2',
      'primary3',
      'primary4',
      'primary5',
      'primary6',
      'specialty',
      'specialty2',
      'specialty3',
      'specialty4',
      'specialty5',
      'specialty6',
      'license_state',
      'license_state2',
      'license_state3',
      'license_state4',
      'license_state5',
      'travel_city',
      'travel_state',
      'travel_country',
      'physician_ownership',
      'third_party_payment',
      'third_party_name',
      'third_party_recipient',
      'charity',
      'context',
      'publish_date',
      'publish_delay',
      'publish_dispute',
      'related_product',
      'payer_id',
      'payer_sub',
      'payer_name',
      'payer_state',
      'payer_country',
      'pay_form',
      'pay_nature',
      'pay_total',
      'pay_date',
      'pay_count',
      'row_id',
      'group_id',
      'name',
      'covered',
      'type',
      'category',
      'pdi',
      'ndc',
      'ndc.rxcui'      = 'rxcui',
      'ndc.atc'        = 'atc',
      'ndc.status'     = 'status',
      'ndc.brand_name' = 'brand_name',
      'ndc.drug_name'  = 'drug_name',
      'ndc.atc_first'  = 'atc_first',
      'ndc.atc_second' = 'atc_second',
      'ndc.atc_third'  = 'atc_third',
      'ndc.atc_fourth' = 'atc_fourth')

    dplyr::select(df, dplyr::any_of(cols))
}
