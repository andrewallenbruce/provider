
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

This package is primarily focused on accessing public API data that can
be linked together via a healthcare provider’s National Provider
Identifier (NPI). Thus far, none of the APIs require the creation of a
user account or API key. The data tend to fall into (and sometimes
between) one of two categories: informational/operational and
analytical. Nothing too shocking there. It only gets interesting when
you start to link them together.

### NPPES National Provider Identifier Registry API

``` r
nppes <- tibble::tribble(
~fn,         ~params,
"nppes_npi", list(npi = 1336413418),
"nppes_npi", list(npi = 1659781227),
"nppes_npi", list(prov_type = "NPI-2", city = "Baltimore", state = "MD", limit = 5),
"nppes_npi", list(prov_type = "NPI-1", city = "Atlanta", state = "GA", limit = 5),
)

purrr::invoke_map_dfr(nppes$fn, nppes$params) |> terse::terse(config = list(ansi = FALSE), width = 100)
```

    #> $datetime            p12 2023-01-05 05:33:26     , 2023-01-05 05:33:26, 2023-01-05 05:33:26     ...
    #> $outcome             c12 results                 , Errors             , results                 ...
    #> $enumeration_type    c12 NPI-2                   , NA                 , NPI-2                   ...
    #> $number              c12 1336413418              , NA                 , 1568849958              ...
    #> $name                c12 LUMINUS DIAGNOSTICS, LLC, NA                 , HEALTHPRO REHABILITATIO ...
    #> $city                c12 TIFTON                  , NA                 , BALTIMORE               ...
    #> $state               c12 GA                      , NA                 , MA                      ...
    #> $addresses           L12 list(structure(list(country_code = c("US", "US"), country_name = c("Un ...
    #> $practiceLocations   L12 list(list(), NULL, list(), list(), list(), list(), list(), list(), lis ...
    #> $taxonomies          L12 list(structure(list(code = "291U00000X", taxonomy_group = "", desc = " ...
    #> $identifiers         L12 list(list(), NULL, structure(list(), names = character(0), row.names = ...
    #> $endpoints           L12 list(list(), NULL, list(), list(), list(), list(), list(), list(), lis ...
    #> $other_names         L12 list(list(), NULL, structure(list(), names = character(0), row.names = ...
    #> $epochs              L12 list(structure(list(created_epoch = "1331130417000", last_updated_epoc ...
    #> $authorized_official L12 list(structure(list(basic_authorized_official_first_name = "Laurel", b ...
    #> $basic               L12 list(structure(list(basic_organization_name = "LUMINUS DIAGNOSTICS, LL ...
    #> $errors              L12 list(NULL, structure(list(description = "CMS deactivated NPI 165978122 ...

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

    #> $date                        D1 2023-01-05            
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

    #> $month                           D1 2023-01-05     
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

    #> $month                                        D5 2023-01-05                , 2023-01-05         ...
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

### Medicare Revalidation Clinic Group Practice Reassignment API

``` r
provider::revalidation_group(ind_npi = 1710912209) |> terse::terse(config = list(ansi = FALSE), width = 100)
```

    #> $month                                        D5 2023-01-05                , 2023-01-05         ...
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

### CMS Public Reporting of Missing Digital Contact Information API

``` r
provider::missing_information(npi = 1144224569) |> terse::terse(config = list(ansi = FALSE), width = 100)
```

    #> $npi        c1 1144224569
    #> $last_name  c1 Clouse    
    #> $first_name c1 John

<br>

### Medicare Physician & Other Practitioners APIs

<br>

> 1.  by Provider and Service API:

<br>

