
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
beneficiary_enrollment(year = 2020, 
                       period = "Year", 
                       level = "State", 
                       fips = "01")
```

    # A tibble: 1 × 26
       year period level state state_name county fips  bene_total bene_orig
      <int> <chr>  <chr> <chr> <chr>      <chr>  <chr>      <int>     <int>
    1  2020 Year   State AL    Alabama    Total  01       1062565    576690
    # ℹ 17 more variables: bene_ma_oth <int>, bene_aged_total <int>,
    #   bene_aged_esrd <int>, bene_aged_no_esrd <int>, bene_dsb_total <int>,
    #   bene_dsb_esrd <int>, bene_dsb_no_esrd <int>, bene_ab_total <int>,
    #   bene_ab_orig <int>, bene_ab_ma_oth <int>, bene_rx_total <int>,
    #   bene_rx_pdp <int>, bene_rx_mapd <int>, bene_rx_elig <int>,
    #   bene_rx_full <int>, bene_rx_part <int>, bene_rx_none <int>

### Chronic Conditions

``` r
# Multiple Chronic Conditions
cc_multiple(year = 2018, 
            level = "National", 
            age_group = "All", 
            demographic = "All")
```

    # A tibble: 4 × 13
       year level    sublevel fips  age_group demographic subdemo mcc     prevalence
      <int> <chr>    <chr>    <chr> <chr>     <chr>       <chr>   <ord>        <dbl>
    1  2018 National National <NA>  All       All         All     [0,1]        0.311
    2  2018 National National <NA>  All       All         All     [2,3]        0.291
    3  2018 National National <NA>  All       All         All     [4,5]        0.221
    4  2018 National National <NA>  All       All         All     [6, In…      0.177
    # ℹ 4 more variables: tot_std_pymt_percap <dbl>, tot_pymt_percap <dbl>,
    #   hosp_readmsn_rate <dbl>, er_visits_per_1k <dbl>

``` r
cc_multiple(year = 2018, 
            level = "State", 
            sublevel = "Alabama", 
            age_group = "All", 
            demographic = "All")
```

    # A tibble: 4 × 13
       year level sublevel fips  age_group demographic subdemo mcc      prevalence
      <int> <chr> <chr>    <chr> <chr>     <chr>       <chr>   <ord>         <dbl>
    1  2018 State Alabama  01    All       All         All     [0,1]         0.258
    2  2018 State Alabama  01    All       All         All     [2,3]         0.285
    3  2018 State Alabama  01    All       All         All     [4,5]         0.250
    4  2018 State Alabama  01    All       All         All     [6, Inf)      0.207
    # ℹ 4 more variables: tot_std_pymt_percap <dbl>, tot_pymt_percap <dbl>,
    #   hosp_readmsn_rate <dbl>, er_visits_per_1k <dbl>

``` r
cc_multiple(year = 2018, 
            level = "County", 
            sublevel = "Alabama : Autauga", 
            fips = "01001", 
            age_group = "All", 
            demographic = "All")
```

    # A tibble: 4 × 13
       year level  sublevel     fips  age_group demographic subdemo mcc   prevalence
      <int> <chr>  <chr>        <chr> <chr>     <chr>       <chr>   <ord>      <dbl>
    1  2018 County Alabama : A… 01001 All       All         All     [0,1]      0.266
    2  2018 County Alabama : A… 01001 All       All         All     [2,3]      0.281
    3  2018 County Alabama : A… 01001 All       All         All     [4,5]      0.248
    4  2018 County Alabama : A… 01001 All       All         All     [6, …      0.205
    # ℹ 4 more variables: tot_std_pymt_percap <dbl>, tot_pymt_percap <dbl>,
    #   hosp_readmsn_rate <dbl>, er_visits_per_1k <dbl>

``` r
# Specific Chronic Conditions
cc_specific(year = 2018, 
            level = "State", 
            sublevel = "California", 
            demographic = "All")
```

    # A tibble: 63 × 13
        year level sublevel fips  age_group demographic subdemo condition prevalence
       <int> <chr> <chr>    <chr> <chr>     <chr>       <chr>   <chr>          <dbl>
     1  2018 State Califor… 06    All       All         All     Alcohol …     0.0215
     2  2018 State Califor… 06    All       All         All     Alzheime…     0.105 
     3  2018 State Califor… 06    All       All         All     Arthritis     0.312 
     4  2018 State Califor… 06    All       All         All     Asthma        0.053 
     5  2018 State Califor… 06    All       All         All     Atrial F…     0.0749
     6  2018 State Califor… 06    All       All         All     Autism S…     0.0022
     7  2018 State Califor… 06    All       All         All     COPD          0.0952
     8  2018 State Califor… 06    All       All         All     Cancer        0.0784
     9  2018 State Califor… 06    All       All         All     Chronic …     0.243 
    10  2018 State Califor… 06    All       All         All     Depressi…     0.162 
    # ℹ 53 more rows
    # ℹ 4 more variables: tot_std_pymt_percap <dbl>, tot_pymt_percap <dbl>,
    #   hosp_readmsn_rate <dbl>, er_visits_per_1k <dbl>

``` r
cc_specific(year = 2011, 
            level = "County", 
            fips = "01001")
