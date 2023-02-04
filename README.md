
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
| `pending_applications()`   | [Medicare Pending Initial Logging and Tracking](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/pending-initial-logging-and-tracking-physicians)                                                  |

<br>

## Installation

You can install the development version of `provider` from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("andrewallenbruce/provider")
```

``` r
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

## Informational APIs

### NPPES NPI Registry

``` r
(npi_1 <- nppes_npi(npi = 1710975040))
```

    #> # A tibble: 1 × 15
    #>   datetime            outcome enumera…¹ number name  city  state addre…² pract…³
    #>   <dttm>              <chr>   <chr>     <chr>  <chr> <chr> <chr> <list>  <list> 
    #> 1 2023-02-03 23:24:30 results NPI-1     17109… JOHN… OLNEY MD    <df>    <list> 
    #> # … with 6 more variables: taxonomies <list>, identifiers <list>,
    #> #   endpoints <list>, other_names <list>, epochs <list>, basic <list>, and
    #> #   abbreviated variable names ¹​enumeration_type, ²​addresses,
    #> #   ³​practiceLocations

<br>

``` r
npi_1 |> dplyr::select(datetime:state) |> gluedown::md_table()
```

| datetime            | outcome | enumeration_type | number     | name         | city  | state |
|:--------------------|:--------|:-----------------|:-----------|:-------------|:------|:------|
| 2023-02-03 23:24:30 | results | NPI-1            | 1710975040 | JOHN HERRING | OLNEY | MD    |

<br>

- Basic Information

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

- Taxonomies

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

- Addresses

``` r
npi_1 |> 
  dplyr::select(addresses) |> 
  tidyr::unnest(addresses) |> 
  tidyr::pivot_longer(!address_purpose) |> 
  tidyr::pivot_wider(names_from = address_purpose, 
                     values_from = value) |> 
  gluedown::md_table()
```

| name             | MAILING         | LOCATION               |
|:-----------------|:----------------|:-----------------------|
| country_code     | US              | US                     |
| country_name     | United States   | United States          |
| address_type     | DOM             | DOM                    |
| address_1        | 1300 PICCARD DR | 18101 PRINCE PHILIP DR |
| address_2        | SUITE 202       | NA                     |
| city             | ROCKVILLE       | OLNEY                  |
| state            | MD              | MD                     |
| postal_code      | 208504303       | 208321514              |
| telephone_number | 310-921-7900    | 301-774-8900           |
| fax_number       | 301-921-7915    | 301-570-8574           |

<br>

- Identifiers

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

<br><br>

### CMS Missing Contact Information

``` r
provider::missing_information(npi = 1144224569) |> gluedown::md_table()
```

| npi        | last_name | first_name |
|:-----------|:----------|:-----------|
| 1144224569 | Clouse    | John       |

<br><br>

### Medicare Order and Referring

``` r
provider::order_refer(npi = 1083879860) |> gluedown::md_table()
```

|        npi | last_name | first_name  | partb | dme  | hha  | pmd  |
|-----------:|:----------|:------------|:------|:-----|:-----|:-----|
| 1083879860 | AARON     | CHRISTOPHER | TRUE  | TRUE | TRUE | TRUE |

<br><br>

### Medicare Opt-Out Affidavits

``` r
provider::opt_out(last = "Aaron") |> 
  dplyr::mutate(dplyr::across(everything(), as.character)) |>
  tidyr::pivot_longer(cols = dplyr::everything()) |> 
  gluedown::md_table()
```

| name                        | value                  |
|:----------------------------|:-----------------------|
| date                        | 2023-02-04             |
| last_updated                | 12/15/2022             |
| first_name                  | Sheryl                 |
| last_name                   | Aaron                  |
| npi                         | 1427358282             |
| specialty                   | Clinical Social Worker |
| optout_effective_date       | 02/17/2022             |
| optout_end_date             | 02/17/2024             |
| first_line_street_address   | 1633 Q ST NW           |
| second_line_street_address  | STE 230                |
| city_name                   | WASHINGTON             |
| state_code                  | DC                     |
| zip_code                    | 200096351              |
| eligible_to_order_and_refer | FALSE                  |

<br><br>

### Medicare Provider and Supplier Taxonomy Crosswalk

``` r
provider::taxonomy_crosswalk(specialty_desc = "Rehabilitation Agency") |> 
  dplyr::select(medicare_specialty_code, 
                medicare_specialty_description = medicare_provider_supplier_type_description,
                provider_taxonomy_code,
                provider_taxonomy_description = provider_taxonomy_description_type_classification_specialization) |> 
  gluedown::md_table()
```

| medicare_specialty_code | medicare_specialty_description | provider_taxonomy_code | provider_taxonomy_description                                  |
|:------------------------|:-------------------------------|:-----------------------|:---------------------------------------------------------------|
| B4\[14\]                | Rehabilitation Agency          | 261QR0400X             | Ambulatory Health Care Facilities/Clinic/Center Rehabilitation |
| B4\[14\]                | Rehabilitation Agency          | 315D00000X             | Nursing & Custodial Care Facilities/Hospice Inpatient          |

<br><br>

### Medicare Fee-For-Service Public Provider Enrollment

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

<br><br>

### Medicare Pending Initial Logging and Tracking

<br>

``` r
provider::pending_applications(npi = 1487003984, type = "physician") |> 
  gluedown::md_table()
```

| npi        | last_name | first_name |
|:-----------|:----------|:-----------|
| 1487003984 | AALAI     | MARRIAM    |

<br><br>

``` r
provider::pending_applications(npi = 1487003984, type = "non-physician") |> 
  gluedown::md_table()
```

| npi | last_name | first_name |
|:----|:----------|:-----------|
| NA  | NA        | NA         |

<br><br>

``` r
provider::pending_applications(last_name = "Abbott", type = "non-physician") |> 
  gluedown::md_table()
```

| npi        | last_name | first_name |
|:-----------|:----------|:-----------|
| 1871240168 | ABBOTT    | ELISE      |

<br><br>

``` r
pending_applications(first_name = "John", type = "physician") |> 
  gluedown::md_table()
```

| npi        | last_name          | first_name |
|:-----------|:-------------------|:-----------|
| 1881791739 | ADAMS              | JOHN       |
| 1841280963 | BIGBEE             | JOHN       |
| 1619996378 | BODDEN             | JOHN       |
| 1588744569 | BRUNO              | JOHN       |
| 1861142556 | BURKE              | JOHN       |
| 1700348547 | CARTER             | JOHN       |
| 1306817531 | COMBS              | JOHN       |
| 1144815689 | DELA CRUZ PORTUGAL | JOHN       |
| 1730349580 | ECHEVARRIA         | JOHN       |
| 1982680997 | EVERED             | JOHN       |
| 1376571554 | FLYNN              | JOHN       |
| 1689774804 | FREEMAN            | JOHN       |
| 1386604080 | GIANNINI           | JOHN       |
| 1316239189 | HAMMONS            | JOHN       |
| 1407832538 | HELLRUNG           | JOHN       |
| 1649734195 | HILTON             | JOHN       |
| 1992799001 | HOLLINGSWORTH      | JOHN       |
| 1710905674 | JONES              | JOHN       |
| 1821495573 | LEE                | JOHN       |
| 1851513428 | LOVEJOY III        | JOHN       |
| 1023000163 | LUDU               | JOHN       |
| 1710403092 | LUU                | JOHN       |
| 1144205394 | MAHANY             | JOHN       |
| 1942307897 | MCGINNIS           | JOHN       |
| 1669506580 | MCKEON             | JOHN       |
| 1275184079 | MCNEELY            | JOHN       |
| 1245970896 | MEISNER            | JOHN       |
| 1275596066 | MUNROE             | JOHN       |
| 1457370702 | PEDERSEN           | JOHN       |
| 1851715767 | PETTYGROVE         | JOHN       |
| 1568506368 | SMITH              | JOHN       |
| 1548823594 | SUTTER             | JOHN       |
| 1366437204 | VARENHOLT          | JOHN       |
| 1639191166 | VERVILLE           | JOHN       |

<br><br>

### Medicare Revalidation APIs

Medicare Revalidation Due Date API

``` r
date <- provider::revalidation_date(npi = 1710912209)
date |> 
  dplyr::mutate(dplyr::across(everything(), as.character)) |>
  tidyr::pivot_longer(cols = dplyr::everything()) |> 
  gluedown::md_table()
```

