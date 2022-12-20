
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
nppes <- tibble::tribble(
~fn,         ~params,
"nppes_npi", list(npi = 1336413418),
"nppes_npi", list(npi = 1659781227),
"nppes_npi", list(prov_type = "NPI-2", city = "Baltimore", state = "MD", limit = 5),
"nppes_npi", list(prov_type = "NPI-1", city = "Atlanta", state = "GA", limit = 5),
)

purrr::invoke_map_dfr(nppes$fn, nppes$params)
#> # A tibble: 12 × 17
#>    datetime            outcome enumer…¹ number name  city  state addre…² pract…³
#>    <dttm>              <chr>   <chr>    <chr>  <chr> <chr> <chr> <list>  <list> 
#>  1 2022-12-19 20:50:26 results NPI-2    13364… LUMI… TIFT… GA    <df>    <list> 
#>  2 2022-12-19 20:50:27 Errors  <NA>     <NA>   <NA>  <NA>  <NA>  <NULL>  <NULL> 
#>  3 2022-12-19 20:50:27 results NPI-2    14271… MCGU… BALT… MD    <df>    <list> 
#>  4 2022-12-19 20:50:27 results NPI-2    18818… MENL… BALT… MD    <df>    <list> 
#>  5 2022-12-19 20:50:27 results NPI-2    16999… MILF… BALT… MD    <df>    <list> 
#>  6 2022-12-19 20:50:27 results NPI-2    12756… VIRG… BALT… MD    <df>    <list> 
#>  7 2022-12-19 20:50:27 results NPI-2    17100… VIRG… BALT… MD    <df>    <list> 
#>  8 2022-12-19 20:50:27 results NPI-1    10837… KIMB… AUST… GA    <df>    <list> 
#>  9 2022-12-19 20:50:27 results NPI-1    10130… BART… ATLA… GA    <df>    <list> 
#> 10 2022-12-19 20:50:27 results NPI-1    16699… DERE… ATLA… GA    <df>    <list> 
#> 11 2022-12-19 20:50:27 results NPI-1    17706… SARA… ATLA… GA    <df>    <list> 
#> 12 2022-12-19 20:50:27 results NPI-1    18012… CHER… ALPH… GA    <df>    <list> 
#> # … with 8 more variables: taxonomies <list>, identifiers <list>,
#> #   endpoints <list>, other_names <list>, epochs <list>,
#> #   authorized_official <list>, basic <list>, errors <list>, and abbreviated
#> #   variable names ¹​enumeration_type, ²​addresses, ³​practiceLocations
```

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
#> # A tibble: 3 × 11
#>   npi    pecos…¹ enrlm…² provi…³ provi…⁴ state…⁵ first…⁶ mdl_n…⁷ last_…⁸ org_n…⁹
#>   <chr>  <chr>   <chr>   <chr>   <chr>   <chr>   <chr>   <chr>   <chr>   <chr>  
#> 1 10838… 842632… I20200… 14-08   PRACTI… PA      "CHRIS… "L"     "AARON" ""     
#> 2 19321… 418353… I20031… 14-13   PRACTI… MD      "MICHA… "K"     "GREEN… ""     
#> 3 13364… 135550… O20120… 12-69   PART B… GA      ""      ""      ""      "LUMIN…
#> # … with 1 more variable: gndr_sw <chr>, and abbreviated variable names
#> #   ¹​pecos_asct_cntl_id, ²​enrlmt_id, ³​provider_type_cd, ⁴​provider_type_desc,
#> #   ⁵​state_cd, ⁶​first_name, ⁷​mdl_name, ⁸​last_name, ⁹​org_name
```

<br>

### Medicare Monthly Enrollment API

``` r
months <- tibble::enframe(month.name) |> 
  dplyr::select(-name) |> 
  dplyr::slice(1:7) |> 
  tibble::deframe()

purrr::map_dfr(months, ~beneficiary_enrollment(year = 2022, 
                                               geo_level = "State", 
                                               state = "Georgia", 
                                               month = .x))
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
```

<br>

### Medicare Order and Referring API

``` r
provider::order_refer(npi = 1083879860)
#> # A tibble: 1 × 7
#>          npi last_name first_name  partb dme   hha   pmd  
#>        <int> <chr>     <chr>       <lgl> <lgl> <lgl> <lgl>
#> 1 1083879860 AARON     CHRISTOPHER TRUE  TRUE  TRUE  TRUE
```

<br>

### Medicare Opt-Out Affidavits API