```

    # A tibble: 63 × 13
        year level sublevel fips  age_group demographic subdemo condition prevalence
       <int> <chr> <chr>    <chr> <chr>     <chr>       <chr>   <chr>          <dbl>
     1  2011 Coun… Alabama… 01001 All       All         All     Alcohol …     0.0116
     2  2011 Coun… Alabama… 01001 All       All         All     Alzheime…     0.100 
     3  2011 Coun… Alabama… 01001 All       All         All     Arthritis     0.274 
     4  2011 Coun… Alabama… 01001 All       All         All     Asthma        0.037 
     5  2011 Coun… Alabama… 01001 All       All         All     Atrial F…     0.0748
     6  2011 Coun… Alabama… 01001 All       All         All     Autism S…    NA     
     7  2011 Coun… Alabama… 01001 All       All         All     COPD          0.122 
     8  2011 Coun… Alabama… 01001 All       All         All     Cancer        0.0792
     9  2011 Coun… Alabama… 01001 All       All         All     Chronic …     0.137 
    10  2011 Coun… Alabama… 01001 All       All         All     Depressi…     0.134 
    # ℹ 53 more rows
    # ℹ 4 more variables: tot_std_pymt_percap <dbl>, tot_pymt_percap <dbl>,
    #   hosp_readmsn_rate <dbl>, er_visits_per_1k <dbl>

### Doctors and Clinicians

``` r
doctors_and_clinicians(npi = 1720081441)
```

    ✖ No results for npi: 1720081441

``` r
doctors_and_clinicians(npi = 1407263999)
```

    # A tibble: 2 × 25
      npi        pac_id     enroll_id first_name middle_name last_name suffix gender
      <chr>      <chr>      <chr>     <chr>      <chr>       <chr>     <chr>  <chr> 
    1 1407263999 8729208152 I2014100… ROBIN      A           AVERY     <NA>   F     
    2 1407263999 8729208152 I2014100… ROBIN      A           AVERY     <NA>   F     
    # ℹ 17 more variables: credential <chr>, school <chr>, grad_year <int>,
    #   grad_duration <Duration>, specialty <chr>, specialty_sec <chr>,
    #   telehealth <lgl>, org_name <chr>, org_pac_id <chr>, org_members <int>,
    #   address <chr>, city <chr>, state <chr>, zipcode <chr>, phone <chr>,
    #   ind_assn <chr>, group_assn <chr>

``` r
doctors_and_clinicians(school = "NEW YORK UNIVERSITY SCHOOL OF MEDICINE", 
                       grad_year = 2000, 
                       state = "FL")
