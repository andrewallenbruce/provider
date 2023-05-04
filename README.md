
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
[![pkgdown](https://github.com/andrewallenbruce/provider/actions/workflows/pkgdown.yaml/badge.svg)](https://github.com/andrewallenbruce/provider/actions/workflows/pkgdown.yaml)
[![Codecov test
coverage](https://codecov.io/gh/andrewallenbruce/provider/branch/main/graph/badge.svg)](https://app.codecov.io/gh/andrewallenbruce/provider?branch=main)
[![CodeFactor](https://www.codefactor.io/repository/github/andrewallenbruce/provider/badge)](https://www.codefactor.io/repository/github/andrewallenbruce/provider)
![GitHub
milestone](https://img.shields.io/github/milestones/progress/andrewallenbruce/provider/1?color=white&logo=milestones)
<!-- badges: end -->

> Providing easy access to [healthcare
> provider](https://en.wikipedia.org/wiki/Health_care_provider)-centric
> data through publicly available APIs & sources.

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

## Motivation

``` r
library(provider)
```

<br>

The goal of `provider` is to make the experience of accessing
publicly-available Medicare provider data easier and more consistent
across a variety of CMS sources.

<br>

| Function                   | API                                                                                                                                                                                                                                   |
|:---------------------------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `beneficiary_enrollment()` | [Medicare Monthly Enrollment](https://data.cms.gov/summary-statistics-on-beneficiary-enrollment/medicare-and-medicaid-reports/medicare-monthly-enrollment)                                                                            |
| `cc_multiple()`            | [Medicare Multiple Chronic Conditions](https://data.cms.gov/medicare-chronic-conditions/multiple-chronic-conditions)                                                                                                                  |
| `cc_specific()`            | [Medicare Specific Chronic Conditions](https://data.cms.gov/medicare-chronic-conditions/specific-chronic-conditions)                                                                                                                  |
| `doctors_and_clinicians()` | [Doctors and Clinicians National Downloadable File](https://data.cms.gov/provider-data/dataset/mj5m-pzi6)                                                                                                                             |
| `facility_affiliations()`  | [CMS Physician Facility Affiliations](https://data.cms.gov/provider-data/dataset/27ea-46a8)                                                                                                                                           |
| `hospital_enrollment()`    | [Hospital Enrollments](https://data.cms.gov/provider-characteristics/hospitals-and-other-facilities/hospital-enrollments)                                                                                                             |
| `missing_information()`    | [CMS Public Reporting of Missing Digital Contact Information](https://data.cms.gov/provider-compliance/public-reporting-of-missing-digital-contact-information)                                                                       |
| `nppes_npi()`              | [NPPES National Provider Identifier (NPI) Registry](https://npiregistry.cms.hhs.gov/search)                                                                                                                                           |
| `open_payments()`          | [CMS Open Payments Program](https://openpaymentsdata.cms.gov/dataset/0380bbeb-aea1-58b6-b708-829f92a48202)                                                                                                                            |
| `opt_out()`                | [Medicare Opt Out Affidavits](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/opt-out-affidavits)                                                                                                 |
| `order_refer()`            | [Medicare Order and Referring](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/order-and-referring)                                                                                               |
| `pending_applications()`   | [Medicare Pending Initial Logging and Tracking](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/pending-initial-logging-and-tracking-physicians)                                                  |
| `physician_by_geography()` | [Medicare Physician & Other Practitioners: by Geography and Service](https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-geography-and-service) |
| `physician_by_provider()`  | [Medicare Physician & Other Practitioners: by Provider](https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-provider)                           |
| `physician_by_service()`   | [Medicare Physician & Other Practitioners: by Provider and Service](https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-provider-and-service)   |
| `provider_enrollment()`    | [Medicare Fee-For-Service Public Provider Enrollment](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/medicare-fee-for-service-public-provider-enrollment)                                        |
| `revalidation_date()`      | [Medicare Revalidation Due Date](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-due-date-list)                                                                                      |
| `revalidation_group()`     | [Medicare Revalidation Clinic Group Practice Reassignment](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-clinic-group-practice-reassignment)                                       |
| `revalidation_reassign()`  | [Medicare Revalidation Reassignment](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-reassignment-list)                                                                              |
| `taxonomy_crosswalk()`     | [Medicare Provider and Supplier Taxonomy Crosswalk](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/medicare-provider-and-supplier-taxonomy-crosswalk)                                            |

<br>

### Beneficiary Enrollment

``` r
beneficiary_enrollment(year = 2021, month = "Year", level = "State", fips = "01")
```

    #> # A tibble: 1 × 26
    #>    year month level state state_name county fips  bene_total bene_orig
    #>   <int> <chr> <chr> <chr> <chr>      <chr>  <chr>      <int>     <int>
    #> 1  2021 Year  State AL    Alabama    Total  01       1070474    528983
    #> # ℹ 17 more variables: bene_ma_oth <int>, bene_aged_total <int>,
    #> #   bene_aged_esrd <int>, bene_aged_no_esrd <int>, bene_dsb_total <int>,
    #> #   bene_dsb_esrd <int>, bene_dsb_no_esrd <int>, bene_ab_total <int>,
    #> #   bene_ab_orig <int>, bene_ab_ma_oth <int>, bene_rx_total <int>,
    #> #   bene_rx_pdp <int>, bene_rx_mapd <int>, bene_rx_elig <int>,
    #> #   bene_rx_full <int>, bene_rx_part <int>, bene_rx_none <int>

``` r
beneficiary_enrollment(month = "Year", level = "County", state = "AL", county = "Autauga")
```

    #> # A tibble: 10 × 26
    #>     year month level  state state_name county  fips  bene_total bene_orig
    #>    <int> <chr> <chr>  <chr> <chr>      <chr>   <chr>      <int>     <int>
    #>  1  2013 Year  County AL    Alabama    Autauga 01001       9323      6484
    #>  2  2014 Year  County AL    Alabama    Autauga 01001       9589      6565
    #>  3  2015 Year  County AL    Alabama    Autauga 01001       9938      6711
    #>  4  2016 Year  County AL    Alabama    Autauga 01001      10214      6799
    #>  5  2017 Year  County AL    Alabama    Autauga 01001      10510      5784
    #>  6  2018 Year  County AL    Alabama    Autauga 01001      10645      5700
    #>  7  2019 Year  County AL    Alabama    Autauga 01001      11059      5761
    #>  8  2020 Year  County AL    Alabama    Autauga 01001      11251      5596
    #>  9  2021 Year  County AL    Alabama    Autauga 01001      11396      5338
    #> 10  2022 Year  County AL    Alabama    Autauga 01001      11578      5186
    #> # ℹ 17 more variables: bene_ma_oth <int>, bene_aged_total <int>,
    #> #   bene_aged_esrd <int>, bene_aged_no_esrd <int>, bene_dsb_total <int>,
    #> #   bene_dsb_esrd <int>, bene_dsb_no_esrd <int>, bene_ab_total <int>,
    #> #   bene_ab_orig <int>, bene_ab_ma_oth <int>, bene_rx_total <int>,
    #> #   bene_rx_pdp <int>, bene_rx_mapd <int>, bene_rx_elig <int>,
    #> #   bene_rx_full <int>, bene_rx_part <int>, bene_rx_none <int>

``` r
beneficiary_enrollment(year = 2017, level = "County", state = "GA") |> 
  dplyr::filter(month %in% month.name) |> dplyr::count(month)
```

    #> # A tibble: 12 × 2
    #>    month         n
    #>    <chr>     <int>
    #>  1 April       159
    #>  2 August      159
    #>  3 December    159
    #>  4 February    159
    #>  5 January     159
    #>  6 July        159
    #>  7 June        159
    #>  8 March       159
    #>  9 May         159
    #> 10 November    159
    #> 11 October     159
    #> 12 September   159

### Chronic Conditions

``` r
# Multiple Chronic Conditions
cc_multiple(year = 2018, level = "National", age_group = "All", demographic = "All")
```

    #> # A tibble: 4 × 13
    #>    year level    sublevel fips  age_group demographic subdemo mcc     prevalence
    #>   <int> <chr>    <chr>    <chr> <chr>     <chr>       <chr>   <ord>        <dbl>
    #> 1  2018 National National <NA>  All       All         All     [0,1]        0.311
    #> 2  2018 National National <NA>  All       All         All     [2,3]        0.291
    #> 3  2018 National National <NA>  All       All         All     [4,5]        0.221
    #> 4  2018 National National <NA>  All       All         All     [6, In…      0.177
    #> # ℹ 4 more variables: tot_std_pymt_percap <dbl>, tot_pymt_percap <dbl>,
    #> #   hosp_readmsn_rate <dbl>, er_visits_per_1k <dbl>

``` r
cc_multiple(year = 2018, level = "State", sublevel = "Alabama", age_group = "All", demographic = "All")
```

    #> # A tibble: 4 × 13
    #>    year level sublevel fips  age_group demographic subdemo mcc      prevalence
    #>   <int> <chr> <chr>    <chr> <chr>     <chr>       <chr>   <ord>         <dbl>
    #> 1  2018 State Alabama  01    All       All         All     [0,1]         0.258
    #> 2  2018 State Alabama  01    All       All         All     [2,3]         0.285
    #> 3  2018 State Alabama  01    All       All         All     [4,5]         0.250
    #> 4  2018 State Alabama  01    All       All         All     [6, Inf)      0.207
    #> # ℹ 4 more variables: tot_std_pymt_percap <dbl>, tot_pymt_percap <dbl>,
    #> #   hosp_readmsn_rate <dbl>, er_visits_per_1k <dbl>

``` r
cc_multiple(year = 2018, level = "County", sublevel = "Alabama : Autauga", fips = "01001", age_group = "All", demographic = "All")
```

    #> # A tibble: 4 × 13
    #>    year level  sublevel     fips  age_group demographic subdemo mcc   prevalence
    #>   <int> <chr>  <chr>        <chr> <chr>     <chr>       <chr>   <ord>      <dbl>
    #> 1  2018 County Alabama : A… 01001 All       All         All     [0,1]      0.266
    #> 2  2018 County Alabama : A… 01001 All       All         All     [2,3]      0.281
    #> 3  2018 County Alabama : A… 01001 All       All         All     [4,5]      0.248
    #> 4  2018 County Alabama : A… 01001 All       All         All     [6, …      0.205
    #> # ℹ 4 more variables: tot_std_pymt_percap <dbl>, tot_pymt_percap <dbl>,
    #> #   hosp_readmsn_rate <dbl>, er_visits_per_1k <dbl>

``` r
# Specific Chronic Conditions
cc_specific(year = 2018, geo_level = "State", state_abb = "CA")
```

    #> # A tibble: 34,020 × 13
    #>     year bene_geo_lvl bene_geo_desc bene_geo_cd bene_age_lvl bene_demo_lvl
    #>    <dbl> <chr>        <chr>         <chr>       <chr>        <chr>        
    #>  1  2018 State        Alabama       01          All          All          
    #>  2  2018 State        Alabama       01          65+          Dual Status  
    #>  3  2018 State        Alabama       01          <65          Dual Status  
    #>  4  2018 State        Alabama       01          All          Dual Status  
    #>  5  2018 State        Alabama       01          65+          Dual Status  
    #>  6  2018 State        Alabama       01          <65          Dual Status  
    #>  7  2018 State        Alabama       01          All          Dual Status  
    #>  8  2018 State        Alabama       01          65+          Sex          
    #>  9  2018 State        Alabama       01          <65          Sex          
    #> 10  2018 State        Alabama       01          All          Sex          
    #> # ℹ 34,010 more rows
    #> # ℹ 7 more variables: bene_demo_desc <chr>, bene_cond <chr>, prvlnc <chr>,
    #> #   tot_mdcr_stdzd_pymt_pc <chr>, tot_mdcr_pymt_pc <chr>,
    #> #   hosp_readmsn_rate <chr>, er_visits_per_1000_benes <chr>

### Doctors and Clinicians

``` r
doctors_and_clinicians(npi = 1720081441)
```

    #> ✖ No results for npi: 1720081441

    #> NULL

``` r
doctors_and_clinicians(npi = 1407263999)
```

    #> # A tibble: 2 × 24
    #>   npi        pac_id     enroll_id first_name middle_name last_name suffix gender
    #>   <chr>      <chr>      <chr>     <chr>      <chr>       <chr>     <chr>  <chr> 
    #> 1 1407263999 8729208152 I2014100… ROBIN      A           AVERY     <NA>   F     
    #> 2 1407263999 8729208152 I2014100… ROBIN      A           AVERY     <NA>   F     
    #> # ℹ 16 more variables: credential <chr>, school <chr>, grad_year <int>,
    #> #   specialty <chr>, specialty_sec <chr>, telehealth <lgl>, org_name <chr>,
    #> #   org_pac_id <chr>, org_members <int>, address <chr>, city <chr>,
    #> #   state <chr>, zipcode <chr>, phone_number <chr>, ind_assign <chr>,
    #> #   group_assign <chr>

``` r
doctors_and_clinicians(school = "NEW YORK UNIVERSITY SCHOOL OF MEDICINE", 
                       grad_year = 2003, 
                       state = "FL")
```

    #> # A tibble: 7 × 24
    #>   npi        pac_id     enroll_id first_name middle_name last_name suffix gender
    #>   <chr>      <chr>      <chr>     <chr>      <chr>       <chr>     <chr>  <chr> 
    #> 1 1033237524 7618041781 I2022061… BRIAN      KEITH       GOLDBERG  <NA>   M     
    #> 2 1164628830 5698811768 I2009100… KEVIN      M           KAPLAN    <NA>   M     
    #> 3 1295895514 7113029984 I2021070… JHUMA      <NA>        CHAUDHURI <NA>   F     
    #> 4 1497955652 3476647330 I2007092… YUI        F           CHIEN     <NA>   M     
    #> 5 1497955652 3476647330 I2007092… YUI        F           CHIEN     <NA>   M     
    #> 6 1497955652 3476647330 I2007092… YUI        F           CHIEN     <NA>   M     
    #> 7 1801000963 3577616598 I2009080… CHRIS      <NA>        SCHETTINO <NA>   M     
    #> # ℹ 16 more variables: credential <chr>, school <chr>, grad_year <int>,
    #> #   specialty <chr>, specialty_sec <chr>, telehealth <lgl>, org_name <chr>,
    #> #   org_pac_id <chr>, org_members <int>, address <chr>, city <chr>,
    #> #   state <chr>, zipcode <chr>, phone_number <chr>, ind_assign <chr>,
    #> #   group_assign <chr>

``` r
doctors_and_clinicians(state = "GA")
```

    #> # A tibble: 500 × 24
    #>    npi        pac_id    enroll_id first_name middle_name last_name suffix gender
    #>    <chr>      <chr>     <chr>     <chr>      <chr>       <chr>     <chr>  <chr> 
    #>  1 1003001843 55977186… I2005030… INGE       C           LUECHING… <NA>   F     
    #>  2 1003006115 93352239… I2008022… BENJAMIN   W           DURHAM    <NA>   M     
    #>  3 1003006115 93352239… I2008022… BENJAMIN   W           DURHAM    <NA>   M     
    #>  4 1003006115 93352239… I2008022… BENJAMIN   W           DURHAM    <NA>   M     
    #>  5 1003006115 93352239… I2008022… BENJAMIN   W           DURHAM    <NA>   M     
    #>  6 1003006115 93352239… I2008022… BENJAMIN   W           DURHAM    <NA>   M     
    #>  7 1003008111 64060279… I2011091… MARIE      <NA>        EASTERLIN <NA>   F     
    #>  8 1003009309 96382395… I2008112… DEBRA      L           BREWER    <NA>   F     
    #>  9 1003012915 91332752… I2009091… JAYASHREE  S           JOHN      <NA>   F     
    #> 10 1003012915 91332752… I2009091… JAYASHREE  S           JOHN      <NA>   F     
    #> # ℹ 490 more rows
    #> # ℹ 16 more variables: credential <chr>, school <chr>, grad_year <int>,
    #> #   specialty <chr>, specialty_sec <chr>, telehealth <lgl>, org_name <chr>,
    #> #   org_pac_id <chr>, org_members <int>, address <chr>, city <chr>,
    #> #   state <chr>, zipcode <chr>, phone_number <chr>, ind_assign <chr>,
    #> #   group_assign <chr>

### Facility Affiliations

``` r
facility_affiliations(npi = 1003019561)
```

    #> ✖ No results for npi: 1003019561

``` r
facility_affiliations(facility_ccn = "060004")
```

    #> # A tibble: 188 × 9
    #>    npi        pac_id     first_name middle_name last_name   suffix facility_type
    #>    <chr>      <chr>      <chr>      <chr>       <chr>       <chr>  <chr>        
    #>  1 1003002890 6002953973 DANIEL     RICHARD     HAMMAN      <NA>   Hospital     
    #>  2 1003019563 4688707060 JOHN       JOSEPH      FRANK       <NA>   Hospital     
    #>  3 1003045022 5890926059 ARTHUR     H           DONAHUE     <NA>   Hospital     
    #>  4 1003105636 6507182847 JAMES      CHARLES     HIGHAM KES… <NA>   Hospital     
    #>  5 1003234162 4284940248 MATTHEW    <NA>        MCDIARMID   <NA>   Hospital     
    #>  6 1003845249 1254326994 GARETH     R           WEINER      <NA>   Hospital     
    #>  7 1013069566 7810096328 AMITY      D           HELZER      <NA>   Hospital     
    #>  8 1013115989 4385891712 ASHLEY     L           PYLE        <NA>   Hospital     
    #>  9 1013979566 1557374014 FIRAS      <NA>        MUWALLA     <NA>   Hospital     
    #> 10 1023261963 2860687431 CHAD       MICHAEL     LUCCI       <NA>   Hospital     
    #> # ℹ 178 more rows
    #> # ℹ 2 more variables: facility_ccn <chr>, parent_ccn <chr>

``` r
facility_affiliations(parent_ccn = 670055)
```

    #> # A tibble: 9 × 9
    #>   npi        pac_id     first_name middle_name last_name  suffix facility_type  
    #>   <chr>      <chr>      <chr>      <chr>       <chr>      <chr>  <chr>          
    #> 1 1083742829 5698833655 RAFAEL     JORGE       FORNARIS   <NA>   Inpatient reha…
    #> 2 1144429580 3577659580 LYSA       LEE         CURRY      <NA>   Inpatient reha…
    #> 3 1558595660 8921241142 JOHN       D           ALFONSO    <NA>   Inpatient reha…
    #> 4 1609973650 0840373239 GEORGE     KIMBELL     WILCOX     <NA>   Inpatient reha…
    #> 5 1710112370 9739337122 VIDYA      <NA>        VADDEMPUDI <NA>   Inpatient reha…
    #> 6 1720069859 7012947229 WILLIAM    WARREN      JANES      <NA>   Inpatient reha…
    #> 7 1740577212 0345473773 GEOFF      R           WEIKLE     <NA>   Inpatient reha…
    #> 8 1770861742 5193940997 AUSTON     J           MYERS      <NA>   Inpatient reha…
    #> 9 1912260464 5092036509 SAAD       MD          MANSOOR    <NA>   Inpatient reha…
    #> # ℹ 2 more variables: facility_ccn <chr>, parent_ccn <chr>

``` r
facility_affiliations(first_name = "John", last_name = "Hill", facility_type = "Home Health Agency")
```

    #> # A tibble: 7 × 9
    #>   npi        pac_id     first_name middle_name last_name suffix facility_type   
    #>   <chr>      <chr>      <chr>      <chr>       <chr>     <chr>  <chr>           
    #> 1 1174587588 7214998079 JOHN       C           HILL      III    Home health age…
    #> 2 1174587588 7214998079 JOHN       C           HILL      III    Home health age…
    #> 3 1174587588 7214998079 JOHN       C           HILL      III    Home health age…
    #> 4 1558380444 4789619362 JOHN       M           HILL      <NA>   Home health age…
    #> 5 1558380444 4789619362 JOHN       M           HILL      <NA>   Home health age…
    #> 6 1558380444 4789619362 JOHN       M           HILL      <NA>   Home health age…
    #> 7 1558380444 4789619362 JOHN       M           HILL      <NA>   Home health age…
    #> # ℹ 2 more variables: facility_ccn <chr>, parent_ccn <chr>

### Hospital Enrollments

``` r
hospital_enrollment(facility_ccn = "060004")
```

    #> # A tibble: 1 × 36
    #>   npi        enroll_id   enroll_state specialty_code specialty_desc facility_ccn
    #>   <chr>      <chr>       <chr>        <chr>          <chr>          <chr>       
    #> 1 1629071758 O200706190… CO           00-09          PART A PROVID… 060004      
    #> # ℹ 30 more variables: pac_id_org <chr>, org_name <chr>,
    #> #   doing_business_as <chr>, incorp_date <date>, incorp_duration <Duration>,
    #> #   incorp_state <chr>, org_structure <chr>, org_other <chr>, address <chr>,
    #> #   city <chr>, state <chr>, zipcode <int>, location_type <chr>,
    #> #   location_other <chr>, multiple_npis <lgl>, proprietary_nonprofit <lgl>,
    #> #   sg_general <lgl>, sg_acute_care <lgl>, sg_alcohol_drug <lgl>,
    #> #   sg_childrens <lgl>, sg_long_term <lgl>, sg_short_term <lgl>, …

``` r
hospital_enrollment(state = "GA")
```

    #> # A tibble: 216 × 36
    #>    npi        enroll_id  enroll_state specialty_code specialty_desc facility_ccn
    #>    <chr>      <chr>      <chr>        <chr>          <chr>          <chr>       
    #>  1 1588664007 O20020826… GA           00-09          PART A PROVID… 112011      
    #>  2 1376574277 O20021108… GA           00-09          PART A PROVID… 110005      
    #>  3 1912951963 O20030515… GA           00-09          PART A PROVID… 110177      
    #>  4 1063406684 O20030925… GA           00-09          PART A PROVID… 110043      
    #>  5 1447252044 O20040406… GA           00-09          PART A PROVID… 112016      
    #>  6 1679543672 O20040513… GA           00-09          PART A PROVID… 114008      
    #>  7 1508810565 O20040823… GA           00-09          PART A PROVID… 110168      
    #>  8 1922178789 O20041013… GA           00-09          PART A PROVID… 113301      
    #>  9 1194722389 O20041103… GA           00-09          PART A PROVID… 112013      
    #> 10 1811940976 O20041109… GA           00-09          PART A PROVID… 110201      
    #> # ℹ 206 more rows
    #> # ℹ 30 more variables: pac_id_org <chr>, org_name <chr>,
    #> #   doing_business_as <chr>, incorp_date <date>, incorp_duration <Duration>,
    #> #   incorp_state <chr>, org_structure <chr>, org_other <chr>, address <chr>,
    #> #   city <chr>, state <chr>, zipcode <int>, location_type <chr>,
    #> #   location_other <chr>, multiple_npis <lgl>, proprietary_nonprofit <lgl>,
    #> #   sg_general <lgl>, sg_acute_care <lgl>, sg_alcohol_drug <lgl>, …

``` r
hospital_enrollment(enroll_state = "GA")
```

    #> # A tibble: 216 × 36
    #>    npi        enroll_id  enroll_state specialty_code specialty_desc facility_ccn
    #>    <chr>      <chr>      <chr>        <chr>          <chr>          <chr>       
    #>  1 1588664007 O20020826… GA           00-09          PART A PROVID… 112011      
    #>  2 1376574277 O20021108… GA           00-09          PART A PROVID… 110005      
    #>  3 1912951963 O20030515… GA           00-09          PART A PROVID… 110177      
    #>  4 1063406684 O20030925… GA           00-09          PART A PROVID… 110043      
    #>  5 1447252044 O20040406… GA           00-09          PART A PROVID… 112016      
    #>  6 1679543672 O20040513… GA           00-09          PART A PROVID… 114008      
    #>  7 1508810565 O20040823… GA           00-09          PART A PROVID… 110168      
    #>  8 1922178789 O20041013… GA           00-09          PART A PROVID… 113301      
    #>  9 1194722389 O20041103… GA           00-09          PART A PROVID… 112013      
    #> 10 1811940976 O20041109… GA           00-09          PART A PROVID… 110201      
    #> # ℹ 206 more rows
    #> # ℹ 30 more variables: pac_id_org <chr>, org_name <chr>,
    #> #   doing_business_as <chr>, incorp_date <date>, incorp_duration <Duration>,
    #> #   incorp_state <chr>, org_structure <chr>, org_other <chr>, address <chr>,
    #> #   city <chr>, state <chr>, zipcode <int>, location_type <chr>,
    #> #   location_other <chr>, multiple_npis <lgl>, proprietary_nonprofit <lgl>,
    #> #   sg_general <lgl>, sg_acute_care <lgl>, sg_alcohol_drug <lgl>, …

``` r
hospital_enrollment(incorp_state = "GA")
```

    #> Error in hospital_enrollment(incorp_state = "GA"): unused argument (incorp_state = "GA")

``` r
hospital_enrollment(enroll_id = "O20030404000017")
```

    #> ✖ No results for enroll_id: O20030404000017

    #> NULL

### Missing Contact Information

``` r
missing_information(npi = 1144224569)
```

    #> # A tibble: 1 × 3
    #>   npi        last_name first_name
    #>   <chr>      <chr>     <chr>     
    #> 1 1144224569 Clouse    John

``` r
missing_information(npi = 11111122222)
```

    #> ✖ No results for npi: 11111122222

### NPI Registry

``` r
nppes_npi(npi = 1316405939)
```

    #> # A tibble: 1 × 20
    #>   npi    enumeration_type enumeration_date enumeration_duration     last_updated
    #>   <chr>  <chr>            <date>           <Duration>               <date>      
    #> 1 13164… NPI-1            2019-03-04       131500800s (~4.17 years) 2023-04-06  
    #> # ℹ 15 more variables: certification_date <date>, status <chr>,
    #> #   first_name <chr>, middle_name <chr>, last_name <chr>, credential <chr>,
    #> #   gender <chr>, sole_proprietor <chr>, country <chr>, street <chr>,
    #> #   city <chr>, state <chr>, zipcode <chr>, phone_number <chr>,
    #> #   fax_number <chr>

``` r
nppes_npi(npi = 1558364273)
```

    #> # A tibble: 1 × 19
    #>   npi   enumeration_type enumeration_date enumeration_duration      last_updated
    #>   <chr> <chr>            <date>           <Duration>                <date>      
    #> 1 1558… NPI-1            2005-05-27       566006400s (~17.94 years) 2007-07-08  
    #> # ℹ 14 more variables: status <chr>, first_name <chr>, middle_name <chr>,
    #> #   last_name <chr>, credential <chr>, gender <chr>, sole_proprietor <chr>,
    #> #   country <chr>, street <chr>, city <chr>, state <chr>, zipcode <chr>,
    #> #   phone_number <chr>, fax_number <chr>

``` r
nppes_npi(1720081441)
```

    #> # A tibble: 1 × 19
    #>   npi   enumeration_type enumeration_date enumeration_duration      last_updated
    #>   <chr> <chr>            <date>           <Duration>                <date>      
    #> 1 1720… NPI-1            2005-05-27       566006400s (~17.94 years) 2007-07-08  
    #> # ℹ 14 more variables: status <chr>, first_name <chr>, middle_name <chr>,
    #> #   last_name <chr>, credential <chr>, gender <chr>, sole_proprietor <chr>,
    #> #   country <chr>, street <chr>, city <chr>, state <chr>, zipcode <chr>,
    #> #   phone_number <chr>, fax_number <chr>

``` r
nppes_npi(1710983663)
```

    #> ✖ No results for npi: 1710983663

``` r
c(1710983663, 1710975040, 1659781227, 
  1336413418, 1003026055, 1316405939, 
  1720392988, 1518184605, 1922056829, 
  1083879860, 1346243805, 1679576722, 
  1093718892, 1477556405, 1770586539, 
  1871596692, 1174526925, 1720081441, 
  1558364273, 1801899513, 1316405939) |> 
  purrr::map(nppes_npi) |>
  purrr::list_rbind()
```

    #> ✖ No results for npi: 1710983663

    #> ✖ No results for npi: 1659781227

    #> # A tibble: 19 × 22
    #>    npi        enumeration_type enumeration_date enumeration_duration     
    #>    <chr>      <chr>            <date>           <Duration>               
    #>  1 1710975040 NPI-1            2005-10-11       554169600s (~17.56 years)
    #>  2 1336413418 NPI-2            2012-03-07       352080000s (~11.16 years)
    #>  3 1003026055 NPI-1            2007-05-22       503366400s (~15.95 years)
    #>  4 1316405939 NPI-1            2019-03-04       131500800s (~4.17 years) 
    #>  5 1720392988 NPI-1            2010-07-29       402796800s (~12.76 years)
    #>  6 1518184605 NPI-1            2007-04-19       506217600s (~16.04 years)
    #>  7 1922056829 NPI-1            2006-05-04       536457600s (~17 years)   
    #>  8 1083879860 NPI-1            2008-07-22       466473600s (~14.78 years)
    #>  9 1346243805 NPI-1            2005-05-27       566006400s (~17.94 years)
    #> 10 1679576722 NPI-1            2005-05-23       566352000s (~17.95 years)
    #> 11 1093718892 NPI-1            2005-05-24       566265600s (~17.94 years)
    #> 12 1477556405 NPI-1            2005-05-23       566352000s (~17.95 years)
    #> 13 1770586539 NPI-1            2005-05-24       566265600s (~17.94 years)
    #> 14 1871596692 NPI-1            2005-05-24       566265600s (~17.94 years)
    #> 15 1174526925 NPI-1            2005-05-24       566265600s (~17.94 years)
    #> 16 1720081441 NPI-1            2005-05-27       566006400s (~17.94 years)
    #> 17 1558364273 NPI-1            2005-05-27       566006400s (~17.94 years)
    #> 18 1801899513 NPI-1            2005-05-27       566006400s (~17.94 years)
    #> 19 1316405939 NPI-1            2019-03-04       131500800s (~4.17 years) 
    #> # ℹ 18 more variables: last_updated <date>, status <chr>, first_name <chr>,
    #> #   middle_name <chr>, last_name <chr>, credential <chr>, gender <chr>,
    #> #   sole_proprietor <chr>, country <chr>, street <chr>, city <chr>,
    #> #   state <chr>, zipcode <chr>, phone_number <chr>, fax_number <chr>,
    #> #   certification_date <date>, organization_name <chr>,
    #> #   organizational_subpart <chr>

### Open Payments

``` r
open_payments(recipient_npi = 1043218118)
```

    #> # A tibble: 92 × 52
    #>    program_year record_number change_type covered_recipient_type     
    #>    <chr>        <chr>         <chr>       <chr>                      
    #>  1 2021         1             UNCHANGED   Covered Recipient Physician
    #>  2 2021         692021        UNCHANGED   Covered Recipient Physician
    #>  3 2021         4385936       UNCHANGED   Covered Recipient Physician
    #>  4 2021         4385946       UNCHANGED   Covered Recipient Physician
    #>  5 2021         4385951       UNCHANGED   Covered Recipient Physician
    #>  6 2021         4385956       UNCHANGED   Covered Recipient Physician
    #>  7 2021         4579206       UNCHANGED   Covered Recipient Physician
    #>  8 2021         4579226       UNCHANGED   Covered Recipient Physician
    #>  9 2021         4624246       UNCHANGED   Covered Recipient Physician
    #> 10 2021         4766366       UNCHANGED   Covered Recipient Physician
    #> # ℹ 82 more rows
    #> # ℹ 48 more variables: covered_recipient_profile_id <chr>,
    #> #   covered_recipient_npi <chr>, covered_recipient_first_name <chr>,
    #> #   covered_recipient_last_name <chr>,
    #> #   recipient_primary_business_street_address_line1 <chr>,
    #> #   recipient_city <chr>, recipient_state <chr>, recipient_zip_code <chr>,
    #> #   recipient_country <chr>, covered_recipient_primary_type_1 <chr>, …

### Opt-Out Affidavits

``` r
opt_out(first_name = "David", last_name = "Smith")
```

    #> # A tibble: 6 × 13
    #>   npi        first_name last_name specialty    optout_start_date optout_end_date
    #>   <chr>      <chr>      <chr>     <chr>        <date>            <date>         
    #> 1 1649265760 David      Smith     Maxillofaci… 2012-06-25        2024-06-25     
    #> 2 1750565958 David      Smith     Oral Surgery 2013-05-07        2023-05-07     
    #> 3 1114058443 David      Smith     Psychiatry   2014-08-15        2024-08-15     
    #> 4 1023002375 David      Smith     Obstetrics/… 2012-10-01        2024-10-01     
    #> 5 1790853307 David      Smith     Oral Surgery 2015-03-26        2025-03-26     
    #> 6 1659300077 David      Smith     Dentist      2015-05-26        2023-05-26     
    #> # ℹ 7 more variables: optout_duration <Duration>, last_updated <date>,
    #> #   order_and_refer <lgl>, address <chr>, city <chr>, state <chr>,
    #> #   zipcode <chr>

``` r
opt_out(specialty = "Psychiatry", city = "BROOKLYN", state = "NY", order_and_refer = FALSE)
```

    #> # A tibble: 4 × 13
    #>   npi        first_name last_name specialty  optout_start_date optout_end_date
    #>   <chr>      <chr>      <chr>     <chr>      <date>            <date>         
    #> 1 1538251731 Robert     Katz      Psychiatry 2021-10-01        2023-10-01     
    #> 2 1114239761 Adriel     Gerard    Psychiatry 2019-12-30        2023-12-30     
    #> 3 1740635804 Joseph     Mouallem  Psychiatry 2020-07-22        2024-07-22     
    #> 4 1932442191 Cecilia    Lipira    Psychiatry 2020-08-14        2024-08-14     
    #> # ℹ 7 more variables: optout_duration <Duration>, last_updated <date>,
    #> #   order_and_refer <lgl>, address <chr>, city <chr>, state <chr>,
    #> #   zipcode <chr>

``` r
opt_out(specialty = "Tsychiatry")
```

    #> ✖ No results for specialty: Tsychiatry

    #> NULL

### Order and Referring Privileges

``` r
order_refer(npi = 1083879860)
```

    #> # A tibble: 1 × 7
    #>   npi        first_name  last_name partb hha   dme   pmd  
    #>   <chr>      <chr>       <chr>     <lgl> <lgl> <lgl> <lgl>
    #> 1 1083879860 CHRISTOPHER AARON     TRUE  TRUE  TRUE  TRUE

``` r
order_refer(last_name = "Smith", partb = FALSE, pmd = FALSE)
```

    #> # A tibble: 148 × 7
    #>    npi        first_name last_name partb hha   dme   pmd  
    #>    <chr>      <chr>      <chr>     <lgl> <lgl> <lgl> <lgl>
    #>  1 1063535672 AARON      SMITH     FALSE FALSE TRUE  FALSE
    #>  2 1891210431 ALAINA     SMITH     FALSE FALSE TRUE  FALSE
    #>  3 1962830570 ALESHA     SMITH     FALSE FALSE TRUE  FALSE
    #>  4 1922655521 ALLISON    SMITH     FALSE FALSE TRUE  FALSE
    #>  5 1942778188 ALYSSA     SMITH     FALSE FALSE TRUE  FALSE
    #>  6 1467902791 AMANDA     SMITH     FALSE FALSE TRUE  FALSE
    #>  7 1992203582 AMANDA     SMITH     FALSE FALSE TRUE  FALSE
    #>  8 1023475761 AMY        SMITH     FALSE FALSE TRUE  FALSE
    #>  9 1609219773 AMY        SMITH     FALSE FALSE TRUE  FALSE
    #> 10 1659973295 ANDREW     SMITH     FALSE FALSE TRUE  FALSE
    #> # ℹ 138 more rows

### Pending Applications

``` r
pending_applications(last_name = "Smith", type = "non-physician")
```

    #> # A tibble: 24 × 4
    #>    npi        last_name first_name type         
    #>    <chr>      <chr>     <chr>      <chr>        
    #>  1 1518672245 SMITH     ALEXANDRA  NON-PHYSICIAN
    #>  2 1700588621 SMITH     AMANDA     NON-PHYSICIAN
    #>  3 1073234282 SMITH     ANGELA     NON-PHYSICIAN
    #>  4 1790408185 SMITH     ARIELLE    NON-PHYSICIAN
    #>  5 1801992912 SMITH     BRIDGET    NON-PHYSICIAN
    #>  6 1558504688 SMITH     BRITTANY   NON-PHYSICIAN
    #>  7 1679235717 SMITH     BRITTNEY   NON-PHYSICIAN
    #>  8 1639635030 SMITH     COURTNEY   NON-PHYSICIAN
    #>  9 1043925035 SMITH     FULGENTIA  NON-PHYSICIAN
    #> 10 1902527641 SMITH     HEATHER    NON-PHYSICIAN
    #> # ℹ 14 more rows

``` r
pending_applications(first_name = "John", type = "physician")
```

    #> # A tibble: 35 × 4
    #>    npi        last_name  first_name type     
    #>    <chr>      <chr>      <chr>      <chr>    
    #>  1 1881791739 ADAMS      JOHN       PHYSICIAN
    #>  2 1841280963 BIGBEE     JOHN       PHYSICIAN
    #>  3 1619996378 BODDEN     JOHN       PHYSICIAN
    #>  4 1588744569 BRUNO      JOHN       PHYSICIAN
    #>  5 1861142556 BURKE      JOHN       PHYSICIAN
    #>  6 1306817531 COMBS      JOHN       PHYSICIAN
    #>  7 1730349580 ECHEVARRIA JOHN       PHYSICIAN
    #>  8 1659074151 EUN        JOHN       PHYSICIAN
    #>  9 1376571554 FLYNN      JOHN       PHYSICIAN
    #> 10 1689774804 FREEMAN    JOHN       PHYSICIAN
    #> # ℹ 25 more rows

``` r
pending_applications(first_name = "John", type = "dentist")
```

    #> Error in `pending_applications()`:
    #> ! `type` must be one of "physician" or "non-physician", not "dentist".

``` r
pending_applications(npi = "1001001234", 
                     first_name = "Gaelic", 
                     last_name = "Garlic",
                     type = "physician")
```

    #> ✖ No results for npi: 1001001234, last_name: Garlic, first_name: Gaelic, and
    #> type: physician

### Physician & Other Practitioners

``` r
# by Provider and Service
physician_by_service(npi = 1003000126)
```

    #> # A tibble: 1 × 6
    #>    year rndrng_npi rndrng_prvdr      totals_srvcs     hcpcs            averages
    #>   <dbl> <chr>      <list>            <list>           <list>           <list>  
    #> 1  2020 1003000126 <tibble [9 × 17]> <tibble [9 × 3]> <tibble [9 × 4]> <tibble>

``` r
# by Geography and Service
physician_by_geography(geo_desc = "Maryland", year = 2020)
```

    #> Error in physician_by_geography(geo_desc = "Maryland", year = 2020): unused argument (geo_desc = "Maryland")

``` r
# by Provider
physician_by_provider(npi = 1003000126, year = 2020)
```

    #> # A tibble: 1 × 11
    #>    year rndrng_npi rndrng_prvdr      totals_srvcs drug_srvcs med_srvcs bene_age
    #>   <dbl> <chr>      <list>            <list>       <list>     <list>    <list>  
    #> 1  2020 1003000126 <tibble [1 × 17]> <tibble>     <tibble>   <tibble>  <tibble>
    #> # ℹ 4 more variables: bene_sex <list>, bene_race <list>, bene_status <list>,
    #> #   bene_cc <list>

### Provider Enrollment

``` r
provider_enrollment(npi = 1083879860)
```

    #> # A tibble: 1 × 11
    #>   npi   pac_id enroll_id specialty_code specialty_desc state org_name first_name
    #>   <chr> <chr>  <chr>     <chr>          <chr>          <chr> <chr>    <chr>     
    #> 1 1083… 84263… I2020061… 14-08          PRACTITIONER … PA    <NA>     CHRISTOPH…
    #> # ℹ 3 more variables: middle_name <chr>, last_name <chr>, gender <chr>

``` r
provider_enrollment(specialty_code = "00-17", state = "GA") # GA RHCs
```

    #> # A tibble: 92 × 11
    #>    npi        pac_id     enroll_id  specialty_code specialty_desc state org_name
    #>    <chr>      <chr>      <chr>      <chr>          <chr>          <chr> <chr>   
    #>  1 1992710610 8729997846 O20030404… 00-17          PART A PROVID… GA    TMC HAR…
    #>  2 1497760243 0042129074 O20030407… 00-17          PART A PROVID… GA    TMC TAL…
    #>  3 1285706879 1557271731 O20030610… 00-17          PART A PROVID… GA    HIAWASS…
    #>  4 1982631321 5991616039 O20030918… 00-17          PART A PROVID… GA    TMC WES…
    #>  5 1821017831 1850294034 O20040421… 00-17          PART A PROVID… GA    BACON C…
    #>  6 1750339511 2264415538 O20040608… 00-17          PART A PROVID… GA    BOWDON-…
    #>  7 1366472003 6002724598 O20041109… 00-17          PART A PROVID… GA    HOSPITA…
    #>  8 1891863569 2062493083 O20050222… 00-17          PART A PROVID… GA    THE MED…
    #>  9 1578682696 3779490503 O20070601… 00-17          PART A PROVID… GA    UNION C…
    #> 10 1922211515 6002724598 O20070830… 00-17          PART A PROVID… GA    HOSPITA…
    #> # ℹ 82 more rows
    #> # ℹ 4 more variables: first_name <chr>, middle_name <chr>, last_name <chr>,
    #> #   gender <chr>

### Revalidation Lists

``` r
# Revalidation Due Date List
revalidation_date(npi = 1710912209)
```

    #> # A tibble: 1 × 13
    #>   enrollment_id   npi        first_name last_name organization_name
    #>   <chr>           <chr>      <chr>      <chr>     <chr>            
    #> 1 I20040602001711 1710912209 Yelena     Voronova  <NA>             
    #> # ℹ 8 more variables: enrollment_state_code <chr>, enrollment_type <chr>,
    #> #   provider_type_text <chr>, enrollment_specialty <chr>,
    #> #   revalidation_due_date <dttm>, adjusted_due_date <dttm>,
    #> #   individual_total_reassign_to <chr>, receiving_benefits_reassignment <int>

``` r
# Revalidation Reassignment List
revalidation_reassign(ind_npi = 1710912209)
```

    #> # A tibble: 5 × 16
    #>   group_pac_id group_enrollment_id group_legal_business_name    group_state_code
    #>          <dbl> <chr>               <chr>                        <chr>           
    #> 1   3678655222 O20080205000002     #1 Wise Podiatry Care P.C.   NY              
    #> 2   9931511052 O20201215000955     Brighton Beach Podiatry Pllc NY              
    #> 3   2062791411 O20161108001365     Fair Podiatry Practice Pllc  NY              
    #> 4   8527313170 O20180622000028     New York Jewish American Po… NY              
    #> 5   5193155174 O20200414003240     Podiatry Of Brooklyn Pllc    NY              
    #> # ℹ 12 more variables: group_due_date <chr>,
    #> #   group_reassignments_and_physician_assistants <int>, record_type <chr>,
    #> #   individual_pac_id <dbl>, individual_enrollment_id <chr>,
    #> #   individual_npi <int>, individual_first_name <chr>,
    #> #   individual_last_name <chr>, individual_state_code <chr>,
    #> #   individual_specialty_description <chr>, individual_due_date <chr>,
    #> #   individual_total_employer_associations <int>

``` r
# Revalidation Clinic Group Practice Reassignment
revalidation_group(ind_npi = 1710912209)
```

    #> # A tibble: 5 × 15
    #>   group_pac_id group_enrollment_id group_legal_business_name    group_state_code
    #>          <dbl> <chr>               <chr>                        <chr>           
    #> 1   3678655222 O20080205000002     #1 Wise Podiatry Care P.C.   NY              
    #> 2   9931511052 O20201215000955     Brighton Beach Podiatry Pllc NY              
    #> 3   2062791411 O20161108001365     Fair Podiatry Practice Pllc  NY              
    #> 4   8527313170 O20180622000028     New York Jewish American Po… NY              
    #> 5   5193155174 O20200414003240     Podiatry Of Brooklyn Pllc    NY              
    #> # ℹ 11 more variables: group_due_date <chr>,
    #> #   group_reassignments_and_physician_assistants <int>, record_type <chr>,
    #> #   individual_enrollment_id <chr>, individual_npi <int>,
    #> #   individual_first_name <chr>, individual_last_name <chr>,
    #> #   individual_state_code <chr>, individual_specialty_description <chr>,
    #> #   individual_due_date <chr>, individual_total_employer_associations <int>

### Taxonomy Crosswalk

``` r
taxonomy_crosswalk(specialty_desc = "Rehabilitation Agency")
```

    #> # A tibble: 2 × 4
    #>   taxonomy_code taxonomy_desc                      specialty_code specialty_desc
    #>   <chr>         <chr>                              <chr>          <chr>         
    #> 1 261QR0400X    Ambulatory Health Care Facilities… B4[14]         Rehabilitatio…
    #> 2 315D00000X    Nursing & Custodial Care Faciliti… B4[14]         Rehabilitatio…

``` r
taxonomy_crosswalk(specialty_code = "B4[14]")
```

    #> # A tibble: 13 × 4
    #>    taxonomy_code taxonomy_desc                     specialty_code specialty_desc
    #>    <chr>         <chr>                             <chr>          <chr>         
    #>  1 261QR0400X    Ambulatory Health Care Facilitie… B4[14]         Rehabilitatio…
    #>  2 335U00000X    Suppliers/Organ Procurement Orga… B4[14]         Organ Procure…
    #>  3 261QM0801X    Ambulatory Health Care Facilitie… B4[14]         Community Men…
    #>  4 261QR0401X    Ambulatory Health Care Facilitie… B4[14]         Comprehensive…
    #>  5 261QE0700X    Ambulatory Health Care Facilitie… B4[14]         End-Stage Ren…
    #>  6 261QF0400X    Ambulatory Health Care Facilitie… B4[14]         Federally Qua…
    #>  7 251G00000X    Agencies/Hospice Care Community … B4[14]         Hospice       
    #>  8 291U00000X    Laboratories/Clinical Medical La… B4[14]         Histocompatib…
    #>  9 291900000X    Laboratories/Military Clinical M… B4[14]         <NA>          
    #> 10 261QR0400X    Ambulatory Health Care Facilitie… B4[14]         Outpatient Ph…
    #> 11 315D00000X    Nursing & Custodial Care Facilit… B4[14]         Rehabilitatio…
    #> 12 282J00000X    Hospitals/Religious Non-medical … B4[14]         Religious Non…
    #> 13 261QR1300X    Ambulatory Health Care Facilitie… B4[14]         Rural Health …

``` r
taxonomy_crosswalk(specialty_code = "8")
```

    #> # A tibble: 9 × 4
    #>   taxonomy_code taxonomy_desc                      specialty_code specialty_desc
    #>   <chr>         <chr>                              <chr>          <chr>         
    #> 1 207Q00000X    Allopathic & Osteopathic Physicia… 8              Physician/Fam…
    #> 2 207QA0401X    Allopathic & Osteopathic Physicia… 8              Physician/Fam…
    #> 3 207QA0000X    Allopathic & Osteopathic Physicia… 8              Physician/Fam…
    #> 4 207QA0505X    Allopathic & Osteopathic Physicia… 8              Physician/Fam…
    #> 5 207QB0002X    Allopathic & Osteopathic Physicia… 8              Physician/Fam…
    #> 6 207QG0300X    Allopathic & Osteopathic Physicia… 8              Physician/Fam…
    #> 7 207QH0002X    Allopathic & Osteopathic Physicia… 8              Physician/Fam…
    #> 8 207QS0010X    Allopathic & Osteopathic Physicia… 8              Physician/Fam…
    #> 9 207QS1201X    Allopathic & Osteopathic Physicia… 8              Physician/Fam…

``` r
taxonomy_crosswalk(taxonomy_code = "207Q00000X")
```

    #> # A tibble: 1 × 4
    #>   taxonomy_code taxonomy_desc                      specialty_code specialty_desc
    #>   <chr>         <chr>                              <chr>          <chr>         
    #> 1 207Q00000X    Allopathic & Osteopathic Physicia… 8              Physician/Fam…

``` r
taxonomy_crosswalk() |> 
  dplyr::full_join(nucc_taxonomy_230, 
  dplyr::join_by(taxonomy_code == code)) |> 
  dplyr::count(grouping)
```

    #> # A tibble: 30 × 2
    #>    grouping                                         n
    #>    <chr>                                        <int>
    #>  1 Agencies                                        16
    #>  2 Allopathic & Osteopathic Physicians            299
    #>  3 Ambulatory Health Care Facilities               64
    #>  4 Behavioral Health & Social Service Providers    41
    #>  5 Chiropractic Providers                          12
    #>  6 Dental Providers                                20
    #>  7 Dietary & Nutritional Service Providers         14
    #>  8 Emergency Medical Service Providers              4
    #>  9 Eye and Vision Services Providers               17
    #> 10 Group                                            2
    #> # ℹ 20 more rows

``` r
nucc_taxonomy_230
```

    #> # A tibble: 873 × 8
    #>    code     grouping classification specialization definition notes display_name
    #>    <chr>    <chr>    <chr>          <chr>          <chr>      <chr> <chr>       
    #>  1 1932000… Group    Multi-Special… <NA>           A busines… [7/1… Multi-Speci…
    #>  2 1934000… Group    Single Specia… <NA>           A busines… [7/1… Single Spec…
    #>  3 207K000… Allopat… Allergy & Imm… <NA>           An allerg… Sour… Allergy & I…
    #>  4 207KA02… Allopat… Allergy & Imm… Allergy        A physici… Sour… Allergy Phy…
    #>  5 207KI00… Allopat… Allergy & Imm… Clinical & La… An allerg… Sour… Clinical & …
    #>  6 207L000… Allopat… Anesthesiology <NA>           An anesth… Sour… Anesthesiol…
    #>  7 207LA04… Allopat… Anesthesiology Addiction Med… An anesth… Sour… Addiction M…
    #>  8 207LC02… Allopat… Anesthesiology Critical Care… An anesth… Sour… Critical Ca…
    #>  9 207LH00… Allopat… Anesthesiology Hospice and P… An anesth… Sour… Hospice and…
    #> 10 207LP29… Allopat… Anesthesiology Pain Medicine  An anesth… Sour… Pain Medici…
    #> # ℹ 863 more rows
    #> # ℹ 1 more variable: section <chr>

------------------------------------------------------------------------

## Code of Conduct

Please note that the `provider` project is released with a [Contributor
Code of
Conduct](https://andrewallenbruce.github.io/provider/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