``` r
provider::opt_out(last = "Aaron")
#> # A tibble: 1 × 14
#>   date       last_updated first_…¹ last_…² npi   speci…³ optou…⁴ optou…⁵ first…⁶
#>   <date>     <chr>        <chr>    <chr>   <chr> <chr>   <chr>   <chr>   <chr>  
#> 1 2022-12-20 09/15/2022   Sheryl   Aaron   1427… Clinic… 02/17/… 02/17/… 1633 Q…
#> # … with 5 more variables: second_line_street_address <chr>, city_name <chr>,
#> #   state_code <chr>, zip_code <chr>, eligible_to_order_and_refer <chr>, and
#> #   abbreviated variable names ¹​first_name, ²​last_name, ³​specialty,
#> #   ⁴​optout_effective_date, ⁵​optout_end_date, ⁶​first_line_street_address
```

<br>

### Medicare Provider and Supplier Taxonomy Crosswalk API

``` r
provider::taxonomy_crosswalk(specialty_desc = "Rehabilitation Agency")
#> # A tibble: 2 × 4
#>   medicare_specialty_code medicare_provider_supplier_type_desc…¹ provi…² provi…³
#>   <chr>                   <chr>                                  <chr>   <chr>  
#> 1 B4[14]                  Rehabilitation Agency                  261QR0… Ambula…
#> 2 B4[14]                  Rehabilitation Agency                  315D00… Nursin…
#> # … with abbreviated variable names
#> #   ¹​medicare_provider_supplier_type_description, ²​provider_taxonomy_code,
#> #   ³​provider_taxonomy_description_type_classification_specialization
```

<br>

### Medicare Revalidation Due Date API

``` r
provider::revalidation_date(npi = 1710912209)
#> # A tibble: 1 × 14
#>   month      enrollmen…¹ natio…² first…³ last_…⁴ organ…⁵ enrol…⁶ enrol…⁷ provi…⁸
#>   <date>     <chr>       <chr>   <chr>   <chr>   <chr>   <chr>   <chr>   <chr>  
#> 1 2022-12-20 I200406020… 171091… Yelena  Vorono… ""      NY      3       Non-DM…
#> # … with 5 more variables: enrollment_specialty <chr>,
#> #   revalidation_due_date <chr>, adjusted_due_date <chr>,
#> #   individual_total_reassign_to <chr>, receiving_benefits_reassignment <int>,
#> #   and abbreviated variable names ¹​enrollment_id,
#> #   ²​national_provider_identifier, ³​first_name, ⁴​last_name, ⁵​organization_name,
#> #   ⁶​enrollment_state_code, ⁷​enrollment_type, ⁸​provider_type_text
```

<br>

### Medicare Revalidation Clinic Group Practice Reassignment API

``` r
provider::revalidation_group(ind_npi = 1710912209)
#> # A tibble: 5 × 16
#>   month      group_pac…¹ group…² group…³ group…⁴ group…⁵ group…⁶ recor…⁷ indiv…⁸
#>   <date>           <dbl> <chr>   <chr>   <chr>   <chr>     <int> <chr>   <chr>  
#> 1 2022-12-20  3678655222 O20080… #1 Wis… NY      10/31/…       1 Reassi… I20040…
#> 2 2022-12-20  9931511052 O20201… Bright… NY      TBD           1 Reassi… I20040…
#> 3 2022-12-20  2062791411 O20161… Fair P… NY      TBD           1 Reassi… I20040…
#> 4 2022-12-20  8527313170 O20180… New Yo… NY      TBD           1 Reassi… I20040…
#> 5 2022-12-20  5193155174 O20200… Podiat… NY      TBD           1 Reassi… I20040…
#> # … with 7 more variables: individual_npi <int>, individual_first_name <chr>,
#> #   individual_last_name <chr>, individual_state_code <chr>,
#> #   individual_specialty_description <chr>, individual_due_date <chr>,
#> #   individual_total_employer_associations <int>, and abbreviated variable
#> #   names ¹​group_pac_id, ²​group_enrollment_id, ³​group_legal_business_name,
#> #   ⁴​group_state_code, ⁵​group_due_date,
#> #   ⁶​group_reassignments_and_physician_assistants, ⁷​record_type, …
```

<br>

### CMS Public Reporting of Missing Digital Contact Information API

``` r
provider::missing_information(npi = 1144224569)
#> # A tibble: 1 × 3
#>   npi        last_name first_name
#>   <chr>      <chr>     <chr>     
#> 1 1144224569 Clouse    John
```

<br>

### Medicare Physician & Other Practitioners APIs

<br>

> 1.  by Provider and Service API:

<br>

