
<!-- README.md is generated from README.Rmd. Please edit that file -->

# provider <img src="man/figures/logo.svg" align="right" height="200" />

> Providing easy access to [healthcare
> provider](https://en.wikipedia.org/wiki/Health_care_provider) data
> through publicly available APIs.

<!-- badges: start -->

![GitHub R package
version](https://img.shields.io/github/r-package/v/andrewallenbruce/provider?style=flat-square&logo=R&label=Package&color=%23192a38)
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
affiliations(facility_ccn = 370781)
```

    #> # A tibble: 16 × 7
    #>    npi        pac        first     middle last        facility_type facility_ccn
    #>    <chr>      <chr>      <chr>     <chr>  <chr>       <fct>         <chr>       
    #>  1 1053547950 7618131160 AARON     S      SIZELOVE    Hospital      370781      
    #>  2 1083618003 6406913474 KEITH     J      KASSABIAN   Hospital      370781      
    #>  3 1225098460 2466474713 BRENDA    K      HUENERGARDT Hospital      370781      
    #>  4 1245239045 4082508833 STEVE     M      MADRID      Hospital      370781      
    #>  5 1316939622 2769376508 CHESTER   WRAY   BEAM        Hospital      370781      
    #>  6 1417376823 0941531362 MICHAEL   <NA>   TRAN        Hospital      370781      
    #>  7 1427045400 7517858608 THOMAS    <NA>   MCGARRY     Hospital      370781      
    #>  8 1487435053 8426405796 NICHOLAS  <NA>   RUSSENBERG… Hospital      370781      
    #>  9 1568453835 3870487739 DWAYNE    A      SCHMIDT     Hospital      370781      
    #> 10 1629043369 6103878764 JANA      NIKOLE MORRIS      Hospital      370781      
    #> 11 1659758472 3375853419 ALYSSA    B      MIZE        Hospital      370781      
    #> 12 1740291517 1052341575 WILLIAM   LANCE  GARNER      Hospital      370781      
    #> 13 1780762195 1052581154 CHRISTIAN L      KOOPMAN     Hospital      370781      
    #> 14 1790005809 2668699729 RYAN      B      HURST       Hospital      370781      
    #> 15 1891248191 1658620976 MATTHEW   I      ORGEL       Hospital      370781      
    #> 16 1922361740 1052633591 LYNNETTE  <NA>   MORRISON    Hospital      370781

### `beneficiaries()`

``` r
beneficiaries(
  year   = 2023, 
  period = "Year", 
  level  = "County", 
  state  = "GA", 
  county = "Lowndes County") |>
  glimpse()
```

    #> Rows: 1
    #> Columns: 26
    #> $ year              <int> 2023
    #> $ period            <ord> Year
    #> $ level             <ord> County
    #> $ state             <ord> GA
    #> $ state_name        <ord> Georgia
    #> $ county            <chr> "Lowndes County"
    #> $ fips              <chr> "13185"
    #> $ bene_total        <int> 20536
    #> $ bene_orig         <int> 11128
    #> $ bene_ma_oth       <int> 9408
    #> $ bene_total_aged   <int> 17059
    #> $ bene_aged_esrd    <int> 125
    #> $ bene_aged_no_esrd <int> 16933
    #> $ bene_total_dsb    <int> 3477
    #> $ bene_dsb_esrd     <int> 145
    #> $ bene_dsb_no_esrd  <int> 3333
    #> $ bene_total_ab     <int> 19048
    #> $ bene_ab_orig      <int> 9646
    #> $ bene_ab_ma_oth    <int> 9402
    #> $ bene_total_rx     <int> 14843
    #> $ bene_rx_pdp       <int> 5942
    #> $ bene_rx_mapd      <int> 8901
    #> $ bene_rx_lis_elig  <int> 5558
    #> $ bene_rx_lis_full  <int> 475
    #> $ bene_rx_lis_part  <int> 159
    #> $ bene_rx_lis_no    <int> 8651

### `clinicians()`

``` r
clinicians(npi = 1932365699) |> glimpse()
```

    #> Rows: 1
    #> Columns: 19
    #> $ npi           <chr> "1932365699"
    #> $ pac           <chr> "0042370496"
    #> $ enid          <chr> "I20171107000894"
    #> $ first         <chr> "STEFAN"
    #> $ middle        <chr> "MICHAEL"
    #> $ last          <chr> "SMITH"
    #> $ gender        <fct> Male
    #> $ credential    <chr> "OD"
    #> $ school        <chr> "ILLINOIS COLLEGE OF OPTOMETRY AT CHICAGO"
    #> $ grad_year     <int> 2008
    #> $ specialty     <chr> "OPTOMETRY"
    #> $ facility_name <chr> "LEE ANN HOVEN OD PC"
    #> $ pac_org       <chr> "5193882009"
    #> $ members_org   <int> 2
    #> $ address_org   <chr> "1165 S CAMINO DEL RIO SUITE 100"
    #> $ city_org      <chr> "DURANGO"
    #> $ state_org     <ord> CO
    #> $ zip_org       <chr> "813036824"
    #> $ phone_org     <chr> "9702478762"

### `hospitals()`

``` r
hospitals(npi = 1720098791) |> glimpse()
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
    #> $ zip               <chr> "317745011"
    #> $ location_type     <chr> "OTHER HOSPITAL PRACTICE LOCATION: REH"
    #> $ registration      <fct> Non-Profit
    #> $ multi_npi         <lgl> FALSE
    #> $ reh_date          <date> 2023-03-23
    #> $ reh_ccns          <chr> "110130"
    #> $ reh_conversion    <lgl> TRUE
    #> $ subgroup          <fct> None

### `laboratories()`

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
nppes(npi = 1497535637) |> glimpse()
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
    #> $ zip         <chr> "316021785"
    #> $ country     <chr> "US"
    #> $ phone       <chr> "229-433-1000"
    #> $ tx_code     <chr> "363L00000X"
    #> $ tx_primary  <lgl> TRUE
    #> $ tx_desc     <chr> "Nurse Practitioner"
    #> $ tx_license  <chr> "RN272237"
    #> $ tx_state    <ord> GA

### `open_payments()`

``` r
open_payments(
  year  = 2021, 
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
    #> $ publish_date        <date> 2024-06-28
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
    #> $ state             <ord> AZ
    #> $ zip               <chr> "852555472"

### `order_refer()`

``` r
order_refer(npi = 1043522824) |> glimpse()
```

    #> Rows: 4
    #> Columns: 4
    #> $ npi      <chr> "1043522824", "1043522824", "1043522824", "1043522824"
    #> $ first    <chr> "JAMES", "JAMES", "JAMES", "JAMES"
    #> $ last     <chr> "SMITH", "SMITH", "SMITH", "SMITH"
    #> $ eligible <fct> Medicare Part B, Home Health Agency, Durable Medical Equipmen…

### `outpatient()`

``` r
outpatient(
  year  = 2021, 
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
prescribers(
  year = 2022, 
  type = 'Provider', 
  npi = 1003000126) |> 
  glimpse()
```

    #> Rows: 1
    #> Columns: 28
    #> $ year              <int> 2022
    #> $ npi               <chr> "1003000126"
    #> $ entity_type       <fct> Individual
    #> $ first             <chr> "Ardalan"
    #> $ last              <chr> "Enkeshafi"
    #> $ gender            <fct> Male
    #> $ credential        <chr> "MD"
    #> $ specialty         <chr> "Internal Medicine"
    #> $ source            <chr> "Claim-Specialty"
    #> $ address           <chr> "6410 Rockledge Dr Ste 304"
    #> $ city              <chr> "Bethesda"
    #> $ state             <ord> MD
    #> $ zip               <chr> "20817"
    #> $ fips              <chr> "24"
    #> $ ruca              <chr> "1"
    #> $ country           <chr> "US"
    #> $ tot_claims        <int> 413
    #> $ tot_fills         <dbl> 715.7667
    #> $ tot_cost          <dbl> 36330.41
    #> $ tot_supply        <int> 19258
    #> $ tot_benes         <int> 155
    #> $ rx_rate_opioid    <dbl> 3.1477
    #> $ rx_rate_opioid_la <dbl> 0
    #> $ bene_race_blk     <int> 20
    #> $ hcc_risk_avg      <dbl> 2.059633
    #> $ detailed          <list> [<tbl_df[1 x 32]>]
    #> $ demographics      <list> [<tbl_df[1 x 14]>]
    #> $ gte_65            <list> [<tbl_df[1 x 8]>]

``` r
prescribers(
  year = 2022, 
  npi = 1003000126,
  type = 'Drug',
  brand_name = 'Atorvastatin Calcium') |> 
  glimpse()
```

    #> Rows: 1
    #> Columns: 17
    #> $ year         <int> 2022
    #> $ npi          <chr> "1003000126"
    #> $ last         <chr> "Enkeshafi"
    #> $ first        <chr> "Ardalan"
    #> $ city         <chr> "Bethesda"
    #> $ state        <ord> MD
    #> $ fips         <chr> "24"
    #> $ specialty    <chr> "Internal Medicine"
    #> $ source       <chr> "Claim-Specialty"
    #> $ brand_name   <chr> "Atorvastatin Calcium"
    #> $ generic_name <chr> "Atorvastatin Calcium"
    #> $ tot_claims   <int> 11
    #> $ tot_fills    <dbl> 29
    #> $ tot_supply   <int> 870
    #> $ tot_cost     <dbl> 286.69
    #> $ level        <ord> Provider
    #> $ gte_65       <list> [<tbl_df[1 x 7]>]

``` r
prescribers(
  year = 2022, 
  type = 'Geography',
  level = 'National',
  brand_name = 'Clotrimazole-Betamethasone') |> 
  glimpse()
```

    #> Rows: 1
    #> Columns: 20
    #> $ year            <int> 2022
    #> $ level           <ord> National
    #> $ state           <ord> National
    #> $ brand_name      <chr> "Clotrimazole-Betamethasone"
    #> $ generic_name    <chr> "Clotrimazole/Betamethasone Dip"
    #> $ tot_prescribers <int> 205696
    #> $ tot_claims      <int> 1598558
    #> $ tot_fills       <dbl> 1688104
    #> $ tot_cost        <dbl> 48271880
    #> $ tot_benes       <int> 879153
    #> $ tot_claims_ge65 <int> 1361135
    #> $ tot_fills_ge65  <dbl> 1439915
    #> $ tot_cost_ge65   <dbl> 40468578
    #> $ tot_benes_ge65  <int> 760752
    #> $ tot_cost_lis    <dbl> 767079.3
    #> $ tot_cost_nlis   <dbl> 12326159
    #> $ opioid          <lgl> FALSE
    #> $ opioid_la       <lgl> FALSE
    #> $ antibiotic      <lgl> FALSE
    #> $ antipsychotic   <lgl> FALSE

### `providers()`

``` r
providers(
  npi  = 1720098791, 
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
quality_payment(
  year = 2021, 
  npi  = 1932365699) |> 
  glimpse()
```

    #> Rows: 1
    #> Columns: 92
    #> $ `provider key`                                   <chr> "000493218"
    #> $ `practice state or us territory`                 <chr> "CO"
    #> $ `practice size`                                  <chr> "3"
    #> $ `clinician specialty`                            <chr> "Optometry"
    #> $ `years in medicare`                              <chr> "14"
    #> $ npi                                              <chr> "1932365699"
    #> $ engaged                                          <chr> "True"
    #> $ `participation type`                             <chr> "Group"
    #> $ `medicare patients`                              <chr> "555"
    #> $ `allowed charges`                                <chr> "112449"
    #> $ services                                         <chr> "1157"
    #> $ `opted into mips`                                <chr> "False"
    #> $ `small practitioner`                             <chr> "True"
    #> $ `rural clinician`                                <chr> "True"
    #> $ `hpsa clinician`                                 <chr> "True"
    #> $ `ambulatory surgical center`                     <chr> "False"
    #> $ `hospital-based clinician`                       <chr> "False"
    #> $ `non-patient facing`                             <chr> "False"
    #> $ `facility-based`                                 <chr> "False"
    #> $ `extreme hardship`                               <chr> "True"
    #> $ `final score`                                    <chr> "60"
    #> $ `payment adjustment percentage`                  <chr> "0"
    #> $ `complex patient bonus`                          <chr> "2.54"
    #> $ `extreme hardship quality`                       <chr> "True"
    #> $ `quality category score`                         <chr> "45"
    #> $ `quality improvement bonus`                      <chr> "0"
    #> $ `quality bonus`                                  <chr> "False"
    #> $ `quality measure id 1`                           <chr> "141"
    #> $ `quality measure score 1`                        <chr> "3"
    #> $ `quality measure id 2`                           <chr> "014"
    #> $ `quality measure score 2`                        <chr> "3"
    #> $ `quality measure id 3`                           <chr> "110"
    #> $ `quality measure score 3`                        <chr> "3"
    #> $ `quality measure id 4`                           <chr> "47"
    #> $ `quality measure score 4`                        <chr> "3"
    #> $ `quality measure id 5`                           <chr> "1"
    #> $ `quality measure score 5`                        <chr> "0"
    #> $ `quality measure id 6`                           <chr> "117"
    #> $ `quality measure score 6`                        <chr> "0"
    #> $ `quality measure id 7`                           <chr> ""
    #> $ `quality measure score 7`                        <chr> ""
    #> $ `quality measure id 8`                           <chr> ""
    #> $ `quality measure score 8`                        <chr> ""
    #> $ `quality measure id 9`                           <chr> ""
    #> $ `quality measure score 9`                        <chr> ""
    #> $ `quality measure id 10`                          <chr> ""
    #> $ `quality measure score 10`                       <chr> ""
    #> $ `promoting interoperability (pi) category score` <chr> "0"
    #> $ `extreme hardship pi`                            <chr> "True"
    #> $ `pi hardship`                                    <chr> "False"
    #> $ `pi reweighting`                                 <chr> "False"
    #> $ `pi bonus`                                       <chr> "False"
    #> $ `pi cehrt id`                                    <chr> ""
    #> $ `pi measure id 1`                                <chr> ""
    #> $ `pi measure score 1`                             <chr> ""
    #> $ `pi measure id 2`                                <chr> ""
    #> $ `pi measure score 2`                             <chr> ""
    #> $ `pi measure id 3`                                <chr> ""
    #> $ `pi measure score 3`                             <chr> ""
    #> $ `pi measure id 4`                                <chr> ""
    #> $ `pi measure score 4`                             <chr> ""
    #> $ `pi measure id 5`                                <chr> ""
    #> $ `pi measure score 5`                             <chr> ""
    #> $ `pi measure id 6`                                <chr> ""
    #> $ `pi measure score 6`                             <chr> ""
    #> $ `pi measure id 7`                                <chr> ""
    #> $ `pi measure score 7`                             <chr> ""
    #> $ `pi measure id 8`                                <chr> ""
    #> $ `pi measure score 8`                             <chr> ""
    #> $ `pi measure id 9`                                <chr> ""
    #> $ `pi measure score 9`                             <chr> ""
    #> $ `pi measure id 10`                               <chr> ""
    #> $ `pi measure score 10`                            <chr> ""
    #> $ `pi measure id 11`                               <chr> ""
    #> $ `pi measure score 11`                            <chr> ""
    #> $ `ia score`                                       <chr> "0"
    #> $ `extreme hardship ia`                            <chr> "True"
    #> $ `ia study`                                       <chr> "False"
    #> $ `ia measure id 1`                                <chr> ""
    #> $ `ia measure score 1`                             <chr> ""
    #> $ `ia measure id 2`                                <chr> ""
    #> $ `ia measure score 2`                             <chr> ""
    #> $ `ia measure id 3`                                <chr> ""
    #> $ `ia measure score 3`                             <chr> ""
    #> $ `ia measure id 4`                                <chr> ""
    #> $ `ia measure score 4`                             <chr> ""
    #> $ `cost score`                                     <chr> "0"
    #> $ `extreme hardship cost`                          <chr> "True"
    #> $ `cost measure id 1`                              <chr> ""
    #> $ `cost measure score 1`                           <chr> ""
    #> $ `cost measure id 2`                              <chr> ""
    #> $ `cost measure score 2`                           <chr> ""

### `quality_eligibility()`

``` r
quality_eligibility(
  year = 2024, 
  npi  = 1932365699,
  tidy = FALSE,
  unnest = FALSE,
  pivot = FALSE,
  na.rm = FALSE) |> 
  glimpse()
```

    #> Rows: 1
    #> Columns: 13
    #> $ year                           <chr> "2024"
    #> $ firstName                      <chr> "STEFAN"
    #> $ middleName                     <chr> "MICHAEL"
    #> $ lastName                       <chr> "SMITH"
    #> $ npi                            <chr> "1932365699"
    #> $ nationalProviderIdentifierType <int> 1
    #> $ firstApprovedDate              <chr> "2008-11-15"
    #> $ yearsInMedicare                <int> 16
    #> $ pecosEnrollmentDate            <int> 2008
    #> $ newlyEnrolled                  <lgl> FALSE
    #> $ specialty                      <df[,3]> <data.frame[1 x 3]>
    #> $ isMaqi                         <lgl> FALSE
    #> $ organizations                  <list> [<data.frame[2 x 12]>]

### `reassignments()`

``` r
reassignments(
  npi = 1932365699, 
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
utilization(
  year = 2022, 
  npi  = 1932365699, 
  type = "Provider") |> 
  glimpse()
```

    #> Rows: 1
    #> Columns: 20
    #> $ year         <int> 2022
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
    #> $ conditions   <list> [<tbl_df[1 x 1]>]

``` r
utilization(
  year  = 2022, 
  npi   = 1932365699,
  hcpcs = "99214",
  type  = "Service",
  rbcs = FALSE) |> 
  glimpse()
```

    #> Rows: 1
    #> Columns: 29
    #> $ year         <int> 2022
    #> $ npi          <chr> "1932365699"
    #> $ level        <ord> Provider
    #> $ entity_type  <chr> "I"
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
    #> $ hcpcs_desc   <chr> "Established patient office or other outpatient visit, 30…
    #> $ drug         <lgl> FALSE
    #> $ pos          <fct> Non-facility
    #> $ tot_benes    <int> 38
    #> $ tot_srvcs    <int> 46
    #> $ tot_day      <int> 46
    #> $ avg_charge   <dbl> 135
    #> $ avg_allowed  <dbl> 130.6146
    #> $ avg_payment  <dbl> 80.1337
    #> $ avg_std_pymt <dbl> 78.30435

``` r
utilization(
  year  = 2022, 
  hcpcs = "99205", 
  level = "National",
  pos   = "F",
  type  = "Geography",
  rbcs = FALSE) |> 
  glimpse()
```

    #> Rows: 1
    #> Columns: 15
    #> $ year         <int> 2022
    #> $ level        <ord> National
    #> $ state        <ord> National
    #> $ hcpcs        <chr> "99205"
    #> $ hcpcs_desc   <chr> "New patient office or other outpatient visit, 60-74 minu…
    #> $ drug         <lgl> FALSE
    #> $ pos          <fct> Facility
    #> $ tot_provs    <int> 67438
    #> $ tot_benes    <int> 589940
    #> $ tot_srvcs    <int> 672234
    #> $ tot_day      <int> 672211
    #> $ avg_charge   <dbl> 506.3615
    #> $ avg_allowed  <dbl> 183.1025
    #> $ avg_payment  <dbl> 139.1145
    #> $ avg_std_pymt <dbl> 137.0229

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
