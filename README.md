
<!-- README.md is generated from README.Rmd. Please edit that file -->

# provider <img src="man/figures/logo.svg" align="right" height="200" />

> Providing easy access to [healthcare
> provider](https://en.wikipedia.org/wiki/Health_care_provider) data
> through publicly available APIs.

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
<!-- badges: end -->

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
             facility_ccn = 370781) |> 
  glimpse()
```

    #> Rows: 1
    #> Columns: 6
    #> $ npi           <chr> "1023630738"
    #> $ pac           <chr> "9032521372"
    #> $ first         <chr> "ALYSIA"
    #> $ last          <chr> "SMITH"
    #> $ facility_type <fct> Hospital
    #> $ facility_ccn  <chr> "370781"

### `beneficiaries()`

``` r
beneficiaries(year   = 2023, 
              period = "Year", 
              level  = "County", 
              state  = "GA", 
              county = "Lowndes") |> 
  glimpse()
```

    #> Rows: 1
    #> Columns: 26
    #> $ year              <int> 2023
    #> $ period            <ord> Year
    #> $ level             <ord> County
    #> $ state             <ord> GA
    #> $ state_name        <ord> Georgia
    #> $ county            <chr> "Lowndes"
    #> $ fips              <chr> "13185"
    #> $ bene_total        <int> 20515
    #> $ bene_orig         <int> 11098
    #> $ bene_ma_oth       <int> 9418
    #> $ bene_total_aged   <int> 17046
    #> $ bene_aged_esrd    <int> 124
    #> $ bene_aged_no_esrd <int> 16923
    #> $ bene_total_dsb    <int> 3469
    #> $ bene_dsb_esrd     <int> 145
    #> $ bene_dsb_no_esrd  <int> 3325
    #> $ bene_total_ab     <int> 19038
    #> $ bene_ab_orig      <int> 9635
    #> $ bene_ab_ma_oth    <int> 9403
    #> $ bene_total_rx     <int> 14850
    #> $ bene_rx_pdp       <int> 5940
    #> $ bene_rx_mapd      <int> 8910
    #> $ bene_rx_lis_elig  <int> 5561
    #> $ bene_rx_lis_full  <int> 456
    #> $ bene_rx_lis_part  <int> 133
    #> $ bene_rx_lis_no    <int> 8701

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
  glimpse()
```

    #> Rows: 1
    #> Columns: 23
    #> $ npi         <chr> "1497535637"
    #> $ entity_type <fct> Individual
    #> $ enum_date   <date> 2023-10-04
    #> $ cert_date   <date> 2023-10-05
    #> $ last_update <date> 2023-10-05
    #> $ status      <fct> Active
    #> $ first       <chr> "CARTER"
    #> $ last        <chr> "ADAMS"
    #> $ gender      <fct> Male
    #> $ credential  <chr> "NP-BC"
    #> $ sole_prop   <lgl> FALSE
    #> $ purpose     <fct> Practice
    #> $ address     <chr> "2501 N PATTERSON ST"
    #> $ city        <chr> "VALDOSTA"
    #> $ state       <ord> GA
    #> $ zip         <chr> "31602"
    #> $ country     <chr> "US"
    #> $ phone       <chr> "229-433-1000"
    #> $ tx_code     <chr> "363L00000X"
    #> $ tx_primary  <lgl> TRUE
    #> $ tx_desc     <chr> "Nurse Practitioner"
    #> $ tx_license  <chr> "RN272237"
    #> $ tx_state    <ord> GA

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
    #> $ publish_date        <date> 2024-01-18
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
order_refer(npi = 1043522824, tidy = FALSE) |> 
  glimpse()