```

    # A tibble: 79 × 25
       npi        pac_id    enroll_id first_name middle_name last_name suffix gender
       <chr>      <chr>     <chr>     <chr>      <chr>       <chr>     <chr>  <chr> 
     1 1043312556 83250900… I2010011… NICOLE     <NA>        IOVINE    <NA>   F     
     2 1043312556 83250900… I2010011… NICOLE     <NA>        IOVINE    <NA>   F     
     3 1043312556 83250900… I2010011… NICOLE     <NA>        IOVINE    <NA>   F     
     4 1043312556 83250900… I2010011… NICOLE     <NA>        IOVINE    <NA>   F     
     5 1043312556 83250900… I2010011… NICOLE     <NA>        IOVINE    <NA>   F     
     6 1043312556 83250900… I2010011… NICOLE     <NA>        IOVINE    <NA>   F     
     7 1043312556 83250900… I2010011… NICOLE     <NA>        IOVINE    <NA>   F     
     8 1073549895 24664809… I2007112… ALAN       B           BENNIE    <NA>   M     
     9 1073549895 24664809… I2007112… ALAN       B           BENNIE    <NA>   M     
    10 1073575403 86280744… I2006101… DANIEL     J           GASSERT   <NA>   M     
    # ℹ 69 more rows
    # ℹ 17 more variables: credential <chr>, school <chr>, grad_year <int>,
    #   grad_duration <Duration>, specialty <chr>, specialty_sec <chr>,
    #   telehealth <lgl>, org_name <chr>, org_pac_id <chr>, org_members <int>,
    #   address <chr>, city <chr>, state <chr>, zipcode <chr>, phone <chr>,
    #   ind_assn <chr>, group_assn <chr>

### Facility Affiliations

``` r
facility_affiliations(npi = 10030195634)
```

    Error in `facility_affiliations()`:
    ! NPI may be incorrect or invalid
    ℹ NPIs are 10 characters long.
    ✖ NPI: 10030195634 is 11 characters long.

``` r
facility_affiliations(facility_ccn = "060004")
```

    # A tibble: 181 × 9
       npi        pac_id     first_name middle_name last_name   suffix facility_type
       <chr>      <chr>      <chr>      <chr>       <chr>       <chr>  <chr>        
     1 1003002890 6002953973 DANIEL     RICHARD     HAMMAN      <NA>   Hospital     
     2 1003019563 4688707060 JOHN       JOSEPH      FRANK       <NA>   Hospital     
     3 1003045022 5890926059 ARTHUR     H           DONAHUE     <NA>   Hospital     
     4 1003105636 6507182847 JAMES      CHARLES     HIGHAM KES… <NA>   Hospital     
     5 1003234162 4284940248 MATTHEW    <NA>        MCDIARMID   <NA>   Hospital     
     6 1003845249 1254326994 GARETH     R           WEINER      <NA>   Hospital     
     7 1013069566 7810096328 AMITY      D           HELZER      <NA>   Hospital     
     8 1013115989 4385891712 ASHLEY     L           PYLE        <NA>   Hospital     
     9 1013979566 1557374014 FIRAS      <NA>        MUWALLA     <NA>   Hospital     
    10 1023261963 2860687431 CHAD       MICHAEL     LUCCI       <NA>   Hospital     
    # ℹ 171 more rows
    # ℹ 2 more variables: facility_ccn <chr>, parent_ccn <chr>

``` r
facility_affiliations(parent_ccn = 670055)
```

    # A tibble: 9 × 9
      npi        pac_id     first_name middle_name last_name suffix facility_type   
      <chr>      <chr>      <chr>      <chr>       <chr>     <chr>  <chr>           
    1 1083742829 5698833655 RAFAEL     JORGE       FORNARIS  <NA>   Inpatient rehab…
    2 1144429580 3577659580 LYSA       LEE         CURRY     <NA>   Inpatient rehab…
    3 1558595660 8921241142 JOHN       D           ALFONSO   <NA>   Inpatient rehab…
    4 1609973650 0840373239 GEORGE     KIMBELL     WILCOX    <NA>   Inpatient rehab…
    5 1710112370 9739337122 VIDYA      <NA>        AMARANENI <NA>   Inpatient rehab…
    6 1720069859 7012947229 WILLIAM    WARREN      JANES     <NA>   Inpatient rehab…
    7 1740577212 0345473773 GEOFF      R           WEIKLE    <NA>   Inpatient rehab…
    8 1770861742 5193940997 AUSTON     J           MYERS     <NA>   Inpatient rehab…
    9 1912260464 5092036509 SAAD       MD          MANSOOR   <NA>   Inpatient rehab…
    # ℹ 2 more variables: facility_ccn <chr>, parent_ccn <chr>

### Hospital Enrollments

``` r
hospital_enrollment(facility_ccn = "060004")
```

    # A tibble: 1 × 36
      npi        enroll_id   enroll_state specialty_code specialty_desc facility_ccn
      <chr>      <chr>       <chr>        <chr>          <chr>          <chr>       
    1 1629071758 O200706190… CO           00-09          PART A PROVID… 060004      
    # ℹ 30 more variables: pac_id_org <chr>, org_name <chr>,
    #   doing_business_as <chr>, incorp_date <date>, incorp_length <dbl>,
    #   incorp_state <chr>, org_structure <chr>, org_other <chr>, address <chr>,
    #   city <chr>, state <chr>, zipcode <int>, location_type <chr>,
    #   location_other <chr>, multiple_npis <lgl>, proprietary_nonprofit <lgl>,
    #   sg_general <lgl>, sg_acute_care <lgl>, sg_alcohol_drug <lgl>,
    #   sg_childrens <lgl>, sg_long_term <lgl>, sg_short_term <lgl>, …

``` r
hospital_enrollment(state = "GA", city = "VALDOSTA")
```

    # A tibble: 3 × 36
      npi        enroll_id   enroll_state specialty_code specialty_desc facility_ccn
      <chr>      <chr>       <chr>        <chr>          <chr>          <chr>       
    1 1306896253 O200803120… GA           00-09          PART A PROVID… 110122      
    2 1467404046 O200803130… GA           00-09          PART A PROVID… 11T122      
    3 1538417753 O201212130… GA           00-09          PART A PROVID… 114036      
    # ℹ 30 more variables: pac_id_org <chr>, org_name <chr>,
    #   doing_business_as <chr>, incorp_date <date>, incorp_length <dbl>,
    #   incorp_state <chr>, org_structure <chr>, org_other <chr>, address <chr>,
    #   city <chr>, state <chr>, zipcode <int>, location_type <chr>,
    #   location_other <chr>, multiple_npis <lgl>, proprietary_nonprofit <lgl>,
    #   sg_general <lgl>, sg_acute_care <lgl>, sg_alcohol_drug <lgl>,
    #   sg_childrens <lgl>, sg_long_term <lgl>, sg_short_term <lgl>, …

``` r
hospital_enrollment(enroll_state = "GA")
```

    # A tibble: 214 × 36
       npi        enroll_id  enroll_state specialty_code specialty_desc facility_ccn
       <chr>      <chr>      <chr>        <chr>          <chr>          <chr>       
     1 1588664007 O20020826… GA           00-09          PART A PROVID… 112011      
     2 1376574277 O20021108… GA           00-09          PART A PROVID… 110005      
     3 1912951963 O20030515… GA           00-09          PART A PROVID… 110177      
     4 1063406684 O20030925… GA           00-09          PART A PROVID… 110043      
     5 1447252044 O20040406… GA           00-09          PART A PROVID… 112016      
     6 1679543672 O20040513… GA           00-09          PART A PROVID… 114008      
     7 1508810565 O20040823… GA           00-09          PART A PROVID… 110168      
     8 1922178789 O20041013… GA           00-09          PART A PROVID… 113301      
     9 1194722389 O20041103… GA           00-09          PART A PROVID… 112013      
    10 1811940976 O20041109… GA           00-09          PART A PROVID… 110201      
    # ℹ 204 more rows
    # ℹ 30 more variables: pac_id_org <chr>, org_name <chr>,
    #   doing_business_as <chr>, incorp_date <date>, incorp_length <dbl>,
    #   incorp_state <chr>, org_structure <chr>, org_other <chr>, address <chr>,
    #   city <chr>, state <chr>, zipcode <int>, location_type <chr>,
    #   location_other <chr>, multiple_npis <lgl>, proprietary_nonprofit <lgl>,
    #   sg_general <lgl>, sg_acute_care <lgl>, sg_alcohol_drug <lgl>, …

``` r
hospital_enrollment(enroll_id = "O20030404000017")
```

    ✖ No results for enroll_id: O20030404000017

### Missing Contact Information

``` r
missing_information(npi = 1144224569)
```

    # A tibble: 1 × 3
      npi        last_name first_name
      <chr>      <chr>     <chr>     
    1 1144224569 Clouse    John      

``` r
missing_information(npi = 11111122222)
```

    Error in `missing_information()`:
    ! NPI may be incorrect or invalid
    ℹ NPIs are 10 characters long.
    ✖ NPI: 11111122222 is 11 characters long.

### NPI Registry

``` r
nppes_npi(npi = 13164059391)
```

    Error in `nppes_npi()`:
    ! NPI may be incorrect or invalid
    ℹ NPIs are 10 characters long.
    ✖ NPI: 13164059391 is 11 characters long.

``` r
nppes_npi(npi = "155836427a")
```

    Error in `nppes_npi()`:
    ! NPI may be incorrect or invalid
    ℹ NPIs must be numeric.
    ✖ NPI: "155836427a" has non-numeric characters.

``` r
nppes_npi(1720081442)
```

    Error in `nppes_npi()`:
    ! NPI may be incorrect or invalid
    ℹ NPIs must pass Luhn algorithm.
    ✖ NPI 1720081442 fails Luhn check.

``` r
nppes_npi(1710983663) 
```

    ✖ No results for npi: 1710983663

``` r
nppes_npi(city = "Valdosta", org_name = "AIRPORT CLINIC INC")
```

    # A tibble: 2 × 28
      npi        entype       enumeration_date years_passed last_updated status
      <chr>      <chr>        <date>                  <dbl> <date>       <chr> 
    1 1730354739 Organization 2008-04-30               15.1 2013-11-21   A     
    2 1730354739 Organization 2008-04-30               15.1 2013-11-21   A     
    # ℹ 22 more variables: organization_name <chr>, organizational_subpart <lgl>,
    #   purpose <chr>, street <chr>, city <chr>, state <chr>, zipcode <chr>,
    #   country <chr>, phone_number <chr>, authorized_official_first_name <chr>,
    #   authorized_official_last_name <chr>,
    #   authorized_official_title_or_position <chr>,
    #   authorized_official_telephone_number <chr>, tx_code <chr>, tx_desc <chr>,
    #   tx_group <chr>, tx_state <lgl>, tx_license <lgl>, tx_primary <lgl>, …

``` r
nppes_npi(last_name = "Smith", purpose_name = "AO", city = "Atlanta")
```

    # A tibble: 236 × 36
       npi      entype enumeration_date years_passed last_updated certification_date
       <chr>    <chr>  <date>                  <dbl> <date>       <date>            
     1 1477605… Organ… 2007-01-18              16.4  2020-08-22   NA                
     2 1477605… Organ… 2007-01-18              16.4  2020-08-22   NA                
     3 1972882… Organ… 2011-08-16              11.8  2016-09-08   NA                
     4 1972882… Organ… 2011-08-16              11.8  2016-09-08   NA                
     5 1679724… Organ… 2008-10-09              14.6  2008-10-09   NA                
     6 1679724… Organ… 2008-10-09              14.6  2008-10-09   NA                
     7 1306357… Organ… 2017-10-17               5.63 2018-05-23   NA                
     8 1306357… Organ… 2017-10-17               5.63 2018-05-23   NA                
     9 1306357… Organ… 2017-10-17               5.63 2018-05-23   NA                
    10 1306357… Organ… 2017-10-17               5.63 2018-05-23   NA                
    # ℹ 226 more rows
    # ℹ 30 more variables: status <chr>, organization_name <chr>,
    #   organizational_subpart <lgl>, purpose <chr>, street <chr>, city <chr>,
    #   state <chr>, zipcode <chr>, country <chr>, phone_number <chr>,
    #   fax_number <chr>, authorized_official_first_name <chr>,
    #   authorized_official_middle_name <chr>, authorized_official_last_name <chr>,
    #   authorized_official_title_or_position <chr>, …

``` r
nppes_npi(last_name = "Smith", purpose_name = "Accounts", city = "Atlanta")
```

    Error in `nppes_npi()`:
    ! `purpose_name` must be one of "AO" or "Provider", not "Accounts".

``` r
provider_enrollment(specialty_code = "00-17", state = "GA") |> 
  dplyr::pull(npi) |> 
  purrr::map(nppes_npi) |> 
  purrr::list_rbind()
