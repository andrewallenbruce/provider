
<!-- README.md is generated from README.Rmd. Please edit that file -->

# `provider` <img src="man/figures/logo.svg" align="right" height="200" />

<!-- badges: start -->

[![R-CMD-check](https://github.com/andrewallenbruce/provider/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/andrewallenbruce/provider/actions/workflows/R-CMD-check.yaml)
[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![Project Status: WIP - Initial development is in progress, but there
has not yet been a stable, usable release suitable for the
public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![License:
MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://choosealicense.com/licenses/mit/)
[![code
size](https://img.shields.io/github/languages/code-size/andrewallenbruce/provider.svg)](https://github.com/andrewallenbruce/provider)
[![last
commit](https://img.shields.io/github/last-commit/andrewallenbruce/provider.svg)](https://github.com/andrewallenbruce/provider/commits/main)
[![Codecov test
coverage](https://codecov.io/gh/andrewallenbruce/provider/branch/main/graph/badge.svg)](https://app.codecov.io/gh/andrewallenbruce/provider?branch=main)
[![CodeFactor](https://www.codefactor.io/repository/github/andrewallenbruce/provider/badge)](https://www.codefactor.io/repository/github/andrewallenbruce/provider)
<!-- badges: end -->

> Providing easy access to [healthcare
> provider](https://en.wikipedia.org/wiki/Health_care_provider)-centric
> data through publicly available APIs & sources.

<br>

| Function                   | API                                                                                                                                                                                                                                   |
|:---------------------------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `nppes_npi()`              | [NPPES National Provider Identifier (NPI) Registry](https://npiregistry.cms.hhs.gov/search)                                                                                                                                           |
| `open_payments()`          | [CMS Open Payments Program](https://openpaymentsdata.cms.gov/dataset/0380bbeb-aea1-58b6-b708-829f92a48202)                                                                                                                            |
| `provider_enrollment()`    | [Medicare Fee-For-Service Public Provider Enrollment](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/medicare-fee-for-service-public-provider-enrollment)                                        |
| `beneficiary_enrollment()` | [Medicare Monthly Enrollment](https://data.cms.gov/summary-statistics-on-beneficiary-enrollment/medicare-and-medicaid-reports/medicare-monthly-enrollment)                                                                            |
| `order_refer()`            | [Medicare Order and Referring](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/order-and-referring)                                                                                               |
| `opt_out()`                | [Medicare Opt Out Affidavits](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/opt-out-affidavits)                                                                                                 |
| `physician_by_provider()`  | [Medicare Physician & Other Practitioners: by Provider](https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-provider)                           |
| `physician_by_service()`   | [Medicare Physician & Other Practitioners: by Provider and Service](https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-provider-and-service)   |
| `physician_by_geography()` | [Medicare Physician & Other Practitioners: by Geography and Service](https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-geography-and-service) |
| `revalidation_date()`      | [Medicare Revalidation Due Date](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-due-date-list)                                                                                      |
| `revalidation_group()`     | [Medicare Revalidation Clinic Group Practice Reassignment](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-clinic-group-practice-reassignment)                                       |
| `revalidation_reassign()`  | [Medicare Revalidation Reassignment](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-reassignment-list)                                                                              |
| `cc_specific()`            | [Medicare Specific Chronic Conditions](https://data.cms.gov/medicare-chronic-conditions/specific-chronic-conditions)                                                                                                                  |
| `cc_multiple()`            | [Medicare Multiple Chronic Conditions](https://data.cms.gov/medicare-chronic-conditions/multiple-chronic-conditions)                                                                                                                  |
| `clia_labs()`              | [Medicare Provider of Services File - Clinical Laboratories](https://data.cms.gov/provider-characteristics/hospitals-and-other-facilities/provider-of-services-file-clinical-laboratories)                                            |
| `taxonomy_crosswalk()`     | [Medicare Provider and Supplier Taxonomy Crosswalk](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/medicare-provider-and-supplier-taxonomy-crosswalk)                                            |
| `missing_information()`    | [CMS Public Reporting of Missing Digital Contact Information](https://data.cms.gov/provider-compliance/public-reporting-of-missing-digital-contact-information)                                                                       |

<br>

## Installation

You can install the development version of `provider` from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("andrewallenbruce/provider")

# install.packages("remotes")
remotes::install_github("andrewallenbruce/provider")
```

``` r
# Load library
library(provider)
```

<br>

## Motivation

<br>

This package is primarily focused on accessing public API data that can
be linked together via a healthcare provider’s National Provider
Identifier (NPI). Thus far, none of the APIs require the creation of a
user account or API key. The data tend to fall into (and sometimes
between) one of two categories: informational/operational and
analytical. It only gets interesting when you start to link them
together.

<br>

## NPPES NPI Registry API

``` r
 # NPI-1
npi_1 <- nppes_npi(npi = 1710975040)

npi_1 |> dplyr::select(datetime:state) |> gluedown::md_table()
```

| datetime            | outcome | enumeration_type | number     | name         | city  | state |
|:--------------------|:--------|:-----------------|:-----------|:-------------|:------|:------|
| 2023-01-22 18:24:08 | results | NPI-1            | 1710975040 | JOHN HERRING | OLNEY | MD    |

<br>

``` r
npi_1 |> 
  dplyr::select(basic) |> 
  tidyr::unnest(basic) |> 
  tidyr::pivot_longer(dplyr::everything()) |> 
  gluedown::md_table()
```

| name                   | value      |
|:-----------------------|:-----------|
| basic_first_name       | JOHN       |
| basic_last_name        | HERRING    |
| basic_middle_name      | E          |
| basic_credential       | MD         |
| basic_sole_proprietor  | NO         |
| basic_gender           | M          |
| basic_enumeration_date | 2005-10-11 |
| basic_last_updated     | 2007-07-08 |
| basic_status           | A          |
| basic_name_prefix      | –          |
| basic_name_suffix      | –          |

<br>

``` r
npi_1 |> 
  dplyr::select(taxonomies) |> 
  tidyr::unnest(taxonomies) |> 
  gluedown::md_table()
```

| code       | taxonomy_group | desc              | state | license  | primary |
|:-----------|:---------------|:------------------|:------|:---------|:--------|
| 207R00000X |                | Internal Medicine | MD    | D0030414 | TRUE    |

<br>

``` r
npi_1 |> 
  dplyr::select(addresses) |> 
  tidyr::unnest(addresses) |> 
  gluedown::md_table()
```

| country_code | country_name  | address_purpose | address_type | address_1              | address_2 | city      | state | postal_code | telephone_number | fax_number   |
|:-------------|:--------------|:----------------|:-------------|:-----------------------|:----------|:----------|:------|:------------|:-----------------|:-------------|
| US           | United States | MAILING         | DOM          | 1300 PICCARD DR        | SUITE 202 | ROCKVILLE | MD    | 208504303   | 310-921-7900     | 301-921-7915 |
| US           | United States | LOCATION        | DOM          | 18101 PRINCE PHILIP DR | NA        | OLNEY     | MD    | 208321514   | 301-774-8900     | 301-570-8574 |

<br>

``` r
npi_1 |> 
  dplyr::select(identifiers) |> 
  tidyr::unnest(identifiers) |> 
  gluedown::md_table()
```

| code | desc                         | issuer    | identifier | state |
|:-----|:-----------------------------|:----------|:-----------|:------|
| 05   | MEDICAID                     | NA        | 367151800  | MD    |
| 01   | Other (non-Medicare)         | Carefirst | 367151810  | NA    |
| 04   | MEDICARE ID-Type Unspecified | NA        | 647145E14  | MD    |
| 04   | MEDICARE ID-Type Unspecified | NA        | 647145E14  | VA    |
| 02   | MEDICARE UPIN                | NA        | C59183     | NA    |

<br>

``` r
 # NPI-2
npi_2 <- nppes_npi(npi = 1336413418)

npi_2 |> dplyr::select(datetime:state) |> 
  gluedown::md_table()
```

| datetime            | outcome | enumeration_type | number     | name                     | city   | state |
|:--------------------|:--------|:-----------------|:-----------|:-------------------------|:-------|:------|
| 2023-01-22 18:24:09 | results | NPI-2            | 1336413418 | LUMINUS DIAGNOSTICS, LLC | TIFTON | GA    |

``` r
npi_2 |> 
  dplyr::select(basic) |> 
  tidyr::unnest(basic) |> 
  tidyr::pivot_longer(dplyr::everything()) |> 
  gluedown::md_table()
```

| name                                        | value                    |
|:--------------------------------------------|:-------------------------|
| basic_organization_name                     | LUMINUS DIAGNOSTICS, LLC |
| basic_organizational_subpart                | NO                       |
| basic_enumeration_date                      | 2012-03-07               |
| basic_last_updated                          | 2020-01-07               |
| basic_certification_date                    | 2020-01-07               |
| basic_status                                | A                        |
| basic_authorized_official_first_name        | Laurel                   |
| basic_authorized_official_last_name         | Gamage                   |
| basic_authorized_official_middle_name       | Smith                    |
| basic_authorized_official_telephone_number  | 2292380790               |
| basic_authorized_official_title_or_position | Manager                  |
| basic_authorized_official_name_prefix       | Mrs.                     |

``` r
npi_2 |> 
  dplyr::select(taxonomies) |> 
  tidyr::unnest(taxonomies) |> 
  gluedown::md_table()
```

| code       | taxonomy_group | desc                        | state | license | primary |
|:-----------|:---------------|:----------------------------|:------|:--------|:--------|
| 291U00000X |                | Clinical Medical Laboratory | NA    | NA      | TRUE    |

``` r
npi_2 |> 
  dplyr::select(addresses) |> 
  tidyr::unnest(addresses) |> 
  gluedown::md_table()
```

| country_code | country_name  | address_purpose | address_type | address_1        | address_2 | city   | state | postal_code | telephone_number | fax_number   |
|:-------------|:--------------|:----------------|:-------------|:-----------------|:----------|:-------|:------|:------------|:-----------------|:-------------|
| US           | United States | MAILING         | DOM          | 2773 MARSHALL DR | SUITE D   | TIFTON | GA    | 317938101   | 229-238-0790     | 229-238-0791 |
| US           | United States | LOCATION        | DOM          | 2773 MARSHALL DR | SUITE D   | TIFTON | GA    | 317938101   | 229-238-0790     | 229-238-0791 |

<br>

``` r
 # Deactivated
nppes_npi(npi = 1659781227) |> 
  tidyr::unnest(cols = c(errors)) |> 
  gluedown::md_table()
```

| datetime            | outcome | description                                                                                                                                                            | field  | number |
|:--------------------|:--------|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-------|:-------|
| 2023-01-22 18:24:10 | Errors  | CMS deactivated NPI 1659781227. The provider can no longer use this NPI. Our public registry does not display provider information about NPIs that are not in service. | number | 15     |

<br><br>

## CMS Open Payments API

``` r
op <- open_payments(recipient_npi = 1043218118)
```

<br><br>

``` r
op |> tidyr::hoist(covered_recipient, 
                   recipient_npi = "covered_recipient_npi",
                   profile_id = "covered_recipient_profile_id",
                   first_name = "covered_recipient_first_name", 
                   last_name = "covered_recipient_last_name",
                   credential = "covered_recipient_primary_type_1",) |> 
      tidyr::hoist(recipient_address, 
                   city = "recipient_city", 
                   state = "recipient_state") |> 
      dplyr::select(program_year, 
                    recipient_npi, 
                    profile_id,
                    first_name,
                    last_name,
                    credential,
                    city,
                    state) |> 
      dplyr::slice_head() |> 
      gluedown::md_table()
```

| program_year | recipient_npi | profile_id | first_name | last_name | credential     | city       | state |
|:-------------|:--------------|:-----------|:-----------|:----------|:---------------|:-----------|:------|
| 2021         | 1043218118    | 92058      | Ahad       | Mahootchi | Medical Doctor | Zephrhills | FL    |

<br><br>

``` r
op_2 <- op |> tidyr::hoist(applicable_mfg_gpo, 
                           manufacturer_gpo_paying = "applicable_manufacturer_or_applicable_gpo_making_payment_name") |>
             tidyr::hoist(associated_drug_device, 
                          type = "indicate_drug_or_biological_or_device_or_medical_supply_1",
                          therapeutic_category = "product_category_or_therapeutic_area_1",
                          name = "name_of_drug_or_biological_or_device_or_medical_supply_1") |> 
             dplyr::select(payment_date = date_of_payment, 
                          manufacturer_gpo_paying,
                          type, 
                          name,
                          therapeutic_category,
                          payment_total = total_amount_of_payment_usdollars,
                          nature_of_payment = nature_of_payment_or_transfer_of_value) |> 
             dplyr::arrange(payment_date)

op_2 |> dplyr::mutate(nature_of_payment = stringr::str_trunc(nature_of_payment, 20, "right"),
                      manufacturer_gpo_paying = stringr::str_trunc(manufacturer_gpo_paying, 20, "right"),
                      name = stringr::str_trunc(name, 20, "right"),
                      therapeutic_category = stringr::str_trunc(therapeutic_category, 20, "right")) |> gluedown::md_table()
```

| payment_date | manufacturer_gpo_paying | type       | name                 | therapeutic_category | payment_total | nature_of_payment  |
|:-------------|:------------------------|:-----------|:---------------------|:---------------------|--------------:|:-------------------|
| 2021-01-04   | Bausch & Lomb, a …      | Device     | STELLARIS            | Ophthalmology        |       3000.00 | Consulting Fee     |
| 2021-01-13   | Allergan, Inc.          | Drug       | DURYSTA              | GLAUCOMA             |        325.00 | Consulting Fee     |
| 2021-01-15   | Allergan, Inc.          | Device     | XEN GLAUCOMA TREA…   | GLAUCOMA             |        487.50 | Consulting Fee     |
| 2021-02-02   | Sight Sciences, Inc.    | Device     | OMNI(R) SURGICAL …   | Ophthalmology        |         98.21 | Food and Beverage  |
| 2021-02-04   | SUN PHARMACEUTICA…      | Drug       | Cequa                | Ophthalmology        |          2.34 | Food and Beverage  |
| 2021-02-19   | Allergan, Inc.          | Drug       | DURYSTA              | GLAUCOMA             |         18.62 | Food and Beverage  |
| 2021-02-25   | Alimera Sciences,…      | Drug       | ILUVIEN              | OPHTHALMOLOGY        |         17.61 | Food and Beverage  |
| 2021-02-26   | Allergan, Inc.          | Device     | XEN GLAUCOMA TREA…   | GLAUCOMA             |        433.33 | Consulting Fee     |
| 2021-03-02   | Sight Sciences, Inc.    | Device     | OMNI(R) SURGICAL …   | Ophthalmology        |         15.04 | Food and Beverage  |
| 2021-03-04   | Johnson & Johnson…      | Device     | Tecnis IOL           | Optics               |         69.90 | Food and Beverage  |
| 2021-03-04   | Kala Pharmaceutic…      | Drug       | INVELTYS             | Ocular               |         24.30 | Food and Beverage  |
| 2021-03-09   | Ivantis, Inc            | Device     | Hydrus Microstent    | Ophthalmic Surgery   |         16.93 | Food and Beverage  |
| 2021-03-09   | Ivantis, Inc            | Device     | Hydrus Microstent    | Ophthalmic Surgery   |         18.33 | Food and Beverage  |
| 2021-03-10   | Allergan, Inc.          | Device     | XEN GLAUCOMA TREA…   | GLAUCOMA             |        325.00 | Consulting Fee     |
| 2021-03-17   | Bausch & Lomb, a …      | Device     | CRYSTALENS           | Ophthalmology        |        116.93 | Food and Beverage  |
| 2021-03-20   | Allergan, Inc.          | Device     | XEN GLAUCOMA TREA…   | GLAUCOMA             |       2600.00 | Compensation for … |
| 2021-03-22   | Allergan, Inc.          | Device     | XEN GLAUCOMA TREA…   | GLAUCOMA             |        379.17 | Consulting Fee     |
| 2021-03-30   | Sight Sciences, Inc.    | Device     | OMNI(R) SURGICAL …   | Ophthalmology        |         16.32 | Food and Beverage  |
| 2021-04-13   | Allergan, Inc.          | Device     | XEN GLAUCOMA TREA…   | GLAUCOMA             |          4.80 | Food and Beverage  |
| 2021-04-14   | Allergan, Inc.          | Device     | XEN GLAUCOMA TREA…   | GLAUCOMA             |         28.24 | Food and Beverage  |
| 2021-04-15   | EyePoint Pharmace…      | Drug       | DEXYCU               | Postoperative Inf…   |         16.64 | Food and Beverage  |
| 2021-04-16   | Allergan, Inc.          | Drug       | DURYSTA              | GLAUCOMA             |          4.05 | Food and Beverage  |
| 2021-04-20   | Allergan, Inc.          | Device     | XEN GLAUCOMA TREA…   | GLAUCOMA             |         54.17 | Consulting Fee     |
| 2021-04-21   | Allergan, Inc.          | Device     | XEN GLAUCOMA TREA…   | GLAUCOMA             |        325.00 | Consulting Fee     |
| 2021-04-22   | Alimera Sciences,…      | Drug       | ILUVIEN              | OPHTHALMOLOGY        |         16.73 | Food and Beverage  |
| 2021-04-29   | Iridex Corporation      | NA         | NA                   | NA                   |         14.97 | Food and Beverage  |
| 2021-05-03   | Allergan, Inc.          | Device     | XEN GLAUCOMA TREA…   | GLAUCOMA             |       1000.00 | Compensation for … |
| 2021-05-06   | Alcon Vision LLC        | Device     | Precision 1          | Ophthalmology        |        114.20 | Food and Beverage  |
| 2021-05-06   | Novartis Pharmace…      | Drug       | BEOVU                | OPHTHALMOLOGY        |         21.65 | Food and Beverage  |
| 2021-05-11   | Ivantis, Inc            | Device     | Hydrus Microstent    | Ophthalmic Surgery   |         16.68 | Food and Beverage  |
| 2021-05-13   | Mallinckrodt Hosp…      | Biological | ACTHAR               | IMMUNOLOGY           |         12.26 | Food and Beverage  |
| 2021-05-13   | SUN PHARMACEUTICA…      | Drug       | Cequa                | Ophthalmology        |        112.23 | Food and Beverage  |
| 2021-05-20   | Allergan, Inc.          | Drug       | DURYSTA              | GLAUCOMA             |         16.30 | Food and Beverage  |
| 2021-05-26   | Mobius Therapeuti…      | Drug       | Mitosol              | Ophthamology         |       2500.00 | Compensation for … |
| 2021-05-27   | SUN PHARMACEUTICA…      | Drug       | Cequa                | Ophthalmology        |         17.65 | Food and Beverage  |
| 2021-06-03   | Kala Pharmaceutic…      | Drug       | INVELTYS             | Ocular               |         22.16 | Food and Beverage  |
| 2021-06-10   | Allergan, Inc.          | Device     | XEN GLAUCOMA TREA…   | GLAUCOMA             |         41.67 | Food and Beverage  |
| 2021-06-10   | Allergan, Inc.          | Device     | XEN GLAUCOMA TREA…   | GLAUCOMA             |       1750.00 | Compensation for … |
| 2021-06-11   | Sight Sciences, Inc.    | Device     | OMNI(R) SURGICAL …   | Ophthalmology        |         24.40 | Food and Beverage  |
| 2021-06-16   | Allergan, Inc.          | Device     | XEN GLAUCOMA TREA…   | GLAUCOMA             |        975.00 | Consulting Fee     |
| 2021-06-17   | Allergan, Inc.          | Device     | XEN GLAUCOMA TREA…   | GLAUCOMA             |         54.17 | Consulting Fee     |
| 2021-06-17   | Ivantis, Inc            | Device     | Hydrus Microstent    | Ophthalmic Surgery   |        100.97 | Food and Beverage  |
| 2021-06-17   | Iridex Corporation      | NA         | NA                   | NA                   |       1000.00 | Consulting Fee     |
| 2021-06-23   | Mallinckrodt Hosp…      | Biological | ACTHAR               | IMMUNOLOGY           |        123.02 | Food and Beverage  |
| 2021-06-24   | Dompe US, Inc.          | Drug       | OXERVATE             | SOLUTION/ DROPS      |         20.48 | Food and Beverage  |
| 2021-07-01   | Alimera Sciences,…      | Drug       | ILUVIEN              | OPHTHALMOLOGY        |         15.44 | Food and Beverage  |
| 2021-07-05   | Allergan, Inc.          | Device     | XEN GLAUCOMA TREA…   | GLAUCOMA             |        325.00 | Consulting Fee     |
| 2021-07-08   | Kala Pharmaceutic…      | Drug       | INVELTYS             | Ocular               |         20.04 | Food and Beverage  |
| 2021-07-09   | NEW WORLD MEDICAL…      | Device     | Ahmed Glaucoma Valve | Ophthalmology        |        116.20 | Food and Beverage  |
| 2021-07-10   | Sight Sciences, Inc.    | Device     | TearCare SmartLid    | Ophthalmology        |         96.30 | Food and Beverage  |
| 2021-07-10   | Ocular Therapeuti…      | Drug       | DEXTENZA             | Corticosteroid in…   |         54.83 | Food and Beverage  |
| 2021-07-10   | SUN PHARMACEUTICA…      | Drug       | Cequa                | Ophthalmology        |         26.19 | Food and Beverage  |
| 2021-07-10   | NEW WORLD MEDICAL…      | Device     | Ahmed Glaucoma Valve | Ophthalmology        |         40.66 | Food and Beverage  |
| 2021-07-16   | Checkpoint Surgic…      | Device     | Checkpoint Stimul…   | Surgery              |         14.74 | Food and Beverage  |
| 2021-07-25   | Allergan, Inc.          | Device     | XEN GLAUCOMA TREA…   | GLAUCOMA             |         94.36 | Food and Beverage  |
| 2021-07-25   | Allergan, Inc.          | Device     | XEN GLAUCOMA TREA…   | GLAUCOMA             |       1750.00 | Compensation for … |
| 2021-08-06   | Allergan, Inc.          | NA         | NA                   | NA                   |         73.24 | Food and Beverage  |
| 2021-08-19   | Alimera Sciences,…      | Drug       | ILUVIEN              | OPHTHALMOLOGY        |         20.07 | Food and Beverage  |
| 2021-08-24   | Horizon Therapeut…      | Drug       | TEPEZZA              | TEPEZZA              |        107.93 | Food and Beverage  |
| 2021-08-24   | Horizon Therapeut…      | Drug       | TEPEZZA              | TEPEZZA              |         97.14 | Food and Beverage  |
| 2021-08-31   | Allergan, Inc.          | Device     | XEN GLAUCOMA TREA…   | GLAUCOMA             |         27.20 | Food and Beverage  |
| 2021-09-02   | Ocular Therapeuti…      | Drug       | DEXTENZA             | Corticosteroid in…   |         14.44 | Food and Beverage  |
| 2021-09-06   | Beaver-Visitec In…      | NA         | NA                   | NA                   |         25.02 | Food and Beverage  |
| 2021-09-09   | Novartis Pharmace…      | Drug       | BEOVU                | OPHTHALMOLOGY        |         16.54 | Food and Beverage  |
| 2021-09-16   | Mallinckrodt Hosp…      | Biological | ACTHAR               | IMMUNOLOGY           |         16.73 | Food and Beverage  |
| 2021-09-17   | Mallinckrodt Hosp…      | Biological | ACTHAR               | IMMUNOLOGY           |          4.90 | Food and Beverage  |
| 2021-09-22   | Allergan, Inc.          | Device     | XEN GLAUCOMA TREA…   | GLAUCOMA             |        325.00 | Consulting Fee     |
| 2021-09-23   | Kala Pharmaceutic…      | Drug       | INVELTYS             | Ocular               |         15.21 | Food and Beverage  |
| 2021-09-30   | Horizon Therapeut…      | Drug       | TEPEZZA              | TEPEZZA              |         23.87 | Food and Beverage  |
| 2021-10-05   | Iridex Corporation      | NA         | NA                   | NA                   |         19.90 | Food and Beverage  |
| 2021-10-06   | Alcon Vision LLC        | Device     | AcrySof IQ VIVITY…   | Ophthalmology        |         14.73 | Food and Beverage  |
| 2021-10-12   | Allergan, Inc.          | Drug       | DURYSTA              | GLAUCOMA             |          8.57 | Food and Beverage  |
| 2021-10-12   | Ivantis, Inc            | Device     | Hydrus Microstent    | Ophthalmic Surgery   |         19.49 | Food and Beverage  |
| 2021-10-14   | Alimera Sciences,…      | Drug       | ILUVIEN              | OPHTHALMOLOGY        |         19.40 | Food and Beverage  |
| 2021-10-15   | Allergan, Inc.          | Device     | XEN GLAUCOMA TREA…   | GLAUCOMA             |        162.50 | Consulting Fee     |
| 2021-10-18   | Allergan, Inc.          | Device     | XEN GLAUCOMA TREA…   | GLAUCOMA             |        379.17 | Consulting Fee     |
| 2021-10-19   | Regeneron Healthc…      | Biological | EYLEA                | OPHTHALMOLOGY        |        125.01 | Food and Beverage  |
| 2021-10-26   | Allergan, Inc.          | Drug       | DURYSTA              | GLAUCOMA             |         23.90 | Food and Beverage  |
| 2021-10-27   | Allergan, Inc.          | Drug       | DURYSTA              | GLAUCOMA             |         10.00 | Food and Beverage  |
| 2021-10-28   | Kala Pharmaceutic…      | Drug       | INVELTYS             | Ocular               |         20.44 | Food and Beverage  |
| 2021-11-03   | Novartis Pharmace…      | Drug       | BEOVU                | OPHTHALMOLOGY        |         23.38 | Food and Beverage  |
| 2021-11-04   | Ivantis, Inc            | Device     | Hydrus Microstent    | Ophthalmic Surgery   |       1500.00 | Consulting Fee     |
| 2021-11-04   | Ivantis, Inc            | Device     | Hydrus Microstent    | Ophthalmic Surgery   |        132.45 | Food and Beverage  |
| 2021-11-04   | SUN PHARMACEUTICA…      | Drug       | Cequa                | Ophthalmology        |         17.12 | Food and Beverage  |
| 2021-11-10   | Horizon Therapeut…      | Drug       | TEPEZZA              | TEPEZZA              |         25.63 | Food and Beverage  |
| 2021-11-16   | Allergan, Inc.          | Device     | XEN GLAUCOMA TREA…   | GLAUCOMA             |         28.72 | Food and Beverage  |
| 2021-11-17   | Allergan, Inc.          | Device     | XEN GLAUCOMA TREA…   | GLAUCOMA             |        216.67 | Consulting Fee     |
| 2021-11-18   | Allergan, Inc.          | Drug       | DURYSTA              | GLAUCOMA             |        115.91 | Food and Beverage  |
| 2021-11-18   | Kala Pharmaceutic…      | Drug       | INVELTYS             | Ocular               |         17.44 | Food and Beverage  |
| 2021-12-07   | Allergan, Inc.          | Device     | XEN GLAUCOMA TREA…   | GLAUCOMA             |         92.33 | Food and Beverage  |
| 2021-12-08   | EyePoint Pharmace…      | Drug       | YUTIQ                | Chronic Non-infec…   |         13.85 | Food and Beverage  |
| 2021-12-15   | Kala Pharmaceutic…      | Drug       | INVELTYS             | Ocular               |         18.87 | Food and Beverage  |

<br><br>

``` r
op_2 |> 
  dplyr::group_by(manufacturer_gpo_paying, nature_of_payment, name) |> 
  dplyr::summarise(n = dplyr::n(),
                   payment_total = sum(payment_total), .groups = "drop") |> 
  dplyr::mutate(nature_of_payment = stringr::str_trunc(nature_of_payment, 20, "right")) |> 
  dplyr::arrange(dplyr::desc(payment_total)) |> 
  gluedown::md_table()
```

| manufacturer_gpo_paying                            | nature_of_payment  | name                          |   n | payment_total |
|:---------------------------------------------------|:-------------------|:------------------------------|----:|--------------:|
| Allergan, Inc.                                     | Compensation for … | XEN GLAUCOMA TREATMENT SYSTEM |   4 |       7100.00 |
| Allergan, Inc.                                     | Consulting Fee     | XEN GLAUCOMA TREATMENT SYSTEM |  13 |       4441.68 |
| Bausch & Lomb, a division of Bausch Health US, LLC | Consulting Fee     | STELLARIS                     |   1 |       3000.00 |
| Mobius Therapeutics, LLC                           | Compensation for … | Mitosol                       |   1 |       2500.00 |
| Ivantis, Inc                                       | Consulting Fee     | Hydrus Microstent             |   1 |       1500.00 |
| Iridex Corporation                                 | Consulting Fee     | NA                            |   1 |       1000.00 |
| Allergan, Inc.                                     | Consulting Fee     | DURYSTA                       |   1 |        325.00 |
| Allergan, Inc.                                     | Food and Beverage  | XEN GLAUCOMA TREATMENT SYSTEM |   7 |        317.32 |
| Ivantis, Inc                                       | Food and Beverage  | Hydrus Microstent             |   6 |        304.85 |
| Horizon Therapeutics plc                           | Food and Beverage  | TEPEZZA                       |   4 |        254.57 |
| Allergan, Inc.                                     | Food and Beverage  | DURYSTA                       |   7 |        197.35 |
| SUN PHARMACEUTICAL INDUSTRIES INC.                 | Food and Beverage  | Cequa                         |   5 |        175.53 |
| Mallinckrodt Hospital Products Inc.                | Food and Beverage  | ACTHAR                        |   4 |        156.91 |
| NEW WORLD MEDICAL,INC.                             | Food and Beverage  | Ahmed Glaucoma Valve          |   2 |        156.86 |
| Sight Sciences, Inc.                               | Food and Beverage  | OMNI(R) SURGICAL SYSTEM (US)  |   4 |        153.97 |
| Kala Pharmaceuticals, Inc.                         | Food and Beverage  | INVELTYS                      |   7 |        138.46 |
| Regeneron Healthcare Solutions, Inc.               | Food and Beverage  | EYLEA                         |   1 |        125.01 |
| Bausch & Lomb, a division of Bausch Health US, LLC | Food and Beverage  | CRYSTALENS                    |   1 |        116.93 |
| Alcon Vision LLC                                   | Food and Beverage  | Precision 1                   |   1 |        114.20 |
| Sight Sciences, Inc.                               | Food and Beverage  | TearCare SmartLid             |   1 |         96.30 |
| Alimera Sciences, Inc.                             | Food and Beverage  | ILUVIEN                       |   5 |         89.25 |
| Allergan, Inc.                                     | Food and Beverage  | NA                            |   1 |         73.24 |
| Johnson & Johnson Surgical Vision, Inc.            | Food and Beverage  | Tecnis IOL                    |   1 |         69.90 |
| Ocular Therapeutix, Inc.                           | Food and Beverage  | DEXTENZA                      |   2 |         69.27 |
| Novartis Pharmaceuticals Corporation               | Food and Beverage  | BEOVU                         |   3 |         61.57 |
| Iridex Corporation                                 | Food and Beverage  | NA                            |   2 |         34.87 |
| Beaver-Visitec International, Inc.                 | Food and Beverage  | NA                            |   1 |         25.02 |
| Dompe US, Inc.                                     | Food and Beverage  | OXERVATE                      |   1 |         20.48 |
| EyePoint Pharmaceuticals US, Inc.                  | Food and Beverage  | DEXYCU                        |   1 |         16.64 |
| Checkpoint Surgical, Inc                           | Food and Beverage  | Checkpoint Stimulators        |   1 |         14.74 |
| Alcon Vision LLC                                   | Food and Beverage  | AcrySof IQ VIVITY IOL         |   1 |         14.73 |
| EyePoint Pharmaceuticals US, Inc.                  | Food and Beverage  | YUTIQ                         |   1 |         13.85 |

## CMS Missing Digital Contact Information API

``` r
provider::missing_information(npi = 1144224569) |> gluedown::md_table()
```

| npi        | last_name | first_name |
|:-----------|:----------|:-----------|
| 1144224569 | Clouse    | John       |

<br>

### Medicare Fee-For-Service Public Provider Enrollment API

``` r
prven <- tibble::tribble(
~fn,         ~params,
"provider_enrollment", list(npi = 1083879860),
"provider_enrollment", list(first_name = "MICHAEL", middle_name = "K", last_name = "GREENBERG", state = "MD"),
"provider_enrollment", list(org_name = "LUMINUS DIAGNOSTICS LLC", state = "GA"),
)

purrr::invoke_map_dfr(prven$fn, prven$params)
```

    #> # A tibble: 3 × 11
    #>   npi    pecos…¹ enrlm…² provi…³ provi…⁴ state…⁵ first…⁶ mdl_n…⁷ last_…⁸ org_n…⁹
    #>   <chr>  <chr>   <chr>   <chr>   <chr>   <chr>   <chr>   <chr>   <chr>   <chr>  
    #> 1 10838… 842632… I20200… 14-08   PRACTI… PA      "CHRIS… "L"     "AARON" ""     
    #> 2 19321… 418353… I20031… 14-13   PRACTI… MD      "MICHA… "K"     "GREEN… ""     
    #> 3 13364… 135550… O20120… 12-69   PART B… GA      ""      ""      ""      "LUMIN…
    #> # … with 1 more variable: gndr_sw <chr>, and abbreviated variable names
    #> #   ¹​pecos_asct_cntl_id, ²​enrlmt_id, ³​provider_type_cd, ⁴​provider_type_desc,
    #> #   ⁵​state_cd, ⁶​first_name, ⁷​mdl_name, ⁸​last_name, ⁹​org_name

<br>

### Medicare Monthly Enrollment API

``` r
months <- tibble::enframe(month.name) |> 
  dplyr::select(-name) |> 
  dplyr::slice(1:7) |> 
  tibble::deframe()

purrr::map_dfr(months, ~beneficiary_enrollment(year = 2022, geo_level = "State", state = "Georgia", month = .x))
```

    #> # A tibble: 7 × 22
    #>    year month    bene_…¹ bene_…² bene_…³ bene_…⁴ bene_…⁵ tot_b…⁶ orgnl…⁷ ma_an…⁸
    #>   <int> <chr>    <chr>   <chr>   <chr>   <chr>   <chr>     <int>   <int>   <int>
    #> 1  2022 January  State   GA      Georgia Total   13      1830959  915752  915207
    #> 2  2022 February State   GA      Georgia Total   13      1830025  913347  916678
    #> 3  2022 March    State   GA      Georgia Total   13      1831573  912897  918676
    #> 4  2022 April    State   GA      Georgia Total   13      1833135  911263  921872
    #> 5  2022 May      State   GA      Georgia Total   13      1835187  910417  924770
    #> 6  2022 June     State   GA      Georgia Total   13      1837394  909778  927616
    #> 7  2022 July     State   GA      Georgia Total   13      1840128  907070  933058
    #> # … with 12 more variables: aged_tot_benes <int>, aged_esrd_benes <int>,
    #> #   aged_no_esrd_benes <int>, dsbld_tot_benes <int>,
    #> #   dsbld_esrd_and_esrd_only_benes <int>, dsbld_no_esrd_benes <int>,
    #> #   a_b_tot_benes <int>, a_b_orgnl_mdcr_benes <int>,
    #> #   a_b_ma_and_oth_benes <int>, prscrptn_drug_tot_benes <int>,
    #> #   prscrptn_drug_pdp_benes <int>, prscrptn_drug_mapd_benes <int>, and
    #> #   abbreviated variable names ¹​bene_geo_lvl, ²​bene_state_abrvtn, …

<br>

### Medicare Order and Referring API

``` r
provider::order_refer(npi = 1083879860) |> 
  gluedown::md_table()
```

|        npi | last_name | first_name  | partb | dme  | hha  | pmd  |
|-----------:|:----------|:------------|:------|:-----|:-----|:-----|
| 1083879860 | AARON     | CHRISTOPHER | TRUE  | TRUE | TRUE | TRUE |

<br>

### Medicare Opt-Out Affidavits API

``` r
provider::opt_out(last = "Aaron") |> 
  gluedown::md_table()
```

| date       | last_updated | first_name | last_name | npi        | specialty              | optout_effective_date | optout_end_date | first_line_street_address | second_line_street_address | city_name  | state_code | zip_code  | eligible_to_order_and_refer |
|:-----------|:-------------|:-----------|:----------|:-----------|:-----------------------|:----------------------|:----------------|:--------------------------|:---------------------------|:-----------|:-----------|:----------|:----------------------------|
| 2023-01-22 | 11/15/2022   | Sheryl     | Aaron     | 1427358282 | Clinical Social Worker | 02/17/2022            | 02/17/2024      | 1633 Q ST NW              | STE 230                    | WASHINGTON | DC         | 200096351 | FALSE                       |

<br>

### Medicare Provider and Supplier Taxonomy Crosswalk API

``` r
provider::taxonomy_crosswalk(specialty_desc = "Rehabilitation Agency")
```

# A tibble: 2 × 4

medicare_specialty_code medicare_provider_supplier_type_desc…¹ provi…²
provi…³ <chr> <chr> <chr> <chr>  
1 B4\[14\] Rehabilitation Agency 261QR0… Ambula… 2 B4\[14\]
Rehabilitation Agency 315D00… Nursin… \# … with abbreviated variable
names \# ¹​medicare_provider_supplier_type_description,
²​provider_taxonomy_code, \#
³​provider_taxonomy_description_type_classification_specialization

<br>

### Medicare Revalidation Due Date API

``` r
provider::revalidation_date(npi = 1710912209)
```

# A tibble: 1 × 14

month enrollmen…¹ natio…² first…³ last\_…⁴ organ…⁵ enrol…⁶ enrol…⁷
provi…⁸ <date> <chr> <chr> <chr> <chr> <chr> <chr> <chr> <chr>  
1 2023-01-22 I200406020… 171091… Yelena Vorono… “” NY 3 Non-DM… \# …
with 5 more variables: enrollment_specialty <chr>, \#
revalidation_due_date <chr>, adjusted_due_date <chr>, \#
individual_total_reassign_to <chr>, receiving_benefits_reassignment
<int>, \# and abbreviated variable names ¹​enrollment_id, \#
²​national_provider_identifier, ³​first_name, ⁴​last_name,
⁵​organization_name, \# ⁶​enrollment_state_code, ⁷​enrollment_type,
⁸​provider_type_text <br>

### Medicare Revalidation Reassignment List API

``` r
provider::revalidation_reassign(ind_npi = 1710912209)
```

# A tibble: 5 × 17

month group_pac…¹ group…² group…³ group…⁴ group…⁵ group…⁶ recor…⁷
indiv…⁸ <date> <dbl> <chr> <chr> <chr> <chr> <int> <chr> <dbl> 1
2023-01-22 3678655222 O20080… \#1 Wis… NY 10/31/… 1 Reassi… 2.86e9 2
2023-01-22 9931511052 O20201… Bright… NY TBD 1 Reassi… 2.86e9 3
2023-01-22 2062791411 O20161… Fair P… NY TBD 1 Reassi… 2.86e9 4
2023-01-22 8527313170 O20180… New Yo… NY TBD 1 Reassi… 2.86e9 5
2023-01-22 5193155174 O20200… Podiat… NY TBD 1 Reassi… 2.86e9 \# … with
8 more variables: individual_enrollment_id <chr>, \# individual_npi
<int>, individual_first_name <chr>, \# individual_last_name <chr>,
individual_state_code <chr>, \# individual_specialty_description <chr>,
individual_due_date <chr>, \# individual_total_employer_associations
<int>, and abbreviated variable \# names ¹​group_pac_id,
²​group_enrollment_id, ³​group_legal_business_name, \# ⁴​group_state_code,
⁵​group_due_date, …

<br>

### Medicare Revalidation Clinic Group Practice Reassignment API

``` r
provider::revalidation_group(ind_npi = 1710912209)
```

# A tibble: 5 × 16

month group_pac…¹ group…² group…³ group…⁴ group…⁵ group…⁶ recor…⁷
indiv…⁸ <date> <dbl> <chr> <chr> <chr> <chr> <int> <chr> <chr>  
1 2023-01-22 3678655222 O20080… \#1 Wis… NY 10/31/… 1 Reassi… I20040… 2
2023-01-22 9931511052 O20201… Bright… NY TBD 1 Reassi… I20040… 3
2023-01-22 2062791411 O20161… Fair P… NY TBD 1 Reassi… I20040… 4
2023-01-22 8527313170 O20180… New Yo… NY TBD 1 Reassi… I20040… 5
2023-01-22 5193155174 O20200… Podiat… NY TBD 1 Reassi… I20040… \# … with
7 more variables: individual_npi <int>, individual_first_name <chr>, \#
individual_last_name <chr>, individual_state_code <chr>, \#
individual_specialty_description <chr>, individual_due_date <chr>, \#
individual_total_employer_associations <int>, and abbreviated variable
\# names ¹​group_pac_id, ²​group_enrollment_id,
³​group_legal_business_name, \# ⁴​group_state_code, ⁵​group_due_date, \#
⁶​group_reassignments_and_physician_assistants, ⁷​record_type, …

<br>

### Medicare Physician & Other Practitioners APIs

<br>

> 1.  by Provider and Service API:

<br>

``` r
pbs <- purrr::map_dfr(2013:2020, ~physician_by_service(npi = 1003000126, year = .x))
```

<br>

> 2.  by Geography and Service API:

<br>

``` r
srvcs <- physician_by_service(npi = 1003000126, year = 2020)

srvcs |> tidyr::unnest(cols = c(rndrng_prvdr, totals_srvcs, hcpcs, averages))
```

# A tibble: 9 × 30

year rndrng…¹ rndrn…² rndrn…³ rndrn…⁴ rndrn…⁵ rndrn…⁶ rndrn…⁷ rndrn…⁸
rndrn…⁹ <dbl> <chr> <chr> <chr> <chr> <chr> <chr> <chr> <chr> <chr>  
1 2020 1003000… Enkesh… Ardalan <NA> M.D. M I 6410 R… <NA>  
2 2020 1003000… Enkesh… Ardalan <NA> M.D. M I 6410 R… <NA>  
3 2020 1003000… Enkesh… Ardalan <NA> M.D. M I 6410 R… <NA>  
4 2020 1003000… Enkesh… Ardalan <NA> M.D. M I 6410 R… <NA>  
5 2020 1003000… Enkesh… Ardalan <NA> M.D. M I 6410 R… <NA>  
6 2020 1003000… Enkesh… Ardalan <NA> M.D. M I 6410 R… <NA>  
7 2020 1003000… Enkesh… Ardalan <NA> M.D. M I 6410 R… <NA>  
8 2020 1003000… Enkesh… Ardalan <NA> M.D. M I 6410 R… <NA>  
9 2020 1003000… Enkesh… Ardalan <NA> M.D. M I 6410 R… <NA>  
\# … with 20 more variables: rndrng_prvdr_city <chr>, \#
rndrng_prvdr_state_abrvtn <chr>, rndrng_prvdr_state_fips <chr>, \#
rndrng_prvdr_zip5 <chr>, rndrng_prvdr_ruca <chr>, \#
rndrng_prvdr_ruca_desc <chr>, rndrng_prvdr_cntry <chr>, \#
rndrng_prvdr_type <chr>, rndrng_prvdr_mdcr_prtcptg_ind <chr>, \#
tot_benes <int>, tot_srvcs <int>, tot_bene_day_srvcs <int>, hcpcs_cd
<chr>, \# hcpcs_desc <chr>, hcpcs_drug_ind <chr>, place_of_srvc <chr>, …

<br>

``` r
purrr::map_dfr(service$hcpcs_cd, ~physician_by_geography(geo_level = "National", year = 2020, hcpcs_code = .x)) |> 
  terse::terse(config = list(ansi = FALSE), width = 100)
```

    #> Error in vctrs_vec_compat(.x, .purrr_user_env): object 'service' not found

<br>

``` r
purrr::map_dfr(service$hcpcs_cd, ~physician_by_geography(geo_desc = "Maryland", year = 2020, hcpcs_code = .x)) |> 
  terse::terse(config = list(ansi = FALSE), width = 100)
```

    #> Error in vctrs_vec_compat(.x, .purrr_user_env): object 'service' not found

<br>

> 3.  by Provider API:

<br>

``` r
x <- purrr::map_dfr(as.character(2013:2020), ~physician_by_provider(npi = 1003000126, year = .x))
```

<br>

``` r
x |> dplyr::select(rndrng_npi, rndrng_prvdr) |> 
     tidyr::unnest(cols = c(rndrng_prvdr)) |> 
     dplyr::slice_head() |> 
     tidyr::pivot_longer(cols = dplyr::everything()) |> 
     gluedown::md_table()
```

| name                          | value                                                                               |
|:------------------------------|:------------------------------------------------------------------------------------|
| rndrng_npi                    | 1003000126                                                                          |
| rndrng_prvdr_last_org_name    | Enkeshafi                                                                           |
| rndrng_prvdr_first_name       | Ardalan                                                                             |
| rndrng_prvdr_mi               | NA                                                                                  |
| rndrng_prvdr_crdntls          | M.D.                                                                                |
| rndrng_prvdr_gndr             | M                                                                                   |
| rndrng_prvdr_ent_cd           | I                                                                                   |
| rndrng_prvdr_st1              | 900 Seton Dr                                                                        |
| rndrng_prvdr_st2              | NA                                                                                  |
| rndrng_prvdr_city             | Cumberland                                                                          |
| rndrng_prvdr_state_abrvtn     | MD                                                                                  |
| rndrng_prvdr_state_fips       | 24                                                                                  |
| rndrng_prvdr_zip5             | 21502                                                                               |
| rndrng_prvdr_ruca             | 1                                                                                   |
| rndrng_prvdr_ruca_desc        | Metropolitan area core: primary flow within an urbanized area of 50,000 and greater |
| rndrng_prvdr_cntry            | US                                                                                  |
| rndrng_prvdr_type             | Internal Medicine                                                                   |
| rndrng_prvdr_mdcr_prtcptg_ind | Y                                                                                   |

<br>

``` r
x |> dplyr::select(year, totals_srvcs) |> 
     tidyr::unnest(cols = c(totals_srvcs)) |> 
     gluedown::md_table()
```

| year | tot_hcpcs_cds | tot_benes | tot_srvcs | tot_sbmtd_chrg | tot_mdcr_alowd_amt | tot_mdcr_pymt_amt | tot_mdcr_stdzd_amt |
|:-----|--------------:|----------:|----------:|---------------:|-------------------:|------------------:|-------------------:|
| 2013 |            22 |       665 |      1648 |         395335 |          146521.84 |         116332.66 |          118271.40 |
| 2014 |            16 |       913 |      2749 |         750652 |          248222.87 |         194073.09 |          193214.54 |
| 2015 |            15 |       929 |      2769 |         800131 |          271108.68 |         213986.93 |          216780.42 |
| 2016 |            23 |       518 |      1477 |         746533 |          157362.25 |         124795.99 |          126129.38 |
| 2017 |            23 |       578 |      1670 |         800850 |          173705.49 |         137084.55 |          138279.12 |
| 2018 |            19 |       445 |      1218 |         692640 |          128729.42 |         102505.73 |          103527.31 |
| 2019 |            18 |       610 |      1392 |         519136 |          156626.32 |         124877.67 |          125266.10 |
| 2020 |            16 |       291 |       764 |         402812 |           85319.63 |          69175.78 |           66401.61 |

<br>

``` r
x |> dplyr::select(year, bene_age) |> 
     tidyr::unnest(cols = c(bene_age)) |> 
     gluedown::md_table()
```

| year | bene_avg_age | bene_age_lt_65_cnt | bene_age_65_74_cnt | bene_age_75_84_cnt | bene_age_gt_84_cnt |
|:-----|-------------:|-------------------:|-------------------:|-------------------:|-------------------:|
| 2013 |           74 |                120 |                186 |                205 |                154 |
| 2014 |           74 |                162 |                277 |                297 |                177 |
| 2015 |           74 |                149 |                293 |                289 |                198 |
| 2016 |           75 |                 74 |                172 |                157 |                115 |
| 2017 |           75 |                 84 |                186 |                187 |                121 |
| 2018 |           76 |                 57 |                136 |                156 |                 96 |
| 2019 |           75 |                 82 |                200 |                184 |                144 |
| 2020 |           77 |                 27 |                 88 |                104 |                 72 |

<br>

``` r
x |> dplyr::select(year, bene_sex, bene_status) |> 
     tidyr::unnest(cols = c(bene_sex, bene_status)) |> 
     gluedown::md_table()
```

| year | bene_feml_cnt | bene_male_cnt | bene_dual_cnt | bene_ndual_cnt |
|:-----|--------------:|--------------:|--------------:|---------------:|
| 2013 |           359 |           306 |           199 |            466 |
| 2014 |           504 |           409 |           326 |            587 |
| 2015 |           471 |           458 |           307 |            622 |
| 2016 |           286 |           232 |           154 |            364 |
| 2017 |           338 |           240 |           153 |            425 |
| 2018 |           263 |           182 |           128 |            317 |
| 2019 |           345 |           265 |           106 |            504 |
| 2020 |           161 |           130 |            61 |            230 |

<br>

``` r
x |> dplyr::select(year, bene_race) |> 
     tidyr::unnest(cols = c(bene_race)) |> 
     gluedown::md_table()
```

| year | bene_race_wht_cnt | bene_race_black_cnt | bene_race_api_cnt | bene_race_hspnc_cnt | bene_race_nat_ind_cnt | bene_race_othr_cnt |
|:-----|------------------:|--------------------:|------------------:|--------------------:|----------------------:|-------------------:|
| 2013 |               639 |                  14 |                NA |                  NA |                     0 |                 NA |
| 2014 |               880 |                  NA |                NA |                  NA |                    NA |                 NA |
| 2015 |               887 |                  31 |                NA |                  NA |                     0 |                 NA |
| 2016 |               466 |                  39 |                NA |                  NA |                     0 |                 NA |
| 2017 |               525 |                  38 |                NA |                  NA |                     0 |                 NA |
| 2018 |               408 |                  NA |                NA |                  NA |                    NA |                 NA |
| 2019 |               402 |                 175 |                NA |                  15 |                    NA |                 NA |
| 2020 |               210 |                  50 |                NA |                  12 |                    NA |                 NA |

<br>

``` r
x |> dplyr::select(year, bene_cc) |> 
     tidyr::unnest(cols = c(bene_cc)) |> 
     gluedown::md_table()
```

| year | bene_cc_af_pct | bene_cc_alzhmr_pct | bene_cc_asthma_pct | bene_cc_cncr_pct | bene_cc_chf_pct | bene_cc_ckd_pct | bene_cc_copd_pct | bene_cc_dprssn_pct | bene_cc_dbts_pct | bene_cc_hyplpdma_pct | bene_cc_hyprtnsn_pct | bene_cc_ihd_pct | bene_cc_opo_pct | bene_cc_raoa_pct | bene_cc_sz_pct | bene_cc_strok_pct | bene_avg_risk_scre |
|:-----|---------------:|-------------------:|-------------------:|-----------------:|----------------:|----------------:|-----------------:|-------------------:|-----------------:|---------------------:|---------------------:|----------------:|----------------:|-----------------:|---------------:|------------------:|-------------------:|
| 2013 |           0.26 |               0.32 |               0.13 |             0.16 |            0.50 |            0.56 |             0.41 |               0.38 |             0.54 |                 0.70 |                 0.75 |            0.67 |            0.13 |             0.47 |           0.16 |              0.20 |             2.1114 |
| 2014 |           0.27 |               0.31 |               0.18 |             0.16 |            0.49 |            0.56 |             0.43 |               0.46 |             0.52 |                 0.70 |                 0.75 |            0.68 |            0.14 |             0.53 |           0.18 |              0.20 |             2.2206 |
| 2015 |           0.29 |               0.34 |               0.19 |             0.17 |            0.52 |            0.60 |             0.44 |               0.49 |             0.53 |                 0.74 |                 0.75 |            0.66 |            0.12 |             0.57 |           0.22 |              0.20 |             2.4686 |
| 2016 |           0.26 |               0.31 |               0.13 |             0.15 |            0.42 |            0.63 |             0.39 |               0.42 |             0.53 |                 0.67 |                 0.75 |            0.53 |            0.12 |             0.49 |           0.09 |              0.13 |             2.0239 |
| 2017 |           0.24 |               0.29 |               0.11 |             0.14 |            0.47 |            0.65 |             0.36 |               0.46 |             0.51 |                 0.67 |                 0.75 |            0.56 |            0.09 |             0.49 |           0.08 |              0.13 |             2.1178 |
| 2018 |           0.27 |               0.31 |               0.11 |             0.15 |            0.48 |            0.70 |             0.44 |               0.47 |             0.53 |                 0.75 |                 0.75 |            0.55 |            0.11 |             0.56 |           0.09 |              0.11 |             2.2948 |
| 2019 |           0.30 |               0.37 |               0.14 |             0.19 |            0.51 |            0.70 |             0.36 |               0.41 |             0.54 |                 0.75 |                 0.75 |            0.61 |            0.11 |             0.54 |           0.08 |              0.21 |             2.5917 |
| 2020 |           0.31 |               0.43 |               0.15 |             0.18 |            0.48 |            0.65 |             0.29 |               0.35 |             0.47 |                 0.73 |                 0.75 |            0.66 |            0.11 |             0.51 |           0.09 |              0.19 |             2.5028 |

<br>

### Medicare Multiple Chronic Conditions API

``` r
cc_multiple(year = 2007, geo_lvl = "National", demo_lvl = "Race")
```

# A tibble: 60 × 13

    year bene_g…¹ bene_…² bene_…³ bene_…⁴ bene_…⁵ bene_…⁶ bene_…⁷ prvlnc tot_m…⁸

<dbl> <chr> <chr> <chr> <chr> <chr> <chr> <chr> <dbl> <dbl> 1 2007
National Nation… “” 65+ Race Asian … 0 to 1 0.327 1033. 2 2007 National
Nation… “” 65+ Race Asian … 2 to 3 0.344 3280. 3 2007 National Nation…
“” 65+ Race Asian … 4 to 5 0.221 7689. 4 2007 National Nation… “” 65+
Race Asian … 6+ 0.108 23479. 5 2007 National Nation… “” 65+ Race Hispan…
0 to 1 0.330 1048. 6 2007 National Nation… “” 65+ Race Hispan… 2 to 3
0.284 4241. 7 2007 National Nation… “” 65+ Race Hispan… 4 to 5 0.226
9788. 8 2007 National Nation… “” 65+ Race Hispan… 6+ 0.160 29290. 9 2007
National Nation… “” 65+ Race Native… 0 to 1 0.324 1356. 10 2007 National
Nation… “” 65+ Race Native… 2 to 3 0.323 4742. \# … with 50 more rows, 3
more variables: tot_mdcr_pymt_pc <dbl>, \# hosp_readmsn_rate <dbl>,
er_visits_per_1000_benes <dbl>, and abbreviated \# variable names
¹​bene_geo_lvl, ²​bene_geo_desc, ³​bene_geo_cd, ⁴​bene_age_lvl, \#
⁵​bene_demo_lvl, ⁶​bene_demo_desc, ⁷​bene_mcc, ⁸​tot_mdcr_stdzd_pymt_pc

<br>

### Medicare Specific Chronic Conditions API

``` r
cc_specific(year = 2007, geo_lvl = "National", demo_lvl = "Race")
```

# A tibble: 315 × 13

    year bene_g…¹ bene_…² bene_…³ bene_…⁴ bene_…⁵ bene_…⁶ bene_…⁷ prvlnc tot_m…⁸

<dbl> <chr> <chr> <chr> <chr> <chr> <chr> <chr> <chr> <chr>  
1 2007 National Nation… “” 65+ Race Asian … Alcoho… 0.0036 “”  
2 2007 National Nation… “” \<65 Race Asian … Alcoho… 0.021 “”  
3 2007 National Nation… “” All Race Asian … Alcoho… 0.0057 “”  
4 2007 National Nation… “” 65+ Race Hispan… Alcoho… 0.0107 “”  
5 2007 National Nation… “” \<65 Race Hispan… Alcoho… 0.0383 “”  
6 2007 National Nation… “” All Race Hispan… Alcoho… 0.0178 “”  
7 2007 National Nation… “” 65+ Race Native… Alcoho… 0.0288 “”  
8 2007 National Nation… “” \<65 Race Native… Alcoho… 0.08 “”  
9 2007 National Nation… “” All Race Native… Alcoho… 0.0453 “”  
10 2007 National Nation… “” 65+ Race non-Hi… Alcoho… 0.0148 “”  
\# … with 305 more rows, 3 more variables: tot_mdcr_pymt_pc <chr>, \#
hosp_readmsn_rate <chr>, er_visits_per_1000_benes <chr>, and abbreviated
\# variable names ¹​bene_geo_lvl, ²​bene_geo_desc, ³​bene_geo_cd,
⁴​bene_age_lvl, \# ⁵​bene_demo_lvl, ⁶​bene_demo_desc, ⁷​bene_cond,
⁸​tot_mdcr_stdzd_pymt_pc

<br>

------------------------------------------------------------------------

## Code of Conduct

Please note that the provider project is released with a [Contributor
Code of
Conduct](https://andrewallenbruce.github.io/provider/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