| name                            | value           |
|:--------------------------------|:----------------|
| month                           | 2023-02-04      |
| enrollment_id                   | I20040602001711 |
| national_provider_identifier    | 1710912209      |
| first_name                      | Yelena          |
| last_name                       | Voronova        |
| organization_name               |                 |
| enrollment_state_code           | NY              |
| enrollment_type                 | 3               |
| provider_type_text              | Non-DME Part B  |
| enrollment_specialty            | Podiatry        |
| revalidation_due_date           | 2019-10-31      |
| adjusted_due_date               |                 |
| individual_total_reassign_to    |                 |
| receiving_benefits_reassignment | 5               |

<br><br>

Medicare Revalidation Reassignment List API

``` r
list <- provider::revalidation_reassign(ind_npi = 1710912209)

list |> dplyr::mutate(dplyr::across(everything(), as.character)) |>
        tidyr::pivot_longer(cols = dplyr::everything()) |> 
        gluedown::md_table()
```

| name                                         | value                                           |
|:---------------------------------------------|:------------------------------------------------|
| month                                        | 2023-02-04                                      |
| group_pac_id                                 | 3678655222                                      |
| group_enrollment_id                          | O20080205000002                                 |
| group_legal_business_name                    | \#1 Wise Podiatry Care P.C.                     |
| group_state_code                             | NY                                              |
| group_due_date                               | 10/31/2019                                      |
| group_reassignments_and_physician_assistants | 1                                               |
| record_type                                  | Reassignment                                    |
| individual_pac_id                            | 2860474988                                      |
| individual_enrollment_id                     | I20040602001711                                 |
| individual_npi                               | 1710912209                                      |
| individual_first_name                        | Yelena                                          |
| individual_last_name                         | Voronova                                        |
| individual_state_code                        | NY                                              |
| individual_specialty_description             | Podiatry                                        |
| individual_due_date                          | 10/31/2019                                      |
| individual_total_employer_associations       | 5                                               |
| month                                        | 2023-02-04                                      |
| group_pac_id                                 | 9931511052                                      |
| group_enrollment_id                          | O20201215000955                                 |
| group_legal_business_name                    | Brighton Beach Podiatry Pllc                    |
| group_state_code                             | NY                                              |
| group_due_date                               | TBD                                             |
| group_reassignments_and_physician_assistants | 1                                               |
| record_type                                  | Reassignment                                    |
| individual_pac_id                            | 2860474988                                      |
| individual_enrollment_id                     | I20040602001711                                 |
| individual_npi                               | 1710912209                                      |
| individual_first_name                        | Yelena                                          |
| individual_last_name                         | Voronova                                        |
| individual_state_code                        | NY                                              |
| individual_specialty_description             | Podiatry                                        |
| individual_due_date                          | 10/31/2019                                      |
| individual_total_employer_associations       | 5                                               |
| month                                        | 2023-02-04                                      |
| group_pac_id                                 | 2062791411                                      |
| group_enrollment_id                          | O20161108001365                                 |
| group_legal_business_name                    | Fair Podiatry Practice Pllc                     |
| group_state_code                             | NY                                              |
| group_due_date                               | TBD                                             |
| group_reassignments_and_physician_assistants | 1                                               |
| record_type                                  | Reassignment                                    |
| individual_pac_id                            | 2860474988                                      |
| individual_enrollment_id                     | I20040602001711                                 |
| individual_npi                               | 1710912209                                      |
| individual_first_name                        | Yelena                                          |
| individual_last_name                         | Voronova                                        |
| individual_state_code                        | NY                                              |
| individual_specialty_description             | Podiatry                                        |
| individual_due_date                          | 10/31/2019                                      |
| individual_total_employer_associations       | 5                                               |
| month                                        | 2023-02-04                                      |
| group_pac_id                                 | 8527313170                                      |
| group_enrollment_id                          | O20180622000028                                 |
| group_legal_business_name                    | New York Jewish American Podiatry Practice Pllc |
| group_state_code                             | NY                                              |
| group_due_date                               | TBD                                             |
| group_reassignments_and_physician_assistants | 1                                               |
| record_type                                  | Reassignment                                    |
| individual_pac_id                            | 2860474988                                      |
| individual_enrollment_id                     | I20040602001711                                 |
| individual_npi                               | 1710912209                                      |
| individual_first_name                        | Yelena                                          |
| individual_last_name                         | Voronova                                        |
| individual_state_code                        | NY                                              |
| individual_specialty_description             | Podiatry                                        |
| individual_due_date                          | 10/31/2019                                      |
| individual_total_employer_associations       | 5                                               |
| month                                        | 2023-02-04                                      |
| group_pac_id                                 | 5193155174                                      |
| group_enrollment_id                          | O20200414003240                                 |
| group_legal_business_name                    | Podiatry Of Brooklyn Pllc                       |
| group_state_code                             | NY                                              |
| group_due_date                               | TBD                                             |
| group_reassignments_and_physician_assistants | 1                                               |
| record_type                                  | Reassignment                                    |
| individual_pac_id                            | 2860474988                                      |
| individual_enrollment_id                     | I20040602001711                                 |
| individual_npi                               | 1710912209                                      |
| individual_first_name                        | Yelena                                          |
| individual_last_name                         | Voronova                                        |
| individual_state_code                        | NY                                              |
| individual_specialty_description             | Podiatry                                        |
| individual_due_date                          | 10/31/2019                                      |
| individual_total_employer_associations       | 5                                               |

<br><br>

Medicare Revalidation Clinic Group Practice Reassignment API

``` r
group <- provider::revalidation_group(ind_npi = 1710912209)

group |> dplyr::mutate(dplyr::across(everything(), as.character)) |>
         tidyr::pivot_longer(cols = dplyr::everything()) |> 
         gluedown::md_table()
```

| name                                         | value                                           |
|:---------------------------------------------|:------------------------------------------------|
| month                                        | 2023-02-04                                      |
| group_pac_id                                 | 3678655222                                      |
| group_enrollment_id                          | O20080205000002                                 |
| group_legal_business_name                    | \#1 Wise Podiatry Care P.C.                     |
| group_state_code                             | NY                                              |
| group_due_date                               | 10/31/2019                                      |
| group_reassignments_and_physician_assistants | 1                                               |
| record_type                                  | Reassignment                                    |
| individual_enrollment_id                     | I20040602001711                                 |
| individual_npi                               | 1710912209                                      |
| individual_first_name                        | Yelena                                          |
| individual_last_name                         | Voronova                                        |
| individual_state_code                        | NY                                              |
| individual_specialty_description             | Podiatry                                        |
| individual_due_date                          | 10/31/2019                                      |
| individual_total_employer_associations       | 5                                               |
| month                                        | 2023-02-04                                      |
| group_pac_id                                 | 9931511052                                      |
| group_enrollment_id                          | O20201215000955                                 |
| group_legal_business_name                    | Brighton Beach Podiatry Pllc                    |
| group_state_code                             | NY                                              |
| group_due_date                               | TBD                                             |
| group_reassignments_and_physician_assistants | 1                                               |
| record_type                                  | Reassignment                                    |
| individual_enrollment_id                     | I20040602001711                                 |
| individual_npi                               | 1710912209                                      |
| individual_first_name                        | Yelena                                          |
| individual_last_name                         | Voronova                                        |
| individual_state_code                        | NY                                              |
| individual_specialty_description             | Podiatry                                        |
| individual_due_date                          | 10/31/2019                                      |
| individual_total_employer_associations       | 5                                               |
| month                                        | 2023-02-04                                      |
| group_pac_id                                 | 2062791411                                      |
| group_enrollment_id                          | O20161108001365                                 |
| group_legal_business_name                    | Fair Podiatry Practice Pllc                     |
| group_state_code                             | NY                                              |
| group_due_date                               | TBD                                             |
| group_reassignments_and_physician_assistants | 1                                               |
| record_type                                  | Reassignment                                    |
| individual_enrollment_id                     | I20040602001711                                 |
| individual_npi                               | 1710912209                                      |
| individual_first_name                        | Yelena                                          |
| individual_last_name                         | Voronova                                        |
| individual_state_code                        | NY                                              |
| individual_specialty_description             | Podiatry                                        |
| individual_due_date                          | 10/31/2019                                      |
| individual_total_employer_associations       | 5                                               |
| month                                        | 2023-02-04                                      |
| group_pac_id                                 | 8527313170                                      |
| group_enrollment_id                          | O20180622000028                                 |
| group_legal_business_name                    | New York Jewish American Podiatry Practice Pllc |
| group_state_code                             | NY                                              |
| group_due_date                               | TBD                                             |
| group_reassignments_and_physician_assistants | 1                                               |
| record_type                                  | Reassignment                                    |
| individual_enrollment_id                     | I20040602001711                                 |
| individual_npi                               | 1710912209                                      |
| individual_first_name                        | Yelena                                          |
| individual_last_name                         | Voronova                                        |
| individual_state_code                        | NY                                              |
| individual_specialty_description             | Podiatry                                        |
| individual_due_date                          | 10/31/2019                                      |
| individual_total_employer_associations       | 5                                               |
| month                                        | 2023-02-04                                      |
| group_pac_id                                 | 5193155174                                      |
| group_enrollment_id                          | O20200414003240                                 |
| group_legal_business_name                    | Podiatry Of Brooklyn Pllc                       |
| group_state_code                             | NY                                              |
| group_due_date                               | TBD                                             |
| group_reassignments_and_physician_assistants | 1                                               |
| record_type                                  | Reassignment                                    |
| individual_enrollment_id                     | I20040602001711                                 |
| individual_npi                               | 1710912209                                      |
| individual_first_name                        | Yelena                                          |
| individual_last_name                         | Voronova                                        |
| individual_state_code                        | NY                                              |
| individual_specialty_description             | Podiatry                                        |
| individual_due_date                          | 10/31/2019                                      |
| individual_total_employer_associations       | 5                                               |