```

    # A tibble: 424 × 36
       npi      entype enumeration_date years_passed last_updated certification_date
       <chr>    <chr>  <date>                  <dbl> <date>       <date>            
     1 1992710… Organ… 2006-07-30               16.8 2021-04-28   2021-04-28        
     2 1992710… Organ… 2006-07-30               16.8 2021-04-28   2021-04-28        
     3 1992710… Organ… 2006-07-30               16.8 2021-04-28   2021-04-28        
     4 1992710… Organ… 2006-07-30               16.8 2021-04-28   2021-04-28        
     5 1992710… Organ… 2006-07-30               16.8 2021-04-28   2021-04-28        
     6 1992710… Organ… 2006-07-30               16.8 2021-04-28   2021-04-28        
     7 1992710… Organ… 2006-07-30               16.8 2021-04-28   2021-04-28        
     8 1992710… Organ… 2006-07-30               16.8 2021-04-28   2021-04-28        
     9 1992710… Organ… 2006-07-30               16.8 2021-04-28   2021-04-28        
    10 1992710… Organ… 2006-07-30               16.8 2021-04-28   2021-04-28        
    # ℹ 414 more rows
    # ℹ 30 more variables: status <chr>, organization_name <chr>,
    #   organizational_subpart <lgl>, purpose <chr>, street <chr>, city <chr>,
    #   state <chr>, zipcode <chr>, country <chr>, phone_number <chr>,
    #   fax_number <chr>, authorized_official_first_name <chr>,
    #   authorized_official_last_name <chr>,
    #   authorized_official_title_or_position <chr>, …

### Open Payments

``` r
open_payments(npi = 1043218118, year = 2021) |> 
  dplyr::filter(!is.na(covered)) |> 
  janitor::remove_empty(which = c("rows", "cols"))
