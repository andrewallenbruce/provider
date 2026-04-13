
<!-- README.md is generated from README.Rmd. Please edit that file -->

# <b>provider</b> <a href="https://andrewallenbruce.github.io/provider/"><img src="man/figures/logo.svg" align="right" height="139" alt="provider website" /></a>

> <b>Tidy Healthcare Provider API Interface</b>

<!-- badges: start -->

![GitHub R package
version](https://img.shields.io/github/r-package/v/andrewallenbruce/provider?style=flat-square&logo=R&label=Package&color=%23192a38)
[![License:
MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://choosealicense.com/licenses/mit/)
<br> [![code
size](https://img.shields.io/github/languages/code-size/andrewallenbruce/provider.svg)](https://github.com/andrewallenbruce/provider)
[![last
commit](https://img.shields.io/github/last-commit/andrewallenbruce/provider.svg)](https://github.com/andrewallenbruce/provider/commits/main)
<br> [![Codecov test
coverage](https://codecov.io/gh/andrewallenbruce/provider/branch/main/graph/badge.svg)](https://app.codecov.io/gh/andrewallenbruce/provider?branch=main)
[![CodeFactor](https://www.codefactor.io/repository/github/andrewallenbruce/provider/badge)](https://www.codefactor.io/repository/github/andrewallenbruce/provider)
<br>

<!-- badges: end -->

You can install `provider` from [GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("andrewallenbruce/provider")
```

### :beginner: Usage

``` r
library(provider)
```

``` r
# Provider/Facility Affiliations
affiliations(facility_ccn = 370781)
✔ affiliations returned 19 results.
# A data frame: 19 × 9
   first   last  middle suffix npi   pac   facility_type facility_ccn parent_ccn
 * <chr>   <chr> <chr>  <chr>  <chr> <chr> <chr>         <chr>        <chr>     
 1 NICOLE  LEE   <NA>   <NA>   1003… 1254… Hospital      370781       <NA>      
 2 LEILA   SEE   DANIE… <NA>   1013… 6800… Hospital      370781       <NA>      
 3 AARON   SIZE… S      <NA>   1053… 7618… Hospital      370781       <NA>      
 4 KEITH   KASS… J      <NA>   1083… 6406… Hospital      370781       <NA>      
 5 BRENDA  HUEN… K      <NA>   1225… 2466… Hospital      370781       <NA>      
 6 STEVE   MADR… M      <NA>   1245… 4082… Hospital      370781       <NA>      
 7 CHESTER BEAM  WRAY   <NA>   1316… 2769… Hospital      370781       <NA>      
 8 COREY   FINCH D      <NA>   1407… 3870… Hospital      370781       <NA>      
 9 THOMAS  MCGA… <NA>   <NA>   1427… 7517… Hospital      370781       <NA>      
10 NICHOL… RUSS… <NA>   <NA>   1487… 8426… Hospital      370781       <NA>      
11 DWAYNE  SCHM… A      <NA>   1568… 3870… Hospital      370781       <NA>      
12 JANA    MORR… NIKOLE <NA>   1629… 6103… Hospital      370781       <NA>      
13 TIMOTHY GRAH… AARON  <NA>   1710… 9739… Hospital      370781       <NA>      
14 RICHARD COST… F      JR.    1710… 2163… Hospital      370781       <NA>      
15 AMBER   PENA  M      <NA>   1720… 6507… Hospital      370781       <NA>      
16 TODD    REGI… S      <NA>   1780… 2668… Hospital      370781       <NA>      
17 CHRIST… KOOP… L      <NA>   1780… 1052… Hospital      370781       <NA>      
18 VEDMIA  FONK… <NA>   <NA>   1801… 9436… Hospital      370781       <NA>      
19 JESS    ARMOR F      <NA>   1922… 9032… Hospital      370781       <NA>      
```

``` r
# Reassignment of Benefits
reassignments(
  first = starts_with("J"), 
  state = "GA", 
  specialty = contains("Gastro"))
✔ reassignments returned 86 results.
# A data frame: 86 × 14
   first   last  state specialty ind_assoc npi   pac   enid  org_name org_assign
 * <chr>   <chr> <chr> <chr>     <chr>     <chr> <chr> <chr> <chr>    <chr>     
 1 Jai Eun Min   GA    Gastroen… 2         1508… 2961… I201… Aga Cli… 36        
 2 James   Barl… GA    Gastroen… 2         1568… 2668… I201… Aga Pro… 160       
 3 Joel    Cami… GA    Gastroen… 3         1144… 1456… I201… Aga Pro… 160       
 4 James   Camp… GA    Gastroen… 2         1053… 1658… I202… Aga Pro… 160       
 5 Justin  Forde GA    Gastroen… 2         1437… 4082… I202… Aga Pro… 160       
 6 Jay     Gart… GA    Gastroen… 2         1831… 3971… I200… Aga Pro… 160       
 7 Jonath… Kand… GA    Gastroen… 3         1043… 3870… I202… Aga Pro… 160       
 8 Justin  Mend… GA    Gastroen… 3         1669… 9335… I201… Aga Pro… 160       
 9 Joyce   Peji  GA    Gastroen… 2         1538… 3870… I200… Aga Pro… 160       
10 Jung    Suh   GA    Gastroen… 3         1952… 1355… I200… Aga Pro… 160       
# ℹ 76 more rows
# ℹ 4 more variables: org_pac <chr>, org_enid <chr>, org_state <chr>,
#   type <chr>
```

``` r
# Revoked Medicare Providers
revocations(
  specialty = contains("CARDIO"), 
  state = not("TX"))
✔ revocations returned 46 results.
# A data frame: 46 × 12
   org_name first    middle last       enid   npi   multi state prov_desc reason
 * <chr>    <chr>    <chr>  <chr>      <chr>  <chr> <chr> <chr> <chr>     <chr> 
 1 <NA>     RONALD   A      CARLISH    I2003… 1639… N     CA    PRACTITI… 424.5…
 2 <NA>     STEVE    E      NOZAD      I2003… 1962… N     NY    PRACTITI… 424.5…
 3 <NA>     RAED     A      JITAN      I2004… 1033… N     WV    PRACTITI… 424.5…
 4 <NA>     RAYMOND  <NA>   CATANIA    I2004… 1023… N     NJ    PRACTITI… 424.5…
 5 <NA>     ROBERT   ALDO   VACCARINO  I2004… 1922… N     NY    PRACTITI… 424.5…
 6 <NA>     STEVEN   B      HEFTER     I2004… 1609… N     AL    PRACTITI… 424.5…
 7 <NA>     LAKKARAJ <NA>   RAJASEKHAR I2004… 1083… N     OH    PRACTITI… 424.5…
 8 <NA>     BRYAN    F      PERRY      I2004… 1235… N     OK    PRACTITI… 424.5…
 9 <NA>     KLAUS    P      RENTROP    I2005… 1194… N     NY    PRACTITI… 424.5…
10 <NA>     JOHN     MILES  MCCLURE    I2005… 1427… N     MI    PRACTITI… 424.5…
# ℹ 36 more rows
# ℹ 2 more variables: start_date <chr>, end_date <chr>
```

``` r
# Clinician Demographics
clinicians(
  city = c("Atlanta", "Macon"), 
  state = "GA", 
  gender = "F",
  grad_year = 2026)
✔ clinicians returned 2 results.
# A data frame: 2 × 25
  first   middle last  suffix gender cred  school grad_year specialty spec_other
* <chr>   <chr>  <chr> <chr>  <chr>  <chr> <chr>  <chr>     <chr>     <chr>     
1 CHRIST… <NA>   AGYE… <NA>   F      <NA>  OTHER  2026      PHYSICIA… <NA>      
2 CHRIST… <NA>   AGYE… <NA>   F      <NA>  OTHER  2026      PHYSICIA… <NA>      
# ℹ 15 more variables: npi <chr>, pac <chr>, enid <chr>, org_name <chr>,
#   org_pac <chr>, org_mem <chr>, add_1 <chr>, add_2 <chr>, org_city <chr>,
#   org_state <chr>, org_zip <chr>, org_phone <chr>, ind <chr>, org <chr>,
#   tlh <chr>
```

``` r
# Opt-Out Affidavits
opt_out(
  specialty = "Psychiatry", 
  order_refer = FALSE)
✔ opt_out returned 798 results.
# A data frame: 798 × 13
   npi       first last  specialty start_date end_date updated add_1 add_2 city 
 * <chr>     <chr> <chr> <chr>     <chr>      <chr>    <chr>   <chr> <chr> <chr>
 1 17204445… Jona… Rain… Psychiat… 1/30/1998  1/30/20… 2/16/2… 1629… P O … GLAD…
 2 15988021… Mart… Leat… Psychiat… 4/1/2012   4/1/2026 10/15/… 1314… #5101 SAN …
 3 19726233… Nancy Shos… Psychiat… 3/2/2012   3/2/2026 10/15/… 1288… <NA>  DALL…
 4 11241167… Namir Daml… Psychiat… 7/26/2020  7/26/20… 8/15/2… 4407… STE … ENCI…
 5 14271463… Lawr… Corm… Psychiat… 5/10/2012  5/10/20… 10/15/… 3773… <NA>  DENV…
 6 11141323… Char… Scha… Psychiat… 6/14/2012  6/14/20… 10/15/… 1455… <NA>  SACR…
 7 10938944… Andr… Popp… Psychiat… 6/1/2012   6/1/2026 1/15/2… 93 U… STE … NEWT…
 8 18715013… Ingr… Schm… Psychiat… 9/2/2010   9/2/2026 10/15/… 5750… STE … AUST…
 9 14776142… Lore… Henry Psychiat… 5/26/2012  5/26/20… 10/15/… 1721… SUIT… COLL…
10 19322840… Patr… Mcgr… Psychiat… 6/1/2012   6/1/2026 7/15/2… 100 … SUIT… NEW …
# ℹ 788 more rows
# ℹ 3 more variables: state <chr>, zip <chr>, order_refer <chr>
```

``` r
# Ordering & Referral Eligibility
order_refer(
  part_b = TRUE,
  dme = TRUE,
  hha = FALSE,
  pmd = TRUE,
  hospice = FALSE)
✔ order_refer returned 51 results.
# A data frame: 51 × 8
   first    last        npi        part_b dme   hha   pmd   hospice
 * <chr>    <chr>       <chr>      <chr>  <chr> <chr> <chr> <chr>  
 1 ROBYN    AYER        1659094290 Y      Y     N     Y     N      
 2 MEGAN    BAUMGARDNER 1023796711 Y      Y     N     Y     N      
 3 KRISTINA BERRY       1295461192 Y      Y     N     Y     N      
 4 BONNIE   BETTS       1306821129 Y      Y     N     Y     N      
 5 LAURA    BOBROWSKI   1013297019 Y      Y     N     Y     N      
 6 LISA     CHRISTIAN   1235636697 Y      Y     N     Y     N      
 7 TRAVIS   DANIEL      1134813934 Y      Y     N     Y     N      
 8 LYNELL   DAWSON      1962852533 Y      Y     N     Y     N      
 9 BETH     DETRICH     1124364203 Y      Y     N     Y     N      
10 BRIDGET  DIETZ       1720522592 Y      Y     N     Y     N      
# ℹ 41 more rows
```

``` r
# Pending Enrollments
pending(
  first = ends_with("E"),
  last = starts_with("A"))
✔ pending returned 54 results.
• Physician     : 18
• Non-Physician : 36
# A data frame: 54 × 4
   prov_type first     last        npi       
 * <fct>     <chr>     <chr>       <chr>     
 1 Physician JOSE      ABREU-ELIAS 1821010513
 2 Physician GEORGE    ADAMS       1649409947
 3 Physician ABOJE     ADUGBA      1184416976
 4 Physician LUCIE     AHN         1558209502
 5 Physician OLUMIDE   AJAYI       1740029511
 6 Physician JUDE      ALCIDE      1578876108
 7 Physician EMILIE    ALLAERT     1922809870
 8 Physician KATHERINE ALLEN       1851823488
 9 Physician ILEANE    AMADOR      1568427268
10 Physician JASMINE   AMBROSIO    1881584712
# ℹ 44 more rows
```

``` r
# Medicare Enrollment
providers(
  first = contains("C"),
  state = "AK",
  prov_type = ends_with(50))
✔ providers returned 172 results.
# A data frame: 172 × 11
   org_name first middle last  state prov_type prov_desc npi   multi pac   enid 
 * <chr>    <chr> <chr>  <chr> <chr> <chr>     <chr>     <chr> <chr> <chr> <chr>
 1 <NA>     CHRI… M      BABC… AK    14-50     PRACTITI… 1013… N     3072… I200…
 2 <NA>     MICH… R      AIKEN AK    14-50     PRACTITI… 1174… N     0840… I200…
 3 <NA>     CHRI… <NA>   KRAM… AK    14-50     PRACTITI… 1942… N     4688… I200…
 4 <NA>     CATH… A      LIDD… AK    14-50     PRACTITI… 1629… N     0345… I200…
 5 <NA>     REBE… A      YOUNG AK    14-50     PRACTITI… 1740… N     8729… I200…
 6 <NA>     CHAR… M      NELS… AK    14-50     PRACTITI… 1073… N     7618… I200…
 7 <NA>     CONN… L      CHEV… AK    14-50     PRACTITI… 1316… N     1850… I200…
 8 <NA>     JOYCE E      ZIMM… AK    14-50     PRACTITI… 1316… N     5294… I200…
 9 <NA>     DARCY M      LUCEY AK    14-50     PRACTITI… 1366… N     7315… I200…
10 <NA>     CYNT… G      JONES AK    14-50     PRACTITI… 1962… N     3870… I200…
# ℹ 162 more rows
```

``` r
# Medicare Part A Hospitals
hospitals(
  city = "Atlanta",
  state = "GA",
  subgroup = subgroups(
    acute = FALSE,
    psych = TRUE))
✔ hospitals returned 2 results.
# A data frame: 2 × 39
  org_name      org_dba enid  enid_state spec  specialty npi   multi ccn   ccn_2
* <chr>         <chr>   <chr> <chr>      <chr> <chr>     <chr> <chr> <chr> <chr>
1 UHS OF ANCHO… ANCHOR… O201… GA         00-09 PART A P… 1023… Y     1140… <NA> 
2 UHS OF PEACH… PEACHF… O201… GA         00-09 PART A P… 1093… N     1140… <NA> 
# ℹ 29 more variables: pac <chr>, inc_date <chr>, inc_state <chr>,
#   org_type <chr>, org_otxt <chr>, org_status <chr>, add_1 <chr>, add_2 <chr>,
#   city <chr>, state <chr>, zip <chr>, loc_type <chr>, loc_otxt <chr>,
#   reh_ind <chr>, reh_date <chr>, sub_general <chr>, sub_acute <chr>,
#   sub_drug <chr>, sub_child <chr>, sub_long <chr>, sub_psych <chr>,
#   sub_rehab <chr>, sub_short <chr>, sub_swing <chr>, sub_psych_unit <chr>,
#   sub_rehab_unit <chr>, sub_specialty <chr>, sub_other <chr>, …
```

``` r
# CLIA Laboratories
clia(name = starts_with("CDC"))
✔ clia returned 23 results.
# A data frame: 23 × 82
   name_1 name_2 ccn   parent xref  chow_n chow_date chow_prv pos   status add_1
 * <chr>  <chr>  <chr> <chr>  <chr> <chr>  <chr>     <chr>    <chr> <chr>  <chr>
 1 CDC A… <NA>   36D1… <NA>   <NA>  0      <NA>      <NA>     N     B      7690…
 2 CDC A… CENTE… 02D0… <NA>   <NA>  0      <NA>      <NA>     N     A      4055…
 3 CDC H… <NA>   36D1… <NA>   <NA>  0      <NA>      <NA>     N     <NA>   807 …
 4 CDC H… <NA>   36D2… <NA>   <NA>  0      <NA>      <NA>     N     <NA>   8900…
 5 CDC M… <NA>   36D2… <NA>   <NA>  0      <NA>      <NA>     N     <NA>   6749…
 6 CDC O… <NA>   06D2… <NA>   <NA>  0      <NA>      <NA>     N     <NA>   3156…
 7 CDC O… <NA>   06D2… <NA>   <NA>  0      <NA>      <NA>     N     <NA>   3156…
 8 CDC O… <NA>   11D2… <NA>   <NA>  0      <NA>      <NA>     N     <NA>   1600…
 9 CDC O… <NA>   09D0… 092512 <NA>  0      <NA>      <NA>     N     <NA>   3178…
10 CDC O… <NA>   49D0… 492535 <NA>  0      <NA>      <NA>     N     <NA>   8003…
# ℹ 13 more rows
# ℹ 71 more variables: add_2 <chr>, phone_1 <chr>, phone_2 <chr>, city <chr>,
#   state <chr>, zip <chr>, region <chr>, region_st <chr>, ssa_st <chr>,
#   ssa_cty <chr>, fips_st <chr>, fips_cty <chr>, cbsa_1 <chr>, cbsa_2 <chr>,
#   eligible <chr>, term_pgm <chr>, term_clia <chr>, apl_type <chr>,
#   cert_type <chr>, fac_type <chr>, owner <chr>, cert_action <chr>,
#   orig_date <chr>, apl_date <chr>, cert_date <chr>, eff_date <chr>, …
```

``` r
# Hospital Transparency Enforcement
transparency(action = "cmp")
✔ transparency returned 26 results.
# A data frame: 26 × 7
   id    name                           address   city  state action action_date
 * <chr> <chr>                          <chr>     <chr> <chr> <chr>  <chr>      
 1 25    Kell West Regional Hospital    5420 Kel… Wich… TX    CMP N… 2023-04-19 
 2 42    Northside Hospital Atlanta     1000 Joh… Atla… GA    CMP N… 2022-06-07 
 3 89    Community First Medical Center 5645 W A… Chic… IL    CMP N… 2023-07-24 
 4 99    Northside Hospital - Cherokee  450 Nort… Cant… GA    CMP N… 2022-06-07 
 5 287   Jackson Memorial Hospital      1611 NW … Miami FL    CMP N… 2024-07-03 
 6 334   Baytown Medical Center         1626 W B… Bayt… TX    CMP N… 2024-12-19 
 7 368   HCA Frisbie Memorial Hospital  11 White… Roch… NH    CMP N… 2023-04-19 
 8 555   First Surgical Hospital        4801 Bis… Bell… TX    CMP N… 2025-01-16 
 9 563   Fulton County Hospital         679 N Ma… Salem AR    CMP N… 2023-07-20 
10 697   West Chase Houston Hospital    6011 W S… Hous… TX    CMP N… 2024-12-19 
# ℹ 16 more rows
```

<br>

------------------------------------------------------------------------

<br>

## :balance_scale: Code of Conduct

Please note that the `provider` project is released with a [Contributor
Code of
Conduct](https://andrewallenbruce.github.io/provider/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.

## :classical_building: Governance

This project is primarily maintained by [Andrew
Bruce](https://github.com/andrewallenbruce). Other authors may
occasionally assist with some of these duties.