``` r
purrr::map_dfr(2013:2020, ~physician_by_service(npi = 1003000126, year = .x)) |> terse::terse(config = list(ansi = FALSE), width = 100)
```

    #> $year                          i78 2013                                                         ...
    #> $rndrng_npi                    c78 1003000126                                                   ...
    #> $rndrng_prvdr_last_org_name    c78 Enkeshafi                                                    ...
    #> $rndrng_prvdr_first_name       c78 Ardalan                                                      ...
    #> $rndrng_prvdr_mi               c78                                                              ...
    #> $rndrng_prvdr_crdntls          c78 M.D.                                                         ...
    #> $rndrng_prvdr_gndr             c78 M                                                            ...
    #> $rndrng_prvdr_ent_cd           c78 I                                                            ...
    #> $rndrng_prvdr_st1              c78 900 Seton Dr                                                 ...
    #> $rndrng_prvdr_st2              c78                                                              ...
    #> $rndrng_prvdr_city             c78 Cumberland                                                   ...
    #> $rndrng_prvdr_state_abrvtn     c78 MD                                                           ...
    #> $rndrng_prvdr_state_fips       c78 24                                                           ...
    #> $rndrng_prvdr_zip5             c78 21502                                                        ...
    #> $rndrng_prvdr_ruca             c78 1                                                            ...
    #> $rndrng_prvdr_ruca_desc        c78 Metropolitan area core: primary flow within an urbanized are ...
    #> $rndrng_prvdr_cntry            c78 US                                                           ...
    #> $rndrng_prvdr_type             c78 Internal Medicine                                            ...
    #> $rndrng_prvdr_mdcr_prtcptg_ind c78 Y                                                            ...
    #> $hcpcs_cd                      c78 99222                                                        ...
    #> $hcpcs_desc                    c78 Initial hospital inpatient care, typically 50 minutes per da ...
    #> $hcpcs_drug_ind                c78 N                                                            ...
    #> $place_of_srvc                 c78 F                                                            ...
    #> $tot_benes                     i78 138                                                          ...
    #> $tot_srvcs                     i78 142                                                          ...
    #> $tot_bene_day_srvcs            i78 142                                                          ...
    #> $avg_sbmtd_chrg                d78 368.62676                                                    ...
    #> $avg_mdcr_alowd_amt            d78 132.17007                                                    ...
    #> $avg_mdcr_pymt_amt             d78 104.29972                                                    ...
    #> $avg_mdcr_stdzd_amt            d78 107.21113                                                    ...

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

    #> $year                  d18 2020                                         , 2020                  ...
    #> $rndrng_prvdr_geo_lvl  c18 National                                     , National              ...
    #> $rndrng_prvdr_geo_cd   c18                                              ,                       ...
    #> $rndrng_prvdr_geo_desc c18 National                                     , National              ...
    #> $hcpcs_cd              c18 99217                                        , 99217                 ...
    #> $hcpcs_desc            c18 Hospital observation care on day of discharge, Hospital observation  ...
    #> $hcpcs_drug_ind        c18 N                                            , N                     ...
    #> $place_of_srvc         c18 F                                            , O                     ...
    #> $tot_rndrng_prvdrs     i18 90842                                        , 693                   ...
    #> $tot_benes             i18 960315                                       , 3650                  ...
    #> $tot_srvcs             d18 1083287                                      , 4520                  ...
    #> $tot_bene_day_srvcs    i18 1083083                                      , 4516                  ...
    #> $avg_sbmtd_chrg        d18 226.52433                                    , 163.35113             ...
    #> $avg_mdcr_alowd_amt    d18 71.85383                                     , 71.47693              ...
    #> $avg_mdcr_pymt_amt     d18 56.39061                                     , 54.49546              ...
    #> $avg_mdcr_stdzd_amt    d18 55.8072                                      , 54.83811              ...

<br>

``` r
purrr::map_dfr(service$hcpcs_cd, ~physician_by_geography(geo_desc = "Maryland", year = 2020, hcpcs_code = .x)) |> 
  terse::terse(config = list(ansi = FALSE), width = 100)
```

    #> $year                  d15 2020                                         , 2020                  ...
    #> $rndrng_prvdr_geo_lvl  c15 State                                        , State                 ...
    #> $rndrng_prvdr_geo_cd   c15 24                                           , 24                    ...
    #> $rndrng_prvdr_geo_desc c15 Maryland                                     , Maryland              ...
    #> $hcpcs_cd              c15 99217                                        , 99218                 ...
    #> $hcpcs_desc            c15 Hospital observation care on day of discharge, Hospital observation  ...
    #> $hcpcs_drug_ind        c15 N                                            , N                     ...
    #> $place_of_srvc         c15 F                                            , F                     ...
    #> $tot_rndrng_prvdrs     i15 1523                                         , 785                   ...
    #> $tot_benes             i15 31433                                        , 3847                  ...
    #> $tot_srvcs             i15 35505                                        , 4042                  ...
    #> $tot_bene_day_srvcs    i15 35504                                        , 4041                  ...
    #> $avg_sbmtd_chrg        d15 300.86334                                    , 377.22372             ...
    #> $avg_mdcr_alowd_amt    d15 73.32784                                     , 102.47521             ...
    #> $avg_mdcr_pymt_amt     d15 57.82643                                     , 80.32934              ...
    #> $avg_mdcr_stdzd_amt    d15 54.26721                                     , 74.86627              ...

<br>

> 3.  by Provider API:

<br>

