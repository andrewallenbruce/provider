
<!-- README.md is generated from README.Rmd. Please edit that file -->

# <b>provider</b> <a href="https://andrewallenbruce.github.io/provider/"><img src="man/figures/logo.svg" align="right" height="139" alt="provider website" /></a>

> <b>Tidy Healthcare Provider API Interface</b>

<br>

<!-- badges: start -->

![GitHub R package
version](https://img.shields.io/github/r-package/v/andrewallenbruce/provider?style=flat-square&logo=R&label=Package&color=%23192a38)
[![License:
MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://choosealicense.com/licenses/mit/)
[![code
size](https://img.shields.io/github/languages/code-size/andrewallenbruce/provider.svg)](https://github.com/andrewallenbruce/provider)
<br> [![last
commit](https://img.shields.io/github/last-commit/andrewallenbruce/provider.svg)](https://github.com/andrewallenbruce/provider/commits/main)
[![Codecov test
coverage](https://codecov.io/gh/andrewallenbruce/provider/branch/main/graph/badge.svg)](https://app.codecov.io/gh/andrewallenbruce/provider?branch=main)
[![CodeFactor](https://www.codefactor.io/repository/github/andrewallenbruce/provider/badge)](https://www.codefactor.io/repository/github/andrewallenbruce/provider)

<!-- badges: end -->

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
✔ `affiliations` returned 15 results.
# A tibble: 15 × 9
   first   last  middle suffix npi   pac   facility_type facility_ccn parent_ccn
   <chr>   <chr> <chr>  <chr>  <chr> <chr> <chr>         <chr>        <chr>     
 1 NICOLE  LEE   <NA>   <NA>   1003… 1254… Hospital      370781       <NA>      
 2 LEILA   SEE   DANIE… <NA>   1013… 6800… Hospital      370781       <NA>      
 3 AARON   SIZE… S      <NA>   1053… 7618… Hospital      370781       <NA>      
 4 KEITH   KASS… J      <NA>   1083… 6406… Hospital      370781       <NA>      
 5 STEVE   MADR… M      <NA>   1245… 4082… Hospital      370781       <NA>      
 6 CHESTER BEAM  WRAY   <NA>   1316… 2769… Hospital      370781       <NA>      
 7 COREY   FINCH D      <NA>   1407… 3870… Hospital      370781       <NA>      
 8 THOMAS  MCGA… <NA>   <NA>   1427… 7517… Hospital      370781       <NA>      
 9 NICHOL… RUSS… <NA>   <NA>   1487… 8426… Hospital      370781       <NA>      
10 DWAYNE  SCHM… A      <NA>   1568… 3870… Hospital      370781       <NA>      
11 JANA    MORR… NIKOLE <NA>   1629… 6103… Hospital      370781       <NA>      
12 TIMOTHY GRAH… AARON  <NA>   1710… 9739… Hospital      370781       <NA>      
13 RICHARD COST… F      JR.    1710… 2163… Hospital      370781       <NA>      
14 VEDMIA  FONK… <NA>   <NA>   1801… 9436… Hospital      370781       <NA>      
15 JESS    ARMOR F      <NA>   1922… 9032… Hospital      370781       <NA>      
```

#### Reassignments

``` r
reassignments(org_pac = 7719037548)
✔ `reassignments` returned 4 results.
# A tibble: 4 × 14
  first   last   state specialty ind_assoc npi   pac   enid  org_name org_assign
  <chr>   <chr>  <chr> <chr>     <chr>     <chr> <chr> <chr> <chr>    <chr>     
1 Brooks  Alldr… CO    Optometry 1         1154… 5294… I201… Eye Cen… 4         
2 Matthew Ehrli… CO    Ophthalm… 1         1083… 6103… I200… Eye Cen… 4         
3 Jeffrey Olson  CO    Ophthalm… 3         1407… 1850… I200… Eye Cen… 4         
4 Stefan  Smith  CO    Optometry 1         1932… 4237… I201… Eye Cen… 4         
# ℹ 4 more variables: org_pac <chr>, org_enid <chr>, org_state <chr>,
#   type <chr>
```

#### Revocations

``` r
revocations(
  specialty = contains("CARDIO"), 
  state = not("TX")
  )
✔ `revocations` returned 46 results.
# A tibble: 46 × 12
   org_name first    middle last       enid   npi   multi state specialty reason
   <chr>    <chr>    <chr>  <chr>      <chr>  <chr> <chr> <chr> <chr>     <chr> 
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

#### National Provider Catalog

``` r
clinicians(
  city = any_of(c("Atlanta", "Macon")), 
  state = "GA", 
  gender = "F",
  year = 2025
  )
✔ `clinicians` returned 293 results.
# A tibble: 293 × 25
   first      middle last  suffix gender cred  school year  specialty spec_other
   <chr>      <chr>  <chr> <chr>  <chr>  <chr> <chr>  <chr> <chr>     <chr>     
 1 THAO       <NA>   HOANG <NA>   F      PA    OTHER  2025  PHYSICIA… <NA>      
 2 MADISON    <NA>   THUR… <NA>   F      OD    ILLIN… 2025  OPHTHALM… <NA>      
 3 MADISON    <NA>   THUR… <NA>   F      OD    ILLIN… 2025  OPHTHALM… <NA>      
 4 KERRINGTON <NA>   PUGH  <NA>   F      <NA>  OTHER  2025  PHYSICIA… <NA>      
 5 MARA       S.     DETR… <NA>   F      <NA>  MERCE… 2025  PHYSICIA… <NA>      
 6 KRYSTAL    GAIL   DENN… <NA>   F      NP    OTHER  2025  NURSE PR… <NA>      
 7 LAUREN     <NA>   FOX   <NA>   F      NP    OTHER  2025  NURSE PR… <NA>      
 8 KAITLYN    <NA>   OZCE… <NA>   F      PT    OTHER  2025  PHYSICAL… <NA>      
 9 KAYLA      JEAN   KLEIN <NA>   F      <NA>  OTHER  2025  ANESTHES… <NA>      
10 SHYKIRA    <NA>   THOM… <NA>   F      PA    OTHER  2025  PHYSICIA… <NA>      
# ℹ 283 more rows
# ℹ 15 more variables: npi <chr>, pac <chr>, enid <chr>, org_name <chr>,
#   org_pac <chr>, org_mem <chr>, add_1 <chr>, add_2 <chr>, org_city <chr>,
#   org_state <chr>, org_zip <chr>, org_phone <chr>, ind <chr>, org <chr>,
#   tlh <chr>
```

#### Opt-Out Affidavits

``` r
opt_out(
  specialty = "Psychiatry", 
  order_refer = FALSE
  )
✔ `opt_out` returned 790 results.
# A tibble: 790 × 13
   npi       first last  specialty start_date end_date updated add_1 add_2 city 
   <chr>     <chr> <chr> <chr>     <chr>      <chr>    <chr>   <chr> <chr> <chr>
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
# ℹ 780 more rows
# ℹ 3 more variables: state <chr>, zip <chr>, order_refer <chr>
```

#### Order & Referral Eligibility

``` r
order_refer(
  last = starts_with("B"),
  part_b = TRUE,
  dme = TRUE,
  hha = FALSE,
  pmd = TRUE,
  hospice = FALSE)
✔ `order_refer` returned 5 results.
# A tibble: 5 × 8
  first    last        npi        part_b dme   hha   pmd   hospice
  <chr>    <chr>       <chr>      <chr>  <chr> <chr> <chr> <chr>  
1 MEGAN    BAUMGARDNER 1023796711 Y      Y     N     Y     N      
2 KRISTINA BERRY       1295461192 Y      Y     N     Y     N      
3 BONNIE   BETTS       1306821129 Y      Y     N     Y     N      
4 ALYSSA   BLEDSOE     1073322277 Y      Y     N     Y     N      
5 LAURA    BOBROWSKI   1013297019 Y      Y     N     Y     N      
```

#### Pending Enrollments

``` r
pending(
  first = starts_with("V"),
  last = starts_with("W")
  )
✔ `pending` returned 8 results.
◉ Physician     : 2
◉ Non-Physician : 6
# A tibble: 8 × 4
  prov_type     first    last       npi       
  <fct>         <chr>    <chr>      <chr>     
1 Physician     VANESSA  WOOSLEY    1326877440
2 Physician     VICTORIA WIDJAJA    1851757033
3 Non-Physician VALERIE  WASHINGTON 1780540567
4 Non-Physician VANESSA  WOMACK     1184148306
5 Non-Physician VERONICA WYNN       1063579613
6 Non-Physician VICKI    WALLS      1366781072
7 Non-Physician VICTORIA WARNER     1780232942
8 Non-Physician VICTORIA WEINAND    1558252023
```

#### Provider Enrollment

``` r
providers(
  first = contains("C"),
  state = "AK",
  spec = ends_with("30")
  )
✔ `providers` returned 33 results.
# A tibble: 33 × 11
   org_name first     middle last  state spec  specialty npi   multi pac   enid 
   <chr>    <chr>     <chr>  <chr> <chr> <chr> <chr>     <chr> <chr> <chr> <chr>
 1 <NA>     CHAKRI    <NA>   INAM… AK    14-30 PRACTITI… 1245… N     3476… I200…
 2 <NA>     CHRISTOP… <NA>   KOTT… AK    14-30 PRACTITI… 1396… N     2769… I200…
 3 <NA>     CLAIRE    <NA>   WAITE AK    14-30 PRACTITI… 1164… N     0042… I200…
 4 <NA>     SCOTT     <NA>   NASP… AK    14-30 PRACTITI… 1891… N     7618… I200…
 5 <NA>     CHRISTOP… <NA>   REED  AK    14-30 PRACTITI… 1417… N     4486… I200…
 6 <NA>     LAURENCE  <NA>   CAMB… AK    14-30 PRACTITI… 1417… N     6103… I200…
 7 <NA>     SCOTT     D      HARR… AK    14-30 PRACTITI… 1558… N     9931… I200…
 8 <NA>     MARC      RICHA… BECK  AK    14-30 PRACTITI… 1437… N     6305… I200…
 9 <NA>     JANICE    <NA>   CHEN  AK    14-30 PRACTITI… 1841… N     2163… I201…
10 <NA>     MICHAEL   T      SMITH AK    14-30 PRACTITI… 1356… N     6305… I201…
# ℹ 23 more rows
```

#### Hospitals

``` r
hospitals(
  city = "Atlanta",
  state = "GA",
  subgroup = subgroups(
    acute = FALSE,
    psych = TRUE
  )
)
✔ `hospitals` returned 2 results.
# A tibble: 2 × 39
  org_name      org_dba enid  enid_state spec  specialty npi   multi ccn   ccn_2
  <chr>         <chr>   <chr> <chr>      <chr> <chr>     <chr> <chr> <chr> <chr>
1 UHS OF ANCHO… ANCHOR… O201… GA         00-09 PART A P… 1023… Y     1140… <NA> 
2 UHS OF PEACH… PEACHF… O201… GA         00-09 PART A P… 1093… N     1140… <NA> 
# ℹ 29 more variables: pac <chr>, inc_date <chr>, inc_state <chr>, str <chr>,
#   str_otxt <chr>, design <chr>, add_1 <chr>, add_2 <chr>, city <chr>,
#   state <chr>, zip <chr>, loc <chr>, loc_otxt <chr>, reh_ind <chr>,
#   reh_date <chr>, sub_general <chr>, sub_acute <chr>, sub_drug <chr>,
#   sub_child <chr>, sub_long <chr>, sub_psych <chr>, sub_rehab <chr>,
#   sub_short <chr>, sub_swing <chr>, sub_psych_unit <chr>,
#   sub_rehab_unit <chr>, sub_specialty <chr>, sub_other <chr>, …
```

#### CLIA Laboratories

``` r
clia(name = starts_with("CDC"))
✔ `clia` returned 23 results.
# A tibble: 23 × 82
   name_1  name_2 ccn   xref  chow_n chow_date chow_prv pos   status add_1 add_2
   <chr>   <chr>  <chr> <chr> <chr>  <chr>     <chr>    <chr> <chr>  <chr> <chr>
 1 CDC AC… <NA>   36D1… <NA>  0      <NA>      <NA>     N     B      7690… <NA> 
 2 CDC AR… CENTE… 02D0… <NA>  0      <NA>      <NA>     N     A      4055… <NA> 
 3 CDC HO… <NA>   36D1… <NA>  0      <NA>      <NA>     N     <NA>   807 … <NA> 
 4 CDC HO… <NA>   36D2… <NA>  0      <NA>      <NA>     N     <NA>   8900… <NA> 
 5 CDC MI… <NA>   36D2… <NA>  0      <NA>      <NA>     N     <NA>   6749… <NA> 
 6 CDC OC… <NA>   06D2… <NA>  0      <NA>      <NA>     N     <NA>   3156… <NA> 
 7 CDC OC… <NA>   06D2… <NA>  0      <NA>      <NA>     N     <NA>   3156… <NA> 
 8 CDC OC… <NA>   11D2… <NA>  0      <NA>      <NA>     N     <NA>   1600… ROOM…
 9 CDC OF… <NA>   09D0… <NA>  0      <NA>      <NA>     N     <NA>   3178… <NA> 
10 CDC OF… <NA>   49D0… <NA>  0      <NA>      <NA>     N     <NA>   8003… <NA> 
# ℹ 13 more rows
# ℹ 71 more variables: phone_1 <chr>, phone_2 <chr>, city <chr>, state <chr>,
#   zip <chr>, region <chr>, region_st <chr>, ssa_st <chr>, ssa_cty <chr>,
#   fips_st <chr>, fips_cty <chr>, cbsa_1 <chr>, cbsa_2 <chr>, eligible <chr>,
#   term_pgm <chr>, term_clia <chr>, apl_type <chr>, cert_type <chr>,
#   fac_type <chr>, owner <chr>, cert_action <chr>, orig_date <chr>,
#   apl_date <chr>, cert_date <chr>, eff_date <chr>, mail_date <chr>, …
```

#### Hospital Transparency Enforcement

``` r
transparency(action = contains("CMP"))
✔ `transparency` returned 26 results.
# A tibble: 26 × 7
   id    name                           address   city  state action action_date
   <chr> <chr>                          <chr>     <chr> <chr> <chr>  <chr>      
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
