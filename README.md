
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

## Motivation

``` r
library(provider)
```

<br>

The goal of `provider` is to make the experience of getting location
data easier and more consistent across a wide variety of sources.

This package is primarily focused on accessing public API data that can
be linked together via a healthcare provider’s National Provider
Identifier (NPI). Thus far, none of the APIs require the creation of a
user account or API key.

<br>

### NPPES NPI Registry

``` r
nppes_npi_new(npi = 1316405939)
```

    #> # A tibble: 1 × 19
    #>   npi       enumeration_type practice_locations first_name last_name middle_name
    #>   <chr>     <chr>            <lgl>              <chr>      <chr>     <chr>      
    #> 1 13164059… NPI-1            NA                 JAENA      ABARZUA   KAE        
    #> # ℹ 13 more variables: credential <chr>, sole_proprietor <chr>, gender <chr>,
    #> #   enumeration_date <date>, last_updated <date>, certification_date <dttm>,
    #> #   status <chr>, taxonomies <list>, identifiers <lgl>, endpoints <lgl>,
    #> #   other_names <list>, enumeration_age <Duration>, addresses <list>

### CMS Physician Facility Affiliations

``` r
facility_affiliations(npi = 1003019563)
```

    #> # A tibble: 4 × 10
    #>   record_number npi        ind_pac_id lst_nm frst_nm mid_nm suff  facility_type
    #>   <chr>         <chr>      <chr>      <chr>  <chr>   <chr>  <chr> <chr>        
    #> 1 2521          1003019563 4688707060 FRANK  JOHN    JOSEPH <NA>  Hospital     
    #> 2 2526          1003019563 4688707060 FRANK  JOHN    JOSEPH <NA>  Hospital     
    #> 3 2531          1003019563 4688707060 FRANK  JOHN    JOSEPH <NA>  Hospital     
    #> 4 2536          1003019563 4688707060 FRANK  JOHN    JOSEPH <NA>  Hospital     
    #> # ℹ 2 more variables: facility_afl_ccn <chr>, parent_ccn <chr>

``` r
facility_affiliations(facility_ccn = "060004")
```

    #> # A tibble: 188 × 10
    #>    record_number npi        ind_pac_id lst_nm frst_nm mid_nm suff  facility_type
    #>    <chr>         <chr>      <chr>      <chr>  <chr>   <chr>  <chr> <chr>        
    #>  1 351           1003002890 6002953973 HAMMAN DANIEL  RICHA… <NA>  Hospital     
    #>  2 2536          1003019563 4688707060 FRANK  JOHN    JOSEPH <NA>  Hospital     
    #>  3 5411          1003045022 5890926059 DONAH… ARTHUR  H      <NA>  Hospital     
    #>  4 13031         1003105636 6507182847 HIGHA… JAMES   CHARL… <NA>  Hospital     
    #>  5 24626         1003234162 4284940248 MCDIA… MATTHEW <NA>   <NA>  Hospital     
    #>  6 54431         1003845249 1254326994 WEINER GARETH  R      <NA>  Hospital     
    #>  7 85426         1013069566 7810096328 HELZER AMITY   D      <NA>  Hospital     
    #>  8 90441         1013115989 4385891712 PYLE   ASHLEY  L      <NA>  Hospital     
    #>  9 150336        1013979566 1557374014 MUWAL… FIRAS   <NA>   <NA>  Hospital     
    #> 10 201096        1023261963 2860687431 LUCCI  CHAD    MICHA… <NA>  Hospital     
    #> # ℹ 178 more rows
    #> # ℹ 2 more variables: facility_afl_ccn <chr>, parent_ccn <chr>

