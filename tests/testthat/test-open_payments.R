test_that("cols_open() works", {
  x <- dplyr::tibble(
    program_year                                                      = 1,
    covered_recipient_npi                                             = 1,
    # change_type                                                       = 1,
    covered_recipient_type                                            = 1,
    teaching_hospital_ccn                                             = 1,
    teaching_hospital_id                                              = 1,
    teaching_hospital_name                                            = 1,
    covered_recipient_first_name                                      = 1,
    covered_recipient_middle_name                                     = 1,
    covered_recipient_last_name                                       = 1,
    covered_recipient_name_suffix                                     = 1,
    address                                                           = 1,
    recipient_city                                                    = 1,
    recipient_state                                                   = 1,
    recipient_zip_code                                                = 1,
    recipient_postal_code                                             = 1,
    recipient_country                                                 = 1,
    recipient_province                                                = 1,
    covered_recipient_primary_type_1                                  = 1,
    covered_recipient_primary_type_2                                  = 1,
    covered_recipient_primary_type_3                                  = 1,
    covered_recipient_primary_type_4                                  = 1,
    covered_recipient_primary_type_5                                  = 1,
    covered_recipient_primary_type_6                                  = 1,
    covered_recipient_specialty_1                                     = 1,
    covered_recipient_specialty_2                                     = 1,
    covered_recipient_specialty_3                                     = 1,
    covered_recipient_specialty_4                                     = 1,
    covered_recipient_specialty_5                                     = 1,
    covered_recipient_specialty_6                                     = 1,
    covered_recipient_license_state_code1                             = 1,
    covered_recipient_license_state_code2                             = 1,
    covered_recipient_license_state_code3                             = 1,
    covered_recipient_license_state_code4                             = 1,
    covered_recipient_license_state_code5                             = 1,
    applicable_manufacturer_or_applicable_gpo_making_payment_id       = 1,
    submitting_applicable_manufacturer_or_applicable_gpo_name         = 1,
    applicable_manufacturer_or_applicable_gpo_making_payment_name     = 1,
    applicable_manufacturer_or_applicable_gpo_making_payment_state    = 1,
    applicable_manufacturer_or_applicable_gpo_making_payment_country  = 1,
    total_amount_of_payment_us_dollars                                = 1,
    date_of_payment                                                   = 1,
    number_of_payments_included_in_total_amount                       = 1,
    form_of_payment_or_transfer_of_value                              = 1,
    nature_of_payment_or_transfer_of_value                            = 1,
    city_of_travel                                                    = 1,
    state_of_travel                                                   = 1,
    country_of_travel                                                 = 1,
    physician_ownership_indicator                                     = 1,
    third_party_payment_recipient_indicator                           = 1,
    name_of_third_party_entity_receiving_payment_or_transfer_of_value = 1,
    third_party_equals_covered_recipient_indicator                    = 1,
    charity_indicator                                                 = 1,
    contextual_information                                            = 1,
    payment_publication_date                                          = 1,
    delay_in_publication_indicator                                    = 1,
    dispute_status_for_publication                                    = 1,
    related_product_indicator                                         = 1,
    name_of_drug_or_biological_or_device_or_medical_supply_1          = 1,
    covered_or_noncovered_indicator_1                                 = 1,
    indicate_drug_or_biological_or_device_or_medical_supply_1         = 1,
    product_category_or_therapeutic_area_1                            = 1,
    associated_drug_or_biological_ndc_1                               = 1,
    associated_device_or_medical_supply_pdi_1                         = 1,
    name_of_drug_or_biological_or_device_or_medical_supply_2          = 1,
    covered_or_noncovered_indicator_2                                 = 1,
    indicate_drug_or_biological_or_device_or_medical_supply_2         = 1,
    product_category_or_therapeutic_area_2                            = 1,
    associated_drug_or_biological_ndc_2                               = 1,
    associated_device_or_medical_supply_pdi_2                         = 1,
    name_of_drug_or_biological_or_device_or_medical_supply_3          = 1,
    covered_or_noncovered_indicator_3                                 = 1,
    indicate_drug_or_biological_or_device_or_medical_supply_3         = 1,
    product_category_or_therapeutic_area_3                            = 1,
    associated_drug_or_biological_ndc_3                               = 1,
    associated_device_or_medical_supply_pdi_3                         = 1,
    name_of_drug_or_biological_or_device_or_medical_supply_4          = 1,
    covered_or_noncovered_indicator_4                                 = 1,
    indicate_drug_or_biological_or_device_or_medical_supply_4         = 1,
    product_category_or_therapeutic_area_4                            = 1,
    associated_drug_or_biological_ndc_4                               = 1,
    associated_device_or_medical_supply_pdi_4                         = 1,
    name_of_drug_or_biological_or_device_or_medical_supply_5          = 1,
    covered_or_noncovered_indicator_5                                 = 1,
    indicate_drug_or_biological_or_device_or_medical_supply_5         = 1,
    product_category_or_therapeutic_area_5                            = 1,
    associated_drug_or_biological_ndc_5                               = 1,
    associated_device_or_medical_supply_pdi_5                         = 1)

  y <- cols_open(x)

  expect_equal(cols_open(x), y)
})

test_that("cols_open2() works", {

  x <- dplyr::tibble(
    program_year          = 1,
    npi                   = 1,
    # changed               = 1,
    covered_recipient     = 1,
    teaching_ccn          = 1,
    teaching_id           = 1,
    teaching_name         = 1,
    first                 = 1,
    middle                = 1,
    last                  = 1,
    suffix                = 1,
    address               = 1,
    city                  = 1,
    state                 = 1,
    zip                   = 1,
    postal                = 1,
    country               = 1,
    province              = 1,
    primary               = 1,
    primary2              = 1,
    primary3              = 1,
    primary4              = 1,
    primary5              = 1,
    primary6              = 1,
    specialty             = 1,
    specialty2            = 1,
    specialty3            = 1,
    specialty4            = 1,
    specialty5            = 1,
    specialty6            = 1,
    license_state         = 1,
    license_state2        = 1,
    license_state3        = 1,
    license_state4        = 1,
    license_state5        = 1,
    payer_id              = 1,
    payer_sub             = 1,
    payer_name            = 1,
    payer_state           = 1,
    payer_country         = 1,
    pay_total             = 1,
    pay_date              = 1,
    pay_count             = 1,
    pay_form              = 1,
    pay_nature            = 1,
    travel_city           = 1,
    travel_state          = 1,
    travel_country        = 1,
    physician_ownership   = 1,
    third_party_payment   = 1,
    third_party_name      = 1,
    third_party_recipient = 1,
    charity               = 1,
    context               = 1,
    publish_date          = 1,
    publish_delay         = 1,
    publish_dispute       = 1,
    related_product       = 1,
    name                  = 1,
    covered               = 1,
    type                  = 1,
    category              = 1,
    ndc                   = 1,
    pdi                   = 1,
    rxcui                 = 1,
    atc                   = 1,
    status                = 1,
    brand_name            = 1,
    drug_name             = 1,
    atc_first             = 1,
    atc_second            = 1,
    atc_third             = 1,
    atc_fourth            = 1)

  y <- cols_open2(x)

  expect_equal(cols_open2(x), y)
})
