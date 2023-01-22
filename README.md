
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

> **Info**  
> The Windows installer modifes your PATH. When using Windows Terminal,
> you will need to **open a new window** for the changes to take affect.
> (Simply opening a new tab will *not* be sufficient.)

``` r
nppes_npi(npi = 1710975040) # NPI-1
```

# A tibble: 1 × 15

datetime outcome enumera…¹ number name city state addre…² pract…³ <dttm>
<chr> <chr> <chr> <chr> <chr> <chr> <list> <list> 1 2023-01-22 10:19:08
results NPI-1 17109… JOHN… OLNEY MD <df> <list> \# … with 6 more
variables: taxonomies <list>, identifiers <list>, \# endpoints <list>,
other_names <list>, epochs <list>, basic <list>, and \# abbreviated
variable names ¹​enumeration_type, ²​addresses, \# ³​practiceLocations

``` r
nppes_npi(npi = 1336413418) # NPI-2
```

# A tibble: 1 × 16

datetime outcome enumera…¹ number name city state addre…² pract…³ <dttm>
<chr> <chr> <chr> <chr> <chr> <chr> <list> <list> 1 2023-01-22 10:19:08
results NPI-2 13364… LUMI… TIFT… GA <df> <list> \# … with 7 more
variables: taxonomies <list>, identifiers <list>, \# endpoints <list>,
other_names <list>, epochs <list>, \# authorized_official <list>, basic
<list>, and abbreviated variable names \# ¹​enumeration_type, ²​addresses,
³​practiceLocations

``` r
nppes_npi(npi = 1659781227) # Deactivated
```

# A tibble: 1 × 3

datetime outcome errors  
<dttm> <chr> <list>  
1 2023-01-22 10:19:09 Errors \<tibble \[1 × 3\]\>

<br>

## CMS Open Payments API

``` r
open_payments(recipient_npi = 1043218118)
```

    #> # A tibble: 92 × 14
    #>    program…¹ recor…² chang…³ total…⁴ date_of_payment     form_…⁵ natur…⁶ recor…⁷
    #>    <chr>     <chr>   <chr>     <dbl> <dttm>              <chr>   <chr>   <chr>  
    #>  1 2021      1       UNCHAN…  2500   2021-05-26 00:00:00 Cash o… Compen… 754966…
    #>  2 2021      692021  UNCHAN…    69.9 2021-03-04 00:00:00 In-kin… Food a… 787838…
    #>  3 2021      4385936 UNCHAN…   108.  2021-08-24 00:00:00 In-kin… Food a… 797168…
    #>  4 2021      4385946 UNCHAN…    97.1 2021-08-24 00:00:00 In-kin… Food a… 797168…
    #>  5 2021      4385951 UNCHAN…    23.9 2021-09-30 00:00:00 In-kin… Food a… 797168…
    #>  6 2021      4385956 UNCHAN…    25.6 2021-11-10 00:00:00 In-kin… Food a… 797168…
    #>  7 2021      4579206 UNCHAN…    13.8 2021-12-08 00:00:00 In-kin… Food a… 799201…
    #>  8 2021      4579226 UNCHAN…    16.6 2021-04-15 00:00:00 In-kin… Food a… 799201…
    #>  9 2021      4624246 UNCHAN…   114.  2021-05-06 00:00:00 In-kin… Food a… 797710…
    #> 10 2021      4766366 UNCHAN…    14.7 2021-10-06 00:00:00 In-kin… Food a… 797773…
    #> # … with 82 more rows, 6 more variables: covered_recipient <list>,
    #> #   recipient_address <list>, applicable_mfg_gpo <list>,
    #> #   associated_drug_device <list>, payment_related_data <list>,
    #> #   teaching_hospital <list>, and abbreviated variable names ¹​program_year,
    #> #   ²​record_number, ³​change_type, ⁴​total_amount_of_payment_usdollars,
    #> #   ⁵​form_of_payment_or_transfer_of_value,
    #> #   ⁶​nature_of_payment_or_transfer_of_value, ⁷​record_id