``` r
facility_affiliations(parent_ccn = 670055)
```

    #> # A tibble: 10 × 10
    #>    record_number npi        ind_pac_id lst_nm frst_nm mid_nm suff  facility_type
    #>    <chr>         <chr>      <chr>      <chr>  <chr>   <chr>  <chr> <chr>        
    #>  1 675486        1083742829 5698833655 FORNA… RAFAEL  JORGE  <NA>  Inpatient re…
    #>  2 1128701       1144429580 3577659580 CURRY  LYSA    LEE    <NA>  Inpatient re…
    #>  3 3309541       1427107028 1456328152 CHANEY DENNIS  M      <NA>  Inpatient re…
    #>  4 4350821       1558595660 8921241142 ALFON… JOHN    D      <NA>  Inpatient re…
    #>  5 4769311       1609973650 0840373239 WILCOX GEORGE  KIMBE… <NA>  Inpatient re…
    #>  6 5561756       1710112370 9739337122 VADDE… VIDYA   <NA>   <NA>  Inpatient re…
    #>  7 5646266       1720069859 7012947229 JANES  WILLIAM WARREN <NA>  Inpatient re…
    #>  8 5836046       1740577212 0345473773 WEIKLE GEOFF   R      <NA>  Inpatient re…
    #>  9 6079621       1770861742 5193940997 MYERS  AUSTON  J      <NA>  Inpatient re…
    #> 10 7129161       1912260464 5092036509 MANSO… SAAD    MD     <NA>  Inpatient re…
    #> # ℹ 2 more variables: facility_afl_ccn <chr>, parent_ccn <chr>

``` r
facility_affiliations(first_name = "John", last_name = "Hill", facility_type = "Home Health Agency")
```

    #> # A tibble: 7 × 10
    #>   record_number npi        ind_pac_id lst_nm frst_nm mid_nm suff  facility_type 
    #>   <chr>         <chr>      <chr>      <chr>  <chr>   <chr>  <chr> <chr>         
    #> 1 1360261       1174587588 7214998079 HILL   JOHN    C      III   Home health a…
    #> 2 1360266       1174587588 7214998079 HILL   JOHN    C      III   Home health a…
    #> 3 1360271       1174587588 7214998079 HILL   JOHN    C      III   Home health a…
    #> 4 4326236       1558380444 4789619362 HILL   JOHN    M      <NA>  Home health a…
    #> 5 4326241       1558380444 4789619362 HILL   JOHN    M      <NA>  Home health a…
    #> 6 4326246       1558380444 4789619362 HILL   JOHN    M      <NA>  Home health a…
    #> 7 4326251       1558380444 4789619362 HILL   JOHN    M      <NA>  Home health a…
    #> # ℹ 2 more variables: facility_afl_ccn <chr>, parent_ccn <chr>

### Hospital Enrollments

``` r
hospital_enrollment(facility_ccn = "060004")
```

    #> # A tibble: 1 × 36
    #>   enrollment_id   enrollment_state provider_type_code provider_type_text   npi  
    #>   <chr>           <chr>            <chr>              <chr>                <chr>
    #> 1 O20070619000323 CO               00-09              PART A PROVIDER - H… 1629…
    #> # ℹ 31 more variables: multiple_npi_flag <lgl>, ccn <chr>, associate_id <chr>,
    #> #   organization_name <chr>, doing_business_as_name <chr>,
    #> #   incorporation_date <chr>, incorporation_state <chr>,
    #> #   organization_type_structure <chr>, organization_other_type_text <chr>,
    #> #   proprietary_nonprofit <lgl>, address_line_1 <chr>, address_line_2 <chr>,
    #> #   city <chr>, state <chr>, zip_code <int>, practice_location_type <chr>,
    #> #   location_other_type_text <chr>, subgroup__general <lgl>, …

### CMS Doctors and Clinicians National File