``` r
physician_by_provider(npi = 1003000126) |> terse::terse(config = list(ansi = FALSE), width = 100)
```

    #> $year                          d1 2020                                                          ...
    #> $rndrng_npi                    c1 1003000126                                                    ...
    #> $rndrng_prvdr_last_org_name    c1 Enkeshafi                                                     ...
    #> $rndrng_prvdr_first_name       c1 Ardalan                                                       ...
    #> $rndrng_prvdr_mi               c1                                                               ...
    #> $rndrng_prvdr_crdntls          c1 M.D.                                                          ...
    #> $rndrng_prvdr_gndr             c1 M                                                             ...
    #> $rndrng_prvdr_ent_cd           c1 I                                                             ...
    #> $rndrng_prvdr_st1              c1 6410 Rockledge Dr Ste 304                                     ...
    #> $rndrng_prvdr_st2              c1                                                               ...
    #> $rndrng_prvdr_city             c1 Bethesda                                                      ...
    #> $rndrng_prvdr_state_abrvtn     c1 MD                                                            ...
    #> $rndrng_prvdr_state_fips       c1 24                                                            ...
    #> $rndrng_prvdr_zip5             c1 20817                                                         ...
    #> $rndrng_prvdr_ruca             c1 1                                                             ...
    #> $rndrng_prvdr_ruca_desc        c1 Metropolitan area core: primary flow within an urbanized area ...
    #> $rndrng_prvdr_cntry            c1 US                                                            ...
    #> $rndrng_prvdr_type             c1 Internal Medicine                                             ...
    #> $rndrng_prvdr_mdcr_prtcptg_ind c1 Y                                                             ...
    #> $tot_hcpcs_cds                 c1 16                                                            ...
    #> $tot_benes                     i1 291                                                           ...
    #> $tot_srvcs                     i1 764                                                           ...
    #> $tot_sbmtd_chrg                i1 402812                                                        ...
    #> $tot_mdcr_alowd_amt            d1 85319.63                                                      ...
    #> $tot_mdcr_pymt_amt             d1 69175.78                                                      ...
    #> $tot_mdcr_stdzd_amt            d1 66401.61                                                      ...
    #> $drug_sprsn_ind                c1                                                               ...
    #> $drug_tot_hcpcs_cds            i1 0                                                             ...
    #> $drug_tot_benes                i1 0                                                             ...
    #> $drug_tot_srvcs                i1 0                                                             ...
    #> $drug_sbmtd_chrg               i1 0                                                             ...
    #> $drug_mdcr_alowd_amt           i1 0                                                             ...
    #> $drug_mdcr_pymt_amt            i1 0                                                             ...
    #> $drug_mdcr_stdzd_amt           i1 0                                                             ...
    #> $med_sprsn_ind                 c1                                                               ...
    #> $med_tot_hcpcs_cds             i1 16                                                            ...
    #> $med_tot_benes                 i1 291                                                           ...
    #> $med_tot_srvcs                 i1 764                                                           ...
    #> $med_sbmtd_chrg                i1 402812                                                        ...
    #> $med_mdcr_alowd_amt            d1 85319.63                                                      ...
    #> $med_mdcr_pymt_amt             d1 69175.78                                                      ...
    #> $med_mdcr_stdzd_amt            d1 66401.61                                                      ...
    #> $bene_avg_age                  i1 77                                                            ...
    #> $bene_age_lt_65_cnt            i1 27                                                            ...
    #> $bene_age_65_74_cnt            i1 88                                                            ...
    #> $bene_age_75_84_cnt            i1 104                                                           ...
    #> $bene_age_gt_84_cnt            i1 72                                                            ...
    #> $bene_feml_cnt                 i1 161                                                           ...
    #> $bene_male_cnt                 i1 130                                                           ...
    #> $bene_race_wht_cnt             i1 210                                                           ...
    #> $bene_race_black_cnt           i1 50                                                            ...
    #> $bene_race_api_cnt             c1                                                               ...
    #> $bene_race_hspnc_cnt           i1 12                                                            ...
    #> $bene_race_nat_ind_cnt         c1                                                               ...
    #> $bene_race_othr_cnt            c1                                                               ...
    #> $bene_dual_cnt                 i1 61                                                            ...
    #> $bene_ndual_cnt                i1 230                                                           ...
    #> $bene_cc_af_pct                d1 0.31                                                          ...
    #> $bene_cc_alzhmr_pct            d1 0.43                                                          ...
    #> $bene_cc_asthma_pct            d1 0.15                                                          ...
    #> $bene_cc_cncr_pct              d1 0.18                                                          ...
    #> $bene_cc_chf_pct               d1 0.48                                                          ...
    #> $bene_cc_ckd_pct               d1 0.65                                                          ...
    #> $bene_cc_copd_pct              d1 0.29                                                          ...
    #> $bene_cc_dprssn_pct            d1 0.35                                                          ...
    #> $bene_cc_dbts_pct              d1 0.47                                                          ...
    #> $bene_cc_hyplpdma_pct          d1 0.73                                                          ...
    #> $bene_cc_hyprtnsn_pct          d1 0.75                                                          ...
    #> $bene_cc_ihd_pct               d1 0.66                                                          ...
    #> $bene_cc_opo_pct               d1 0.11                                                          ...
    #> $bene_cc_raoa_pct              d1 0.51                                                          ...
    #> $bene_cc_sz_pct                d1 0.09                                                          ...
    #> $bene_cc_strok_pct             d1 0.19                                                          ...
    #> $bene_avg_risk_scre            d1 2.5028                                                        ...

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
