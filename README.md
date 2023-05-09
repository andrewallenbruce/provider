
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
beneficiary_enrollment(year = 2021, 
                       month = "Year", 
                       level = "State", 
                       fips = "01")
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
beneficiary_enrollment(month = "Year", 
                       level = "County", 
                       state = "AL", 
                       county = "Autauga")
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
beneficiary_enrollment(year = 2017, 
                       level = "County", 
                       state = "GA", 
                       county = "Lowndes") 
```

    #> # A tibble: 13 × 26
    #>     year month     level  state state_name county  fips  bene_total bene_orig
    #>    <int> <chr>     <chr>  <chr> <chr>      <chr>   <chr>      <int>     <int>
    #>  1  2017 Year      County GA    Georgia    Lowndes 13185      17172     13007
    #>  2  2017 January   County GA    Georgia    Lowndes 13185      17035     12940
    #>  3  2017 February  County GA    Georgia    Lowndes 13185      17064     12952
    #>  4  2017 March     County GA    Georgia    Lowndes 13185      17083     12961
    #>  5  2017 April     County GA    Georgia    Lowndes 13185      17096     12963
    #>  6  2017 May       County GA    Georgia    Lowndes 13185      17112     12968
    #>  7  2017 June      County GA    Georgia    Lowndes 13185      17141     12978
    #>  8  2017 July      County GA    Georgia    Lowndes 13185      17161     12990
    #>  9  2017 August    County GA    Georgia    Lowndes 13185      17218     13039
    #> 10  2017 September County GA    Georgia    Lowndes 13185      17272     13085
    #> 11  2017 October   County GA    Georgia    Lowndes 13185      17258     13057
    #> 12  2017 November  County GA    Georgia    Lowndes 13185      17293     13069
    #> 13  2017 December  County GA    Georgia    Lowndes 13185      17333     13077
    #> # ℹ 17 more variables: bene_ma_oth <int>, bene_aged_total <int>,
    #> #   bene_aged_esrd <int>, bene_aged_no_esrd <int>, bene_dsb_total <int>,
    #> #   bene_dsb_esrd <int>, bene_dsb_no_esrd <int>, bene_ab_total <int>,
    #> #   bene_ab_orig <int>, bene_ab_ma_oth <int>, bene_rx_total <int>,
    #> #   bene_rx_pdp <int>, bene_rx_mapd <int>, bene_rx_elig <int>,
    #> #   bene_rx_full <int>, bene_rx_part <int>, bene_rx_none <int>

``` r
# dplyr::filter(month %in% month.name)
```

### Chronic Conditions

``` r
# Multiple Chronic Conditions
cc_multiple(year = 2018, 
            level = "National", 
            age_group = "All", 
            demographic = "All")
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
cc_multiple(year = 2018, 
            level = "State", 
            sublevel = "Alabama", 
            age_group = "All", 
            demographic = "All")
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
cc_multiple(year = 2018, 
            level = "County", 
            sublevel = "Alabama : Autauga", 
            fips = "01001", 
            age_group = "All", 
            demographic = "All")
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
cc_specific(year = 2018, 
            level = "State", 
            sublevel = "California", 
            demographic = "All")
```

    #> # A tibble: 63 × 13
    #>     year level sublevel fips  age_group demographic subdemo condition prevalence
    #>    <int> <chr> <chr>    <chr> <chr>     <chr>       <chr>   <chr>          <dbl>
    #>  1  2018 State Califor… 06    All       All         All     Alcohol …     0.0215
    #>  2  2018 State Califor… 06    All       All         All     Alzheime…     0.105 
    #>  3  2018 State Califor… 06    All       All         All     Arthritis     0.312 
    #>  4  2018 State Califor… 06    All       All         All     Asthma        0.053 
    #>  5  2018 State Califor… 06    All       All         All     Atrial F…     0.0749
    #>  6  2018 State Califor… 06    All       All         All     Autism S…     0.0022
    #>  7  2018 State Califor… 06    All       All         All     COPD          0.0952
    #>  8  2018 State Califor… 06    All       All         All     Cancer        0.0784
    #>  9  2018 State Califor… 06    All       All         All     Chronic …     0.243 
    #> 10  2018 State Califor… 06    All       All         All     Depressi…     0.162 
    #> # ℹ 53 more rows
    #> # ℹ 4 more variables: tot_std_pymt_percap <dbl>, tot_pymt_percap <dbl>,
    #> #   hosp_readmsn_rate <dbl>, er_visits_per_1k <dbl>

``` r
cc_specific(year = 2011, 
            level = "County", 
            fips = "01001")