``` r
doctors_and_clinicians(npi = 1407263999)
```

    #> # A tibble: 2 × 32
    #>   record_number npi     ind_pac_id ind_enrl_id lst_nm frst_nm mid_nm suff  gndr 
    #>   <chr>         <chr>   <chr>      <chr>       <chr>  <chr>   <chr>  <chr> <chr>
    #> 1 4995451       140726… 8729208152 I201410060… AVERY  ROBIN   A      <NA>  F    
    #> 2 4995456       140726… 8729208152 I201410060… AVERY  ROBIN   A      <NA>  F    
    #> # ℹ 23 more variables: cred <chr>, med_sch <chr>, grd_yr <chr>, pri_spec <chr>,
    #> #   sec_spec_1 <chr>, sec_spec_2 <chr>, sec_spec_3 <chr>, sec_spec_4 <chr>,
    #> #   sec_spec_all <chr>, telehlth <chr>, org_nm <chr>, org_pac_id <chr>,
    #> #   num_org_mem <chr>, adr_ln_1 <chr>, adr_ln_2 <chr>, ln_2_sprs <chr>,
    #> #   cty <chr>, st <chr>, zip <chr>, phn_numbr <chr>, ind_assgn <chr>,
    #> #   grp_assgn <chr>, adrs_id <chr>

``` r
doctors_and_clinicians(med_sch = "NEW YORK UNIVERSITY SCHOOL OF MEDICINE", grad_year = 2003, state = "FL")
```

    #> # A tibble: 7 × 32
    #>   record_number npi     ind_pac_id ind_enrl_id lst_nm frst_nm mid_nm suff  gndr 
    #>   <chr>         <chr>   <chr>      <chr>       <chr>  <chr>   <chr>  <chr> <chr>
    #> 1 412556        103323… 7618041781 I202206140… GOLDB… BRIAN   KEITH  <NA>  M    
    #> 2 2043441       116462… 5698811768 I200910020… KAPLAN KEVIN   M      <NA>  M    
    #> 3 3701041       129589… 7113029984 I202107010… CHAUD… JHUMA   <NA>   <NA>  F    
    #> 4 6190121       149795… 3476647330 I200709220… CHIEN  YUI     F      <NA>  M    
    #> 5 6190126       149795… 3476647330 I200709220… CHIEN  YUI     F      <NA>  M    
    #> 6 6190131       149795… 3476647330 I200709220… CHIEN  YUI     F      <NA>  M    
    #> 7 9918516       180100… 3577616598 I200908070… SCHET… CHRIS   <NA>   <NA>  M    
    #> # ℹ 23 more variables: cred <chr>, med_sch <chr>, grd_yr <chr>, pri_spec <chr>,
    #> #   sec_spec_1 <chr>, sec_spec_2 <chr>, sec_spec_3 <chr>, sec_spec_4 <chr>,
    #> #   sec_spec_all <chr>, telehlth <chr>, org_nm <chr>, org_pac_id <chr>,
    #> #   num_org_mem <chr>, adr_ln_1 <chr>, adr_ln_2 <chr>, ln_2_sprs <chr>,
    #> #   cty <chr>, st <chr>, zip <chr>, phn_numbr <chr>, ind_assgn <chr>,
    #> #   grp_assgn <chr>, adrs_id <chr>

### CMS Missing Contact Information

``` r
missing_information(npi = 1144224569)
```

    #> # A tibble: 1 × 3
    #>   npi        last_name first_name
    #>   <chr>      <chr>     <chr>     
    #> 1 1144224569 Clouse    John

### Medicare Order and Referring

``` r
order_refer(npi = 1083879860)
```

    #> # A tibble: 1 × 7
    #>   npi        last_name first_name  partb dme   hha   pmd  
    #>   <chr>      <chr>     <chr>       <lgl> <lgl> <lgl> <lgl>
    #> 1 1083879860 AARON     CHRISTOPHER TRUE  TRUE  TRUE  TRUE

### Medicare Opt-Out Affidavits