``` r
purrr::map_dfr(2013:2020, ~physician_by_service(npi = 1003000126, year = .x))
#> # A tibble: 78 × 30
#>     year rndrn…¹ rndrn…² rndrn…³ rndrn…⁴ rndrn…⁵ rndrn…⁶ rndrn…⁷ rndrn…⁸ rndrn…⁹
#>    <int> <chr>   <chr>   <chr>   <chr>   <chr>   <chr>   <chr>   <chr>   <chr>  
#>  1  2013 100300… Enkesh… Ardalan ""      M.D.    M       I       900 Se… ""     
#>  2  2013 100300… Enkesh… Ardalan ""      M.D.    M       I       900 Se… ""     
#>  3  2013 100300… Enkesh… Ardalan ""      M.D.    M       I       900 Se… ""     
#>  4  2013 100300… Enkesh… Ardalan ""      M.D.    M       I       900 Se… ""     
#>  5  2013 100300… Enkesh… Ardalan ""      M.D.    M       I       900 Se… ""     
#>  6  2013 100300… Enkesh… Ardalan ""      M.D.    M       I       900 Se… ""     
#>  7  2013 100300… Enkesh… Ardalan ""      M.D.    M       I       900 Se… ""     
#>  8  2014 100300… Enkesh… Ardalan ""      M.D.    M       I       900 Se… ""     
#>  9  2014 100300… Enkesh… Ardalan ""      M.D.    M       I       900 Se… ""     
#> 10  2014 100300… Enkesh… Ardalan ""      M.D.    M       I       900 Se… ""     
#> # … with 68 more rows, 20 more variables: rndrng_prvdr_city <chr>,
#> #   rndrng_prvdr_state_abrvtn <chr>, rndrng_prvdr_state_fips <chr>,
#> #   rndrng_prvdr_zip5 <chr>, rndrng_prvdr_ruca <chr>,
#> #   rndrng_prvdr_ruca_desc <chr>, rndrng_prvdr_cntry <chr>,
#> #   rndrng_prvdr_type <chr>, rndrng_prvdr_mdcr_prtcptg_ind <chr>,
#> #   hcpcs_cd <chr>, hcpcs_desc <chr>, hcpcs_drug_ind <chr>,
#> #   place_of_srvc <chr>, tot_benes <int>, tot_srvcs <int>, …
```

<br>

> 2.  by Geography and Service API:

<br>

