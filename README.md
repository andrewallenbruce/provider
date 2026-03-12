
<!-- README.md is generated from README.Rmd. Please edit that file -->

# <b>provider</b> <a href="https://andrewallenbruce.github.io/provider/"><img src="man/figures/logo.svg" align="right" height="139" alt="provider website" /></a>

<br>

> Tidy Healthcare Provider API Interface

<br>

<!-- badges: start -->

![GitHub R package
version](https://img.shields.io/github/r-package/v/andrewallenbruce/provider?style=flat-square&logo=R&label=Package&color=%23192a38)
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

You can install `provider` from [GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("andrewallenbruce/provider")
```

## :beginner: Usage

``` r
library(provider)
```

#### Facility Affiliations

``` r
affiliations(facility_ccn = 370781)
```

    #> ✔ Query returned 15 results.

    #> # A tibble: 15 × 9
    #>    first   last  middle suffix npi   pac   facility_type facility_ccn parent_ccn
    #>    <chr>   <chr> <chr>  <chr>  <chr> <chr> <chr>         <chr>        <chr>     
    #>  1 NICOLE  LEE   <NA>   <NA>   1003… 1254… Hospital      370781       <NA>      
    #>  2 LEILA   SEE   DANIE… <NA>   1013… 6800… Hospital      370781       <NA>      
    #>  3 AARON   SIZE… S      <NA>   1053… 7618… Hospital      370781       <NA>      
    #>  4 KEITH   KASS… J      <NA>   1083… 6406… Hospital      370781       <NA>      
    #>  5 STEVE   MADR… M      <NA>   1245… 4082… Hospital      370781       <NA>      
    #>  6 CHESTER BEAM  WRAY   <NA>   1316… 2769… Hospital      370781       <NA>      
    #>  7 COREY   FINCH D      <NA>   1407… 3870… Hospital      370781       <NA>      
    #>  8 THOMAS  MCGA… <NA>   <NA>   1427… 7517… Hospital      370781       <NA>      
    #>  9 NICHOL… RUSS… <NA>   <NA>   1487… 8426… Hospital      370781       <NA>      
    #> 10 DWAYNE  SCHM… A      <NA>   1568… 3870… Hospital      370781       <NA>      
    #> 11 JANA    MORR… NIKOLE <NA>   1629… 6103… Hospital      370781       <NA>      
    #> 12 TIMOTHY GRAH… AARON  <NA>   1710… 9739… Hospital      370781       <NA>      
    #> 13 RICHARD COST… F      JR.    1710… 2163… Hospital      370781       <NA>      
    #> 14 VEDMIA  FONK… <NA>   <NA>   1801… 9436… Hospital      370781       <NA>      
    #> 15 JESS    ARMOR F      <NA>   1922… 9032… Hospital      370781       <NA>

#### National Provider Catalog

``` r
clinicians(npi = 1932365699) |> str()
```

    #> ✔ Query returned 1 result.

    #> tibble [1 × 25] (S3: tbl_df/tbl/data.frame)
    #>  $ first        : chr "STEFAN"
    #>  $ middle       : chr "MICHAEL"
    #>  $ last         : chr "SMITH"
    #>  $ suffix       : chr NA
    #>  $ gender       : chr "M"
    #>  $ cred         : chr "OD"
    #>  $ school       : chr "ILLINOIS COLLEGE OF OPTOMETRY AT CHICAGO"
    #>  $ year         : chr "2008"
    #>  $ specialty    : chr "OPTOMETRY"
    #>  $ spec_other   : chr NA
    #>  $ facility_name: chr "VEP IL OPTOMETRIC LLC"
    #>  $ npi          : chr "1932365699"
    #>  $ pac          : chr "0042370496"
    #>  $ enid         : chr "I20081115000066"
    #>  $ org_pac      : chr "3678814217"
    #>  $ org_mems     : chr "25"
    #>  $ add_1        : chr "1001 CHARLESTON AVE E"
    #>  $ add_2        : chr NA
    #>  $ city         : chr "MATTOON"
    #>  $ state        : chr "IL"
    #>  $ zip          : chr "619386226"
    #>  $ phone        : chr "2172352020"
    #>  $ ind          : chr "Y"
    #>  $ grp          : chr "Y"
    #>  $ tele         : chr NA

#### Hospitals

``` r
hospitals(npi = 1720098791) |> str()
```

    #> ✔ Query returned 1 result.

    #> tibble [1 × 39] (S3: tbl_df/tbl/data.frame)
    #>  $ org_name      : chr "IRWIN COUNTY HOSPITAL"
    #>  $ dba_name      : chr "PROGRESSIVE MEDICAL ENTERPRISE"
    #>  $ enid          : chr "O20230310002325"
    #>  $ enid_state    : chr "GA"
    #>  $ spec          : chr "00-24"
    #>  $ specialty     : chr "PART A PROVIDER - RURAL EMERGENCY HOSPITAL (REH)"
    #>  $ npi           : chr "1720098791"
    #>  $ multi         : chr "N"
    #>  $ ccn           : chr "110779"
    #>  $ ccn_2         : chr "110130"
    #>  $ pac           : chr "7618950643"
    #>  $ inc_date      : chr NA
    #>  $ inc_state     : chr "GA"
    #>  $ org_type      : chr "OTHER"
    #>  $ org_text      : chr "HOSPITAL AUTHORITY"
    #>  $ designation   : chr "N"
    #>  $ add_1         : chr "710 N IRWIN AVE"
    #>  $ add_2         : chr NA
    #>  $ city          : chr "OCILLA"
    #>  $ state         : chr "GA"
    #>  $ zip           : chr "317745011"
    #>  $ location_type : chr "OTHER HOSPITAL PRACTICE LOCATION"
    #>  $ location_text : chr "REH"
    #>  $ reh_ind       : chr "Y"
    #>  $ reh_date      : chr "2023-03-23"
    #>  $ sub_general   : chr "N"
    #>  $ sub_acute     : chr "N"
    #>  $ sub_drug      : chr "N"
    #>  $ sub_child     : chr "N"
    #>  $ sub_long      : chr "N"
    #>  $ sub_psych     : chr "N"
    #>  $ sub_rehab     : chr "N"
    #>  $ sub_short     : chr "N"
    #>  $ sub_swing     : chr "N"
    #>  $ sub_psych_unit: chr "N"
    #>  $ sub_rehab_unit: chr "N"
    #>  $ sub_specialty : chr "N"
    #>  $ sub_other     : chr "N"
    #>  $ sub_otext     : chr NA

#### CLIA Laboratories

``` r
laboratories(ccn = "11D0265516") |> str()
```

    #> ✔ Query returned 1 result.

    #> tibble [1 × 82] (S3: tbl_df/tbl/data.frame)
    #>  $ name_1     : chr "DANIEL FELDMAN MD"
    #>  $ name_2     : chr NA
    #>  $ ccn        : chr "11D0265516"
    #>  $ xref       : chr NA
    #>  $ chow_n     : chr "0"
    #>  $ chow_date  : chr NA
    #>  $ chow_prev  : chr NA
    #>  $ pos        : chr "Y"
    #>  $ status     : chr "A"
    #>  $ add_1      : chr "205 WOODROW WILSON DR"
    #>  $ add_2      : chr NA
    #>  $ phone_1    : chr "8032619888"
    #>  $ phone_2    : chr NA
    #>  $ city       : chr "VALDOSTA"
    #>  $ state      : chr "GA"
    #>  $ region     : chr "04"
    #>  $ zip        : chr "31602"
    #>  $ state_ssa  : chr "11"
    #>  $ county_ssa : chr "700"
    #>  $ fips_state : chr "13"
    #>  $ fips_county: chr "185"
    #>  $ state_reg  : chr "001"
    #>  $ cbsa_cd    : chr "46660"
    #>  $ cbsa_ind   : chr "U"
    #>  $ eligible   : chr "Y"
    #>  $ term_pgm   : chr "17"
    #>  $ term_clia  : chr "17"
    #>  $ apl_type   : chr "1"
    #>  $ cert_type  : chr "1"
    #>  $ fac_type   : chr "21"
    #>  $ ownership  : chr "04"
    #>  $ cert_action: chr "2"
    #>  $ orig_date  : chr "19920901"
    #>  $ apl_date   : chr "19930120"
    #>  $ cert_date  : chr "19960321"
    #>  $ eff_date   : chr "19960829"
    #>  $ mail_date  : chr "19960925"
    #>  $ term_date  : chr "19980804"
    #>  $ a2la_cred  : chr NA
    #>  $ a2la_date  : chr NA
    #>  $ a2la_ind   : chr "N"
    #>  $ aabb_cred  : chr NA
    #>  $ aabb_date  : chr NA
    #>  $ aabb_ind   : chr "N"
    #>  $ aoa_cred   : chr NA
    #>  $ aoa_date   : chr NA
    #>  $ aoa_ind    : chr "N"
    #>  $ ashi_cred  : chr NA
    #>  $ ashi_date  : chr NA
    #>  $ ashi_ind   : chr "N"
    #>  $ cap_cred   : chr NA
    #>  $ cap_date   : chr NA
    #>  $ cap_ind    : chr "N"
    #>  $ cola_cred  : chr NA
    #>  $ cola_date  : chr NA
    #>  $ cola_ind   : chr "N"
    #>  $ jcaho_cred : chr NA
    #>  $ jcaho_date : chr NA
    #>  $ jcaho_ind  : chr "N"
    #>  $ clia_88    : chr "00205114A3"
    #>  $ acrd_sched : chr NA
    #>  $ cert_sched : chr NA
    #>  $ comp_sched : chr NA
    #>  $ survey_vol : chr "0"
    #>  $ acrd_vol   : chr "0"
    #>  $ comp_vol   : chr "0"
    #>  $ ppm_vol    : chr "0"
    #>  $ waive_vol  : chr "0"
    #>  $ affiliated : chr "0"
    #>  $ multi      : chr "N"
    #>  $ hosp       : chr "N"
    #>  $ nonprof    : chr "N"
    #>  $ temp       : chr "N"
    #>  $ sites      : chr "0"
    #>  $ related_num: chr NA
    #>  $ shared_lab : chr "N"
    #>  $ shared_num : chr NA
    #>  $ fyend      : chr NA
    #>  $ mac_curr   : chr NA
    #>  $ mac_prev   : chr NA
    #>  $ vend       : chr NA
    #>  $ skeleton   : chr "N"

#### Opt-Out Affidavits

``` r
opt_out(npi = 1043522824)
```

    #> ✔ Query returned 1 result.

    #> # A tibble: 1 × 13
    #>   npi    first last  specialty date_start date_end last_update add_1 add_2 city 
    #>   <chr>  <chr> <chr> <chr>     <chr>      <chr>    <chr>       <chr> <chr> <chr>
    #> 1 10435… James Smith Nurse Pr… 7/1/2019   7/1/2027 8/15/2025   8585… STE … SCOT…
    #> # ℹ 3 more variables: state <chr>, zip <chr>, order_refer <chr>

#### Ordering & Referral

``` r
order_refer(npi = 1043522824)
```

    #> ✔ Query returned 1 result.

    #> # A tibble: 1 × 8
    #>   npi        first last  part_b dme   hha   pmd   hospice
    #>   <chr>      <chr> <chr> <chr>  <chr> <chr> <chr> <chr>  
    #> 1 1043522824 JAMES SMITH Y      Y     Y     Y     N

#### Provider Enrollment

``` r
providers(enid = "O20040610001257")
```

    #> ✔ Query returned 1 result.

    #> # A tibble: 1 × 11
    #>   first middle last  org_name      state spec  specialty npi   multi pac   enid 
    #>   <chr> <chr>  <chr> <chr>         <chr> <chr> <chr>     <chr> <chr> <chr> <chr>
    #> 1 <NA>  <NA>   <NA>  IRWIN COUNTY… GA    12-70 PART B S… 1720… N     7618… O200…

#### Reassignments

``` r
reassignments(org_pac = 7719037548)
```

    #> ✔ Query returned 4 results.

    #> # A tibble: 4 × 14
    #>   first   last   state specialty ind_assoc npi   pac   enid  org_name org_assign
    #>   <chr>   <chr>  <chr> <chr>     <chr>     <chr> <chr> <chr> <chr>    <chr>     
    #> 1 Brooks  Alldr… CO    Optometry 1         1154… 5294… I201… Eye Cen… 4         
    #> 2 Matthew Ehrli… CO    Ophthalm… 1         1083… 6103… I200… Eye Cen… 4         
    #> 3 Jeffrey Olson  CO    Ophthalm… 3         1407… 1850… I200… Eye Cen… 4         
    #> 4 Stefan  Smith  CO    Optometry 1         1932… 4237… I201… Eye Cen… 4         
    #> # ℹ 4 more variables: org_pac <chr>, org_enid <chr>, org_state <chr>,
    #> #   type <chr>

#### Revocations

``` r
revocations(state = "GA")
```

    #> ✔ Query returned 213 results.

    #> # A tibble: 213 × 12
    #>    enid           npi   first middle last  org_name multi state specialty reason
    #>    <chr>          <chr> <chr> <chr>  <chr> <chr>    <chr> <chr> <chr>     <chr> 
    #>  1 I200312190001… 1881… WALL… S      ANDE… <NA>     N     GA    PRACTITI… 424.5…
    #>  2 I200312260000… 1073… LEO   G      FRAN… <NA>     N     GA    PRACTITI… 424.5…
    #>  3 I200402100005… 1265… ANTH… D      MILLS <NA>     N     GA    PRACTITI… 424.5…
    #>  4 I200402240001… 1851… JEFF… M.     GALL… <NA>     N     GA    PRACTITI… 424.5…
    #>  5 I200404020006… 1528… CURT… <NA>   CHEE… <NA>     N     GA    PRACTITI… 424.5…
    #>  6 I200404130008… 1770… ZAVI… C      ASH   <NA>     N     GA    PRACTITI… 424.5…
    #>  7 I200404300007… 1679… SHAWN E      TYWON <NA>     N     GA    PRACTITI… 424.5…
    #>  8 I200408090002… 1649… ANAND P      LALA… <NA>     N     GA    PRACTITI… 424.5…
    #>  9 I200409010000… 1205… TIFF… D      FORB… <NA>     N     GA    PRACTITI… 424.5…
    #> 10 I200409100000… 1952… STEP… T      BASH… <NA>     N     GA    PRACTITI… 424.5…
    #> # ℹ 203 more rows
    #> # ℹ 2 more variables: date_start <chr>, date_end <chr>

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