```

    #> # A tibble: 63 × 13
    #>     year level sublevel fips  age_group demographic subdemo condition prevalence
    #>    <int> <chr> <chr>    <chr> <chr>     <chr>       <chr>   <chr>          <dbl>
    #>  1  2011 Coun… Alabama… 01001 All       All         All     Alcohol …     0.0116
    #>  2  2011 Coun… Alabama… 01001 All       All         All     Alzheime…     0.100 
    #>  3  2011 Coun… Alabama… 01001 All       All         All     Arthritis     0.274 
    #>  4  2011 Coun… Alabama… 01001 All       All         All     Asthma        0.037 
    #>  5  2011 Coun… Alabama… 01001 All       All         All     Atrial F…     0.0748
    #>  6  2011 Coun… Alabama… 01001 All       All         All     Autism S…    NA     
    #>  7  2011 Coun… Alabama… 01001 All       All         All     COPD          0.122 
    #>  8  2011 Coun… Alabama… 01001 All       All         All     Cancer        0.0792
    #>  9  2011 Coun… Alabama… 01001 All       All         All     Chronic …     0.137 
    #> 10  2011 Coun… Alabama… 01001 All       All         All     Depressi…     0.134 
    #> # ℹ 53 more rows
    #> # ℹ 4 more variables: tot_std_pymt_percap <dbl>, tot_pymt_percap <dbl>,
    #> #   hosp_readmsn_rate <dbl>, er_visits_per_1k <dbl>

### Doctors and Clinicians

``` r
doctors_and_clinicians(npi = 1720081441)
```

    #> ✖ No results for npi: 1720081441

``` r
doctors_and_clinicians(npi = 1407263999)
```

    #> # A tibble: 2 × 25
    #>   npi        pac_id     enroll_id first_name middle_name last_name suffix gender
    #>   <chr>      <chr>      <chr>     <chr>      <chr>       <chr>     <chr>  <chr> 
    #> 1 1407263999 8729208152 I2014100… ROBIN      A           AVERY     <NA>   F     
    #> 2 1407263999 8729208152 I2014100… ROBIN      A           AVERY     <NA>   F     
    #> # ℹ 17 more variables: credential <chr>, school <chr>, grad_year <int>,
    #> #   grad_duration <Duration>, specialty <chr>, specialty_sec <chr>,
    #> #   telehealth <lgl>, org_name <chr>, org_pac_id <chr>, org_members <int>,
    #> #   address <chr>, city <chr>, state <chr>, zipcode <chr>, phone_number <chr>,
    #> #   ind_assign <chr>, group_assign <chr>

``` r
doctors_and_clinicians(school = "NEW YORK UNIVERSITY SCHOOL OF MEDICINE", 
                       grad_year = 2000, 
                       state = "FL")