``` r
service <- physician_by_service(npi = 1003000126, year = 2020)

purrr::map_dfr(service$hcpcs_cd, ~physician_by_geography(geo_level = "National", year = 2020, hcpcs_code = .x))
#> # A tibble: 18 × 16
#>     year rndrn…¹ rndrn…² rndrn…³ hcpcs…⁴ hcpcs…⁵ hcpcs…⁶ place…⁷ tot_r…⁸ tot_b…⁹
#>    <dbl> <chr>   <chr>   <chr>   <chr>   <chr>   <chr>   <chr>     <int>   <int>
#>  1  2020 Nation… ""      Nation… 99217   Hospit… N       F         90842  960315
#>  2  2020 Nation… ""      Nation… 99217   Hospit… N       O           693    3650
#>  3  2020 Nation… ""      Nation… 99218   Hospit… N       F         37219  107097
#>  4  2020 Nation… ""      Nation… 99218   Hospit… N       O           250     433
#>  5  2020 Nation… ""      Nation… 99220   Hospit… N       F         88585 1057367
#>  6  2020 Nation… ""      Nation… 99220   Hospit… N       O           807    4043
#>  7  2020 Nation… ""      Nation… 99221   Initia… N       F        170573 1095114
#>  8  2020 Nation… ""      Nation… 99221   Initia… N       O           542    1250
#>  9  2020 Nation… ""      Nation… 99223   Initia… N       F        243208 3820713
#> 10  2020 Nation… ""      Nation… 99223   Initia… N       O          1540    5666
#> 11  2020 Nation… ""      Nation… 99232   Subseq… N       F        298435 3982972
#> 12  2020 Nation… ""      Nation… 99232   Subseq… N       O          2894   12875
#> 13  2020 Nation… ""      Nation… 99233   Subseq… N       F        241646 3338934
#> 14  2020 Nation… ""      Nation… 99233   Subseq… N       O          2006    7191
#> 15  2020 Nation… ""      Nation… 99238   Hospit… N       F        124642 1561729
#> 16  2020 Nation… ""      Nation… 99238   Hospit… N       O           407    1773
#> 17  2020 Nation… ""      Nation… 99239   Hospit… N       F        105545 3093233
#> 18  2020 Nation… ""      Nation… 99239   Hospit… N       O           603    1737
#> # … with 6 more variables: tot_srvcs <dbl>, tot_bene_day_srvcs <int>,
#> #   avg_sbmtd_chrg <dbl>, avg_mdcr_alowd_amt <dbl>, avg_mdcr_pymt_amt <dbl>,
#> #   avg_mdcr_stdzd_amt <dbl>, and abbreviated variable names
#> #   ¹​rndrng_prvdr_geo_lvl, ²​rndrng_prvdr_geo_cd, ³​rndrng_prvdr_geo_desc,
#> #   ⁴​hcpcs_cd, ⁵​hcpcs_desc, ⁶​hcpcs_drug_ind, ⁷​place_of_srvc,
#> #   ⁸​tot_rndrng_prvdrs, ⁹​tot_benes

purrr::map_dfr(service$hcpcs_cd, ~physician_by_geography(geo_desc = "Maryland", year = 2020, hcpcs_code = .x))
#> # A tibble: 15 × 16
#>     year rndrn…¹ rndrn…² rndrn…³ hcpcs…⁴ hcpcs…⁵ hcpcs…⁶ place…⁷ tot_r…⁸ tot_b…⁹
#>    <dbl> <chr>   <chr>   <chr>   <chr>   <chr>   <chr>   <chr>     <int>   <int>
#>  1  2020 State   24      Maryla… 99217   Hospit… N       F          1523   31433
#>  2  2020 State   24      Maryla… 99218   Hospit… N       F           785    3847
#>  3  2020 State   24      Maryla… 99220   Hospit… N       F          1795   41984
#>  4  2020 State   24      Maryla… 99221   Initia… N       F          3498   26136
#>  5  2020 State   24      Maryla… 99221   Initia… N       O            46      77
#>  6  2020 State   24      Maryla… 99223   Initia… N       F          4803   98672
#>  7  2020 State   24      Maryla… 99223   Initia… N       O            59     103
#>  8  2020 State   24      Maryla… 99232   Subseq… N       F          5942  104865
#>  9  2020 State   24      Maryla… 99232   Subseq… N       O            89     137
#> 10  2020 State   24      Maryla… 99233   Subseq… N       F          5032  102804
#> 11  2020 State   24      Maryla… 99233   Subseq… N       O            74     108
#> 12  2020 State   24      Maryla… 99238   Hospit… N       F          2039   19248
#> 13  2020 State   24      Maryla… 99238   Hospit… N       O            11      12
#> 14  2020 State   24      Maryla… 99239   Hospit… N       F          2146   77391
#> 15  2020 State   24      Maryla… 99239   Hospit… N       O            12      13
#> # … with 6 more variables: tot_srvcs <int>, tot_bene_day_srvcs <int>,
#> #   avg_sbmtd_chrg <dbl>, avg_mdcr_alowd_amt <dbl>, avg_mdcr_pymt_amt <dbl>,
#> #   avg_mdcr_stdzd_amt <dbl>, and abbreviated variable names
#> #   ¹​rndrng_prvdr_geo_lvl, ²​rndrng_prvdr_geo_cd, ³​rndrng_prvdr_geo_desc,
#> #   ⁴​hcpcs_cd, ⁵​hcpcs_desc, ⁶​hcpcs_drug_ind, ⁷​place_of_srvc,
#> #   ⁸​tot_rndrng_prvdrs, ⁹​tot_benes
```

<br>

> 3.  by Provider API:

<br>

``` r
physician_by_provider(npi = 1003000126)
#> # A tibble: 1 × 74
#>    year rndrng…¹ rndrn…² rndrn…³ rndrn…⁴ rndrn…⁵ rndrn…⁶ rndrn…⁷ rndrn…⁸ rndrn…⁹
#>   <dbl> <chr>    <chr>   <chr>   <chr>   <chr>   <chr>   <chr>   <chr>   <chr>  
#> 1  2020 1003000… Enkesh… Ardalan ""      M.D.    M       I       6410 R… ""     
#> # … with 64 more variables: rndrng_prvdr_city <chr>,
#> #   rndrng_prvdr_state_abrvtn <chr>, rndrng_prvdr_state_fips <chr>,
#> #   rndrng_prvdr_zip5 <chr>, rndrng_prvdr_ruca <chr>,
#> #   rndrng_prvdr_ruca_desc <chr>, rndrng_prvdr_cntry <chr>,
#> #   rndrng_prvdr_type <chr>, rndrng_prvdr_mdcr_prtcptg_ind <chr>,
#> #   tot_hcpcs_cds <chr>, tot_benes <int>, tot_srvcs <int>,
#> #   tot_sbmtd_chrg <int>, tot_mdcr_alowd_amt <dbl>, tot_mdcr_pymt_amt <dbl>, …
```