<br>

## CMS Missing Digital Contact Information API

``` r
provider::missing_information(npi = 1144224569) |> terse::terse(config = list(ansi = FALSE), width = 100)
```

    #> $npi        c1 1144224569
    #> $last_name  c1 Clouse    
    #> $first_name c1 John

<br>

### Medicare Fee-For-Service Public Provider Enrollment API

``` r
prven <- tibble::tribble(
~fn,         ~params,
"provider_enrollment", list(npi = 1083879860),
"provider_enrollment", list(first_name = "MICHAEL", middle_name = "K", last_name = "GREENBERG", state = "MD"),
"provider_enrollment", list(org_name = "LUMINUS DIAGNOSTICS LLC", state = "GA"),
)

purrr::invoke_map_dfr(prven$fn, prven$params) |> terse::terse(config = list(ansi = FALSE), width = 100)
```

    #> $npi                c3 1083879860                    , 1932192150              , 1336413418     ...
    #> $pecos_asct_cntl_id c3 8426328519                    , 4183536311              , 1355507260     ...
    #> $enrlmt_id          c3 I20200617001010               , I20031105000174         , O2012072300004 ...
    #> $provider_type_cd   c3 14-08                         , 14-13                   , 12-69          ...
    #> $provider_type_desc c3 PRACTITIONER - FAMILY PRACTICE, PRACTITIONER - NEUROLOGY, PART B SUPPLIE ...
    #> $state_cd           c3 PA                            , MD                      , GA             ...
    #> $first_name         c3 CHRISTOPHER                   , MICHAEL                 ,                ...
    #> $mdl_name           c3 L                             , K                       ,                ...
    #> $last_name          c3 AARON                         , GREENBERG               ,                ...
    #> $org_name           c3                               ,                         , LUMINUS DIAGNO ...
    #> $gndr_sw            c3 M                             , M                       ,                ...

<br>

### Medicare Monthly Enrollment API

``` r
months <- tibble::enframe(month.name) |> 
  dplyr::select(-name) |> 
  dplyr::slice(1:7) |> 
  tibble::deframe()

purrr::map_dfr(months, ~beneficiary_enrollment(year = 2022, geo_level = "State", state = "Georgia", month = .x)) |> terse::terse(config = list(ansi = FALSE), width = 100)
```

    #> $year                           i7 2022   , 2022    , 2022   , 2022   , 2022   , 2022   , 2022   
    #> $month                          c7 January, February, March  , April  , May    , June   , July   
    #> $bene_geo_lvl                   c7 State  , State   , State  , State  , State  , State  , State  
    #> $bene_state_abrvtn              c7 GA     , GA      , GA     , GA     , GA     , GA     , GA     
    #> $bene_state_desc                c7 Georgia, Georgia , Georgia, Georgia, Georgia, Georgia, Georgia
    #> $bene_county_desc               c7 Total  , Total   , Total  , Total  , Total  , Total  , Total  
    #> $bene_fips_cd                   c7 13     , 13      , 13     , 13     , 13     , 13     , 13     
    #> $tot_benes                      i7 1830959, 1830025 , 1831573, 1833135, 1835187, 1837394, 1840128
    #> $orgnl_mdcr_benes               i7 915752 , 913347  , 912897 , 911263 , 910417 , 909778 , 907070 
    #> $ma_and_oth_benes               i7 915207 , 916678  , 918676 , 921872 , 924770 , 927616 , 933058 
    #> $aged_tot_benes                 i7 1572257, 1571050 , 1572037, 1573058, 1574570, 1575954, 1578129
    #> $aged_esrd_benes                i7 11635  , 11312   , 11096  , 10888  , 10716  , 10525  , 10368  
    #> $aged_no_esrd_benes             i7 1560622, 1559738 , 1560941, 1562170, 1563854, 1565429, 1567761
    #> $dsbld_tot_benes                i7 258702 , 258975  , 259536 , 260077 , 260617 , 261440 , 261999 
    #> $dsbld_esrd_and_esrd_only_benes i7 12011  , 11905   , 11853  , 11835  , 11827  , 11790  , 11713  
    #> $dsbld_no_esrd_benes            i7 246691 , 247070  , 247683 , 248242 , 248790 , 249650 , 250286 
    #> $a_b_tot_benes                  i7 1681852, 1680770 , 1681852, 1683513, 1685479, 1687818, 1696372
    #> $a_b_orgnl_mdcr_benes           i7 767454 , 764903  , 763986 , 762450 , 761518 , 761012 , 764122 
    #> $a_b_ma_and_oth_benes           i7 914398 , 915867  , 917866 , 921063 , 923961 , 926806 , 932250 
    #> $prscrptn_drug_tot_benes        i7 1410752, 1410748 , 1411729, 1413507, 1415521, 1417811, 1422171
    #> $prscrptn_drug_pdp_benes        i7 538559 , 536815  , 535968 , 534687 , 534006 , 533731 , 533004 
    #> $prscrptn_drug_mapd_benes       i7 872193 , 873933  , 875761 , 878820 , 881515 , 884080 , 889167