```

    #> Rows: 1
    #> Columns: 8
    #> $ NPI        <chr> "1043522824"
    #> $ LAST_NAME  <chr> "SMITH"
    #> $ FIRST_NAME <chr> "JAMES"
    #> $ PARTB      <chr> "Y"
    #> $ DME        <chr> "Y"
    #> $ HHA        <chr> "Y"
    #> $ PMD        <chr> "Y"
    #> $ HOSPICE    <chr> "N"

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
prescribers(year = 2021, 
            type = 'Provider', 
            npi = 1003000423) |> 
  glimpse()
```

    #> Rows: 1
    #> Columns: 27
    #> $ year           <int> 2021
    #> $ npi            <chr> "1003000423"
    #> $ entity_type    <fct> Individual
    #> $ first          <chr> "Jennifer"
    #> $ middle         <chr> "A"
    #> $ last           <chr> "Velotta"
    #> $ gender         <fct> Female
    #> $ credential     <chr> "MD"
    #> $ specialty      <chr> "Obstetrics & Gynecology"
    #> $ source         <fct> Medicare Specialty Code
    #> $ address        <chr> "11100 Euclid Ave"
    #> $ city           <chr> "Cleveland"
    #> $ state          <ord> OH
    #> $ zip            <chr> "44106"
    #> $ fips           <chr> "39"
    #> $ ruca           <chr> "1"
    #> $ country        <chr> "US"
    #> $ tot_claims     <int> 206
    #> $ tot_fills      <dbl> 378.2667
    #> $ tot_cost       <dbl> 20757.65
    #> $ tot_supply     <int> 10231
    #> $ tot_benes      <int> 66
    #> $ rx_rate_opioid <dbl> 0
    #> $ hcc_risk_avg   <dbl> 0.8011638
    #> $ detailed       <list> [<tbl_df[1 x 32]>]
    #> $ demographics   <list> [<tbl_df[1 x 14]>]
    #> $ gte_65         <list> [<tbl_df[1 x 8]>]

``` r
prescribers(year = 2019, 
            npi = 1003000126,
            type = 'Drug',
            brand_name = 'Atorvastatin Calcium') |> 
  glimpse()
```

    #> Rows: 1
    #> Columns: 18
    #> $ year         <int> 2019
    #> $ npi          <chr> "1003000126"
    #> $ last         <chr> "Enkeshafi"
    #> $ first        <chr> "Ardalan"
    #> $ city         <chr> "Cumberland"
    #> $ state        <ord> MD
    #> $ fips         <chr> "24"
    #> $ specialty    <chr> "Internal Medicine"
    #> $ source       <fct> Medicare Specialty Code
    #> $ brand_name   <chr> "Atorvastatin Calcium"
    #> $ generic_name <chr> "Atorvastatin Calcium"
    #> $ tot_claims   <int> 41
    #> $ tot_fills    <dbl> 50
    #> $ tot_supply   <int> 1482
    #> $ tot_cost     <dbl> 373.6
    #> $ tot_benes    <int> 22
    #> $ level        <ord> Provider
    #> $ gte_65       <list> [<tbl_df[1 x 7]>]

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
    #> Columns: 47
    #> $ year                <int> 2021
    #> $ npi                 <chr> "1932365699"
    #> $ npi_type            <fct> Individual
    #> $ first               <chr> "STEFAN"
    #> $ middle              <chr> "MICHAEL"
    #> $ last                <chr> "SMITH"
    #> $ state               <ord> CO
    #> $ first_approved_date <date> 2008-11-15
    #> $ years_in_medicare   <dbl> 13
    #> $ participation_type  <fct> Group
    #> $ beneficiaries       <int> 555
    #> $ services            <int> 1157
    #> $ charges             <dbl> 112449
    #> $ final_score         <dbl> 60
    #> $ pay_adjust          <dbl> 0
    #> $ quality_score       <dbl> 45
    #> $ pi_score            <dbl> 0
    #> $ ia_score            <dbl> 0
    #> $ cost_score          <dbl> 0
    #> $ complex_bonus       <dbl> 2.54
    #> $ qi_bonus            <dbl> 0
    #> $ newly_enrolled      <lgl> FALSE
    #> $ is_maqi             <lgl> FALSE
    #> $ org_id              <int> 1
    #> $ org_size            <int> 3
    #> $ org_name            <chr> "LEE ANN HOVEN OD PC"
    #> $ org_address         <chr> "ADVANCED EYE CARE 1165S CAMINO DEL RIO SUITE 100"
    #> $ org_city            <chr> "DURANGO"
    #> $ org_state           <ord> CO
    #> $ org_zip             <chr> "81303"
    #> $ org_hosp_vbp_name   <chr> NA
    #> $ org_facility_based  <lgl> FALSE
    #> $ ind_lvt_status_code <chr> "BOTH"
    #> $ ind_lvt_status_desc <chr> "Both the unique beneficiaries and Part B"
    #> $ ind_hosp_vbp_score  <int> 0
    #> $ specialty           <chr> "Optometry"
    #> $ specialty_desc      <chr> "Optometry"
    #> $ specialty_type      <chr> "Doctor of Optometry"
    #> $ specialty_cat       <chr> "Physicians"
    #> $ ind_specialty_code  <chr> "41"
    #> $ ind_specialty_desc  <chr> "Optometry"
    #> $ ind_specialty_type  <chr> "Doctor of Optometry"
    #> $ ind_specialty_cat   <chr> "Physicians"
    #> $ qpp_status          <list> [<tbl_df[9 x 1]>]
    #> $ qpp_measures        <list> [<tbl_df[6 x 3]>]
    #> $ ind_status          <list> [<tbl_df[8 x 1]>]
    #> $ grp_status          <list> [<tbl_df[10 x 1]>]