```

    #> # A tibble: 68 × 25
    #>    npi        pac_id    enroll_id first_name middle_name last_name suffix gender
    #>    <chr>      <chr>     <chr>     <chr>      <chr>       <chr>     <chr>  <chr> 
    #>  1 1043312556 83250900… I2010011… NICOLE     <NA>        IOVINE    <NA>   F     
    #>  2 1043312556 83250900… I2010011… NICOLE     <NA>        IOVINE    <NA>   F     
    #>  3 1043312556 83250900… I2010011… NICOLE     <NA>        IOVINE    <NA>   F     
    #>  4 1043312556 83250900… I2010011… NICOLE     <NA>        IOVINE    <NA>   F     
    #>  5 1043312556 83250900… I2010011… NICOLE     <NA>        IOVINE    <NA>   F     
    #>  6 1043312556 83250900… I2010011… NICOLE     <NA>        IOVINE    <NA>   F     
    #>  7 1043312556 83250900… I2010011… NICOLE     <NA>        IOVINE    <NA>   F     
    #>  8 1073549895 24664809… I2007112… ALAN       B           BENNIE    <NA>   M     
    #>  9 1073549895 24664809… I2007112… ALAN       B           BENNIE    <NA>   M     
    #> 10 1073575403 86280744… I2006101… DANIEL     J           GASSERT   <NA>   M     
    #> # ℹ 58 more rows
    #> # ℹ 17 more variables: credential <chr>, school <chr>, grad_year <int>,
    #> #   grad_duration <Duration>, specialty <chr>, specialty_sec <chr>,
    #> #   telehealth <lgl>, org_name <chr>, org_pac_id <chr>, org_members <int>,
    #> #   address <chr>, city <chr>, state <chr>, zipcode <chr>, phone_number <chr>,
    #> #   ind_assign <chr>, group_assign <chr>

``` r
#doctors_and_clinicians(state = "GA", city = "VALDOSTA")
```

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
facility_affiliations(first_name = "John", 
                      last_name = "Hill", 
                      facility_type = "Home Health Agency")
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
hospital_enrollment(state = "GA", city = "VALDOSTA")
```

    #> # A tibble: 3 × 36
    #>   npi        enroll_id   enroll_state specialty_code specialty_desc facility_ccn
    #>   <chr>      <chr>       <chr>        <chr>          <chr>          <chr>       
    #> 1 1306896253 O200803120… GA           00-09          PART A PROVID… 110122      
    #> 2 1467404046 O200803130… GA           00-09          PART A PROVID… 11T122      
    #> 3 1538417753 O201212130… GA           00-09          PART A PROVID… 114036      
    #> # ℹ 30 more variables: pac_id_org <chr>, org_name <chr>,
    #> #   doing_business_as <chr>, incorp_date <date>, incorp_duration <Duration>,
    #> #   incorp_state <chr>, org_structure <chr>, org_other <chr>, address <chr>,
    #> #   city <chr>, state <chr>, zipcode <int>, location_type <chr>,
    #> #   location_other <chr>, multiple_npis <lgl>, proprietary_nonprofit <lgl>,
    #> #   sg_general <lgl>, sg_acute_care <lgl>, sg_alcohol_drug <lgl>,
    #> #   sg_childrens <lgl>, sg_long_term <lgl>, sg_short_term <lgl>, …

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
hospital_enrollment(enroll_id = "O20030404000017")
```

    #> ✖ No results for enroll_id: O20030404000017

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
    #>   npi        entype     enumeration_date enumeration_duration     last_updated
    #>   <chr>      <chr>      <date>           <Duration>               <date>      
    #> 1 1316405939 Individual 2019-03-04       131932800s (~4.18 years) 2023-04-06  
    #> # ℹ 15 more variables: certification_date <date>, status <chr>,
    #> #   first_name <chr>, middle_name <chr>, last_name <chr>, credential <chr>,
    #> #   gender <chr>, sole_proprietor <chr>, country <chr>, street <chr>,
    #> #   city <chr>, state <chr>, zipcode <chr>, phone_number <chr>,
    #> #   fax_number <chr>

``` r
nppes_npi(npi = 1558364273)
```

    #> # A tibble: 1 × 19
    #>   npi      entype enumeration_date enumeration_duration      last_updated status
    #>   <chr>    <chr>  <date>           <Duration>                <date>       <chr> 
    #> 1 1558364… Indiv… 2005-05-27       566438400s (~17.95 years) 2007-07-08   A     
    #> # ℹ 13 more variables: first_name <chr>, middle_name <chr>, last_name <chr>,
    #> #   credential <chr>, gender <chr>, sole_proprietor <chr>, country <chr>,
    #> #   street <chr>, city <chr>, state <chr>, zipcode <chr>, phone_number <chr>,
    #> #   fax_number <chr>

``` r
nppes_npi(1710983663) 
```

    #> ✖ No results for npi: 1710983663

``` r
nppes_npi(1720081441)
```

    #> # A tibble: 1 × 19
    #>   npi      entype enumeration_date enumeration_duration      last_updated status
    #>   <chr>    <chr>  <date>           <Duration>                <date>       <chr> 
    #> 1 1720081… Indiv… 2005-05-27       566438400s (~17.95 years) 2007-07-08   A     
    #> # ℹ 13 more variables: first_name <chr>, middle_name <chr>, last_name <chr>,
    #> #   credential <chr>, gender <chr>, sole_proprietor <chr>, country <chr>,
    #> #   street <chr>, city <chr>, state <chr>, zipcode <chr>, phone_number <chr>,
    #> #   fax_number <chr>

``` r
# c(1710983663, 1710975040, 1659781227, 
#   1336413418, 1003026055, 1316405939, 
#   1720392988, 1518184605, 1922056829, 
#   1083879860, 1346243805, 1679576722, 
#   1093718892, 1477556405, 1770586539, 
#   1871596692, 1174526925, 1720081441, 
#   1558364273, 1801899513, 1316405939) |> 
#   purrr::map(nppes_npi) |>
#   purrr::list_rbind()
```

### Open Payments

``` r
open_payments(npi = 1043218118, year = 2021) |> 
  janitor::remove_empty(which = c("rows", "cols"))