<br>

### Medicare Order and Referring API

``` r
provider::order_refer(npi = 1083879860) |> terse::terse(config = list(ansi = FALSE), width = 100)
```

    #> $npi        i1 1083879860 
    #> $last_name  c1 AARON      
    #> $first_name c1 CHRISTOPHER
    #> $partb      l1 T          
    #> $dme        l1 T          
    #> $hha        l1 T          
    #> $pmd        l1 T

<br>

### Medicare Opt-Out Affidavits API

``` r
provider::opt_out(last = "Aaron") |> terse::terse(config = list(ansi = FALSE), width = 100)
```

    #> $date                        D1 2023-01-22            
    #> $last_updated                c1 11/15/2022            
    #> $first_name                  c1 Sheryl                
    #> $last_name                   c1 Aaron                 
    #> $npi                         c1 1427358282            
    #> $specialty                   c1 Clinical Social Worker
    #> $optout_effective_date       c1 02/17/2022            
    #> $optout_end_date             c1 02/17/2024            
    #> $first_line_street_address   c1 1633 Q ST NW          
    #> $second_line_street_address  c1 STE 230               
    #> $city_name                   c1 WASHINGTON            
    #> $state_code                  c1 DC                    
    #> $zip_code                    c1 200096351             
    #> $eligible_to_order_and_refer l1 F

<br>

### Medicare Provider and Supplier Taxonomy Crosswalk API

``` r
provider::taxonomy_crosswalk(specialty_desc = "Rehabilitation Agency") |> 
  terse::terse(config = list(ansi = FALSE), width = 100)
```

    #> $medicare_specialty_code                                          c2 B4[14]                     ...
    #> $medicare_provider_supplier_type_description                      c2 Rehabilitation Agency      ...
    #> $provider_taxonomy_code                                           c2 261QR0400X                 ...
    #> $provider_taxonomy_description_type_classification_specialization c2 Ambulatory Health Care Fac ...

<br>

### Medicare Revalidation Due Date API

``` r
provider::revalidation_date(npi = 1710912209) |> terse::terse(config = list(ansi = FALSE), width = 100)
```

    #> $month                           D1 2023-01-22     
    #> $enrollment_id                   c1 I20040602001711
    #> $national_provider_identifier    c1 1710912209     
    #> $first_name                      c1 Yelena         
    #> $last_name                       c1 Voronova       
    #> $organization_name               c1                
    #> $enrollment_state_code           c1 NY             
    #> $enrollment_type                 c1 3              
    #> $provider_type_text              c1 Non-DME Part B 
    #> $enrollment_specialty            c1 Podiatry       
    #> $revalidation_due_date           c1 2019-10-31     
    #> $adjusted_due_date               c1                
    #> $individual_total_reassign_to    c1                
    #> $receiving_benefits_reassignment i1 5