<br><br>

## Analytical APIs

### CMS Open Payments API

``` r
op <- open_payments(recipient_npi = 1043218118)
```

<br>

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

<br>

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

<br>

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

<br><br>

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

<br><br>

### Medicare Physician & Other Practitioners APIs

<br>

> 1.  by Provider and Service API:

<br>

``` r
(pbs <- purrr::map_dfr(2013:2020, ~physician_by_service(npi = 1003000126, year = .x)))
```

    #> # A tibble: 8 × 6
    #>    year rndrng_npi rndrng_prvdr       totals_srvcs      hcpcs    averages
    #>   <int> <chr>      <list>             <list>            <list>   <list>  
    #> 1  2013 1003000126 <tibble [7 × 17]>  <tibble [7 × 3]>  <tibble> <tibble>
    #> 2  2014 1003000126 <tibble [8 × 17]>  <tibble [8 × 3]>  <tibble> <tibble>
    #> 3  2015 1003000126 <tibble [11 × 17]> <tibble [11 × 3]> <tibble> <tibble>
    #> 4  2016 1003000126 <tibble [12 × 17]> <tibble [12 × 3]> <tibble> <tibble>
    #> 5  2017 1003000126 <tibble [11 × 17]> <tibble [11 × 3]> <tibble> <tibble>
    #> 6  2018 1003000126 <tibble [11 × 17]> <tibble [11 × 3]> <tibble> <tibble>
    #> 7  2019 1003000126 <tibble [9 × 17]>  <tibble [9 × 3]>  <tibble> <tibble>
    #> 8  2020 1003000126 <tibble [9 × 17]>  <tibble [9 × 3]>  <tibble> <tibble>

<br>

> 2.  by Geography and Service API:

<br>

``` r
srvcs <- provider::physician_by_service(npi = 1003000126, year = 2020) |> 
         tidyr::unnest(cols = c(rndrng_prvdr, totals_srvcs, hcpcs, averages))

srvcs |> dplyr::select(year, 
                       tot_benes:tot_srvcs, hcpcs_cd, avg_sbmtd_chrg:avg_mdcr_pymt_amt) |> 
         gluedown::md_table()
```

| year | tot_benes | tot_srvcs | hcpcs_cd | avg_sbmtd_chrg | avg_mdcr_alowd_amt | avg_mdcr_pymt_amt |
|-----:|----------:|----------:|:---------|---------------:|-------------------:|------------------:|
| 2020 |        23 |        23 | 99217    |       406.1739 |           76.80391 |          61.40174 |
| 2020 |        16 |        16 | 99218    |       811.8125 |          108.24938 |          85.08125 |
| 2020 |        16 |        16 | 99220    |      1150.9375 |          191.96062 |         152.37688 |
| 2020 |        12 |        12 | 99221    |       681.6667 |          110.04750 |          82.23750 |
| 2020 |        52 |        52 | 99223    |      1108.3846 |          209.42385 |         170.83462 |
| 2020 |        57 |       134 | 99232    |       251.3284 |           73.45470 |          57.95582 |
| 2020 |       154 |       326 | 99233    |       513.2117 |          108.84687 |          88.94589 |
| 2020 |        13 |        13 | 99238    |       268.4615 |           74.15769 |          60.53308 |
| 2020 |       145 |       146 | 99239    |       491.8699 |          111.25979 |          90.92384 |

<br> <br>

``` r
nat <- purrr::map_dfr(srvcs$hcpcs_cd, ~physician_by_geography(geo_level = "National", year = 2020, hcpcs_code = .x))

nat |> dplyr::filter(place_of_srvc == "F") |>  
       dplyr::select(year, tot_rndrng_prvdrs:tot_srvcs, hcpcs_cd, avg_sbmtd_chrg:avg_mdcr_pymt_amt) |> 
       gluedown::md_table()
```

| year | tot_rndrng_prvdrs | tot_benes | tot_srvcs | hcpcs_cd | avg_sbmtd_chrg | avg_mdcr_alowd_amt | avg_mdcr_pymt_amt |
|-----:|------------------:|----------:|----------:|:---------|---------------:|-------------------:|------------------:|
| 2020 |             90842 |    960315 |   1083287 | 99217    |       226.5243 |           71.85383 |          56.39061 |
| 2020 |             37219 |    107097 |    113741 | 99218    |       279.0389 |           99.76702 |          77.72797 |
| 2020 |             88585 |   1057367 |   1251727 | 99220    |       602.4899 |          184.34005 |         144.10759 |
| 2020 |            170573 |   1095114 |   1469013 | 99221    |       262.3614 |          101.74503 |          79.93905 |
| 2020 |            243208 |   3820713 |   9472774 | 99223    |       502.2729 |          204.68211 |         161.39257 |
| 2020 |            298435 |   3982972 |  39627779 | 99232    |       175.3005 |           72.96044 |          58.10423 |
| 2020 |            241646 |   3338934 |  24561011 | 99233    |       282.3940 |          105.81724 |          84.56269 |
| 2020 |            124642 |   1561729 |   1996528 | 99238    |       188.4993 |           73.12491 |          57.87497 |
| 2020 |            105545 |   3093233 |   4564152 | 99239    |       310.6096 |          107.56667 |          85.47697 |

<br> <br>

``` r
state <- purrr::map_dfr(srvcs$hcpcs_cd, ~physician_by_geography(geo_desc = "Maryland", year = 2020, hcpcs_code = .x))

state |> dplyr::filter(place_of_srvc == "F") |>  
         dplyr::select(year, tot_rndrng_prvdrs:tot_srvcs, hcpcs_cd, avg_sbmtd_chrg:avg_mdcr_pymt_amt) |> 
         gluedown::md_table()
```

| year | tot_rndrng_prvdrs | tot_benes | tot_srvcs | hcpcs_cd | avg_sbmtd_chrg | avg_mdcr_alowd_amt | avg_mdcr_pymt_amt |
|-----:|------------------:|----------:|----------:|:---------|---------------:|-------------------:|------------------:|
| 2020 |              1523 |     31433 |     35505 | 99217    |       300.8633 |           73.32784 |          57.82643 |
| 2020 |               785 |      3847 |      4042 | 99218    |       377.2237 |          102.47521 |          80.32934 |
| 2020 |              1795 |     41984 |     49557 | 99220    |       761.2434 |          188.95922 |         147.87499 |
| 2020 |              3498 |     26136 |     32153 | 99221    |       269.1815 |          106.16173 |          83.30873 |
| 2020 |              4803 |     98672 |    183066 | 99223    |       556.9738 |          211.89818 |         166.53387 |
| 2020 |              5942 |    104865 |    634904 | 99232    |       176.7973 |           75.67333 |          60.11680 |
| 2020 |              5032 |    102804 |    508985 | 99233    |       338.0418 |          109.47410 |          87.22652 |
| 2020 |              2039 |     19248 |     21567 | 99238    |       207.3356 |           76.11991 |          60.27566 |
| 2020 |              2146 |     77391 |     99591 | 99239    |       367.9219 |          111.66222 |          88.69363 |

<br> <br>

> 3.  by Provider API:

<br><br>