``` r
opt_out(last_name = "Aaron")
```

    #> # A tibble: 1 × 13
    #>   first_name last_name npi   specialty optout_effective_date optout_end_date    
    #>   <chr>      <chr>     <chr> <chr>     <dttm>                <dttm>             
    #> 1 Sheryl     Aaron     1427… Clinical… 2022-02-17 00:00:00   2024-02-17 00:00:00
    #> # ℹ 7 more variables: first_line_street_address <chr>,
    #> #   second_line_street_address <chr>, city_name <chr>, state_code <chr>,
    #> #   zip_code <chr>, eligible_to_order_and_refer <lgl>, last_updated <dttm>

### Medicare Provider and Supplier Taxonomy Crosswalk

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

### Medicare Fee-For-Service Public Provider Enrollment

``` r
provider_enrollment(npi = 1083879860)
```

    #> # A tibble: 1 × 11
    #>   npi        pecos_asct_cntl_id enrlmt_id    provider_type_cd provider_type_desc
    #>   <chr>      <chr>              <chr>        <chr>            <chr>             
    #> 1 1083879860 8426328519         I2020061700… 14-08            PRACTITIONER - FA…
    #> # ℹ 6 more variables: state_cd <chr>, first_name <chr>, mdl_name <chr>,
    #> #   last_name <chr>, org_name <chr>, gndr_sw <chr>

### Medicare Pending Initial Logging and Tracking

``` r
pending_applications(npi = 1487003984, type = "physician")
```

    #> ✖ NPI: 1487003984

``` r
pending_applications(npi = 1487003984, type = "non-physician")
```

    #> ✖ NPI: 1487003984

``` r
pending_applications(last_name = "Abbott", type = "non-physician")
```

    #> ✖ NPI:

``` r
pending_applications(first_name = "John", type = "physician")
```

    #> # A tibble: 35 × 3
    #>    npi        last_name  first_name
    #>    <chr>      <chr>      <chr>     
    #>  1 1881791739 ADAMS      JOHN      
    #>  2 1841280963 BIGBEE     JOHN      
    #>  3 1619996378 BODDEN     JOHN      
    #>  4 1588744569 BRUNO      JOHN      
    #>  5 1861142556 BURKE      JOHN      
    #>  6 1306817531 COMBS      JOHN      
    #>  7 1730349580 ECHEVARRIA JOHN      
    #>  8 1659074151 EUN        JOHN      
    #>  9 1376571554 FLYNN      JOHN      
    #> 10 1689774804 FREEMAN    JOHN      
    #> # ℹ 25 more rows

### Medicare Revalidation APIs

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

### CMS Open Payments API

``` r
open_payments(recipient_npi = 1043218118)
```

    #> # A tibble: 92 × 92
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
    #> # ℹ 88 more variables: teaching_hospital_ccn <chr>, teaching_hospital_id <chr>,
    #> #   teaching_hospital_name <chr>, covered_recipient_profile_id <chr>,
    #> #   covered_recipient_npi <chr>, covered_recipient_first_name <chr>,
    #> #   covered_recipient_middle_name <chr>, covered_recipient_last_name <chr>,
    #> #   covered_recipient_name_suffix <chr>,
    #> #   recipient_primary_business_street_address_line1 <chr>, …

### Medicare Monthly Enrollment API

``` r
beneficiary_enrollment(year = 2021, geo_level = "County", state_abb = "GA", month = NULL)
```

    #> # A tibble: 960 × 22
    #>     year month bene_geo_lvl bene_state_abrvtn bene_state_desc bene_county_desc
    #>    <int> <chr> <chr>        <chr>             <chr>           <chr>           
    #>  1  2021 Year  County       GA                Georgia         Appling         
    #>  2  2021 Year  County       GA                Georgia         Atkinson        
    #>  3  2021 Year  County       GA                Georgia         Bacon           
    #>  4  2021 Year  County       GA                Georgia         Baker           
    #>  5  2021 Year  County       GA                Georgia         Baldwin         
    #>  6  2021 Year  County       GA                Georgia         Banks           
    #>  7  2021 Year  County       GA                Georgia         Barrow          
    #>  8  2021 Year  County       GA                Georgia         Bartow          
    #>  9  2021 Year  County       GA                Georgia         Ben Hill        
    #> 10  2021 Year  County       GA                Georgia         Berrien         
    #> # ℹ 950 more rows
    #> # ℹ 16 more variables: bene_fips_cd <chr>, tot_benes <chr>,
    #> #   orgnl_mdcr_benes <chr>, ma_and_oth_benes <chr>, aged_tot_benes <chr>,
    #> #   aged_esrd_benes <chr>, aged_no_esrd_benes <chr>, dsbld_tot_benes <chr>,
    #> #   dsbld_esrd_and_esrd_only_benes <chr>, dsbld_no_esrd_benes <chr>,
    #> #   a_b_tot_benes <chr>, a_b_orgnl_mdcr_benes <chr>,
    #> #   a_b_ma_and_oth_benes <chr>, prscrptn_drug_tot_benes <chr>, …