``` r
q <- quality_payment(year = 2021, 
                     npi = 1932365699)

q |> 
  select(
    year,
    qpp_status
    ) |> 
  unnest(qpp_status)
```

    #> # A tibble: 9 × 2
    #>    year qualified                 
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
q |> 
  select(
    year,
    qpp_measures
    ) |> 
  unnest(qpp_measures)
```

    #> # A tibble: 6 × 4
    #>    year category measure_id score
    #>   <int> <fct>    <chr>      <dbl>
    #> 1  2021 Quality  141            3
    #> 2  2021 Quality  014            3
    #> 3  2021 Quality  110            3
    #> 4  2021 Quality  47             3
    #> 5  2021 Quality  1              0
    #> 6  2021 Quality  117            0

### `quality_eligibility()`

``` r
quality_eligibility(year = 2021, 
                    npi  = 1932365699) |> 
  glimpse()
```

    #> Rows: 1
    #> Columns: 30
    #> $ year                <int> 2021
    #> $ npi                 <chr> "1932365699"
    #> $ npi_type            <fct> Individual
    #> $ first               <chr> "STEFAN"
    #> $ middle              <chr> "MICHAEL"
    #> $ last                <chr> "SMITH"
    #> $ first_approved_date <date> 2008-11-15
    #> $ years_in_medicare   <dbl> 13
    #> $ newly_enrolled      <lgl> FALSE
    #> $ specialty_desc      <chr> "Optometry"
    #> $ specialty_type      <chr> "Doctor of Optometry"
    #> $ specialty_cat       <chr> "Physicians"
    #> $ is_maqi             <lgl> FALSE
    #> $ org_id              <int> 1
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

    #> Error in `utilization()`:
    #> ! `type` must be one of "Provider", "Service", or "Geography", not
    #>   "provider".
    #> ℹ Did you mean "Provider"?

``` r
p <- utilization(year = 2021, 
                 npi = 1932365699, 
                 type = "provider")
```

    #> Error in `utilization()`:
    #> ! `type` must be one of "Provider", "Service", or "Geography", not
    #>   "provider".
    #> ℹ Did you mean "Provider"?

``` r
select(p, year, performance) |> 
  unnest(performance) |> 
  glimpse()
```

    #> Error in eval(expr, envir, enclos): object 'p' not found

``` r
select(p, year, demographics) |> 
  unnest(demographics) |> 
  glimpse()
```

    #> Error in eval(expr, envir, enclos): object 'p' not found

``` r
select(p, year, conditions) |> 
  unnest(conditions) |> 
  glimpse()
```

    #> Error in eval(expr, envir, enclos): object 'p' not found

``` r
utilization(year  = 2021, 
            npi   = 1932365699,
            hcpcs = "99214",
            type  = "service") |> 
  glimpse()
```

    #> Error in `utilization()`:
    #> ! `type` must be one of "Provider", "Service", or "Geography", not
    #>   "service".
    #> ℹ Did you mean "Service"?

``` r
utilization(year  = 2021, 
            hcpcs = "99205", 
            level = "National",
            pos   = "F",
            type  = "geography") |> 
  glimpse()
```

    #> Error in `utilization()`:
    #> ! `type` must be one of "Provider", "Service", or "Geography", not
    #>   "geography".
    #> ℹ Did you mean "Geography"?

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