``` r
(prov <- purrr::map_dfr(as.character(2013:2020), ~physician_by_provider(npi = 1003000126, year = .x)))
```

    #> # A tibble: 8 × 11
    #>   year  rndrng_…¹ rndrng…² totals…³ drug_s…⁴ med_sr…⁵ bene_age bene_sex bene_r…⁶
    #>   <chr> <chr>     <list>   <list>   <list>   <list>   <list>   <list>   <list>  
    #> 1 2013  10030001… <tibble> <tibble> <tibble> <tibble> <tibble> <tibble> <tibble>
    #> 2 2014  10030001… <tibble> <tibble> <tibble> <tibble> <tibble> <tibble> <tibble>
    #> 3 2015  10030001… <tibble> <tibble> <tibble> <tibble> <tibble> <tibble> <tibble>
    #> 4 2016  10030001… <tibble> <tibble> <tibble> <tibble> <tibble> <tibble> <tibble>
    #> 5 2017  10030001… <tibble> <tibble> <tibble> <tibble> <tibble> <tibble> <tibble>
    #> 6 2018  10030001… <tibble> <tibble> <tibble> <tibble> <tibble> <tibble> <tibble>
    #> 7 2019  10030001… <tibble> <tibble> <tibble> <tibble> <tibble> <tibble> <tibble>
    #> 8 2020  10030001… <tibble> <tibble> <tibble> <tibble> <tibble> <tibble> <tibble>
    #> # … with 2 more variables: bene_status <list>, bene_cc <list>, and abbreviated
    #> #   variable names ¹​rndrng_npi, ²​rndrng_prvdr, ³​totals_srvcs, ⁴​drug_srvcs,
    #> #   ⁵​med_srvcs, ⁶​bene_race

<br><br>

``` r
prov |> dplyr::select(rndrng_npi, rndrng_prvdr) |> 
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

<br><br>

``` r
prov |> dplyr::select(year, totals_srvcs) |> 
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

<br><br>

``` r
prov |> dplyr::select(year, bene_age) |> 
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

<br><br>

``` r
prov |> dplyr::select(year, bene_sex, bene_status) |> 
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

<br><br>

``` r
prov |> dplyr::select(year, bene_race) |> 
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

<br><br>

``` r
prov |> dplyr::select(year, bene_cc) |> 
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

<br><br>

### Medicare Chronic Conditions APIs

<br>

> Medicare Multiple Chronic Conditions API

<br>

``` r
mult <- cc_multiple(year = 2007, geo_lvl = "National", demo_lvl = "Race")

mult |> dplyr::select(year, bene_age_lvl, bene_demo_desc:er_visits_per_1000_benes) |> 
        gluedown::md_table()
```

| year | bene_age_lvl | bene_demo_desc         | bene_mcc | prvlnc | tot_mdcr_stdzd_pymt_pc | tot_mdcr_pymt_pc | hosp_readmsn_rate | er_visits_per_1000_benes |
|-----:|:-------------|:-----------------------|:---------|-------:|-----------------------:|-----------------:|------------------:|-------------------------:|
| 2007 | 65+          | Asian Pacific Islander | 0 to 1   | 0.3271 |               1033.425 |         1116.901 |            0.0612 |                  82.1561 |
| 2007 | 65+          | Asian Pacific Islander | 2 to 3   | 0.3438 |               3279.785 |         3692.248 |            0.0765 |                 210.1455 |
| 2007 | 65+          | Asian Pacific Islander | 4 to 5   | 0.2213 |               7688.844 |         8993.658 |            0.1237 |                 440.5998 |
| 2007 | 65+          | Asian Pacific Islander | 6+       | 0.1078 |              23479.215 |        28630.010 |            0.2514 |                1263.9579 |
| 2007 | 65+          | Hispanic               | 0 to 1   | 0.3299 |               1048.381 |         1068.586 |            0.0616 |                 121.4645 |
| 2007 | 65+          | Hispanic               | 2 to 3   | 0.2839 |               4241.093 |         4442.853 |            0.0815 |                 335.1211 |
| 2007 | 65+          | Hispanic               | 4 to 5   | 0.2259 |               9788.229 |        10473.366 |            0.1253 |                 637.7866 |
| 2007 | 65+          | Hispanic               | 6+       | 0.1604 |              29290.045 |        32426.369 |            0.2599 |                1635.1060 |
| 2007 | 65+          | Native American        | 0 to 1   | 0.3240 |               1355.807 |         1575.737 |            0.0691 |                 152.5662 |
| 2007 | 65+          | Native American        | 2 to 3   | 0.3231 |               4741.659 |         5345.857 |            0.0976 |                 381.1576 |
| 2007 | 65+          | Native American        | 4 to 5   | 0.2233 |              11047.675 |        12030.484 |            0.1460 |                 771.0588 |
| 2007 | 65+          | Native American        | 6+       | 0.1296 |              28707.960 |        30417.626 |            0.2613 |                1950.7418 |
| 2007 | 65+          | non-Hispanic Black     | 0 to 1   | 0.2805 |               1149.668 |         1161.112 |            0.0611 |                 157.3308 |
| 2007 | 65+          | non-Hispanic Black     | 2 to 3   | 0.3178 |               4574.554 |         4720.844 |            0.0869 |                 409.1927 |
| 2007 | 65+          | non-Hispanic Black     | 4 to 5   | 0.2378 |              11399.047 |        12071.111 |            0.1437 |                 836.2304 |
| 2007 | 65+          | non-Hispanic Black     | 6+       | 0.1638 |              33055.616 |        36171.156 |            0.2871 |                2171.2936 |
| 2007 | 65+          | non-Hispanic White     | 0 to 1   | 0.3160 |               1678.438 |         1661.474 |            0.0556 |                 127.2300 |
| 2007 | 65+          | non-Hispanic White     | 2 to 3   | 0.3353 |               4736.856 |         4793.009 |            0.0781 |                 313.0761 |
| 2007 | 65+          | non-Hispanic White     | 4 to 5   | 0.2200 |              10365.840 |        10680.746 |            0.1231 |                 663.8755 |
| 2007 | 65+          | non-Hispanic White     | 6+       | 0.1287 |              26710.488 |        27953.944 |            0.2418 |                1707.3168 |
| 2007 | \<65         | Asian Pacific Islander | 0 to 1   | 0.5135 |               1698.810 |         1797.475 |            0.0833 |                 217.5890 |
| 2007 | \<65         | Asian Pacific Islander | 2 to 3   | 0.2748 |               7053.768 |         7765.466 |            0.1304 |                 578.1715 |
| 2007 | \<65         | Asian Pacific Islander | 4 to 5   | 0.1478 |              14866.641 |        16877.190 |            0.1946 |                1029.8161 |
| 2007 | \<65         | Asian Pacific Islander | 6+       | 0.0640 |              36231.393 |        42542.236 |            0.3273 |                2661.9224 |
| 2007 | \<65         | Hispanic               | 0 to 1   | 0.4644 |               1719.425 |         1787.453 |            0.0878 |                 359.8491 |
| 2007 | \<65         | Hispanic               | 2 to 3   | 0.2694 |               6898.978 |         7304.867 |            0.1315 |                 817.4752 |
| 2007 | \<65         | Hispanic               | 4 to 5   | 0.1695 |              14897.610 |        16093.783 |            0.1914 |                1321.2344 |
| 2007 | \<65         | Hispanic               | 6+       | 0.0967 |              37732.625 |        41863.841 |            0.3220 |                2811.1045 |
| 2007 | \<65         | Native American        | 0 to 1   | 0.4612 |               1902.885 |         2060.935 |            0.0934 |                 458.9592 |
| 2007 | \<65         | Native American        | 2 to 3   | 0.2803 |               7184.807 |         7754.458 |            0.1428 |                1104.7525 |
| 2007 | \<65         | Native American        | 4 to 5   | 0.1685 |              15883.469 |        17016.842 |            0.1981 |                1824.6730 |
| 2007 | \<65         | Native American        | 6+       | 0.0901 |              36370.124 |        39061.169 |            0.3265 |                3869.7664 |
| 2007 | \<65         | non-Hispanic Black     | 0 to 1   | 0.4416 |               1770.660 |         1804.031 |            0.1231 |                 499.0150 |
| 2007 | \<65         | non-Hispanic Black     | 2 to 3   | 0.2744 |               7771.096 |         8046.864 |            0.1554 |                1083.2787 |
| 2007 | \<65         | non-Hispanic Black     | 4 to 5   | 0.1752 |              17010.521 |        18064.257 |            0.2101 |                1758.1527 |
| 2007 | \<65         | non-Hispanic Black     | 6+       | 0.1088 |              40837.009 |        44781.576 |            0.3605 |                3824.2017 |
| 2007 | \<65         | non-Hispanic White     | 0 to 1   | 0.4749 |               1983.117 |         1933.157 |            0.0884 |                 391.4371 |
| 2007 | \<65         | non-Hispanic White     | 2 to 3   | 0.2818 |               6328.382 |         6336.386 |            0.1239 |                 901.7026 |
| 2007 | \<65         | non-Hispanic White     | 4 to 5   | 0.1576 |              12662.525 |        12991.623 |            0.1705 |                1500.5192 |
| 2007 | \<65         | non-Hispanic White     | 6+       | 0.0857 |              31315.970 |        32895.787 |            0.3004 |                3287.8006 |
| 2007 | All          | Asian Pacific Islander | 0 to 1   | 0.3494 |               1150.655 |         1236.807 |            0.0681 |                 106.0172 |
| 2007 | All          | Asian Pacific Islander | 2 to 3   | 0.3355 |               3650.345 |         4092.190 |            0.0868 |                 246.2813 |
| 2007 | All          | Asian Pacific Islander | 4 to 5   | 0.2125 |               8287.475 |         9651.147 |            0.1340 |                 489.7406 |
| 2007 | All          | Asian Pacific Islander | 6+       | 0.1026 |              24432.532 |        29670.049 |            0.2598 |                1368.4657 |
| 2007 | All          | Hispanic               | 0 to 1   | 0.3646 |               1269.106 |         1305.041 |            0.0757 |                 199.8758 |
| 2007 | All          | Hispanic               | 2 to 3   | 0.2801 |               4901.231 |         5153.691 |            0.1002 |                 454.9232 |
| 2007 | All          | Hispanic               | 4 to 5   | 0.2114 |              10846.752 |        11637.761 |            0.1451 |                 779.3781 |
| 2007 | All          | Hispanic               | 6+       | 0.1439 |              30754.493 |        34063.390 |            0.2738 |                1839.0943 |
| 2007 | All          | Native American        | 0 to 1   | 0.3683 |               1577.132 |         1772.028 |            0.0814 |                 276.5202 |
| 2007 | All          | Native American        | 2 to 3   | 0.3093 |               5456.978 |         6051.060 |            0.1145 |                 593.0158 |
| 2007 | All          | Native American        | 4 to 5   | 0.2056 |              12328.138 |        13350.814 |            0.1635 |                1050.0437 |
| 2007 | All          | Native American        | 6+       | 0.1169 |              30616.248 |        32570.328 |            0.2812 |                2428.6812 |
| 2007 | All          | non-Hispanic Black     | 0 to 1   | 0.3366 |               1433.227 |         1454.683 |            0.1052 |                 313.3516 |
| 2007 | All          | non-Hispanic Black     | 2 to 3   | 0.3027 |               5583.154 |         5770.298 |            0.1200 |                 621.8861 |
| 2007 | All          | non-Hispanic Black     | 4 to 5   | 0.2160 |              12982.946 |        13762.741 |            0.1693 |                1096.4529 |
| 2007 | All          | non-Hispanic Black     | 6+       | 0.1447 |              35092.092 |        38424.598 |            0.3109 |                2603.8778 |
| 2007 | All          | non-Hispanic White     | 0 to 1   | 0.3383 |               1738.363 |         1714.909 |            0.0661 |                 179.1948 |
| 2007 | All          | non-Hispanic White     | 2 to 3   | 0.3278 |               4928.542 |         4978.895 |            0.0865 |                 383.9712 |
| 2007 | All          | non-Hispanic White     | 4 to 5   | 0.2113 |              10605.882 |        10922.272 |            0.1296 |                 751.3189 |
| 2007 | All          | non-Hispanic White     | 6+       | 0.1227 |              27161.302 |        28437.683 |            0.2490 |                1862.0246 |