<br>

### Medicare Multiple Chronic Conditions API

``` r
cc_multiple(year = 2007, geo_lvl = "National", demo_lvl = "Race")
#> # A tibble: 60 × 13
#>     year bene_g…¹ bene_…² bene_…³ bene_…⁴ bene_…⁵ bene_…⁶ bene_…⁷ prvlnc tot_m…⁸
#>    <dbl> <chr>    <chr>   <chr>   <chr>   <chr>   <chr>   <chr>    <dbl>   <dbl>
#>  1  2007 National Nation… ""      65+     Race    Asian … 0 to 1   0.327   1033.
#>  2  2007 National Nation… ""      65+     Race    Asian … 2 to 3   0.344   3280.
#>  3  2007 National Nation… ""      65+     Race    Asian … 4 to 5   0.221   7689.
#>  4  2007 National Nation… ""      65+     Race    Asian … 6+       0.108  23479.
#>  5  2007 National Nation… ""      65+     Race    Hispan… 0 to 1   0.330   1048.
#>  6  2007 National Nation… ""      65+     Race    Hispan… 2 to 3   0.284   4241.
#>  7  2007 National Nation… ""      65+     Race    Hispan… 4 to 5   0.226   9788.
#>  8  2007 National Nation… ""      65+     Race    Hispan… 6+       0.160  29290.
#>  9  2007 National Nation… ""      65+     Race    Native… 0 to 1   0.324   1356.
#> 10  2007 National Nation… ""      65+     Race    Native… 2 to 3   0.323   4742.
#> # … with 50 more rows, 3 more variables: tot_mdcr_pymt_pc <dbl>,
#> #   hosp_readmsn_rate <dbl>, er_visits_per_1000_benes <dbl>, and abbreviated
#> #   variable names ¹​bene_geo_lvl, ²​bene_geo_desc, ³​bene_geo_cd, ⁴​bene_age_lvl,
#> #   ⁵​bene_demo_lvl, ⁶​bene_demo_desc, ⁷​bene_mcc, ⁸​tot_mdcr_stdzd_pymt_pc
```

<br>

### Medicare Specific Chronic Conditions API

``` r
cc_specific(year = 2007, geo_lvl = "National", demo_lvl = "Race")
#> # A tibble: 315 × 13
#>     year bene_g…¹ bene_…² bene_…³ bene_…⁴ bene_…⁵ bene_…⁶ bene_…⁷ prvlnc tot_m…⁸
#>    <dbl> <chr>    <chr>   <chr>   <chr>   <chr>   <chr>   <chr>   <chr>  <chr>  
#>  1  2007 National Nation… ""      65+     Race    Asian … Alcoho… 0.0036 ""     
#>  2  2007 National Nation… ""      <65     Race    Asian … Alcoho… 0.021  ""     
#>  3  2007 National Nation… ""      All     Race    Asian … Alcoho… 0.0057 ""     
#>  4  2007 National Nation… ""      65+     Race    Hispan… Alcoho… 0.0107 ""     
#>  5  2007 National Nation… ""      <65     Race    Hispan… Alcoho… 0.0383 ""     
#>  6  2007 National Nation… ""      All     Race    Hispan… Alcoho… 0.0178 ""     
#>  7  2007 National Nation… ""      65+     Race    Native… Alcoho… 0.0288 ""     
#>  8  2007 National Nation… ""      <65     Race    Native… Alcoho… 0.08   ""     
#>  9  2007 National Nation… ""      All     Race    Native… Alcoho… 0.0453 ""     
#> 10  2007 National Nation… ""      65+     Race    non-Hi… Alcoho… 0.0148 ""     
#> # … with 305 more rows, 3 more variables: tot_mdcr_pymt_pc <chr>,
#> #   hosp_readmsn_rate <chr>, er_visits_per_1000_benes <chr>, and abbreviated
#> #   variable names ¹​bene_geo_lvl, ²​bene_geo_desc, ³​bene_geo_cd, ⁴​bene_age_lvl,
#> #   ⁵​bene_demo_lvl, ⁶​bene_demo_desc, ⁷​bene_cond, ⁸​tot_mdcr_stdzd_pymt_pc
```

<br>

------------------------------------------------------------------------

## Code of Conduct

Please note that the provider project is released with a [Contributor
Code of
Conduct](https://andrewallenbruce.github.io/provider/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