```

    # A tibble: 105 × 42
       year  npi      profile_id changed cov_type first_name last_name address city 
       <chr> <chr>    <chr>      <lgl>   <chr>    <chr>      <chr>     <chr>   <chr>
     1 2021  1043218… 92058      FALSE   Physici… Ahad       Mahootchi 6739 G… Zeph…
     2 2021  1043218… 92058      FALSE   Physici… AHAD       MAHOOTCHI 6739 G… ZEPH…
     3 2021  1043218… 92058      FALSE   Physici… AHAD       MAHOOTCHI 6739 G… ZEPH…
     4 2021  1043218… 92058      FALSE   Physici… AHAD       MAHOOTCHI 6739 G… ZEPH…
     5 2021  1043218… 92058      FALSE   Physici… AHAD       MAHOOTCHI 6739 G… ZEPH…
     6 2021  1043218… 92058      FALSE   Physici… AHAD       MAHOOTCHI 6739 G… ZEPH…
     7 2021  1043218… 92058      FALSE   Physici… AHAD       MAHOOTCHI 6739 G… ZEPH…
     8 2021  1043218… 92058      FALSE   Physici… AHAD       MAHOOTCHI 6739 G… ZEPH…
     9 2021  1043218… 92058      FALSE   Physici… AHAD       MAHOOTCHI 6739 G… ZEPH…
    10 2021  1043218… 92058      FALSE   Physici… AHAD       MAHOOTCHI 6739 G… ZEPH…
    # ℹ 95 more rows
    # ℹ 33 more variables: state <chr>, zipcode <chr>, country <chr>,
    #   primary_type <chr>, primary_other <chr>, specialty <chr>,
    #   specialty_other <chr>, license_state <chr>, license_state_other <chr>,
    #   payer_id <chr>, payer_sub <chr>, payer_name <chr>, payer_state <chr>,
    #   payer_country <chr>, pay_total <dbl>, pay_date <date>, pay_count <chr>,
    #   pay_form <chr>, pay_nature <chr>, phys_ownship <lgl>, third_pay <chr>, …

### Opt-Out Affidavits

``` r
opt_out(first_name = "David", last_name = "Smith")
```

    # A tibble: 6 × 13
      npi        first_name last_name specialty    optout_start_date optout_end_date
      <chr>      <chr>      <chr>     <chr>        <date>            <date>         
    1 1649265760 David      Smith     Maxillofaci… 2012-06-25        2024-06-25     
    2 1750565958 David      Smith     Oral Surgery 2013-05-07        2023-05-07     
    3 1114058443 David      Smith     Psychiatry   2014-08-15        2024-08-15     
    4 1023002375 David      Smith     Obstetrics/… 2012-10-01        2024-10-01     
    5 1790853307 David      Smith     Oral Surgery 2015-03-26        2025-03-26     
    6 1659300077 David      Smith     Dentist      2015-05-26        2023-05-26     
    # ℹ 7 more variables: optout_duration <Duration>, last_updated <date>,
    #   order_and_refer <lgl>, address <chr>, city <chr>, state <chr>,
    #   zipcode <chr>

``` r
opt_out(specialty = "Psychiatry", 
        city = "Brooklyn", 
        state = "NY", 
        order_and_refer = FALSE)
```

    # A tibble: 4 × 13
      npi        first_name last_name specialty  optout_start_date optout_end_date
      <chr>      <chr>      <chr>     <chr>      <date>            <date>         
    1 1538251731 Robert     Katz      Psychiatry 2021-10-01        2023-10-01     
    2 1114239761 Adriel     Gerard    Psychiatry 2019-12-30        2023-12-30     
    3 1740635804 Joseph     Mouallem  Psychiatry 2020-07-22        2024-07-22     
    4 1932442191 Cecilia    Lipira    Psychiatry 2020-08-14        2024-08-14     
    # ℹ 7 more variables: optout_duration <Duration>, last_updated <date>,
    #   order_and_refer <lgl>, address <chr>, city <chr>, state <chr>,
    #   zipcode <chr>

``` r
opt_out(specialty = "Tsychiatry")
```

    ✖ No results for specialty: Tsychiatry

### Order and Referring Privileges

``` r
order_refer(npi = 1083879860)
```

    # A tibble: 1 × 7
      npi        first_name  last_name partb hha   dme   pmd  
      <chr>      <chr>       <chr>     <lgl> <lgl> <lgl> <lgl>
    1 1083879860 CHRISTOPHER AARON     TRUE  TRUE  TRUE  TRUE 

``` r
order_refer(last_name = "Smith", 
            partb = FALSE, 
            pmd = FALSE)