```

    #> # A tibble: 92 × 50
    #>    year  change_type covered_type  profile_id npi   first_name last_name address
    #>    <chr> <chr>       <chr>         <chr>      <chr> <chr>      <chr>     <chr>  
    #>  1 2021  UNCHANGED   Covered Reci… 92058      1043… Ahad       Mahootchi 6739 G…
    #>  2 2021  UNCHANGED   Covered Reci… 92058      1043… AHAD       MAHOOTCHI 6739 G…
    #>  3 2021  UNCHANGED   Covered Reci… 92058      1043… AHAD       MAHOOTCHI 6739 G…
    #>  4 2021  UNCHANGED   Covered Reci… 92058      1043… AHAD       MAHOOTCHI 6739 G…
    #>  5 2021  UNCHANGED   Covered Reci… 92058      1043… AHAD       MAHOOTCHI 6739 G…
    #>  6 2021  UNCHANGED   Covered Reci… 92058      1043… AHAD       MAHOOTCHI 6739 G…
    #>  7 2021  UNCHANGED   Covered Reci… 92058      1043… AHAD       MAHOOTCHI 6739 G…
    #>  8 2021  UNCHANGED   Covered Reci… 92058      1043… AHAD       MAHOOTCHI 6739 G…
    #>  9 2021  UNCHANGED   Covered Reci… 92058      1043… AHAD       MAHOOTCHI 6739 G…
    #> 10 2021  UNCHANGED   Covered Reci… 92058      1043… AHAD       MAHOOTCHI 6739 G…
    #> # ℹ 82 more rows
    #> # ℹ 42 more variables: city <chr>, state <chr>, zipcode <chr>, country <chr>,
    #> #   primary_type <chr>, specialty <chr>, license_state <chr>,
    #> #   payer_submitting <chr>, payer_id <chr>, payer_name <chr>,
    #> #   payer_state <chr>, payer_country <chr>, payment_total <chr>,
    #> #   payment_date <date>, payment_count <chr>, payment_form <chr>,
    #> #   payment_nature <chr>, physician_ownership <chr>, …

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
opt_out(specialty = "Psychiatry", 
        city = "Brooklyn", 
        state = "NY", 
        order_and_refer = FALSE)
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

``` r
opt_out(city = "Valdosta", state = "GA")
```

    #> # A tibble: 3 × 13
    #>   npi        first_name last_name specialty    optout_start_date optout_end_date
    #>   <chr>      <chr>      <chr>     <chr>        <date>            <date>         
    #> 1 1992848659 Jeffery    Wood      Maxillofaci… 2016-01-11        2024-01-11     
    #> 2 1073632659 Fernando   Alvarado  Oral Surgery 2017-07-01        2023-07-01     
    #> 3 1811005655 Sonya      Merriman  Plastic And… 2022-01-01        2024-01-01     
    #> # ℹ 7 more variables: optout_duration <Duration>, last_updated <date>,
    #> #   order_and_refer <lgl>, address <chr>, city <chr>, state <chr>,
    #> #   zipcode <chr>

### Order and Referring Privileges

``` r
order_refer(npi = 1083879860)
```

    #> # A tibble: 1 × 7
    #>   npi        first_name  last_name partb hha   dme   pmd  
    #>   <chr>      <chr>       <chr>     <lgl> <lgl> <lgl> <lgl>
    #> 1 1083879860 CHRISTOPHER AARON     TRUE  TRUE  TRUE  TRUE

``` r
order_refer(last_name = "Smith", 
            partb = FALSE, 
            pmd = FALSE)
```

    #> # A tibble: 150 × 7
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
    #> # ℹ 140 more rows

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
# by Geography and Service
physician_by_geography(sublevel = "Georgia", year = 2020) |> 
  dplyr::slice_max(avg_payment, n = 10)
```

    #> # A tibble: 10 × 16
    #>     year level sublevel fips  hcpcs hcpcs_desc        hcpcs_drug pos   tot_provs
    #>    <int> <chr> <chr>    <chr> <chr> <chr>             <lgl>      <chr>     <int>
    #>  1  2020 State Georgia  13    Q2043 Sipuleucel-t, mi… TRUE       O            26
    #>  2  2020 State Georgia  13    37227 Removal of plaqu… FALSE      O            55
    #>  3  2020 State Georgia  13    G2170 Percutaneous art… FALSE      F             6
    #>  4  2020 State Georgia  13    37229 Removal of plaqu… FALSE      O            61
    #>  5  2020 State Georgia  13    37231 Removal of plaqu… FALSE      O            11
    #>  6  2020 State Georgia  13    37226 Insertion of ste… FALSE      O            42
    #>  7  2020 State Georgia  13    37225 Removal of plaqu… FALSE      O            67
    #>  8  2020 State Georgia  13    37230 Insertion of ste… FALSE      O             9
    #>  9  2020 State Georgia  13    63685 Insertion of spi… FALSE      F           274
    #> 10  2020 State Georgia  13    C9740 Cystourethroscop… FALSE      F            26
    #> # ℹ 7 more variables: tot_benes <int>, tot_srvcs <int>, tot_day <int>,
    #> #   avg_charge <dbl>, avg_allowed <dbl>, avg_payment <dbl>, avg_std_pymt <dbl>