### Medicare Physician & Other Practitioners APIs

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

    #> # A tibble: 5,866 × 16
    #>     year rndrng_prvdr_geo_lvl rndrng_prvdr_geo_cd rndrng_prvdr_geo_desc hcpcs_cd
    #>    <dbl> <chr>                <chr>               <chr>                 <chr>   
    #>  1  2020 State                24                  Maryland              0001A   
    #>  2  2020 State                24                  Maryland              0002A   
    #>  3  2020 State                24                  Maryland              00100   
    #>  4  2020 State                24                  Maryland              00103   
    #>  5  2020 State                24                  Maryland              00103   
    #>  6  2020 State                24                  Maryland              00104   
    #>  7  2020 State                24                  Maryland              0011A   
    #>  8  2020 State                24                  Maryland              00120   
    #>  9  2020 State                24                  Maryland              00126   
    #> 10  2020 State                24                  Maryland              00140   
    #> # ℹ 5,856 more rows
    #> # ℹ 11 more variables: hcpcs_desc <chr>, hcpcs_drug_ind <chr>,
    #> #   place_of_srvc <chr>, tot_rndrng_prvdrs <int>, tot_benes <int>,
    #> #   tot_srvcs <dbl>, tot_bene_day_srvcs <int>, avg_sbmtd_chrg <dbl>,
    #> #   avg_mdcr_alowd_amt <dbl>, avg_mdcr_pymt_amt <dbl>, avg_mdcr_stdzd_amt <dbl>

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

### Medicare Chronic Conditions APIs

``` r
# Multiple Chronic Conditions
cc_multiple(year = 2007, geo_level = "National", demo_level = "Race")
```

    #> # A tibble: 60 × 13
    #>     year bene_geo_lvl bene_geo_desc bene_geo_cd bene_age_lvl bene_demo_lvl
    #>    <dbl> <chr>        <chr>         <chr>       <chr>        <chr>        
    #>  1  2007 National     National      ""          65+          Race         
    #>  2  2007 National     National      ""          65+          Race         
    #>  3  2007 National     National      ""          65+          Race         
    #>  4  2007 National     National      ""          65+          Race         
    #>  5  2007 National     National      ""          65+          Race         
    #>  6  2007 National     National      ""          65+          Race         
    #>  7  2007 National     National      ""          65+          Race         
    #>  8  2007 National     National      ""          65+          Race         
    #>  9  2007 National     National      ""          65+          Race         
    #> 10  2007 National     National      ""          65+          Race         
    #> # ℹ 50 more rows
    #> # ℹ 7 more variables: bene_demo_desc <chr>, bene_mcc <chr>, prvlnc <dbl>,
    #> #   tot_mdcr_stdzd_pymt_pc <dbl>, tot_mdcr_pymt_pc <dbl>,
    #> #   hosp_readmsn_rate <dbl>, er_visits_per_1000_benes <dbl>

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

------------------------------------------------------------------------

## Code of Conduct

Please note that the `provider` project is released with a [Contributor
Code of
Conduct](https://andrewallenbruce.github.io/provider/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