<br>

### Medicare Revalidation Reassignment List API

``` r
provider::revalidation_reassign(ind_npi = 1710912209) |> terse::terse(config = list(ansi = FALSE), width = 100)
```

    #> $month                                        D5 2023-01-22                , 2023-01-22         ...
    #> $group_pac_id                                 d5 3678655222                , 9931511052         ...
    #> $group_enrollment_id                          c5 O20080205000002           , O20201215000955    ...
    #> $group_legal_business_name                    c5 #1 Wise Podiatry Care P.C., Brighton Beach Pod ...
    #> $group_state_code                             c5 NY                        , NY                 ...
    #> $group_due_date                               c5 10/31/2019                , TBD                ...
    #> $group_reassignments_and_physician_assistants i5 1                         , 1                  ...
    #> $record_type                                  c5 Reassignment              , Reassignment       ...
    #> $individual_pac_id                            d5 2860474988                , 2860474988         ...
    #> $individual_enrollment_id                     c5 I20040602001711           , I20040602001711    ...
    #> $individual_npi                               i5 1710912209                , 1710912209         ...
    #> $individual_first_name                        c5 Yelena                    , Yelena             ...
    #> $individual_last_name                         c5 Voronova                  , Voronova           ...
    #> $individual_state_code                        c5 NY                        , NY                 ...
    #> $individual_specialty_description             c5 Podiatry                  , Podiatry           ...
    #> $individual_due_date                          c5 10/31/2019                , 10/31/2019         ...
    #> $individual_total_employer_associations       i5 5                         , 5                  ...

<br>

### Medicare Revalidation Clinic Group Practice Reassignment API

``` r
provider::revalidation_group(ind_npi = 1710912209) |> terse::terse(config = list(ansi = FALSE), width = 100)
```

    #> $month                                        D5 2023-01-22                , 2023-01-22         ...
    #> $group_pac_id                                 d5 3678655222                , 9931511052         ...
    #> $group_enrollment_id                          c5 O20080205000002           , O20201215000955    ...
    #> $group_legal_business_name                    c5 #1 Wise Podiatry Care P.C., Brighton Beach Pod ...
    #> $group_state_code                             c5 NY                        , NY                 ...
    #> $group_due_date                               c5 10/31/2019                , TBD                ...
    #> $group_reassignments_and_physician_assistants i5 1                         , 1                  ...
    #> $record_type                                  c5 Reassignment              , Reassignment       ...
    #> $individual_enrollment_id                     c5 I20040602001711           , I20040602001711    ...
    #> $individual_npi                               i5 1710912209                , 1710912209         ...
    #> $individual_first_name                        c5 Yelena                    , Yelena             ...
    #> $individual_last_name                         c5 Voronova                  , Voronova           ...
    #> $individual_state_code                        c5 NY                        , NY                 ...
    #> $individual_specialty_description             c5 Podiatry                  , Podiatry           ...
    #> $individual_due_date                          c5 10/31/2019                , 10/31/2019         ...
    #> $individual_total_employer_associations       i5 5                         , 5                  ...

<br>

### Medicare Physician & Other Practitioners APIs

<br>

> 1.  by Provider and Service API:

<br>

``` r
purrr::map_dfr(2013:2020, ~physician_by_service(npi = 1003000126, year = .x)) |> terse::terse(config = list(ansi = FALSE), width = 100)
```

    #> $year         i8 2013      , 2014      , 2015      , 2016      , 2017      , 2018      , 2019   ...
    #> $rndrng_npi   c8 1003000126, 1003000126, 1003000126, 1003000126, 1003000126, 1003000126, 100300 ...
    #> $rndrng_prvdr L8 list(structure(list(rndrng_prvdr_last_org_name = c("Enkeshafi", "Enkeshafi", " ...
    #> $totals_srvcs L8 list(structure(list(tot_benes = c(138L, 95L, 47L, 381L, 106L, 208L, 137L), tot ...
    #> $hcpcs        L8 list(structure(list(hcpcs_cd = c("99222", "99223", "99231", "99232", "99233",  ...
    #> $averages     L8 list(structure(list(avg_sbmtd_chrg = c(368.62676056, 524.60416667, 97, 187.594 ...

