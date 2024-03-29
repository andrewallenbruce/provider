
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
[![Codecov test
coverage](https://codecov.io/gh/andrewallenbruce/provider/branch/main/graph/badge.svg)](https://app.codecov.io/gh/andrewallenbruce/provider?branch=main)
[![CodeFactor](https://www.codefactor.io/repository/github/andrewallenbruce/provider/badge)](https://www.codefactor.io/repository/github/andrewallenbruce/provider)
![GitHub
milestone](https://img.shields.io/github/milestones/progress/andrewallenbruce/provider/1?color=white&logo=milestones)
<!-- badges: end -->

> Providing easy access to [healthcare
> provider](https://en.wikipedia.org/wiki/Health_care_provider) data
> through publicly available APIs.

## :package: Installation

You can install **`provider`** from [GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("andrewallenbruce/provider")
```

## :beginner: Usage

``` r
library(provider)
library(dplyr)
library(tidyr)
```

### `affiliations()`

``` r
affiliations(npi = 1023630738,
             pac = 9032521372,
             facility_ccn = "37Z324") |> 
  glimpse()
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

### `beneficiaries()`

``` r
beneficiaries(year   = 2022, 
              period = "Year", 
              level  = "County", 
              state  = "GA", 
              county = "Lowndes") |> 
  glimpse()
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
    #> $ bene_orig         <int> 11732
    #> $ bene_ma_oth       <int> 8051
    #> $ bene_total_aged   <int> 16290
    #> $ bene_aged_esrd    <int> 129
    #> $ bene_aged_no_esrd <int> 16161
    #> $ bene_total_dsb    <int> 3492
    #> $ bene_dsb_esrd     <int> 143
    #> $ bene_dsb_no_esrd  <int> 3350
    #> $ bene_total_ab     <int> 18314
    #> $ bene_ab_orig      <int> 10270
    #> $ bene_ab_ma_oth    <int> 8044
    #> $ bene_total_rx     <int> 14028
    #> $ bene_rx_pdp       <int> 6431
    #> $ bene_rx_mapd      <int> 7596
    #> $ bene_rx_lis_elig  <int> 5146
    #> $ bene_rx_lis_full  <int> 464
    #> $ bene_rx_lis_part  <int> 143
    #> $ bene_rx_lis_no    <int> 8274

### `clinicians()`

``` r
clinicians(npi = 1932365699) |> 
  glimpse()
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
    #> $ state_org     <ord> CO
    #> $ zip_org       <chr> "81303"
    #> $ phone_org     <chr> "9702478762"

### `conditions()`

``` r
conditions(year  = 2018, 
           set   = "Multiple", 
           level = "National", 
           age   = "All", 
           demo  = "All", 
           mcc   = "6+") |> 
  glimpse()
```

    #> Rows: 1
    #> Columns: 12
    #> $ year                <int> 2018
    #> $ level               <ord> National
    #> $ sublevel            <ord> National
    #> $ age                 <fct> All
    #> $ demographic         <fct> All
    #> $ subdemo             <fct> All
    #> $ mcc                 <ord> 6+
    #> $ prevalence          <dbl> 0.177
    #> $ tot_pymt_percap     <dbl> 32475.26
    #> $ tot_std_pymt_percap <dbl> 30118.69
    #> $ hosp_readmit_rate   <dbl> 0.227
    #> $ er_visits_per_1k    <dbl> 1922.216

``` r
conditions(year      = 2018, 
           set       = "Specific", 
           level     = "National", 
           age       = "All", 
           demo      = "All",
           condition = "Arthritis") |> 
  glimpse()
```

    #> Rows: 1
    #> Columns: 12
    #> $ year                <int> 2018
    #> $ level               <ord> National
    #> $ sublevel            <ord> National
    #> $ age                 <fct> All
    #> $ demographic         <fct> All
    #> $ subdemo             <fct> All
    #> $ condition           <ord> Arthritis
    #> $ prevalence          <dbl> 0.3347
    #> $ tot_pymt_percap     <dbl> 16890.05
    #> $ tot_std_pymt_percap <dbl> 16006.14
    #> $ hosp_readmit_rate   <dbl> 0.1843
    #> $ er_visits_per_1k    <dbl> 1013.535

### `hospitals()`

``` r
hospitals(npi = 1720098791) |> 
  glimpse()
```

    #> Rows: 1
    #> Columns: 22
    #> $ npi_org           <chr> "1720098791"
    #> $ pac_org           <chr> "7618950643"
    #> $ enid_org          <chr> "O20230310002325"
    #> $ enid_state        <ord> GA
    #> $ facility_ccn      <chr> "110779"
    #> $ organization      <chr> "IRWIN COUNTY HOSPITAL"
    #> $ doing_business_as <chr> "PROGRESSIVE MEDICAL ENTERPRISE"
    #> $ specialty_code    <chr> "00-24"
    #> $ specialty         <chr> "PART A PROVIDER - RURAL EMERGENCY HOSPITAL (REH)"
    #> $ incorp_state      <ord> GA
    #> $ structure         <chr> "OTHER: HOSPITAL AUTHORITY"
    #> $ address           <chr> "710 N IRWIN AVE"
    #> $ city              <chr> "OCILLA"
    #> $ state             <ord> GA
    #> $ zip               <chr> "31774"
    #> $ location_type     <chr> "OTHER HOSPITAL PRACTICE LOCATION: REH"
    #> $ registration      <fct> Non-Profit
    #> $ multi_npi         <lgl> FALSE
    #> $ reh_date          <date> 2023-03-23
    #> $ reh_ccns          <chr> "110130"
    #> $ reh_conversion    <lgl> TRUE
    #> $ subgroup          <fct> None

### `laboratories()`

``` r
laboratories(clia = "11D0265516") |> 
  glimpse()
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
    #> $ director_affiliations <int> 0
    #> $ address               <chr> "205 WOODROW WILSON DR"
    #> $ city                  <chr> "VALDOSTA"
    #> $ state                 <ord> GA
    #> $ zip                   <chr> "31602"
    #> $ phone                 <chr> "8032619888"
    #> $ orig_part_date        <date> 1992-09-01
    #> $ application_date      <date> 1993-01-20
    #> $ certification_date    <date> 1996-03-21
    #> $ mailed_date           <date> 1996-09-25
    #> $ region                <fct> Atlanta
    #> $ clia_class_current    <fct> CLIA Lab

### `nppes()`

``` r
nppes(npi = 1497535637) |> 
  add_counties(state, 
               zip, 
               add_fips = TRUE, 
               add_geo = TRUE, 
               as_sf = TRUE)
```

    #> Simple feature collection with 1 feature and 25 fields
    #> Geometry type: POINT
    #> Dimension:     XY
    #> Bounding box:  xmin: -83.3 ymin: 30.9 xmax: -83.3 ymax: 30.9
    #> Geodetic CRS:  WGS 84
    #> # A tibble: 1 × 26
    #>   npi    entity_type enum_date  cert_date  last_update status first last  gender
    #> * <chr>  <fct>       <date>     <date>     <date>      <fct>  <chr> <chr> <fct> 
    #> 1 14975… Individual  2023-10-04 2023-10-05 2023-10-05  Active CART… ADAMS Male  
    #> # ℹ 17 more variables: credential <chr>, sole_prop <lgl>, purpose <fct>,
    #> #   address <chr>, city <chr>, state <ord>, zip <chr>, country <chr>,
    #> #   phone <chr>, tx_code <chr>, tx_primary <lgl>, tx_desc <chr>,
    #> #   tx_license <chr>, tx_state <ord>, county <chr>, county_fips <chr>,
    #> #   geometry <POINT [°]>

### `open_payments()`

``` r
open_payments(year  = 2021, 
              npi   = 1023630738, 
              na.rm = TRUE) |> 
  glimpse()
```

    #> Rows: 1
    #> Columns: 46
    #> $ program_year        <int> 2021
    #> $ npi                 <chr> "1023630738"
    #> $ covered_recipient   <fct> Non-Physician Practitioner
    #> $ first               <chr> "ALYSIA"
    #> $ middle              <chr> "MOTA"
    #> $ last                <chr> "SMITH"
    #> $ address             <chr> "610 N HOY ST"
    #> $ city                <chr> "BUFFALO"
    #> $ state               <ord> OK
    #> $ zip                 <chr> "73834"
    #> $ country             <chr> "United States"
    #> $ primary             <chr> "Physician Assistant"
    #> $ specialty           <chr> "Physician Assistants & Advanced Practice Nursing …
    #> $ license_state       <ord> OK
    #> $ physician_ownership <lgl> FALSE
    #> $ third_party_payment <chr> "No Third Party Payment"
    #> $ publish_date        <date> 2023-06-30
    #> $ publish_delay       <lgl> FALSE
    #> $ publish_dispute     <lgl> FALSE
    #> $ related_product     <lgl> TRUE
    #> $ payer_id            <chr> "100000866821"
    #> $ payer_sub           <chr> "Organon LLC"
    #> $ payer_name          <chr> "Organon LLC"
    #> $ payer_state         <ord> NJ
    #> $ payer_country       <chr> "United States"
    #> $ pay_form            <chr> "In-kind items and services"
    #> $ pay_nature          <chr> "Food and Beverage"
    #> $ pay_total           <dbl> 17.43
    #> $ pay_date            <date> 2021-08-25
    #> $ pay_count           <int> 1
    #> $ row_id              <int> 1
    #> $ group_id            <int> 1
    #> $ name                <chr> "NEXPLANON"
    #> $ covered             <lgl> TRUE
    #> $ type                <chr> "Drug"
    #> $ category            <chr> "CONTRACEPTIVES"
    #> $ ndc                 <chr> "78206-145-01"
    #> $ ndc.rxcui           <chr> "1111011"
    #> $ ndc.atc             <chr> "G03AC"
    #> $ ndc.status          <chr> "ACTIVE"
    #> $ ndc.brand_name      <chr> "NEXPLANON"
    #> $ ndc.drug_name       <chr> "etonogestrel 68 MG Drug Implant [Nexplanon]"
    #> $ ndc.atc_first       <chr> "genito urinary system and sex hormones"
    #> $ ndc.atc_second      <chr> "sex hormones and modulators of the genital system"
    #> $ ndc.atc_third       <chr> "hormonal contraceptives for systemic use"
    #> $ ndc.atc_fourth      <chr> "progestogens"

### `opt_out()`

``` r
opt_out(npi = 1043522824) |> 
  glimpse()
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
    #> $ state             <ord> AZ
    #> $ zip               <chr> "85255"

### `order_refer()`

``` r
order_refer(npi = 1043522824)
```

    #> # A tibble: 4 × 4
    #>   npi        first last  service                  
    #>   <chr>      <chr> <chr> <fct>                    
    #> 1 1043522824 JAMES SMITH Medicare Part B          
    #> 2 1043522824 JAMES SMITH Home Health Agency       
    #> 3 1043522824 JAMES SMITH Durable Medical Equipment
    #> 4 1043522824 JAMES SMITH Power Mobility Devices

### `outpatient()`

``` r
outpatient(year  = 2021, 
           state = "GA", 
           city  = "Valdosta", 
           apc   = "5072") |> 
  glimpse()
```

    #> Rows: 1
    #> Columns: 18
    #> $ year                <int> 2021
    #> $ ccn                 <chr> "110122"
    #> $ organization        <chr> "South Georgia Medical Center"
    #> $ address             <chr> "2501 North Patterson Street, Po Box 1727"
    #> $ city                <chr> "Valdosta"
    #> $ state               <ord> GA
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

### `prescribers()`

``` r
prescribers(year = 2019, 
            type = 'Provider', 
            npi = 1003000423) |> 
  glimpse()
```

    #> Rows: 1
    #> Columns: 67
    #> $ year                      <int> 2019
    #> $ npi                       <chr> "1003000423"
    #> $ entity_type               <fct> Individual
    #> $ first                     <chr> "Jennifer"
    #> $ middle                    <chr> "A"
    #> $ last                      <chr> "Velotta"
    #> $ gender                    <fct> Female
    #> $ credential                <chr> "MD"
    #> $ specialty                 <chr> "Obstetrics & Gynecology"
    #> $ source                    <fct> Medicare Specialty Code
    #> $ address                   <chr> "11100 Euclid Ave"
    #> $ city                      <chr> "Cleveland"
    #> $ state                     <ord> OH
    #> $ zip                       <chr> "44106"
    #> $ fips                      <chr> "39"
    #> $ ruca                      <chr> "1"
    #> $ country                   <chr> "US"
    #> $ tot_claims                <int> 199
    #> $ tot_fills                 <dbl> 344.0667
    #> $ tot_cost                  <dbl> 21614.75
    #> $ tot_supply                <int> 8759
    #> $ tot_benes                 <int> 65
    #> $ tot_claims_ge65           <int> 150
    #> $ tot_fills_ge65            <dbl> 260.8667
    #> $ tot_cost_ge65             <dbl> 17660.51
    #> $ tot_supply_ge65           <int> 6495
    #> $ tot_benes_ge65            <int> 49
    #> $ tot_claims_brand          <int> 49
    #> $ tot_cost_brand            <dbl> 14343.73
    #> $ tot_claims_generic        <int> 150
    #> $ tot_cost_generic          <dbl> 7271.02
    #> $ tot_claims_other          <int> 0
    #> $ tot_cost_other            <dbl> 0
    #> $ tot_claims_mapd           <int> 78
    #> $ tot_cost_mapd             <dbl> 9438.54
    #> $ tot_claims_pdp            <int> 121
    #> $ tot_cost_pdp              <dbl> 12176.21
    #> $ tot_claims_lis            <int> 73
    #> $ tot_cost_lis              <dbl> 9659.24
    #> $ tot_claims_nlis           <int> 126
    #> $ tot_cost_nlis             <dbl> 11955.51
    #> $ tot_claims_opioid         <int> 0
    #> $ tot_cost_opioid           <dbl> 0
    #> $ tot_supply_opioid         <int> 0
    #> $ tot_benes_opioid          <int> 0
    #> $ rx_rate_opioid            <dbl> 0
    #> $ tot_claims_opioid_la      <int> 0
    #> $ tot_cost_opioid_la        <dbl> 0
    #> $ tot_supply_opioid_la      <int> 0
    #> $ tot_benes_opioid_la       <int> 0
    #> $ tot_claims_antibioc       <int> 14
    #> $ tot_cost_antibioc         <dbl> 177.68
    #> $ tot_benes_antibioc        <int> 11
    #> $ tot_claims_antipsych_ge65 <int> 0
    #> $ tot_cost_antipsych_ge65   <dbl> 0
    #> $ tot_benes_antipsych_ge65  <int> 0
    #> $ bene_age_avg              <dbl> 66.63077
    #> $ bene_age_lt65             <int> 16
    #> $ bene_age_65_74            <int> 33
    #> $ bene_race_wht             <int> 60
    #> $ bene_race_nonwht          <int> 5
    #> $ bene_race_api             <int> 0
    #> $ bene_race_nat             <int> 0
    #> $ bene_race_oth             <int> 0
    #> $ bene_dual                 <int> 17
    #> $ bene_ndual                <int> 48
    #> $ hcc_risk_avg              <dbl> 0.8426269

``` r
prescribers(year = 2019, 
            npi = 1003000126,
            type = 'Drug',
            brand_name = 'Atorvastatin Calcium') |> 
  glimpse()
```

    #> Rows: 1
    #> Columns: 22
    #> $ year            <int> 2019
    #> $ npi             <chr> "1003000126"
    #> $ last            <chr> "Enkeshafi"
    #> $ first           <chr> "Ardalan"
    #> $ city            <chr> "Cumberland"
    #> $ state           <ord> MD
    #> $ fips            <chr> "24"
    #> $ specialty       <chr> "Internal Medicine"
    #> $ source          <fct> Medicare Specialty Code
    #> $ brand_name      <chr> "Atorvastatin Calcium"
    #> $ generic_name    <chr> "Atorvastatin Calcium"
    #> $ tot_claims      <int> 41
    #> $ tot_fills       <dbl> 50
    #> $ tot_supply      <int> 1482
    #> $ tot_cost        <dbl> 373.6
    #> $ tot_benes       <int> 22
    #> $ tot_claims_ge65 <int> 41
    #> $ tot_fills_ge65  <dbl> 50
    #> $ tot_cost_ge65   <dbl> 373.6
    #> $ tot_supply_ge65 <int> 1482
    #> $ tot_benes_ge65  <int> 22
    #> $ level           <ord> Provider

``` r
prescribers(year = 2021, 
            type = 'Geography',
            level = 'National',
            brand_name = 'Clotrimazole-Betamethasone') |> 
  glimpse()
```

    #> Rows: 1
    #> Columns: 20
    #> $ year            <int> 2021
    #> $ level           <ord> National
    #> $ state           <ord> National
    #> $ brand_name      <chr> "Clotrimazole-Betamethasone"
    #> $ generic_name    <chr> "Clotrimazole/Betamethasone Dip"
    #> $ tot_prescribers <int> 203283
    #> $ tot_claims      <int> 1611886
    #> $ tot_fills       <dbl> 1694182
    #> $ tot_cost        <dbl> 43735273
    #> $ tot_benes       <int> 887643
    #> $ tot_claims_ge65 <int> 1363536
    #> $ tot_fills_ge65  <dbl> 1435849
    #> $ tot_cost_ge65   <dbl> 36509742
    #> $ tot_benes_ge65  <int> 763073
    #> $ tot_cost_lis    <dbl> 877005.8
    #> $ tot_cost_nlis   <dbl> 11891222
    #> $ opioid          <lgl> FALSE
    #> $ opioid_la       <lgl> FALSE
    #> $ antibiotic      <lgl> FALSE
    #> $ antipsychotic   <lgl> FALSE

### `providers()`

``` r
providers(npi  = 1720098791, 
          enid = "O20040610001257") |> 
  glimpse()
```

    #> Rows: 1
    #> Columns: 7
    #> $ npi                   <chr> "1720098791"
    #> $ pac                   <chr> "7618950643"
    #> $ enid                  <chr> "O20040610001257"
    #> $ specialty_code        <chr> "12-70"
    #> $ specialty_description <chr> "PART B SUPPLIER - CLINIC/GROUP PRACTICE"
    #> $ state                 <ord> GA
    #> $ organization          <chr> "IRWIN COUNTY HOSPITAL"

### `quality_payment()`

``` r
quality_payment(year = 2021, 
                npi  = 1932365699) |> 
  glimpse()
```

    #> Rows: 1
    #> Columns: 20
    #> $ year            <int> 2021
    #> $ npi             <chr> "1932365699"
    #> $ state           <ord> CO
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
    #> $ statuses        <list> [<tbl_df[9 x 1]>]
    #> $ measures        <list> [<tbl_df[6 x 3]>]

``` r
q <- quality_payment(year = 2021, 
                     npi = 1932365699)

select(q, year, statuses) |> 
  unnest(statuses) 
```

    #> # A tibble: 9 × 2
    #>    year category                  
    #>   <int> <fct>                     
    #> 1  2021 Engaged                   
    #> 2  2021 Small Practitioner        
    #> 3  2021 Rural Clinician           
    #> 4  2021 HPSA Clinician            
    #> 5  2021 Extreme Hardship          
    #> 6  2021 Extreme Hardship (Quality)
    #> 7  2021 Extreme Hardship (PI)     
    #> 8  2021 Extreme Hardship (IA)     
    #> 9  2021 Extreme Hardship (Cost)

``` r
select(q, year, measures) |> 
  unnest(measures)
```

    #> # A tibble: 6 × 4
    #>    year measure id    score
    #>   <int> <fct>   <chr> <dbl>
    #> 1  2021 Quality 141       3
    #> 2  2021 Quality 014       3
    #> 3  2021 Quality 110       3
    #> 4  2021 Quality 47        3
    #> 5  2021 Quality 1         0
    #> 6  2021 Quality 117       0

### `quality_eligibility()`

``` r
quality_eligibility(year = 2021, 
                    npi  = 1932365699) |> 
  glimpse()
```

    #> Rows: 1
    #> Columns: 29
    #> $ year                <int> 2021
    #> $ npi                 <chr> "1932365699"
    #> $ npi_type            <fct> Individual
    #> $ first               <chr> "STEFAN"
    #> $ middle              <chr> "MICHAEL"
    #> $ last                <chr> "SMITH"
    #> $ first_approved_date <date> 2008-11-15
    #> $ pecos_year          <int> 2008
    #> $ newly_enrolled      <lgl> FALSE
    #> $ specialty_desc      <chr> "Optometry"
    #> $ specialty_type      <chr> "Doctor of Optometry"
    #> $ specialty_cat       <chr> "Physicians"
    #> $ is_maqi             <lgl> FALSE
    #> $ org_name            <chr> "LEE ANN HOVEN OD PC"
    #> $ org_hosp_vbp_name   <chr> NA
    #> $ org_facility_based  <lgl> FALSE
    #> $ org_address         <chr> "ADVANCED EYE CARE 1165S CAMINO DEL RIO SUITE 100"
    #> $ org_city            <chr> "DURANGO"
    #> $ org_state           <ord> CO
    #> $ org_zip             <chr> "81303"
    #> $ ind_lvt_status_code <chr> "BOTH"
    #> $ ind_lvt_status_desc <chr> "Both the unique beneficiaries and Part B"
    #> $ ind_hosp_vbp_score  <int> 0
    #> $ ind_specialty_code  <chr> "41"
    #> $ ind_specialty_desc  <chr> "Optometry"
    #> $ ind_specialty_type  <chr> "Doctor of Optometry"
    #> $ ind_specialty_cat   <chr> "Physicians"
    #> $ ind_status          <list> [<tbl_df[8 x 1]>]
    #> $ grp_status          <list> [<tbl_df[10 x 1]>]

### `reassignments()`

``` r
reassignments(npi = 1932365699, 
              pac_org = 7719037548) |> 
  glimpse()
```

    #> Rows: 1
    #> Columns: 12
    #> $ npi           <chr> "1932365699"
    #> $ pac           <chr> "42370496"
    #> $ enid          <chr> "I20171107000894"
    #> $ first         <chr> "STEFAN"
    #> $ last          <chr> "SMITH"
    #> $ associations  <int> 2
    #> $ organization  <chr> "EYE CENTER OF THE ROCKIES PC"
    #> $ pac_org       <chr> "7719037548"
    #> $ enid_org      <chr> "O20090616000599"
    #> $ state_org     <ord> CO
    #> $ reassignments <int> 5
    #> $ entry         <fct> Reassignment

### `utilization()`

``` r
utilization(year = 2021, 
            npi  = 1932365699, 
            type = "provider") |> 
  glimpse()
```

    #> Rows: 1
    #> Columns: 20
    #> $ year         <int> 2021
    #> $ npi          <chr> "1932365699"
    #> $ entity_type  <fct> Individual
    #> $ first        <chr> "Stefan"
    #> $ middle       <chr> "M"
    #> $ last         <chr> "Smith"
    #> $ gender       <fct> Male
    #> $ credential   <chr> "OD"
    #> $ specialty    <chr> "Optometry"
    #> $ address      <chr> "724 St. Louis Road"
    #> $ city         <chr> "Collinsville"
    #> $ state        <ord> IL
    #> $ zip          <chr> "62234"
    #> $ fips         <chr> "17"
    #> $ ruca         <chr> "1"
    #> $ country      <chr> "US"
    #> $ par          <lgl> TRUE
    #> $ performance  <list> [<tbl_df[1 x 11]>]
    #> $ demographics <list> [<tbl_df[1 x 12]>]
    #> $ conditions   <list> [<tbl_df[1 x 17]>]

``` r
p <- utilization(year = 2021, 
                 npi = 1932365699, 
                 type = "provider")

select(p, year, performance) |> 
  unnest(performance) |> 
  glimpse()
```

    #> Rows: 1
    #> Columns: 12
    #> $ year            <int> 2021
    #> $ tot_hcpcs       <int> 19
    #> $ tot_benes       <int> 279
    #> $ tot_srvcs       <int> 475
    #> $ tot_charges     <dbl> 57098.8
    #> $ tot_allowed     <dbl> 48345.19
    #> $ tot_payment     <dbl> 31966.13
    #> $ tot_std_pymt    <dbl> 31316.51
    #> $ .copay_deduct   <dbl> 16379.06
    #> $ .srvcs_per_bene <dbl> 1.702509
    #> $ .pymt_per_bene  <dbl> 114.5739
    #> $ .pymt_per_srvc  <dbl> 67.29712

``` r
select(p, year, demographics) |> 
  unnest(demographics) |> 
  glimpse()
```

    #> Rows: 1
    #> Columns: 13
    #> $ year               <int> 2021
    #> $ bene_age_avg       <int> 72
    #> $ bene_age_lt65      <int> 16
    #> $ bene_age_65_74     <int> 181
    #> $ bene_age_75_84     <int> 63
    #> $ bene_age_gt84      <int> 19
    #> $ bene_gen_female    <int> 157
    #> $ bene_gen_male      <int> 122
    #> $ bene_race_wht      <int> 245
    #> $ bene_race_nonwht   <int> 34
    #> $ bene_dual          <int> 40
    #> $ bene_ndual         <int> 239
    #> $ bene_race_detailed <list> [<tbl_df[1 x 5]>]

``` r
select(p, year, conditions) |> 
  unnest(conditions) |> 
  glimpse()
```

    #> Rows: 1
    #> Columns: 18
    #> $ year         <int> 2021
    #> $ hcc_risk_avg <dbl> 0.7719
    #> $ cc_af        <dbl> 0.08
    #> $ cc_alz       <dbl> 0.07
    #> $ cc_asth      <dbl> 0.06
    #> $ cc_canc      <dbl> 0.09
    #> $ cc_chf       <dbl> 0.06
    #> $ cc_ckd       <dbl> 0.15
    #> $ cc_copd      <dbl> 0.06
    #> $ cc_dep       <dbl> 0.19
    #> $ cc_diab      <dbl> 0.16
    #> $ cc_hplip     <dbl> 0.32
    #> $ cc_hpten     <dbl> 0.33
    #> $ cc_ihd       <dbl> 0.18
    #> $ cc_opo       <dbl> 0.13
    #> $ cc_raoa      <dbl> 0.3
    #> $ cc_sz        <dbl> NA
    #> $ cc_strk      <dbl> NA

``` r
utilization(year  = 2021, 
            npi   = 1932365699,
            hcpcs = "99214",
            type  = "service") |> 
  glimpse()
```

    #> Rows: 1
    #> Columns: 32
    #> $ year         <int> 2021
    #> $ npi          <chr> "1932365699"
    #> $ level        <ord> Provider
    #> $ first        <chr> "Stefan"
    #> $ middle       <chr> "M"
    #> $ last         <chr> "Smith"
    #> $ gender       <fct> Male
    #> $ credential   <chr> "O.D."
    #> $ specialty    <chr> "Optometry"
    #> $ address      <chr> "724 St. Louis Road"
    #> $ city         <chr> "Collinsville"
    #> $ state        <ord> IL
    #> $ zip          <chr> "62234"
    #> $ fips         <chr> "17"
    #> $ ruca         <chr> "1"
    #> $ country      <chr> "US"
    #> $ par          <lgl> TRUE
    #> $ hcpcs        <chr> "99214"
    #> $ hcpcs_desc   <chr> "Established patient outpatient visit, total time 30-39 m…
    #> $ category     <chr> "E&M"
    #> $ subcategory  <chr> "Office/Outpatient Services"
    #> $ family       <chr> "Office E&M - Established"
    #> $ procedure    <fct> Non-procedure
    #> $ drug         <lgl> FALSE
    #> $ pos          <fct> Non-facility
    #> $ tot_benes    <int> 24
    #> $ tot_srvcs    <int> 27
    #> $ tot_day      <int> 27
    #> $ avg_charge   <dbl> 134.7407
    #> $ avg_allowed  <dbl> 132.7281
    #> $ avg_payment  <dbl> 102.7159
    #> $ avg_std_pymt <dbl> 99.46074

``` r
utilization(year  = 2021, 
            hcpcs = "99205", 
            level = "National",
            pos   = "F",
            type  = "geography") |> 
  glimpse()
```

    #> Rows: 1
    #> Columns: 19
    #> $ year         <int> 2021
    #> $ level        <ord> National
    #> $ state        <ord> National
    #> $ hcpcs        <chr> "99205"
    #> $ hcpcs_desc   <chr> "New patient outpatient visit, total time 60-74 minutes"
    #> $ category     <chr> "E&M"
    #> $ subcategory  <chr> "Office/Outpatient Services"
    #> $ family       <chr> "Office E&M - New"
    #> $ procedure    <fct> Non-procedure
    #> $ drug         <lgl> FALSE
    #> $ pos          <fct> Facility
    #> $ tot_provs    <int> 65502
    #> $ tot_benes    <int> 574426
    #> $ tot_srvcs    <int> 653339
    #> $ tot_day      <int> 653311
    #> $ avg_charge   <dbl> 493.5003
    #> $ avg_allowed  <dbl> 186.2096
    #> $ avg_payment  <dbl> 143.4408
    #> $ avg_std_pymt <dbl> 139.6115

------------------------------------------------------------------------

## :balance_scale: Code of Conduct

Please note that the `provider` project is released with a [Contributor
Code of
Conduct](https://andrewallenbruce.github.io/provider/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.

## :classical_building: Governance

This project is primarily maintained by [Andrew
Bruce](https://github.com/andrewallenbruce). Other authors may
occasionally assist with some of these duties.