```

    # A tibble: 151 × 7
       npi        first_name last_name partb hha   dme   pmd  
       <chr>      <chr>      <chr>     <lgl> <lgl> <lgl> <lgl>
     1 1063535672 AARON      SMITH     FALSE FALSE TRUE  FALSE
     2 1891210431 ALAINA     SMITH     FALSE FALSE TRUE  FALSE
     3 1962830570 ALESHA     SMITH     FALSE FALSE TRUE  FALSE
     4 1922655521 ALLISON    SMITH     FALSE FALSE TRUE  FALSE
     5 1942778188 ALYSSA     SMITH     FALSE FALSE TRUE  FALSE
     6 1467902791 AMANDA     SMITH     FALSE FALSE TRUE  FALSE
     7 1992203582 AMANDA     SMITH     FALSE FALSE TRUE  FALSE
     8 1023475761 AMY        SMITH     FALSE FALSE TRUE  FALSE
     9 1609219773 AMY        SMITH     FALSE FALSE TRUE  FALSE
    10 1063878056 ANNA       SMITH     FALSE FALSE TRUE  FALSE
    # ℹ 141 more rows

### Pending Applications

``` r
pending_applications(last_name = "Smith", type = "non-physician")
```

    # A tibble: 21 × 4
       npi        last_name first_name type         
       <chr>      <chr>     <chr>      <chr>        
     1 1750870218 SMITH     ASHLEY     NON-PHYSICIAN
     2 1861062531 SMITH     ASHLEY     NON-PHYSICIAN
     3 1427639202 SMITH     BRANDON    NON-PHYSICIAN
     4 1801992912 SMITH     BRIDGET    NON-PHYSICIAN
     5 1407553340 SMITH     CAMILLE    NON-PHYSICIAN
     6 1811270325 SMITH     FRANCESCA  NON-PHYSICIAN
     7 1902527641 SMITH     HEATHER    NON-PHYSICIAN
     8 1386906386 SMITH     JANET      NON-PHYSICIAN
     9 1356079727 SMITH     JARED      NON-PHYSICIAN
    10 1891169751 SMITH     JEANA      NON-PHYSICIAN
    # ℹ 11 more rows

``` r
pending_applications(first_name = "John", type = "physician")
```

    # A tibble: 50 × 4
       npi        last_name first_name type     
       <chr>      <chr>     <chr>      <chr>    
     1 1881791739 ADAMS     JOHN       PHYSICIAN
     2 1275235814 ADENT     JOHN       PHYSICIAN
     3 1699397141 AHERN     JOHN       PHYSICIAN
     4 1861020240 BALTZ     JOHN       PHYSICIAN
     5 1841280963 BIGBEE    JOHN       PHYSICIAN
     6 1619996378 BODDEN    JOHN       PHYSICIAN
     7 1588744569 BRUNO     JOHN       PHYSICIAN
     8 1023591427 BRYAN     JOHN       PHYSICIAN
     9 1861142556 BURKE     JOHN       PHYSICIAN
    10 1306817531 COMBS     JOHN       PHYSICIAN
    # ℹ 40 more rows

``` r
pending_applications(first_name = "John", type = "dentist")
```

    Error in `pending_applications()`:
    ! `type` must be one of "physician" or "non-physician", not "dentist".

``` r
pending_applications(npi = "1083879860", 
                     first_name = "Gaelic", 
                     last_name = "Garlic",
                     type = "physician")
```

    ✖ No results for npi: 1083879860, last_name: Garlic, first_name: Gaelic, and
    type: physician

### Physician & Other Practitioners

``` r
# by Geography and Service
physician_by_geography(sublevel = "Georgia", year = 2020) |> 
  dplyr::slice_max(avg_payment, n = 10)