``` r
# by Provider and Service
physician_by_service(year = 2020, npi = 1285706879)
```

    #> ✖ No results for year: 2020 and npi: 1285706879

``` r
# by Provider
physician_by_provider(npi = 1285706879, year = 2020)
```

    #> ✖ No results for year: 2020 and npi: 1285706879

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
    #>   npi        enroll_id    first_name last_name org_name enroll_state enroll_type
    #>   <chr>      <chr>        <chr>      <chr>     <chr>    <chr>        <chr>      
    #> 1 1710912209 I2004060200… Yelena     Voronova  <NA>     NY           3          
    #> # ℹ 6 more variables: enroll_desc <chr>, enroll_specialty <chr>,
    #> #   revalidation_due_date <dttm>, adjusted_due_date <dttm>,
    #> #   individual_total_reassign_to <chr>, receiving_benefits_reassignment <int>

``` r
# Revalidation Reassignment List
revalidation_reassign(npi = 1710912209)
```

    #> # A tibble: 5 × 16
    #>   npi        pac_id  enroll_id first_name last_name state specialty due_date_ind
    #>   <chr>      <chr>   <chr>     <chr>      <chr>     <chr> <chr>     <chr>       
    #> 1 1710912209 286047… I2004060… Yelena     Voronova  NY    Podiatry  10/31/2019  
    #> 2 1710912209 286047… I2004060… Yelena     Voronova  NY    Podiatry  10/31/2019  
    #> 3 1710912209 286047… I2004060… Yelena     Voronova  NY    Podiatry  10/31/2019  
    #> 4 1710912209 286047… I2004060… Yelena     Voronova  NY    Podiatry  10/31/2019  
    #> 5 1710912209 286047… I2004060… Yelena     Voronova  NY    Podiatry  10/31/2019  
    #> # ℹ 8 more variables: ind_tot_employer_associations <int>, pac_id_group <chr>,
    #> #   enroll_id_group <chr>, business_name <chr>, state_group <chr>,
    #> #   due_date_group <chr>, group_reassignments_and_physician_assistants <int>,
    #> #   record_type <chr>

``` r
# Revalidation Clinic Group Practice Reassignment
revalidation_group(npi = 1710912209)
```

    #> # A tibble: 5 × 15
    #>   npi        enroll_id       first_name last_name state specialty due_date_ind
    #>   <chr>      <chr>           <chr>      <chr>     <chr> <chr>     <chr>       
    #> 1 1710912209 I20040602001711 Yelena     Voronova  NY    Podiatry  10/31/2019  
    #> 2 1710912209 I20040602001711 Yelena     Voronova  NY    Podiatry  10/31/2019  
    #> 3 1710912209 I20040602001711 Yelena     Voronova  NY    Podiatry  10/31/2019  
    #> 4 1710912209 I20040602001711 Yelena     Voronova  NY    Podiatry  10/31/2019  
    #> 5 1710912209 I20040602001711 Yelena     Voronova  NY    Podiatry  10/31/2019  
    #> # ℹ 8 more variables: ind_tot_employer_associations <int>, pac_id_group <chr>,
    #> #   enroll_id_group <chr>, business_name <chr>, state_group <chr>,
    #> #   due_date_group <chr>, group_reassignments_and_physician_assistants <int>,
    #> #   record_type <chr>

``` r
revalidation_group(pac_id_group = 9436483807,
                   enroll_id_group = "O20190619002165",
                   business_name = "1st Call Urgent Care",
                   state_group = "FL",
                   record_type = "Reassignment")
```

    #> ✖ No results for pac_id_group: 9436483807, enroll_id_group: O20190619002165,
    #> business_name: 1st Call Urgent Care, state_group: FL, and record_type:
    #> Reassignment

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
# taxonomy_crosswalk() |> 
#   dplyr::full_join(nucc_taxonomy_230, 
#   dplyr::join_by(taxonomy_code == code))
```

------------------------------------------------------------------------

## Code of Conduct

Please note that the `provider` project is released with a [Contributor
Code of
Conduct](https://andrewallenbruce.github.io/provider/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
