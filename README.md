
<!-- README.md is generated from README.Rmd. Please edit that file -->

# provider <img src="man/figures/logo.svg" align="right" height="200" />

<!-- badges: start -->

[![R-CMD-check](https://github.com/andrewallenbruce/provider/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/andrewallenbruce/provider/actions/workflows/R-CMD-check.yaml)
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
> provider](https://en.wikipedia.org/wiki/Health_care_provider) data
> through publicly available APIs.

## Installation

You can install `provider` from [GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("andrewallenbruce/provider")
```

## Usage

``` r
library(provider)
library(dplyr)
```

## `affiliations()`

``` r
affiliations(npi = 1023630738, facility_ccn = "37Z324") |> glimpse()
```

    #> Rows: 1
    #> Columns: 7
    #> $ npi           <chr> "1023630738"
    #> $ pac           <chr> "9032521372"
    #> $ first         <chr> "ALYSIA"
    #> $ last          <chr> "SMITH"
    #> $ facility_type <fct> Nursing home
    #> $ facility_ccn  <chr> "37Z324"
    #> $ parent_ccn    <chr> "371324"

## `beneficiaries()`

``` r
beneficiaries(year = 2022, period = "Year", level = "County", state = "GA", county = "Lowndes") |> glimpse()
```

    #> Rows: 1
    #> Columns: 26
    #> $ year              <int> 2022
    #> $ period            <ord> Year
    #> $ level             <ord> County
    #> $ state             <ord> GA
    #> $ state_name        <ord> Georgia
    #> $ county            <chr> "Lowndes"
    #> $ fips              <chr> "13185"
    #> $ bene_total        <int> 19782
    #> $ bene_orig         <int> 11731
    #> $ bene_ma_oth       <int> 8051
    #> $ bene_total_aged   <int> 16289
    #> $ bene_aged_esrd    <int> 129
    #> $ bene_aged_no_esrd <int> 16160
    #> $ bene_total_dsb    <int> 3493
    #> $ bene_dsb_esrd     <int> 144
    #> $ bene_dsb_no_esrd  <int> 3349
    #> $ bene_total_ab     <int> 18315
    #> $ bene_ab_orig      <int> 10271
    #> $ bene_ab_ma_oth    <int> 8044
    #> $ bene_total_rx     <int> 14027
    #> $ bene_rx_pdp       <int> 6430
    #> $ bene_rx_mapd      <int> 7596
    #> $ bene_rx_lis_elig  <int> 5145
    #> $ bene_rx_lis_full  <int> 464
    #> $ bene_rx_lis_part  <int> 143
    #> $ bene_rx_lis_no    <int> 8274

## `clinicians()`

``` r
clinicians(npi = 1932365699) |> glimpse()
```

    #> Rows: 1
    #> Columns: 18
    #> $ npi           <chr> "1932365699"
    #> $ pac           <chr> "0042370496"
    #> $ enid          <chr> "I20171107000894"
    #> $ first         <chr> "STEFAN"
    #> $ middle        <chr> "MICHAEL"
    #> $ last          <chr> "SMITH"
    #> $ gender        <fct> Male
    #> $ school        <chr> "ILLINOIS COLLEGE OF OPTOMETRY AT CHICAGO"
    #> $ grad_year     <int> 2008
    #> $ specialty     <chr> "OPTOMETRY"
    #> $ facility_name <chr> "LEE ANN HOVEN OD PC"
    #> $ pac_org       <chr> "5193882009"
    #> $ members_org   <int> 2
    #> $ address_org   <chr> "1165 S CAMINO DEL RIO SUITE 100"
    #> $ city_org      <chr> "DURANGO"
    #> $ state_org     <chr> "CO"
    #> $ zip_org       <chr> "813036824"
    #> $ phone_org     <chr> "9702478762"

## `conditions()`

``` r
conditions(year = 2018, set = "multiple", level = "national", age = "all", demo = "all", mcc = "6+") |> glimpse()
```

    #> Rows: 1
    #> Columns: 12
    #> $ year                <int> 2018
    #> $ level               <ord> National
    #> $ sublevel            <ord> National
    #> $ age                 <fct> All
    #> $ demographic         <fct> All
    #> $ subdemo             <fct> All
    #> $ mcc                 <chr> "6+"
    #> $ prevalence          <dbl> 0.177
    #> $ tot_pymt_percap     <dbl> 32475.26
    #> $ tot_std_pymt_percap <dbl> 30118.69
    #> $ hosp_readmit_rate   <chr> "0.227"
    #> $ er_visits_per_1k    <dbl> 1922.216

## `hospitals()`

``` r
hospitals(npi = 1720098791) |> glimpse()
```

    #> Rows: 1
    #> Columns: 22
    #> $ npi_org           <chr> "1720098791"
    #> $ pac_org           <chr> "7618950643"
    #> $ enid_org          <chr> "O20230310002325"
    #> $ enid_state        <chr> "GA"
    #> $ facility_ccn      <chr> "110779"
    #> $ organization      <chr> "IRWIN COUNTY HOSPITAL"
    #> $ doing_business_as <chr> "PROGRESSIVE MEDICAL ENTERPRISE"
    #> $ specialty_code    <chr> "00-24"
    #> $ specialty         <chr> "PART A PROVIDER - RURAL EMERGENCY HOSPITAL (REH)"
    #> $ incorp_state      <chr> "GA"
    #> $ structure         <chr> "OTHER: HOSPITAL AUTHORITY"
    #> $ address           <chr> "710 N IRWIN AVE"
    #> $ city              <chr> "OCILLA"
    #> $ state             <chr> "GA"
    #> $ zip               <chr> "317745011"
    #> $ location_type     <chr> "OTHER HOSPITAL PRACTICE LOCATION: REH"
    #> $ registration      <fct> Non-Profit
    #> $ multi_npi         <lgl> FALSE
    #> $ reh_date          <date> 2023-03-23
    #> $ reh_ccns          <chr> "110130"
    #> $ reh_conversion    <lgl> TRUE
    #> $ subgroup          <fct> None

## `laboratories()`

``` r
laboratories(clia = "11D0265516") |> glimpse()
```

    #> Rows: 1
    #> Columns: 25
    #> $ clia_number           <chr> "11D0265516"
    #> $ provider_name         <chr> "DANIEL FELDMAN MD"
    #> $ certificate           <ord> Compliance
    #> $ clia_medicare         <chr> "00205114A3"
    #> $ effective_date        <date> 1996-08-29
    #> $ expiration_date       <date> 1998-08-04
    #> $ expired               <lgl> TRUE
    #> $ termination_reason    <ord> "Mail Returned No Forward Address Cert Ended (CL…
    #> $ status                <ord> In Compliance
    #> $ poc_ind               <lgl> TRUE
    #> $ type_of_action        <ord> Recertification
    #> $ ownership_type        <fct> Proprietary
    #> $ facility_type         <ord> Physician Office
    #> $ director_affiliations <chr> "0"
    #> $ address               <chr> "205 WOODROW WILSON DR"
    #> $ city                  <chr> "VALDOSTA"
    #> $ state                 <chr> "GA"
    #> $ zip                   <chr> "31602"
    #> $ phone                 <chr> "8032619888"
    #> $ orig_part_date        <date> 1992-09-01
    #> $ application_date      <date> 1993-01-20
    #> $ certification_date    <date> 1996-03-21
    #> $ mailed_date           <date> 1996-09-25
    #> $ region                <fct> Atlanta
    #> $ clia_class_current    <fct> CLIA Lab

## `nppes()`

``` r
nppes(npi = 1720098791) |> glimpse()
```

    #> Error in `dplyr::mutate()`:
    #> ℹ In argument: `gender = fct_gen(gender)`.
    #> Caused by error in `factor()`:
    #> ! object 'gender' not found

## `open_payments()`

``` r
open_payments(year = 2021, npi = 1023630738) |> glimpse()
```

    #> Rows: 1
    #> Columns: 38
    #> $ program_year        <int> 2021
    #> $ npi                 <chr> "1023630738"
    #> $ changed             <lgl> FALSE
    #> $ covered_recipient   <chr> "Non-Physician"
    #> $ first               <chr> "ALYSIA"
    #> $ middle              <chr> "MOTA"
    #> $ last                <chr> "SMITH"
    #> $ address             <chr> "610 N HOY ST"
    #> $ city                <chr> "BUFFALO"
    #> $ state               <chr> "OK"
    #> $ zip                 <chr> "73834"
    #> $ country             <chr> "United States"
    #> $ primary             <chr> "Physician Assistant"
    #> $ specialty           <chr> "Physician Assistants & Advanced Practice Nursing …
    #> $ license_state       <chr> "OK"
    #> $ payer_id            <chr> "100000866821"
    #> $ payer_sub           <chr> "Organon LLC"
    #> $ payer_name          <chr> "Organon LLC"
    #> $ payer_state         <chr> "NJ"
    #> $ payer_country       <chr> "United States"
    #> $ pay_total           <dbl> 17.43
    #> $ pay_date            <date> 2021-08-25
    #> $ pay_count           <chr> "1"
    #> $ pay_form            <chr> "In-kind items and services"
    #> $ pay_nature          <chr> "Food and Beverage"
    #> $ physician_ownership <chr> "No"
    #> $ third_party_payment <chr> "No Third Party Payment"
    #> $ publish_date        <date> 2023-06-30
    #> $ publish_delay       <chr> "No"
    #> $ publish_dispute     <chr> "No"
    #> $ related_product     <chr> "Yes"
    #> $ id                  <int> 1
    #> $ group               <int> 1
    #> $ name                <chr> "NEXPLANON"
    #> $ covered             <lgl> TRUE
    #> $ type                <chr> "Drug"
    #> $ category            <chr> "CONTRACEPTIVES"
    #> $ ndc                 <chr> "78206-145-01"

## `opt_out()`

``` r
opt_out(npi = 1043522824) |> glimpse()
```

    #> Rows: 1
    #> Columns: 12
    #> $ npi               <chr> "1043522824"
    #> $ first             <chr> "James"
    #> $ last              <chr> "Smith"
    #> $ specialty         <chr> "Nurse Practitioner"
    #> $ order_refer       <lgl> TRUE
    #> $ optout_start_date <date> 2019-07-01
    #> $ optout_end_date   <date> 2025-07-01
    #> $ last_updated      <date> 2023-09-15
    #> $ address           <chr> "8585 E HARTFORD DR STE 111"
    #> $ city              <chr> "SCOTTSDALE"
    #> $ state             <chr> "AZ"
    #> $ zip               <chr> "852555472"

## `order_refer()`

``` r
order_refer(npi = 1043522824, pivot = FALSE) |> glimpse()
```

    #> Rows: 1
    #> Columns: 7
    #> $ npi        <chr> "1043522824"
    #> $ last_name  <chr> "SMITH"
    #> $ first_name <chr> "JAMES"
    #> $ partb      <lgl> TRUE
    #> $ dme        <lgl> TRUE
    #> $ hha        <lgl> TRUE
    #> $ pmd        <lgl> TRUE

## `outpatient()`

``` r
outpatient(year = 2021, state = "GA", city = "Valdosta", apc = "5072") |> glimpse()
```

    #> Rows: 1
    #> Columns: 18
    #> $ year                <int> 2021
    #> $ ccn                 <chr> "110122"
    #> $ organization        <chr> "South Georgia Medical Center"
    #> $ street              <chr> "2501 North Patterson Street, Po Box 1727"
    #> $ city                <chr> "Valdosta"
    #> $ state               <chr> "GA"
    #> $ fips                <chr> "13"
    #> $ zip                 <chr> "31602"
    #> $ ruca                <chr> "1"
    #> $ apc                 <chr> "5072"
    #> $ apc_desc            <chr> "Level 2 Excision/ Biopsy/ Incision and Drainage"
    #> $ tot_benes           <int> 210
    #> $ comp_apc_srvcs      <int> 222
    #> $ avg_charges         <dbl> 6454.778
    #> $ avg_allowed         <dbl> 1233.753
    #> $ avg_payment         <dbl> 981.9733
    #> $ tot_outlier_srvcs   <int> 0
    #> $ avg_outlier_payment <dbl> 0

## `providers()`

``` r
providers(npi = 1720098791) |> glimpse()
```

    #> Rows: 2
    #> Columns: 7
    #> $ npi                   <chr> "1720098791", "1720098791"
    #> $ pac                   <chr> "7618950643", "7618950643"
    #> $ enid                  <chr> "O20040610001257", "O20230310002325"
    #> $ specialty_code        <chr> "12-70", "00-24"
    #> $ specialty_description <chr> "PART B SUPPLIER - CLINIC/GROUP PRACTICE", "PART…
    #> $ state                 <chr> "GA", "GA"
    #> $ organization          <chr> "IRWIN COUNTY HOSPITAL", "IRWIN COUNTY HOSPITAL"

## `quality_payment()`

``` r
quality_payment(year = 2021, npi = 1932365699) |> glimpse()
```

    #> Rows: 1
    #> Columns: 20
    #> $ year            <int> 2021
    #> $ npi             <chr> "1932365699"
    #> $ state           <chr> "CO"
    #> $ size            <int> 3
    #> $ specialty       <chr> "Optometry"
    #> $ med_years       <int> 14
    #> $ type            <fct> Group
    #> $ beneficiaries   <int> 555
    #> $ services        <int> 1157
    #> $ allowed_charges <dbl> 112449
    #> $ final_score     <dbl> 60
    #> $ pay_adjust      <dbl> 0
    #> $ quality_score   <dbl> 45
    #> $ pi_score        <dbl> 0
    #> $ ia_score        <dbl> 0
    #> $ cost_score      <dbl> 0
    #> $ complex_bonus   <dbl> 2.54
    #> $ qi_bonus        <dbl> 0
    #> $ statuses        <list> [<tbl_df[9 x 2]>]
    #> $ measures        <list> [<tbl_df[6 x 3]>]

## `reassignments()`

``` r
reassignments(npi = 1932365699) |> glimpse()
```

    #> Rows: 2
    #> Columns: 12
    #> $ npi           <chr> "1932365699", "1932365699"
    #> $ pac           <chr> "42370496", "42370496"
    #> $ enid          <chr> "I20171107000894", "I20171107000894"
    #> $ first         <chr> "STEFAN", "STEFAN"
    #> $ last          <chr> "SMITH", "SMITH"
    #> $ associations  <int> 2, 2
    #> $ organization  <chr> "EYE CENTER OF THE ROCKIES PC", "LEE ANN HOVEN OD PC"
    #> $ pac_org       <chr> "7719037548", "5193882009"
    #> $ enid_org      <chr> "O20090616000599", "O20090320000182"
    #> $ state_org     <chr> "CO", "CO"
    #> $ reassignments <int> 5, 6
    #> $ entry         <chr> "Reassignment", "Reassignment"

## `utilization()`

``` r
utilization(year = 2021, npi = 1932365699, type = "provider") |> glimpse()
```

    #> Rows: 1
    #> Columns: 20
    #> $ year         <int> 2021
    #> $ npi          <chr> "1932365699"
    #> $ entity_type  <chr> "I"
    #> $ first        <chr> "Stefan"
    #> $ middle       <chr> "M"
    #> $ last         <chr> "Smith"
    #> $ gender       <chr> "M"
    #> $ credential   <chr> "OD"
    #> $ specialty    <chr> "Optometry"
    #> $ address      <chr> "724 St. Louis Road"
    #> $ city         <chr> "Collinsville"
    #> $ state        <chr> "IL"
    #> $ zip          <chr> "62234"
    #> $ fips         <chr> "17"
    #> $ ruca         <chr> "1"
    #> $ country      <chr> "US"
    #> $ par          <lgl> TRUE
    #> $ performance  <list> [<tbl_df[1 x 11]>]
    #> $ demographics <list> [<tbl_df[1 x 15]>]
    #> $ conditions   <list> [<tbl_df[1 x 17]>]

------------------------------------------------------------------------

## Code of Conduct

Please note that the `provider` project is released with a [Contributor
Code of
Conduct](https://andrewallenbruce.github.io/provider/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