<br><br>

> Medicare Specific Chronic Conditions API

<br>

``` r
spec <- cc_specific(year = 2007, geo_lvl = "National", demo_lvl = "Race")

spec |> dplyr::select(year, bene_age_lvl, bene_demo_desc:prvlnc) |> 
        gluedown::md_table()
```

| year | bene_age_lvl | bene_demo_desc         | bene_cond                                   | prvlnc |
|-----:|:-------------|:-----------------------|:--------------------------------------------|:-------|
| 2007 | 65+          | Asian Pacific Islander | Alcohol Abuse                               | 0.0036 |
| 2007 | \<65         | Asian Pacific Islander | Alcohol Abuse                               | 0.021  |
| 2007 | All          | Asian Pacific Islander | Alcohol Abuse                               | 0.0057 |
| 2007 | 65+          | Hispanic               | Alcohol Abuse                               | 0.0107 |
| 2007 | \<65         | Hispanic               | Alcohol Abuse                               | 0.0383 |
| 2007 | All          | Hispanic               | Alcohol Abuse                               | 0.0178 |
| 2007 | 65+          | Native American        | Alcohol Abuse                               | 0.0288 |
| 2007 | \<65         | Native American        | Alcohol Abuse                               | 0.08   |
| 2007 | All          | Native American        | Alcohol Abuse                               | 0.0453 |
| 2007 | 65+          | non-Hispanic Black     | Alcohol Abuse                               | 0.0148 |
| 2007 | \<65         | non-Hispanic Black     | Alcohol Abuse                               | 0.0487 |
| 2007 | All          | non-Hispanic Black     | Alcohol Abuse                               | 0.0266 |
| 2007 | 65+          | non-Hispanic White     | Alcohol Abuse                               | 0.0087 |
| 2007 | \<65         | non-Hispanic White     | Alcohol Abuse                               | 0.0425 |
| 2007 | All          | non-Hispanic White     | Alcohol Abuse                               | 0.0134 |
| 2007 | 65+          | Asian Pacific Islander | Alzheimer’s Disease/Dementia                | 0.0936 |
| 2007 | \<65         | Asian Pacific Islander | Alzheimer’s Disease/Dementia                | 0.0261 |
| 2007 | All          | Asian Pacific Islander | Alzheimer’s Disease/Dementia                | 0.0855 |
| 2007 | 65+          | Hispanic               | Alzheimer’s Disease/Dementia                | 0.1228 |
| 2007 | \<65         | Hispanic               | Alzheimer’s Disease/Dementia                | 0.0281 |
| 2007 | All          | Hispanic               | Alzheimer’s Disease/Dementia                | 0.0983 |
| 2007 | 65+          | Native American        | Alzheimer’s Disease/Dementia                | 0.1025 |
| 2007 | \<65         | Native American        | Alzheimer’s Disease/Dementia                | 0.0233 |
| 2007 | All          | Native American        | Alzheimer’s Disease/Dementia                | 0.0769 |
| 2007 | 65+          | non-Hispanic Black     | Alzheimer’s Disease/Dementia                | 0.1538 |
| 2007 | \<65         | non-Hispanic Black     | Alzheimer’s Disease/Dementia                | 0.0294 |
| 2007 | All          | non-Hispanic Black     | Alzheimer’s Disease/Dementia                | 0.1105 |
| 2007 | 65+          | non-Hispanic White     | Alzheimer’s Disease/Dementia                | 0.1168 |
| 2007 | \<65         | non-Hispanic White     | Alzheimer’s Disease/Dementia                | 0.0313 |
| 2007 | All          | non-Hispanic White     | Alzheimer’s Disease/Dementia                | 0.1048 |
| 2007 | 65+          | Asian Pacific Islander | Arthritis                                   | 0.2476 |
| 2007 | \<65         | Asian Pacific Islander | Arthritis                                   | 0.118  |
| 2007 | All          | Asian Pacific Islander | Arthritis                                   | 0.2321 |
| 2007 | 65+          | Hispanic               | Arthritis                                   | 0.2936 |
| 2007 | \<65         | Hispanic               | Arthritis                                   | 0.1801 |
| 2007 | All          | Hispanic               | Arthritis                                   | 0.2643 |
| 2007 | 65+          | Native American        | Arthritis                                   | 0.2791 |
| 2007 | \<65         | Native American        | Arthritis                                   | 0.1953 |
| 2007 | All          | Native American        | Arthritis                                   | 0.2521 |
| 2007 | 65+          | non-Hispanic Black     | Arthritis                                   | 0.2855 |
| 2007 | \<65         | non-Hispanic Black     | Arthritis                                   | 0.1767 |
| 2007 | All          | non-Hispanic Black     | Arthritis                                   | 0.2476 |
| 2007 | 65+          | non-Hispanic White     | Arthritis                                   | 0.2791 |
| 2007 | \<65         | non-Hispanic White     | Arthritis                                   | 0.1928 |
| 2007 | All          | non-Hispanic White     | Arthritis                                   | 0.267  |
| 2007 | 65+          | Asian Pacific Islander | Asthma                                      | 0.0439 |
| 2007 | \<65         | Asian Pacific Islander | Asthma                                      | 0.047  |
| 2007 | All          | Asian Pacific Islander | Asthma                                      | 0.0442 |
| 2007 | 65+          | Hispanic               | Asthma                                      | 0.0493 |
| 2007 | \<65         | Hispanic               | Asthma                                      | 0.0665 |
| 2007 | All          | Hispanic               | Asthma                                      | 0.0538 |
| 2007 | 65+          | Native American        | Asthma                                      | 0.0474 |
| 2007 | \<65         | Native American        | Asthma                                      | 0.0706 |
| 2007 | All          | Native American        | Asthma                                      | 0.0549 |
| 2007 | 65+          | non-Hispanic Black     | Asthma                                      | 0.0458 |
| 2007 | \<65         | non-Hispanic Black     | Asthma                                      | 0.0739 |
| 2007 | All          | non-Hispanic Black     | Asthma                                      | 0.0556 |
| 2007 | 65+          | non-Hispanic White     | Asthma                                      | 0.0358 |
| 2007 | \<65         | non-Hispanic White     | Asthma                                      | 0.0616 |
| 2007 | All          | non-Hispanic White     | Asthma                                      | 0.0394 |
| 2007 | 65+          | Asian Pacific Islander | Atrial Fibrillation                         | 0.0457 |
| 2007 | \<65         | Asian Pacific Islander | Atrial Fibrillation                         | 0.0163 |
| 2007 | All          | Asian Pacific Islander | Atrial Fibrillation                         | 0.0422 |
| 2007 | 65+          | Hispanic               | Atrial Fibrillation                         | 0.0438 |
| 2007 | \<65         | Hispanic               | Atrial Fibrillation                         | 0.0124 |
| 2007 | All          | Hispanic               | Atrial Fibrillation                         | 0.0357 |
| 2007 | 65+          | Native American        | Atrial Fibrillation                         | 0.0529 |
| 2007 | \<65         | Native American        | Atrial Fibrillation                         | 0.0124 |
| 2007 | All          | Native American        | Atrial Fibrillation                         | 0.0398 |
| 2007 | 65+          | non-Hispanic Black     | Atrial Fibrillation                         | 0.0448 |
| 2007 | \<65         | non-Hispanic Black     | Atrial Fibrillation                         | 0.0149 |
| 2007 | All          | non-Hispanic Black     | Atrial Fibrillation                         | 0.0344 |
| 2007 | 65+          | non-Hispanic White     | Atrial Fibrillation                         | 0.0941 |
| 2007 | \<65         | non-Hispanic White     | Atrial Fibrillation                         | 0.0192 |
| 2007 | All          | non-Hispanic White     | Atrial Fibrillation                         | 0.0836 |
| 2007 | 65+          | Asian Pacific Islander | Autism Spectrum Disorders                   | 0      |
| 2007 | \<65         | Asian Pacific Islander | Autism Spectrum Disorders                   | 0.0044 |
| 2007 | All          | Asian Pacific Islander | Autism Spectrum Disorders                   | 6e-04  |
| 2007 | 65+          | Hispanic               | Autism Spectrum Disorders                   | 0      |
| 2007 | \<65         | Hispanic               | Autism Spectrum Disorders                   | 0.0024 |
| 2007 | All          | Hispanic               | Autism Spectrum Disorders                   | 6e-04  |
| 2007 | 65+          | Native American        | Autism Spectrum Disorders                   |        |
| 2007 | \<65         | Native American        | Autism Spectrum Disorders                   |        |
| 2007 | All          | Native American        | Autism Spectrum Disorders                   | 8e-04  |
| 2007 | 65+          | non-Hispanic Black     | Autism Spectrum Disorders                   | 1e-04  |
| 2007 | \<65         | non-Hispanic Black     | Autism Spectrum Disorders                   | 0.0026 |
| 2007 | All          | non-Hispanic Black     | Autism Spectrum Disorders                   | 0.001  |
| 2007 | 65+          | non-Hispanic White     | Autism Spectrum Disorders                   | 1e-04  |
| 2007 | \<65         | non-Hispanic White     | Autism Spectrum Disorders                   | 0.0048 |
| 2007 | All          | non-Hispanic White     | Autism Spectrum Disorders                   | 7e-04  |
| 2007 | 65+          | Asian Pacific Islander | COPD                                        | 0.075  |
| 2007 | \<65         | Asian Pacific Islander | COPD                                        | 0.0457 |
| 2007 | All          | Asian Pacific Islander | COPD                                        | 0.0715 |
| 2007 | 65+          | Hispanic               | COPD                                        | 0.0994 |
| 2007 | \<65         | Hispanic               | COPD                                        | 0.0619 |
| 2007 | All          | Hispanic               | COPD                                        | 0.0897 |
| 2007 | 65+          | Native American        | COPD                                        | 0.1301 |
| 2007 | \<65         | Native American        | COPD                                        | 0.095  |
| 2007 | All          | Native American        | COPD                                        | 0.1188 |
| 2007 | 65+          | non-Hispanic Black     | COPD                                        | 0.1008 |
| 2007 | \<65         | non-Hispanic Black     | COPD                                        | 0.0772 |
| 2007 | All          | non-Hispanic Black     | COPD                                        | 0.0926 |
| 2007 | 65+          | non-Hispanic White     | COPD                                        | 0.1185 |
| 2007 | \<65         | non-Hispanic White     | COPD                                        | 0.1175 |
| 2007 | All          | non-Hispanic White     | COPD                                        | 0.1183 |
| 2007 | 65+          | Asian Pacific Islander | Cancer                                      | 0.0576 |
| 2007 | \<65         | Asian Pacific Islander | Cancer                                      | 0.0209 |
| 2007 | All          | Asian Pacific Islander | Cancer                                      | 0.0532 |
| 2007 | 65+          | Hispanic               | Cancer                                      | 0.0612 |
| 2007 | \<65         | Hispanic               | Cancer                                      | 0.0197 |
| 2007 | All          | Hispanic               | Cancer                                      | 0.0505 |
| 2007 | 65+          | Native American        | Cancer                                      | 0.0647 |
| 2007 | \<65         | Native American        | Cancer                                      | 0.0195 |
| 2007 | All          | Native American        | Cancer                                      | 0.0501 |
| 2007 | 65+          | non-Hispanic Black     | Cancer                                      | 0.0944 |
| 2007 | \<65         | non-Hispanic Black     | Cancer                                      | 0.0271 |
| 2007 | All          | non-Hispanic Black     | Cancer                                      | 0.071  |
| 2007 | 65+          | non-Hispanic White     | Cancer                                      | 0.0912 |
| 2007 | \<65         | non-Hispanic White     | Cancer                                      | 0.0253 |
| 2007 | All          | non-Hispanic White     | Cancer                                      | 0.082  |
| 2007 | 65+          | Asian Pacific Islander | Chronic Kidney Disease                      | 0.1076 |
| 2007 | \<65         | Asian Pacific Islander | Chronic Kidney Disease                      | 0.1415 |
| 2007 | All          | Asian Pacific Islander | Chronic Kidney Disease                      | 0.1117 |
| 2007 | 65+          | Hispanic               | Chronic Kidney Disease                      | 0.1217 |
| 2007 | \<65         | Hispanic               | Chronic Kidney Disease                      | 0.1276 |
| 2007 | All          | Hispanic               | Chronic Kidney Disease                      | 0.1232 |
| 2007 | 65+          | Native American        | Chronic Kidney Disease                      | 0.1462 |
| 2007 | \<65         | Native American        | Chronic Kidney Disease                      | 0.1269 |
| 2007 | All          | Native American        | Chronic Kidney Disease                      | 0.1399 |
| 2007 | 65+          | non-Hispanic Black     | Chronic Kidney Disease                      | 0.1814 |
| 2007 | \<65         | non-Hispanic Black     | Chronic Kidney Disease                      | 0.1546 |
| 2007 | All          | non-Hispanic Black     | Chronic Kidney Disease                      | 0.1721 |
| 2007 | 65+          | non-Hispanic White     | Chronic Kidney Disease                      | 0.1112 |
| 2007 | \<65         | non-Hispanic White     | Chronic Kidney Disease                      | 0.0809 |
| 2007 | All          | non-Hispanic White     | Chronic Kidney Disease                      | 0.107  |
| 2007 | 65+          | Asian Pacific Islander | Depression                                  | 0.0496 |
| 2007 | \<65         | Asian Pacific Islander | Depression                                  | 0.1598 |
| 2007 | All          | Asian Pacific Islander | Depression                                  | 0.0628 |
| 2007 | 65+          | Hispanic               | Depression                                  | 0.104  |
| 2007 | \<65         | Hispanic               | Depression                                  | 0.2164 |
| 2007 | All          | Hispanic               | Depression                                  | 0.1331 |
| 2007 | 65+          | Native American        | Depression                                  | 0.1058 |
| 2007 | \<65         | Native American        | Depression                                  | 0.2375 |
| 2007 | All          | Native American        | Depression                                  | 0.1484 |
| 2007 | 65+          | non-Hispanic Black     | Depression                                  | 0.0717 |
| 2007 | \<65         | non-Hispanic Black     | Depression                                  | 0.1637 |
| 2007 | All          | non-Hispanic Black     | Depression                                  | 0.1038 |
| 2007 | 65+          | non-Hispanic White     | Depression                                  | 0.1022 |
| 2007 | \<65         | non-Hispanic White     | Depression                                  | 0.2632 |
| 2007 | All          | non-Hispanic White     | Depression                                  | 0.1247 |
| 2007 | 65+          | Asian Pacific Islander | Diabetes                                    | 0.3215 |
| 2007 | \<65         | Asian Pacific Islander | Diabetes                                    | 0.254  |
| 2007 | All          | Asian Pacific Islander | Diabetes                                    | 0.3134 |
| 2007 | 65+          | Hispanic               | Diabetes                                    | 0.3746 |
| 2007 | \<65         | Hispanic               | Diabetes                                    | 0.3116 |
| 2007 | All          | Hispanic               | Diabetes                                    | 0.3584 |
| 2007 | 65+          | Native American        | Diabetes                                    | 0.3668 |
| 2007 | \<65         | Native American        | Diabetes                                    | 0.3017 |
| 2007 | All          | Native American        | Diabetes                                    | 0.3458 |
| 2007 | 65+          | non-Hispanic Black     | Diabetes                                    | 0.3818 |
| 2007 | \<65         | non-Hispanic Black     | Diabetes                                    | 0.2871 |
| 2007 | All          | non-Hispanic Black     | Diabetes                                    | 0.3488 |
| 2007 | 65+          | non-Hispanic White     | Diabetes                                    | 0.2367 |
| 2007 | \<65         | non-Hispanic White     | Diabetes                                    | 0.2204 |
| 2007 | All          | non-Hispanic White     | Diabetes                                    | 0.2344 |
| 2007 | 65+          | Asian Pacific Islander | Drug/Substance Abuse                        | 0.0019 |
| 2007 | \<65         | Asian Pacific Islander | Drug/Substance Abuse                        | 0.0243 |
| 2007 | All          | Asian Pacific Islander | Drug/Substance Abuse                        | 0.0046 |
| 2007 | 65+          | Hispanic               | Drug/Substance Abuse                        | 0.0039 |
| 2007 | \<65         | Hispanic               | Drug/Substance Abuse                        | 0.0384 |
| 2007 | All          | Hispanic               | Drug/Substance Abuse                        | 0.0128 |
| 2007 | 65+          | Native American        | Drug/Substance Abuse                        | 0.0117 |
| 2007 | \<65         | Native American        | Drug/Substance Abuse                        | 0.0649 |
| 2007 | All          | Native American        | Drug/Substance Abuse                        | 0.0289 |
| 2007 | 65+          | non-Hispanic Black     | Drug/Substance Abuse                        | 0.0061 |
| 2007 | \<65         | non-Hispanic Black     | Drug/Substance Abuse                        | 0.0614 |
| 2007 | All          | non-Hispanic Black     | Drug/Substance Abuse                        | 0.0253 |
| 2007 | 65+          | non-Hispanic White     | Drug/Substance Abuse                        | 0.0054 |
| 2007 | \<65         | non-Hispanic White     | Drug/Substance Abuse                        | 0.0478 |
| 2007 | All          | non-Hispanic White     | Drug/Substance Abuse                        | 0.0114 |
| 2007 | 65+          | Asian Pacific Islander | HIV/AIDS                                    | 5e-04  |
| 2007 | \<65         | Asian Pacific Islander | HIV/AIDS                                    | 0.0101 |
| 2007 | All          | Asian Pacific Islander | HIV/AIDS                                    | 0.0017 |
| 2007 | 65+          | Hispanic               | HIV/AIDS                                    | 0.0032 |
| 2007 | \<65         | Hispanic               | HIV/AIDS                                    | 0.0275 |
| 2007 | All          | Hispanic               | HIV/AIDS                                    | 0.0095 |
| 2007 | 65+          | Native American        | HIV/AIDS                                    | 7e-04  |
| 2007 | \<65         | Native American        | HIV/AIDS                                    | 0.0123 |
| 2007 | All          | Native American        | HIV/AIDS                                    | 0.0044 |
| 2007 | 65+          | non-Hispanic Black     | HIV/AIDS                                    | 0.0029 |
| 2007 | \<65         | non-Hispanic Black     | HIV/AIDS                                    | 0.0363 |
| 2007 | All          | non-Hispanic Black     | HIV/AIDS                                    | 0.0145 |
| 2007 | 65+          | non-Hispanic White     | HIV/AIDS                                    | 6e-04  |
| 2007 | \<65         | non-Hispanic White     | HIV/AIDS                                    | 0.0114 |
| 2007 | All          | non-Hispanic White     | HIV/AIDS                                    | 0.0021 |
| 2007 | 65+          | Asian Pacific Islander | Heart Failure                               | 0.1381 |
| 2007 | \<65         | Asian Pacific Islander | Heart Failure                               | 0.0898 |
| 2007 | All          | Asian Pacific Islander | Heart Failure                               | 0.1323 |
| 2007 | 65+          | Hispanic               | Heart Failure                               | 0.1825 |
| 2007 | \<65         | Hispanic               | Heart Failure                               | 0.1071 |
| 2007 | All          | Hispanic               | Heart Failure                               | 0.1631 |
| 2007 | 65+          | Native American        | Heart Failure                               | 0.1806 |
| 2007 | \<65         | Native American        | Heart Failure                               | 0.0995 |
| 2007 | All          | Native American        | Heart Failure                               | 0.1544 |
| 2007 | 65+          | non-Hispanic Black     | Heart Failure                               | 0.2196 |
| 2007 | \<65         | non-Hispanic Black     | Heart Failure                               | 0.145  |
| 2007 | All          | non-Hispanic Black     | Heart Failure                               | 0.1936 |
| 2007 | 65+          | non-Hispanic White     | Heart Failure                               | 0.1757 |
| 2007 | \<65         | non-Hispanic White     | Heart Failure                               | 0.0951 |
| 2007 | All          | non-Hispanic White     | Heart Failure                               | 0.1644 |
| 2007 | 65+          | Asian Pacific Islander | Hepatitis (Chronic Viral B & C)             | 0.0179 |
| 2007 | \<65         | Asian Pacific Islander | Hepatitis (Chronic Viral B & C)             | 0.0305 |
| 2007 | All          | Asian Pacific Islander | Hepatitis (Chronic Viral B & C)             | 0.0194 |
| 2007 | 65+          | Hispanic               | Hepatitis (Chronic Viral B & C)             | 0.005  |
| 2007 | \<65         | Hispanic               | Hepatitis (Chronic Viral B & C)             | 0.0273 |
| 2007 | All          | Hispanic               | Hepatitis (Chronic Viral B & C)             | 0.0108 |
| 2007 | 65+          | Native American        | Hepatitis (Chronic Viral B & C)             | 0.0026 |
| 2007 | \<65         | Native American        | Hepatitis (Chronic Viral B & C)             | 0.0256 |
| 2007 | All          | Native American        | Hepatitis (Chronic Viral B & C)             | 0.01   |
| 2007 | 65+          | non-Hispanic Black     | Hepatitis (Chronic Viral B & C)             | 0.0053 |
| 2007 | \<65         | non-Hispanic Black     | Hepatitis (Chronic Viral B & C)             | 0.0268 |
| 2007 | All          | non-Hispanic Black     | Hepatitis (Chronic Viral B & C)             | 0.0128 |
| 2007 | 65+          | non-Hispanic White     | Hepatitis (Chronic Viral B & C)             | 0.0016 |
| 2007 | \<65         | non-Hispanic White     | Hepatitis (Chronic Viral B & C)             | 0.0195 |
| 2007 | All          | non-Hispanic White     | Hepatitis (Chronic Viral B & C)             | 0.0041 |
| 2007 | 65+          | Asian Pacific Islander | Hyperlipidemia                              | 0.4612 |
| 2007 | \<65         | Asian Pacific Islander | Hyperlipidemia                              | 0.2765 |
| 2007 | All          | Asian Pacific Islander | Hyperlipidemia                              | 0.4391 |
| 2007 | 65+          | Hispanic               | Hyperlipidemia                              | 0.4235 |
| 2007 | \<65         | Hispanic               | Hyperlipidemia                              | 0.2929 |
| 2007 | All          | Hispanic               | Hyperlipidemia                              | 0.3898 |
| 2007 | 65+          | Native American        | Hyperlipidemia                              | 0.328  |
| 2007 | \<65         | Native American        | Hyperlipidemia                              | 0.2162 |
| 2007 | All          | Native American        | Hyperlipidemia                              | 0.2919 |
| 2007 | 65+          | non-Hispanic Black     | Hyperlipidemia                              | 0.3822 |
| 2007 | \<65         | non-Hispanic Black     | Hyperlipidemia                              | 0.2383 |
| 2007 | All          | non-Hispanic Black     | Hyperlipidemia                              | 0.3321 |
| 2007 | 65+          | non-Hispanic White     | Hyperlipidemia                              | 0.4346 |
| 2007 | \<65         | non-Hispanic White     | Hyperlipidemia                              | 0.2784 |
| 2007 | All          | non-Hispanic White     | Hyperlipidemia                              | 0.4127 |
| 2007 | 65+          | Asian Pacific Islander | Hypertension                                | 0.5861 |
| 2007 | \<65         | Asian Pacific Islander | Hypertension                                | 0.3311 |
| 2007 | All          | Asian Pacific Islander | Hypertension                                | 0.5556 |
| 2007 | 65+          | Hispanic               | Hypertension                                | 0.5801 |
| 2007 | \<65         | Hispanic               | Hypertension                                | 0.3746 |
| 2007 | All          | Hispanic               | Hypertension                                | 0.527  |
| 2007 | 65+          | Native American        | Hypertension                                | 0.5687 |
| 2007 | \<65         | Native American        | Hypertension                                | 0.3574 |
| 2007 | All          | Native American        | Hypertension                                | 0.5004 |
| 2007 | 65+          | non-Hispanic Black     | Hypertension                                | 0.6876 |
| 2007 | \<65         | non-Hispanic Black     | Hypertension                                | 0.4724 |
| 2007 | All          | non-Hispanic Black     | Hypertension                                | 0.6127 |
| 2007 | 65+          | non-Hispanic White     | Hypertension                                | 0.5612 |
| 2007 | \<65         | non-Hispanic White     | Hypertension                                | 0.3364 |
| 2007 | All          | non-Hispanic White     | Hypertension                                | 0.5297 |
| 2007 | 65+          | Asian Pacific Islander | Ischemic Heart Disease                      | 0.2968 |
| 2007 | \<65         | Asian Pacific Islander | Ischemic Heart Disease                      | 0.1533 |
| 2007 | All          | Asian Pacific Islander | Ischemic Heart Disease                      | 0.2796 |
| 2007 | 65+          | Hispanic               | Ischemic Heart Disease                      | 0.3432 |
| 2007 | \<65         | Hispanic               | Ischemic Heart Disease                      | 0.1932 |
| 2007 | All          | Hispanic               | Ischemic Heart Disease                      | 0.3045 |
| 2007 | 65+          | Native American        | Ischemic Heart Disease                      | 0.3049 |
| 2007 | \<65         | Native American        | Ischemic Heart Disease                      | 0.1683 |
| 2007 | All          | Native American        | Ischemic Heart Disease                      | 0.2607 |
| 2007 | 65+          | non-Hispanic Black     | Ischemic Heart Disease                      | 0.3141 |
| 2007 | \<65         | non-Hispanic Black     | Ischemic Heart Disease                      | 0.1901 |
| 2007 | All          | non-Hispanic Black     | Ischemic Heart Disease                      | 0.2709 |
| 2007 | 65+          | non-Hispanic White     | Ischemic Heart Disease                      | 0.3398 |
| 2007 | \<65         | non-Hispanic White     | Ischemic Heart Disease                      | 0.1861 |
| 2007 | All          | non-Hispanic White     | Ischemic Heart Disease                      | 0.3183 |
| 2007 | 65+          | Asian Pacific Islander | Osteoporosis                                | 0.1109 |
| 2007 | \<65         | Asian Pacific Islander | Osteoporosis                                | 0.0249 |
| 2007 | All          | Asian Pacific Islander | Osteoporosis                                | 0.1006 |
| 2007 | 65+          | Hispanic               | Osteoporosis                                | 0.0809 |
| 2007 | \<65         | Hispanic               | Osteoporosis                                | 0.0245 |
| 2007 | All          | Hispanic               | Osteoporosis                                | 0.0663 |
| 2007 | 65+          | Native American        | Osteoporosis                                | 0.0543 |
| 2007 | \<65         | Native American        | Osteoporosis                                | 0.0178 |
| 2007 | All          | Native American        | Osteoporosis                                | 0.0425 |
| 2007 | 65+          | non-Hispanic Black     | Osteoporosis                                | 0.0355 |
| 2007 | \<65         | non-Hispanic Black     | Osteoporosis                                | 0.0108 |
| 2007 | All          | non-Hispanic Black     | Osteoporosis                                | 0.0269 |
| 2007 | 65+          | non-Hispanic White     | Osteoporosis                                | 0.0733 |
| 2007 | \<65         | non-Hispanic White     | Osteoporosis                                | 0.0247 |
| 2007 | All          | non-Hispanic White     | Osteoporosis                                | 0.0665 |
| 2007 | 65+          | Asian Pacific Islander | Schizophrenia and Other Psychotic Disorders | 0.0125 |
| 2007 | \<65         | Asian Pacific Islander | Schizophrenia and Other Psychotic Disorders | 0.1288 |
| 2007 | All          | Asian Pacific Islander | Schizophrenia and Other Psychotic Disorders | 0.0264 |
| 2007 | 65+          | Hispanic               | Schizophrenia and Other Psychotic Disorders | 0.0229 |
| 2007 | \<65         | Hispanic               | Schizophrenia and Other Psychotic Disorders | 0.0843 |
| 2007 | All          | Hispanic               | Schizophrenia and Other Psychotic Disorders | 0.0388 |
| 2007 | 65+          | Native American        | Schizophrenia and Other Psychotic Disorders | 0.0238 |
| 2007 | \<65         | Native American        | Schizophrenia and Other Psychotic Disorders | 0.0909 |
| 2007 | All          | Native American        | Schizophrenia and Other Psychotic Disorders | 0.0455 |
| 2007 | 65+          | non-Hispanic Black     | Schizophrenia and Other Psychotic Disorders | 0.0362 |
| 2007 | \<65         | non-Hispanic Black     | Schizophrenia and Other Psychotic Disorders | 0.1135 |
| 2007 | All          | non-Hispanic Black     | Schizophrenia and Other Psychotic Disorders | 0.0631 |
| 2007 | 65+          | non-Hispanic White     | Schizophrenia and Other Psychotic Disorders | 0.0226 |
| 2007 | \<65         | non-Hispanic White     | Schizophrenia and Other Psychotic Disorders | 0.0935 |
| 2007 | All          | non-Hispanic White     | Schizophrenia and Other Psychotic Disorders | 0.0325 |
| 2007 | 65+          | Asian Pacific Islander | Stroke                                      | 0.0398 |
| 2007 | \<65         | Asian Pacific Islander | Stroke                                      | 0.0268 |
| 2007 | All          | Asian Pacific Islander | Stroke                                      | 0.0383 |
| 2007 | 65+          | Hispanic               | Stroke                                      | 0.0466 |
| 2007 | \<65         | Hispanic               | Stroke                                      | 0.0249 |
| 2007 | All          | Hispanic               | Stroke                                      | 0.041  |
| 2007 | 65+          | Native American        | Stroke                                      | 0.0377 |
| 2007 | \<65         | Native American        | Stroke                                      | 0.0205 |
| 2007 | All          | Native American        | Stroke                                      | 0.0322 |
| 2007 | 65+          | non-Hispanic Black     | Stroke                                      | 0.0644 |
| 2007 | \<65         | non-Hispanic Black     | Stroke                                      | 0.0344 |
| 2007 | All          | non-Hispanic Black     | Stroke                                      | 0.0539 |
| 2007 | 65+          | non-Hispanic White     | Stroke                                      | 0.0446 |
| 2007 | \<65         | non-Hispanic White     | Stroke                                      | 0.0231 |
| 2007 | All          | non-Hispanic White     | Stroke                                      | 0.0416 |

<br><br>

------------------------------------------------------------------------

## Code of Conduct

Please note that the provider project is released with a [Contributor
Code of
Conduct](https://andrewallenbruce.github.io/provider/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