```

    # A tibble: 10 × 16
        year level sublevel fips  hcpcs_code hcpcs_desc     hcpcs_drug place_of_srvc
       <int> <chr> <chr>    <chr> <chr>      <chr>          <lgl>      <chr>        
     1  2020 State Georgia  13    Q2043      Sipuleucel-t,… TRUE       O            
     2  2020 State Georgia  13    37227      Removal of pl… FALSE      O            
     3  2020 State Georgia  13    G2170      Percutaneous … FALSE      F            
     4  2020 State Georgia  13    37229      Removal of pl… FALSE      O            
     5  2020 State Georgia  13    37231      Removal of pl… FALSE      O            
     6  2020 State Georgia  13    37226      Insertion of … FALSE      O            
     7  2020 State Georgia  13    37225      Removal of pl… FALSE      O            
     8  2020 State Georgia  13    37230      Insertion of … FALSE      O            
     9  2020 State Georgia  13    63685      Insertion of … FALSE      F            
    10  2020 State Georgia  13    C9740      Cystourethros… FALSE      F            
    # ℹ 8 more variables: tot_provs <int>, tot_benes <int>, tot_srvcs <int>,
    #   tot_day <int>, avg_charges <dbl>, avg_allowed <dbl>, avg_payment <dbl>,
    #   avg_std_pymt <dbl>

``` r
# by Provider and Service
physician_by_service(year = 2020, npi = 1083879860)
```

    # A tibble: 6 × 28
       year npi        entype     first_name middle_name last_name credential gender
      <int> <chr>      <chr>      <chr>      <chr>       <chr>     <chr>      <chr> 
    1  2020 1083879860 Individual Christoph… <NA>        Aaron     <NA>       M     
    2  2020 1083879860 Individual Christoph… <NA>        Aaron     <NA>       M     
    3  2020 1083879860 Individual Christoph… <NA>        Aaron     <NA>       M     
    4  2020 1083879860 Individual Christoph… <NA>        Aaron     <NA>       M     
    5  2020 1083879860 Individual Christoph… <NA>        Aaron     <NA>       M     
    6  2020 1083879860 Individual Christoph… <NA>        Aaron     <NA>       M     
    # ℹ 20 more variables: specialty <chr>, street <chr>, city <chr>, state <chr>,
    #   fips <chr>, zipcode <chr>, ruca <chr>, country <chr>, par <lgl>,
    #   hcpcs_code <chr>, hcpcs_desc <chr>, hcpcs_drug <chr>, place_of_srvc <chr>,
    #   tot_benes <int>, tot_srvcs <int>, tot_day <int>, avg_charges <dbl>,
    #   avg_allowed <dbl>, avg_payment <dbl>, avg_std_pymt <dbl>

``` r
# by Provider
physician_by_provider(npi = 1083879860, year = 2020)
```

    # A tibble: 1 × 70
       year npi     first_name middle_name last_name credential gender entype street
      <int> <chr>   <chr>      <chr>       <chr>     <chr>      <chr>  <chr>  <chr> 
    1  2020 108387… Christoph… <NA>        Aaron     <NA>       M      Indiv… 792 G…
    # ℹ 61 more variables: city <chr>, state <chr>, fips <chr>, zipcode <chr>,
    #   ruca <chr>, country <chr>, specialty <chr>, par <lgl>, tot_hcpcs <int>,
    #   tot_benes <int>, tot_srvcs <int>, tot_charges <dbl>, tot_allowed <dbl>,
    #   tot_payment <dbl>, tot_std_pymt <dbl>, drug_hcpcs <int>, drug_benes <int>,
    #   drug_srvcs <int>, drug_charges <dbl>, drug_allowed <dbl>,
    #   drug_payment <dbl>, drug_std_pymt <dbl>, med_hcpcs <int>, med_benes <int>,
    #   med_srvcs <int>, med_charges <dbl>, med_allowed <dbl>, med_payment <dbl>, …

### Provider Enrollment

``` r
provider_enrollment(npi = 1083879860)
```

    # A tibble: 1 × 11
      npi   pac_id enroll_id specialty_code specialty_desc state org_name first_name
      <chr> <chr>  <chr>     <chr>          <chr>          <chr> <chr>    <chr>     
    1 1083… 84263… I2020061… 14-08          PRACTITIONER … PA    <NA>     CHRISTOPH…
    # ℹ 3 more variables: middle_name <chr>, last_name <chr>, gender <chr>

``` r
provider_enrollment(specialty_code = "00-17", state = "GA") # GA RHCs
```

    # A tibble: 92 × 11
       npi        pac_id     enroll_id  specialty_code specialty_desc state org_name
       <chr>      <chr>      <chr>      <chr>          <chr>          <chr> <chr>   
     1 1992710610 8729997846 O20030404… 00-17          PART A PROVID… GA    TMC HAR…
     2 1497760243 0042129074 O20030407… 00-17          PART A PROVID… GA    TMC TAL…
     3 1285706879 1557271731 O20030610… 00-17          PART A PROVID… GA    HIAWASS…
     4 1982631321 5991616039 O20030918… 00-17          PART A PROVID… GA    TMC WES…
     5 1821017831 1850294034 O20040421… 00-17          PART A PROVID… GA    BACON C…
     6 1750339511 2264415538 O20040608… 00-17          PART A PROVID… GA    BOWDON-…
     7 1366472003 6002724598 O20041109… 00-17          PART A PROVID… GA    HOSPITA…
     8 1891863569 2062493083 O20050222… 00-17          PART A PROVID… GA    THE MED…
     9 1578682696 3779490503 O20070601… 00-17          PART A PROVID… GA    UNION C…
    10 1922211515 6002724598 O20070830… 00-17          PART A PROVID… GA    HOSPITA…
    # ℹ 82 more rows
    # ℹ 4 more variables: first_name <chr>, middle_name <chr>, last_name <chr>,
    #   gender <chr>

### Quality Payment Program

``` r
2017:2020 |> 
  furrr::future_map(\(x) quality_payment(year = x, npi = 1144544834)) |> 
  purrr::list_rbind() |> 
  janitor::remove_empty(which = c("rows", "cols"))
