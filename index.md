# **provider**

  

> Tidy Healthcare Provider API Interface

  

## 📦 Installation

You can install `provider` from [GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("andrewallenbruce/provider")
```

## 🔰 Usage

``` r
library(provider)
```

#### Facility Affiliations

``` r
affiliations(facility_ccn = 370781)
#> ✔ `affiliations()` returned 15 results.
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
```

#### National Provider Catalog

``` r
clinicians(npi = 1932365699)
#> ✔ `clinicians()` returned 1 result.
#> # A tibble: 1 × 25
#>   first middle last  suffix gender cred  school year  specialty spec_other npi  
#>   <chr> <chr>  <chr> <chr>  <chr>  <chr> <chr>  <chr> <chr>     <chr>      <chr>
#> 1 STEF… MICHA… SMITH <NA>   M      OD    ILLIN… 2008  OPTOMETRY <NA>       1932…
#> # ℹ 14 more variables: pac <chr>, enid <chr>, org_name <chr>, org_pac <chr>,
#> #   org_mem <chr>, add_1 <chr>, add_2 <chr>, city <chr>, state <chr>,
#> #   zip <chr>, phone <chr>, ind <chr>, grp <chr>, tlh <chr>
```

#### Hospitals

``` r
hospitals(npi = 1720098791)
#> ✔ `hospitals()` returned 1 result.
#> # A tibble: 1 × 39
#>   org_name      org_dba enid  enid_state spec  specialty npi   multi ccn   ccn_2
#>   <chr>         <chr>   <chr> <chr>      <chr> <chr>     <chr> <chr> <chr> <chr>
#> 1 IRWIN COUNTY… PROGRE… O202… GA         00-24 PART A P… 1720… N     1107… 1101…
#> # ℹ 29 more variables: pac <chr>, inc_date <chr>, inc_state <chr>,
#> #   struct <chr>, struct_otext <chr>, design <chr>, add_1 <chr>, add_2 <chr>,
#> #   city <chr>, state <chr>, zip <chr>, location <chr>, loc_otext <chr>,
#> #   reh_ind <chr>, reh_date <chr>, sub_general <chr>, sub_acute <chr>,
#> #   sub_drug <chr>, sub_child <chr>, sub_long <chr>, sub_psych <chr>,
#> #   sub_rehab <chr>, sub_short <chr>, sub_swing <chr>, sub_psych_unit <chr>,
#> #   sub_rehab_unit <chr>, sub_specialty <chr>, sub_other <chr>, …
```

#### CLIA Laboratories

``` r
clia(ccn = "11D0265516")
#> ✔ `clia()` returned 1 result.
#> # A tibble: 1 × 82
#>   name_1   name_2 ccn   xref  chow_n chow_date chow_prv pos   status add_1 add_2
#>   <chr>    <chr>  <chr> <chr> <chr>  <chr>     <chr>    <chr> <chr>  <chr> <chr>
#> 1 DANIEL … <NA>   11D0… <NA>  0      <NA>      <NA>     Y     A      205 … <NA> 
#> # ℹ 71 more variables: phone_1 <chr>, phone_2 <chr>, city <chr>, state <chr>,
#> #   zip <chr>, region <chr>, region_st <chr>, ssa_st <chr>, ssa_cty <chr>,
#> #   fips_st <chr>, fips_cty <chr>, cbsa <chr>, cbsa_i <chr>, eligible <chr>,
#> #   term_pgm <chr>, term_clia <chr>, apl_type <chr>, cert_type <chr>,
#> #   fac_type <chr>, owner <chr>, cert_action <chr>, orig_date <chr>,
#> #   apl_date <chr>, cert_date <chr>, eff_date <chr>, mail_date <chr>,
#> #   term_date <chr>, a2la_cred <chr>, a2la_date <chr>, a2la_ind <chr>, …
```

#### Opt-Out Affidavits

``` r
opt_out(npi = 1043522824)
#> ✔ `opt_out()` returned 1 result.
#> # A tibble: 1 × 13
#>   npi    first last  specialty date_start date_end last_update add_1 add_2 city 
#>   <chr>  <chr> <chr> <chr>     <chr>      <chr>    <chr>       <chr> <chr> <chr>
#> 1 10435… James Smith Nurse Pr… 7/1/2019   7/1/2027 8/15/2025   8585… STE … SCOT…
#> # ℹ 3 more variables: state <chr>, zip <chr>, order_refer <chr>
```

#### Ordering & Referral

``` r
order_refer(npi = 1043522824)
#> ✔ `order_refer()` returned 1 result.
#> # A tibble: 1 × 8
#>   first last  npi        part_b dme   hha   pmd   hospice
#>   <chr> <chr> <chr>      <chr>  <chr> <chr> <chr> <chr>  
#> 1 JAMES SMITH 1043522824 Y      Y     Y     Y     N
```

#### Provider Enrollment

``` r
providers(enid = "O20040610001257")
#> ✔ `providers()` returned 1 result.
#> # A tibble: 1 × 11
#>   org_name      first middle last  state spec  specialty npi   multi pac   enid 
#>   <chr>         <chr> <chr>  <chr> <chr> <chr> <chr>     <chr> <chr> <chr> <chr>
#> 1 IRWIN COUNTY… <NA>  <NA>   <NA>  GA    12-70 PART B S… 1720… N     7618… O200…
```

#### Reassignments

``` r
reassignments(org_pac = 7719037548)
#> ✔ `reassignments()` returned 4 results.
#> # A tibble: 4 × 14
#>   first   last   state specialty ind_assoc npi   pac   enid  org_name org_assign
#>   <chr>   <chr>  <chr> <chr>     <chr>     <chr> <chr> <chr> <chr>    <chr>     
#> 1 Brooks  Alldr… CO    Optometry 1         1154… 5294… I201… Eye Cen… 4         
#> 2 Matthew Ehrli… CO    Ophthalm… 1         1083… 6103… I200… Eye Cen… 4         
#> 3 Jeffrey Olson  CO    Ophthalm… 3         1407… 1850… I200… Eye Cen… 4         
#> 4 Stefan  Smith  CO    Optometry 1         1932… 4237… I201… Eye Cen… 4         
#> # ℹ 4 more variables: org_pac <chr>, org_enid <chr>, org_state <chr>,
#> #   type <chr>
```

#### Revocations

``` r
revocations(state = "GA")
#> ✔ `revocations()` returned 213 results.
#> # A tibble: 213 × 12
#>    org_name first    middle last       enid   npi   multi state specialty reason
#>    <chr>    <chr>    <chr>  <chr>      <chr>  <chr> <chr> <chr> <chr>     <chr> 
#>  1 <NA>     WALLACE  S      ANDERSON   I2003… 1881… N     GA    PRACTITI… 424.5…
#>  2 <NA>     LEO      G      FRANGIPANE I2003… 1073… N     GA    PRACTITI… 424.5…
#>  3 <NA>     ANTHONY  D      MILLS      I2004… 1265… N     GA    PRACTITI… 424.5…
#>  4 <NA>     JEFFREY  M.     GALLUPS    I2004… 1851… N     GA    PRACTITI… 424.5…
#>  5 <NA>     CURTIS   <NA>   CHEEKS     I2004… 1528… N     GA    PRACTITI… 424.5…
#>  6 <NA>     ZAVIER   C      ASH        I2004… 1770… N     GA    PRACTITI… 424.5…
#>  7 <NA>     SHAWN    E      TYWON      I2004… 1679… N     GA    PRACTITI… 424.5…
#>  8 <NA>     ANAND    P      LALAJI     I2004… 1649… N     GA    PRACTITI… 424.5…
#>  9 <NA>     TIFFANNI D      FORBES     I2004… 1205… N     GA    PRACTITI… 424.5…
#> 10 <NA>     STEPHEN  T      BASHUK     I2004… 1952… N     GA    PRACTITI… 424.5…
#> # ℹ 203 more rows
#> # ℹ 2 more variables: date_start <chr>, date_end <chr>
```

------------------------------------------------------------------------

## ⚖️ Code of Conduct

Please note that the `provider` project is released with a [Contributor
Code of
Conduct](https://andrewallenbruce.github.io/provider/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.

## 🏛️ Governance

This project is primarily maintained by [Andrew
Bruce](https://github.com/andrewallenbruce). Other authors may
occasionally assist with some of these duties.