<br>

> 2.  by Geography and Service API:

<br>

``` r
service <- physician_by_service(npi = 1003000126, year = 2020)
```

<br>

``` r
purrr::map_dfr(service$hcpcs_cd, ~physician_by_geography(geo_level = "National", year = 2020, hcpcs_code = .x)) |> 
  terse::terse(config = list(ansi = FALSE), width = 100)
```

    #> Error in (function (..., na.rm = FALSE) : no arguments

<br>

``` r
purrr::map_dfr(service$hcpcs_cd, ~physician_by_geography(geo_desc = "Maryland", year = 2020, hcpcs_code = .x)) |> 
  terse::terse(config = list(ansi = FALSE), width = 100)
```

    #> Error in (function (..., na.rm = FALSE) : no arguments

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
cc_multiple(year = 2007, geo_lvl = "National", demo_lvl = "Race") |> terse::terse(config = list(ansi = FALSE), width = 100)
```

    #> $year                     d60 2007                  , 2007                  , 2007              ...
    #> $bene_geo_lvl             c60 National              , National              , National          ...
    #> $bene_geo_desc            c60 National              , National              , National          ...
    #> $bene_geo_cd              c60                       ,                       ,                   ...
    #> $bene_age_lvl             c60 65+                   , 65+                   , 65+               ...
    #> $bene_demo_lvl            c60 Race                  , Race                  , Race              ...
    #> $bene_demo_desc           c60 Asian Pacific Islander, Asian Pacific Islander, Asian Pacific Isl ...
    #> $bene_mcc                 c60 0 to 1                , 2 to 3                , 4 to 5            ...
    #> $prvlnc                   d60 0.3271                , 0.3438                , 0.2213            ...
    #> $tot_mdcr_stdzd_pymt_pc   d60 1033.4246             , 3279.7851             , 7688.8443         ...
    #> $tot_mdcr_pymt_pc         d60 1116.9013             , 3692.2481             , 8993.6581         ...
    #> $hosp_readmsn_rate        d60 0.0612                , 0.0765                , 0.1237            ...
    #> $er_visits_per_1000_benes d60 82.1561               , 210.1455              , 440.5998          ...

<br>

### Medicare Specific Chronic Conditions API

``` r
cc_specific(year = 2007, geo_lvl = "National", demo_lvl = "Race") |> 
  terse::terse(config = list(ansi = FALSE), width = 100)
```

    #> $year                     d315 2007                  , 2007                  , 2007             ...
    #> $bene_geo_lvl             c315 National              , National              , National         ...
    #> $bene_geo_desc            c315 National              , National              , National         ...
    #> $bene_geo_cd              c315                       ,                       ,                  ...
    #> $bene_age_lvl             c315 65+                   , <65                   , All              ...
    #> $bene_demo_lvl            c315 Race                  , Race                  , Race             ...
    #> $bene_demo_desc           c315 Asian Pacific Islander, Asian Pacific Islander, Asian Pacific Is ...
    #> $bene_cond                c315 Alcohol Abuse         , Alcohol Abuse         , Alcohol Abuse    ...
    #> $prvlnc                   c315 0.0036                , 0.021                 , 0.0057           ...
    #> $tot_mdcr_stdzd_pymt_pc   c315                       ,                       ,                  ...
    #> $tot_mdcr_pymt_pc         c315                       ,                       ,                  ...
    #> $hosp_readmsn_rate        c315                       ,                       ,                  ...
    #> $er_visits_per_1000_benes c315                       ,                       ,                  ...

<br>

------------------------------------------------------------------------

## Code of Conduct

Please note that the provider project is released with a [Contributor
Code of
Conduct](https://andrewallenbruce.github.io/provider/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