```

    # A tibble: 5 × 56
       year npi        provider_key state practice_size specialty  med_yrs part_type
      <int> <chr>      <chr>        <chr>         <int> <chr>        <int> <chr>    
    1  2017 1144544834 000865909    GA                8 Physician…       8 Group    
    2  2018 1144544834 000047522    GA                8 Physician…       8 Group    
    3  2018 1144544834 000117740    GA               12 Physician…       8 Group    
    4  2019 1144544834 000659906    GA               13 Physician…       9 Group    
    5  2020 1144544834 000000310    GA               13 Physician…      10 Group    
    # ℹ 48 more variables: beneficiaries <int>, allowed_charges <int>,
    #   services <int>, final_score <chr>, pmt_adj_pct <chr>,
    #   complex_patient_bonus <chr>, quality_category_score <chr>,
    #   quality_improvement_bonus <chr>, quality_bonus <lgl>, engaged <lgl>,
    #   opted_into_mips <lgl>, small_practitioner <lgl>, rural_clinician <lgl>,
    #   hpsa_clinician <lgl>, asc <lgl>, hospital_based <lgl>,
    #   non_patient_facing <lgl>, facility_based <lgl>, extreme_hardship <lgl>, …

### Revalidation Lists

``` r
# Revalidation Due Date List
revalidation_date(npi = 1710912209)
```

    # A tibble: 1 × 13
      npi        enroll_id    first_name last_name org_name enroll_state enroll_type
      <chr>      <chr>        <chr>      <chr>     <chr>    <chr>        <chr>      
    1 1710912209 I2004060200… Yelena     Voronova  <NA>     NY           3          
    # ℹ 6 more variables: enroll_desc <chr>, enroll_specialty <chr>,
    #   revalidation_due_date <date>, adjusted_due_date <date>,
    #   indiv_total_reassigned <chr>, rec_bene_reassign <int>

``` r
# Revalidation Reassignment List
revalidation_reassign(npi = 1710912209)
```

    # A tibble: 5 × 16
      npi        pac_id  enroll_id first_name last_name state specialty due_date_ind
      <chr>      <chr>   <chr>     <chr>      <chr>     <chr> <chr>     <date>      
    1 1710912209 286047… I2004060… Yelena     Voronova  NY    Podiatry  2019-10-31  
    2 1710912209 286047… I2004060… Yelena     Voronova  NY    Podiatry  2019-10-31  
    3 1710912209 286047… I2004060… Yelena     Voronova  NY    Podiatry  2019-10-31  
    4 1710912209 286047… I2004060… Yelena     Voronova  NY    Podiatry  2019-10-31  
    5 1710912209 286047… I2004060… Yelena     Voronova  NY    Podiatry  2019-10-31  
    # ℹ 8 more variables: ind_tot_emp_assn <int>, pac_id_group <chr>,
    #   enroll_id_group <chr>, business_name <chr>, state_group <chr>,
    #   due_date_group <date>, group_reassign_and_phys_assist <int>,
    #   record_type <chr>

``` r
# Revalidation Clinic Group Practice Reassignment
revalidation_group(npi = 1710912209)
```

    # A tibble: 5 × 15
      npi        enroll_id       first_name last_name state specialty due_date_ind
      <chr>      <chr>           <chr>      <chr>     <chr> <chr>     <date>      
    1 1710912209 I20040602001711 Yelena     Voronova  NY    Podiatry  2019-10-31  
    2 1710912209 I20040602001711 Yelena     Voronova  NY    Podiatry  2019-10-31  
    3 1710912209 I20040602001711 Yelena     Voronova  NY    Podiatry  2019-10-31  
    4 1710912209 I20040602001711 Yelena     Voronova  NY    Podiatry  2019-10-31  
    5 1710912209 I20040602001711 Yelena     Voronova  NY    Podiatry  2019-10-31  
    # ℹ 8 more variables: ind_tot_emp_assn <int>, pac_id_group <chr>,
    #   enroll_id_group <chr>, business_name <chr>, state_group <chr>,
    #   due_date_group <date>, group_reassign_and_phys_assist <int>,
    #   record_type <chr>

``` r
revalidation_group(enroll_id_group = "O20080205000002")
```

    # A tibble: 1 × 15
      npi        enroll_id       first_name last_name state specialty due_date_ind
      <chr>      <chr>           <chr>      <chr>     <chr> <chr>     <date>      
    1 1710912209 I20040602001711 Yelena     Voronova  NY    Podiatry  2019-10-31  
    # ℹ 8 more variables: ind_tot_emp_assn <int>, pac_id_group <chr>,
    #   enroll_id_group <chr>, business_name <chr>, state_group <chr>,
    #   due_date_group <date>, group_reassign_and_phys_assist <int>,
    #   record_type <chr>

### Taxonomy Crosswalk

``` r
taxonomy_crosswalk(specialty_desc = "Rehabilitation Agency")
```

    # A tibble: 2 × 4
      taxonomy_code taxonomy_desc                      specialty_code specialty_desc
      <chr>         <chr>                              <chr>          <chr>         
    1 261QR0400X    Ambulatory Health Care Facilities… B4[14]         Rehabilitatio…
    2 315D00000X    Nursing & Custodial Care Faciliti… B4[14]         Rehabilitatio…

``` r
taxonomy_crosswalk(specialty_code = "B4[14]")
```

    # A tibble: 13 × 4
       taxonomy_code taxonomy_desc                     specialty_code specialty_desc
       <chr>         <chr>                             <chr>          <chr>         
     1 261QR0400X    Ambulatory Health Care Facilitie… B4[14]         Rehabilitatio…
     2 335U00000X    Suppliers/Organ Procurement Orga… B4[14]         Organ Procure…
     3 261QM0801X    Ambulatory Health Care Facilitie… B4[14]         Community Men…
     4 261QR0401X    Ambulatory Health Care Facilitie… B4[14]         Comprehensive…
     5 261QE0700X    Ambulatory Health Care Facilitie… B4[14]         End-Stage Ren…
     6 261QF0400X    Ambulatory Health Care Facilitie… B4[14]         Federally Qua…
     7 251G00000X    Agencies/Hospice Care Community … B4[14]         Hospice       
     8 291U00000X    Laboratories/Clinical Medical La… B4[14]         Histocompatib…
     9 291900000X    Laboratories/Military Clinical M… B4[14]         <NA>          
    10 261QR0400X    Ambulatory Health Care Facilitie… B4[14]         Outpatient Ph…
    11 315D00000X    Nursing & Custodial Care Facilit… B4[14]         Rehabilitatio…
    12 282J00000X    Hospitals/Religious Non-medical … B4[14]         Religious Non…
    13 261QR1300X    Ambulatory Health Care Facilitie… B4[14]         Rural Health …

``` r
taxonomy_crosswalk(specialty_code = "8")
```

    # A tibble: 9 × 4
      taxonomy_code taxonomy_desc                      specialty_code specialty_desc
      <chr>         <chr>                              <chr>          <chr>         
    1 207Q00000X    Allopathic & Osteopathic Physicia… 8              Physician/Fam…
    2 207QA0401X    Allopathic & Osteopathic Physicia… 8              Physician/Fam…
    3 207QA0000X    Allopathic & Osteopathic Physicia… 8              Physician/Fam…
    4 207QA0505X    Allopathic & Osteopathic Physicia… 8              Physician/Fam…
    5 207QB0002X    Allopathic & Osteopathic Physicia… 8              Physician/Fam…
    6 207QG0300X    Allopathic & Osteopathic Physicia… 8              Physician/Fam…
    7 207QH0002X    Allopathic & Osteopathic Physicia… 8              Physician/Fam…
    8 207QS0010X    Allopathic & Osteopathic Physicia… 8              Physician/Fam…
    9 207QS1201X    Allopathic & Osteopathic Physicia… 8              Physician/Fam…

``` r
taxonomy_crosswalk(taxonomy_code = "207Q00000X")
```

    # A tibble: 1 × 4
      taxonomy_code taxonomy_desc                      specialty_code specialty_desc
      <chr>         <chr>                              <chr>          <chr>         
    1 207Q00000X    Allopathic & Osteopathic Physicia… 8              Physician/Fam…

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
