
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

> Functions offering easy access to [healthcare
> provider](https://en.wikipedia.org/wiki/Health_care_provider) data
> through publicly available APIs & sources.

<br>

| Function                   | API                                                                                                                                                                                                                                   |
|:---------------------------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `nppes_npi()`              | [NPPES National Provider Identifier (NPI) Registry](https://npiregistry.cms.hhs.gov/search)                                                                                                                                           |
| `provider_enrollment()`    | [Medicare Fee-For-Service Public Provider Enrollment](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/medicare-fee-for-service-public-provider-enrollment)                                        |
| `beneficiary_enrollment()` | [Medicare Monthly Enrollment](https://data.cms.gov/summary-statistics-on-beneficiary-enrollment/medicare-and-medicaid-reports/medicare-monthly-enrollment)                                                                            |
| `order_refer()`            | [Medicare Order and Referring](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/order-and-referring)                                                                                               |
| `opt_out()`                | [Medicare Opt Out Affidavits](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/opt-out-affidavits)                                                                                                 |
| `physician_by_provider()`  | [Medicare Physician & Other Practitioners: by Provider](https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-provider)                           |
| `physician_by_service()`   | [Medicare Physician & Other Practitioners: by Provider and Service](https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-provider-and-service)   |
| `physician_by_geography()` | [Medicare Physician & Other Practitioners: by Geography and Service](https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-geography-and-service) |
| `revalidation_date()`      | [Medicare Revalidation Due Date](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-due-date-list)                                                                                      |
| `revalidation_group()`     | [Medicare Revalidation Clinic Group Practice Reassignment](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-clinic-group-practice-reassignment)                                       |
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

### NPPES National Provider Identifier Registry API

``` r
tribble <- tibble::tribble(
~fn,         ~params,
"nppes_npi", list(1336413418),
"nppes_npi", list(1659781227),
"nppes_npi", list(prov_type = "NPI-2", city = "Baltimore", state = "MD", limit = 10),
"nppes_npi", list(prov_type = "NPI-1", city = "Atlanta", state = "GA", limit = 10),
)

purrr::invoke_map_dfr(tribble$fn, tribble$params)
#> # A tibble: 22 × 17
#>    datetime            outcome enumera…¹ number basic…² basic_…³ addre…⁴ pract…⁵
#>    <dttm>              <chr>   <chr>     <chr>  <chr>   <list>   <list>  <list> 
#>  1 2022-12-19 18:21:32 results NPI-2     13364… LUMINU… <tibble> <df>    <list> 
#>  2 2022-12-19 18:21:32 Errors  <NA>      <NA>   <NA>    <NULL>   <NULL>  <NULL> 
#>  3 2022-12-19 18:21:32 results NPI-2     14271… MCGUIR… <tibble> <df>    <list> 
#>  4 2022-12-19 18:21:32 results NPI-2     18818… MENLO … <tibble> <df>    <list> 
#>  5 2022-12-19 18:21:32 results NPI-2     16999… MILFOR… <tibble> <df>    <list> 
#>  6 2022-12-19 18:21:32 results NPI-2     12756… VIRGIN… <tibble> <df>    <list> 
#>  7 2022-12-19 18:21:32 results NPI-2     17100… VIRGIN… <tibble> <df>    <list> 
#>  8 2022-12-19 18:21:32 results NPI-2     19322… VIRGIN… <tibble> <df>    <list> 
#>  9 2022-12-19 18:21:32 results NPI-2     18414… FRANRE… <tibble> <df>    <list> 
#> 10 2022-12-19 18:21:32 results NPI-2     12454… PLANNE… <tibble> <df>    <list> 
#> # … with 12 more rows, 9 more variables: taxonomies <list>, identifiers <list>,
#> #   endpoints <list>, other_names <list>, epochs <list>,
#> #   authorized_official <list>, errors <list>, basic_first_name <chr>,
#> #   basic_last_name <chr>, and abbreviated variable names ¹​enumeration_type,
#> #   ²​basic_organization_name, ³​basic_other, ⁴​addresses, ⁵​practiceLocations
```

<br>

### Medicare Fee-For-Service Public Provider Enrollment API

``` r
provider::provider_enrollment(npi = 1083879860)
```

| name               | value                          |
|:-------------------|:-------------------------------|
| npi                | 1083879860                     |
| pecos_asct_cntl_id | 8426328519                     |
| enrlmt_id          | I20200617001010                |
| provider_type_cd   | 14-08                          |
| provider_type_desc | PRACTITIONER - FAMILY PRACTICE |
| state_cd           | PA                             |
| first_name         | CHRISTOPHER                    |
| mdl_name           | L                              |
| last_name          | AARON                          |
| org_name           |                                |
| gndr_sw            | M                              |

<br>

### Medicare Monthly Enrollment API

``` r
provider::beneficiary_enrollment(year = 2021, month = "Year", 
  geo_level = "County", state_abb = "AL", county = "Autauga")
```

| name                           | value   |
|:-------------------------------|:--------|
| year                           | 2021    |
| month                          | Year    |
| bene_geo_lvl                   | County  |
| bene_state_abrvtn              | AL      |
| bene_state_desc                | Alabama |
| bene_county_desc               | Autauga |
| bene_fips_cd                   | 01001   |
| tot_benes                      | 11398   |
| orgnl_mdcr_benes               | 5339    |
| ma_and_oth_benes               | 6059    |
| aged_tot_benes                 | 9031    |
| aged_esrd_benes                | 56      |
| aged_no_esrd_benes             | 8975    |
| dsbld_tot_benes                | 2367    |
| dsbld_esrd_and_esrd_only_benes | 49      |
| dsbld_no_esrd_benes            | 2318    |
| a_b\_tot_benes                 | 10557   |
| a_b\_orgnl_mdcr_benes          | 4501    |
| a_b\_ma_and_oth_benes          | 6057    |
| prscrptn_drug_tot_benes        | 7838    |
| prscrptn_drug_pdp_benes        | 1931    |
| prscrptn_drug_mapd_benes       | 5907    |

``` r
months <- tibble::enframe(month.name) |> 
  dplyr::select(-name) |> 
  dplyr::slice(1:7) |> 
  tibble::deframe()

ga_bene <- purrr::map_dfr(months, 
      ~beneficiary_enrollment(year = 2022, 
                              geo_level = "State", 
                              state = "Georgia", 
                              month = .x))
ga_bene |> 
  dplyr::select(year, 
                month, 
                state = bene_state_abrvtn, 
                tot_benes,
                orgnl_mdcr_benes,
                ma_and_oth_benes,
                a_b_tot_benes:a_b_ma_and_oth_benes) |> 
  gluedown::md_table()
```

| year | month    | state | tot_benes | orgnl_mdcr_benes | ma_and_oth_benes | a_b\_tot_benes | a_b\_orgnl_mdcr_benes | a_b\_ma_and_oth_benes |
|-----:|:---------|:------|----------:|-----------------:|-----------------:|---------------:|----------------------:|----------------------:|
| 2022 | January  | GA    |   1830959 |           915752 |           915207 |        1681852 |                767454 |                914398 |
| 2022 | February | GA    |   1830025 |           913347 |           916678 |        1680770 |                764903 |                915867 |
| 2022 | March    | GA    |   1831573 |           912897 |           918676 |        1681852 |                763986 |                917866 |
| 2022 | April    | GA    |   1833135 |           911263 |           921872 |        1683513 |                762450 |                921063 |
| 2022 | May      | GA    |   1835187 |           910417 |           924770 |        1685479 |                761518 |                923961 |
| 2022 | June     | GA    |   1837394 |           909778 |           927616 |        1687818 |                761012 |                926806 |
| 2022 | July     | GA    |   1840128 |           907070 |           933058 |        1696372 |                764122 |                932250 |

``` r
ga_bene |> 
  dplyr::select(year, 
                month, 
                state = bene_state_abrvtn, 
                aged_tot_benes:aged_no_esrd_benes,
                dsbld_tot_benes:dsbld_no_esrd_benes) |> 
  gluedown::md_table()
```

| year | month    | state | aged_tot_benes | aged_esrd_benes | aged_no_esrd_benes | dsbld_tot_benes | dsbld_esrd_and_esrd_only_benes | dsbld_no_esrd_benes |
|-----:|:---------|:------|---------------:|----------------:|-------------------:|----------------:|-------------------------------:|--------------------:|
| 2022 | January  | GA    |        1572257 |           11635 |            1560622 |          258702 |                          12011 |              246691 |
| 2022 | February | GA    |        1571050 |           11312 |            1559738 |          258975 |                          11905 |              247070 |
| 2022 | March    | GA    |        1572037 |           11096 |            1560941 |          259536 |                          11853 |              247683 |
| 2022 | April    | GA    |        1573058 |           10888 |            1562170 |          260077 |                          11835 |              248242 |
| 2022 | May      | GA    |        1574570 |           10716 |            1563854 |          260617 |                          11827 |              248790 |
| 2022 | June     | GA    |        1575954 |           10525 |            1565429 |          261440 |                          11790 |              249650 |
| 2022 | July     | GA    |        1578129 |           10368 |            1567761 |          261999 |                          11713 |              250286 |

``` r
ga_bene |> 
  dplyr::select(year, 
                month, 
                state = bene_state_abrvtn, 
                dsbld_tot_benes:dsbld_no_esrd_benes) |> 
  gluedown::md_table()
```

| year | month    | state | dsbld_tot_benes | dsbld_esrd_and_esrd_only_benes | dsbld_no_esrd_benes |
|-----:|:---------|:------|----------------:|-------------------------------:|--------------------:|
| 2022 | January  | GA    |          258702 |                          12011 |              246691 |
| 2022 | February | GA    |          258975 |                          11905 |              247070 |
| 2022 | March    | GA    |          259536 |                          11853 |              247683 |
| 2022 | April    | GA    |          260077 |                          11835 |              248242 |
| 2022 | May      | GA    |          260617 |                          11827 |              248790 |
| 2022 | June     | GA    |          261440 |                          11790 |              249650 |
| 2022 | July     | GA    |          261999 |                          11713 |              250286 |

<br>

### Medicare Order and Referring API

``` r
provider::order_refer(npi = 1083879860)
```

| name       | value       |
|:-----------|:------------|
| npi        | 1083879860  |
| last_name  | AARON       |
| first_name | CHRISTOPHER |
| partb      | TRUE        |
| dme        | TRUE        |
| hha        | TRUE        |
| pmd        | TRUE        |

<br>

### Medicare Opt-Out Affidavits API

``` r
provider::opt_out(last = "Aaron")
```

| name                        | value                  |
|:----------------------------|:-----------------------|
| date                        | 2022-12-19             |
| last_updated                | 09/15/2022             |
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
| eligible_to_order_and_refer | N                      |

<br>

### Medicare Provider and Supplier Taxonomy Crosswalk API

``` r
provider::taxonomy_crosswalk(specialty_desc = "Rehabilitation Agency")
```

| specialty_code | specialty_description | provider_taxonomy_code | provider_taxonomy_desc                                         |
|:---------------|:----------------------|:-----------------------|:---------------------------------------------------------------|
| B4\[14\]       | Rehabilitation Agency | 261QR0400X             | Ambulatory Health Care Facilities/Clinic/Center Rehabilitation |
| B4\[14\]       | Rehabilitation Agency | 315D00000X             | Nursing & Custodial Care Facilities/Hospice Inpatient          |

<br>

### Medicare Revalidation Due Date API

``` r
provider::revalidation_date(npi = 1710912209)
```

| name                            | value           |
|:--------------------------------|:----------------|
| month                           | 2022-12-19      |
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

<br>

### Medicare Revalidation Clinic Group Practice Reassignment API

``` r
provider::revalidation_group(ind_npi = 1710912209)
```

| name                                   | value           |
|:---------------------------------------|:----------------|
| individual_enrollment_id               | I20040602001711 |
| individual_npi                         | 1710912209      |
| individual_first_name                  | Yelena          |
| individual_last_name                   | Voronova        |
| individual_state_code                  | NY              |
| individual_specialty_description       | Podiatry        |
| individual_due_date                    | 10/31/2019      |
| individual_total_employer_associations | 5               |
| record_type                            | Reassignment    |

| name                                         | value                                           |
|:---------------------------------------------|:------------------------------------------------|
| group_pac_id                                 | 3678655222                                      |
| group_enrollment_id                          | O20080205000002                                 |
| group_legal_business_name                    | \#1 Wise Podiatry Care P.C.                     |
| group_state_code                             | NY                                              |
| group_due_date                               | 10/31/2019                                      |
| group_reassignments_and_physician_assistants | 1                                               |
| group_pac_id                                 | 9931511052                                      |
| group_enrollment_id                          | O20201215000955                                 |
| group_legal_business_name                    | Brighton Beach Podiatry Pllc                    |
| group_state_code                             | NY                                              |
| group_due_date                               | TBD                                             |
| group_reassignments_and_physician_assistants | 1                                               |
| group_pac_id                                 | 2062791411                                      |
| group_enrollment_id                          | O20161108001365                                 |
| group_legal_business_name                    | Fair Podiatry Practice Pllc                     |
| group_state_code                             | NY                                              |
| group_due_date                               | TBD                                             |
| group_reassignments_and_physician_assistants | 1                                               |
| group_pac_id                                 | 8527313170                                      |
| group_enrollment_id                          | O20180622000028                                 |
| group_legal_business_name                    | New York Jewish American Podiatry Practice Pllc |
| group_state_code                             | NY                                              |
| group_due_date                               | TBD                                             |
| group_reassignments_and_physician_assistants | 1                                               |
| group_pac_id                                 | 5193155174                                      |
| group_enrollment_id                          | O20200414003240                                 |
| group_legal_business_name                    | Podiatry Of Brooklyn Pllc                       |
| group_state_code                             | NY                                              |
| group_due_date                               | TBD                                             |
| group_reassignments_and_physician_assistants | 1                                               |

<br>

### CMS Public Reporting of Missing Digital Contact Information API

``` r
provider::missing_information(npi = 1144224569)
```

| npi        | last_name | first_name |
|:-----------|:----------|:-----------|
| 1144224569 | Clouse    | John       |

<br>

### Medicare Physician & Other Practitioners APIs

> 1.  by Provider and Service API:

``` r
purrr::map_dfr(2013:2020, 
      ~physician_by_service(npi = 1003000126, year = .x))
```

| npi        | year | tot_benes | tot_srvcs | avg_sbmtd_chrg | avg_allowed | avg_pymt |
|:-----------|-----:|----------:|----------:|---------------:|------------:|---------:|
| 1003000126 | 2013 |      1112 |      1607 |         270.95 |      101.51 |    80.61 |
| 1003000126 | 2014 |      1748 |      2728 |         361.07 |      119.61 |    93.50 |
| 1003000126 | 2015 |      1767 |      2751 |         365.43 |      114.19 |    89.82 |
| 1003000126 | 2016 |      1007 |      1450 |         587.63 |      121.90 |    96.25 |
| 1003000126 | 2017 |      1088 |      1637 |         620.50 |      129.92 |   102.21 |
| 1003000126 | 2018 |       852 |      1192 |         676.98 |      124.04 |    98.62 |
| 1003000126 | 2019 |       969 |      1367 |         420.85 |      126.46 |   100.82 |
| 1003000126 | 2020 |       488 |       738 |         631.54 |      118.24 |    94.48 |

> 2.  by Geography and Service API:

``` r
physician_by_service(npi = 1003000126, year = 2020)
```

| year | level      | hcpcs_cd | tot_benes | tot_srvcs | avg_charge | avg_allowed |  avg_pymt |
|-----:|:-----------|:---------|----------:|----------:|-----------:|------------:|----------:|
| 2020 | Individual | 99217    |        23 |        23 |   406.1739 |    76.80391 |  61.40174 |
| 2020 | Individual | 99218    |        16 |        16 |   811.8125 |   108.24938 |  85.08125 |
| 2020 | Individual | 99220    |        16 |        16 |  1150.9375 |   191.96062 | 152.37688 |
| 2020 | Individual | 99221    |        12 |        12 |   681.6667 |   110.04750 |  82.23750 |
| 2020 | Individual | 99223    |        52 |        52 |  1108.3846 |   209.42385 | 170.83462 |
| 2020 | Individual | 99232    |        57 |       134 |   251.3284 |    73.45470 |  57.95582 |
| 2020 | Individual | 99233    |       154 |       326 |   513.2117 |   108.84687 |  88.94589 |
| 2020 | Individual | 99238    |        13 |        13 |   268.4615 |    74.15769 |  60.53308 |
| 2020 | Individual | 99239    |       145 |       146 |   491.8699 |   111.25979 |  90.92384 |

``` r
hcpcs <- physician_by_service(npi = 1003000126, year = 2020)

purrr::map_dfr(hcpcs$hcpcs_cd, 
               ~physician_by_geography(geo_level = "National", 
                                       year = 2020, 
                                       hcpcs_code = .x))
```

| year | level    | hcpcs_cd | tot_benes | tot_srvcs | avg_charge | avg_allowed |  avg_pymt |
|-----:|:---------|:---------|----------:|----------:|-----------:|------------:|----------:|
| 2020 | National | 99217    |    960315 |   1083287 |   226.5243 |    71.85383 |  56.39061 |
| 2020 | National | 99218    |    107097 |    113741 |   279.0389 |    99.76702 |  77.72797 |
| 2020 | National | 99220    |   1057367 |   1251727 |   602.4899 |   184.34005 | 144.10759 |
| 2020 | National | 99221    |   1095114 |   1469013 |   262.3614 |   101.74503 |  79.93905 |
| 2020 | National | 99223    |   3820713 |   9472774 |   502.2729 |   204.68211 | 161.39257 |
| 2020 | National | 99232    |   3982972 |  39627779 |   175.3005 |    72.96044 |  58.10423 |
| 2020 | National | 99233    |   3338934 |  24561011 |   282.3940 |   105.81724 |  84.56269 |
| 2020 | National | 99238    |   1561729 |   1996528 |   188.4993 |    73.12491 |  57.87497 |
| 2020 | National | 99239    |   3093233 |   4564152 |   310.6096 |   107.56667 |  85.47697 |

``` r
hcpcs <- physician_by_service(npi = 1003000126, year = 2020)

purrr::map_dfr(hcpcs$hcpcs_cd, 
               ~physician_by_geography(geo_desc = "Maryland", 
                                       year = 2020, 
                                       hcpcs_code = .x))
```

| year | level    | hcpcs_cd | tot_benes | tot_srvcs | avg_charge | avg_allowed |  avg_pymt |
|-----:|:---------|:---------|----------:|----------:|-----------:|------------:|----------:|
| 2020 | Maryland | 99217    |     31433 |     35505 |   300.8633 |    73.32784 |  57.82643 |
| 2020 | Maryland | 99218    |      3847 |      4042 |   377.2237 |   102.47521 |  80.32934 |
| 2020 | Maryland | 99220    |     41984 |     49557 |   761.2434 |   188.95922 | 147.87499 |
| 2020 | Maryland | 99221    |     26136 |     32153 |   269.1815 |   106.16173 |  83.30873 |
| 2020 | Maryland | 99223    |     98672 |    183066 |   556.9738 |   211.89818 | 166.53387 |
| 2020 | Maryland | 99232    |    104865 |    634904 |   176.7973 |    75.67333 |  60.11680 |
| 2020 | Maryland | 99233    |    102804 |    508985 |   338.0418 |   109.47410 |  87.22652 |
| 2020 | Maryland | 99238    |     19248 |     21567 |   207.3356 |    76.11991 |  60.27566 |
| 2020 | Maryland | 99239    |     77391 |     99591 |   367.9219 |   111.66222 |  88.69363 |

> 3.  by Provider API:

``` r
physician_by_provider(npi = 1003000126)
```

| name                          | value                                                                               |
|:------------------------------|:------------------------------------------------------------------------------------|
| year                          | 2020                                                                                |
| rndrng_npi                    | 1003000126                                                                          |
| rndrng_prvdr_last_org_name    | Enkeshafi                                                                           |
| rndrng_prvdr_first_name       | Ardalan                                                                             |
| rndrng_prvdr_mi               |                                                                                     |
| rndrng_prvdr_crdntls          | M.D.                                                                                |
| rndrng_prvdr_gndr             | M                                                                                   |
| rndrng_prvdr_ent_cd           | I                                                                                   |
| rndrng_prvdr_st1              | 6410 Rockledge Dr Ste 304                                                           |
| rndrng_prvdr_st2              |                                                                                     |
| rndrng_prvdr_city             | Bethesda                                                                            |
| rndrng_prvdr_state_abrvtn     | MD                                                                                  |
| rndrng_prvdr_state_fips       | 24                                                                                  |
| rndrng_prvdr_zip5             | 20817                                                                               |
| rndrng_prvdr_ruca             | 1                                                                                   |
| rndrng_prvdr_ruca_desc        | Metropolitan area core: primary flow within an urbanized area of 50,000 and greater |
| rndrng_prvdr_cntry            | US                                                                                  |
| rndrng_prvdr_type             | Internal Medicine                                                                   |
| rndrng_prvdr_mdcr_prtcptg_ind | Y                                                                                   |
| tot_hcpcs_cds                 | 16                                                                                  |
| tot_benes                     | 291                                                                                 |
| tot_srvcs                     | 764                                                                                 |
| tot_sbmtd_chrg                | 402812                                                                              |
| tot_mdcr_alowd_amt            | 85319.63                                                                            |
| tot_mdcr_pymt_amt             | 69175.78                                                                            |
| tot_mdcr_stdzd_amt            | 66401.61                                                                            |
| drug_sprsn_ind                |                                                                                     |
| drug_tot_hcpcs_cds            | 0                                                                                   |
| drug_tot_benes                | 0                                                                                   |
| drug_tot_srvcs                | 0                                                                                   |
| drug_sbmtd_chrg               | 0                                                                                   |
| drug_mdcr_alowd_amt           | 0                                                                                   |
| drug_mdcr_pymt_amt            | 0                                                                                   |
| drug_mdcr_stdzd_amt           | 0                                                                                   |
| med_sprsn_ind                 |                                                                                     |
| med_tot_hcpcs_cds             | 16                                                                                  |
| med_tot_benes                 | 291                                                                                 |
| med_tot_srvcs                 | 764                                                                                 |
| med_sbmtd_chrg                | 402812                                                                              |
| med_mdcr_alowd_amt            | 85319.63                                                                            |
| med_mdcr_pymt_amt             | 69175.78                                                                            |
| med_mdcr_stdzd_amt            | 66401.61                                                                            |
| bene_avg_age                  | 77                                                                                  |
| bene_age_lt_65_cnt            | 27                                                                                  |
| bene_age_65_74_cnt            | 88                                                                                  |
| bene_age_75_84_cnt            | 104                                                                                 |
| bene_age_gt_84_cnt            | 72                                                                                  |
| bene_feml_cnt                 | 161                                                                                 |
| bene_male_cnt                 | 130                                                                                 |
| bene_race_wht_cnt             | 210                                                                                 |
| bene_race_black_cnt           | 50                                                                                  |
| bene_race_api_cnt             |                                                                                     |
| bene_race_hspnc_cnt           | 12                                                                                  |
| bene_race_nat_ind_cnt         |                                                                                     |
| bene_race_othr_cnt            |                                                                                     |
| bene_dual_cnt                 | 61                                                                                  |
| bene_ndual_cnt                | 230                                                                                 |
| bene_cc_af_pct                | 0.31                                                                                |
| bene_cc_alzhmr_pct            | 0.43                                                                                |
| bene_cc_asthma_pct            | 0.15                                                                                |
| bene_cc_cncr_pct              | 0.18                                                                                |
| bene_cc_chf_pct               | 0.48                                                                                |
| bene_cc_ckd_pct               | 0.65                                                                                |
| bene_cc_copd_pct              | 0.29                                                                                |
| bene_cc_dprssn_pct            | 0.35                                                                                |
| bene_cc_dbts_pct              | 0.47                                                                                |
| bene_cc_hyplpdma_pct          | 0.73                                                                                |
| bene_cc_hyprtnsn_pct          | 0.75                                                                                |
| bene_cc_ihd_pct               | 0.66                                                                                |
| bene_cc_opo_pct               | 0.11                                                                                |
| bene_cc_raoa_pct              | 0.51                                                                                |
| bene_cc_sz_pct                | 0.09                                                                                |
| bene_cc_strok_pct             | 0.19                                                                                |
| bene_avg_risk_scre            | 2.5028                                                                              |

------------------------------------------------------------------------

## Code of Conduct

Please note that the provider project is released with a [Contributor
Code of
Conduct](https://andrewallenbruce.github.io/provider/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
