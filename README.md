
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
# A tibble: 19 × 9
   first  last  middle suffix    npi pac   facility_type facility_ccn parent_ccn
 * <chr>  <chr> <chr>  <chr>   <int> <chr> <chr>         <chr>        <chr>     
 1 NICOLE LEE   <NA>   <NA>   1.00e9 1254… Hospital      370781       <NA>      
 2 LEILA  SEE   DANIE… <NA>   1.01e9 6800… Hospital      370781       <NA>      
 3 AARON  SIZE… S      <NA>   1.05e9 7618… Hospital      370781       <NA>      
 4 KEITH  KASS… J      <NA>   1.08e9 6406… Hospital      370781       <NA>      
 5 BRENDA HUEN… K      <NA>   1.23e9 2466… Hospital      370781       <NA>      
 6 STEVE  MADR… M      <NA>   1.25e9 4082… Hospital      370781       <NA>      
 7 CHEST… BEAM  WRAY   <NA>   1.32e9 2769… Hospital      370781       <NA>      
 8 COREY  FINCH D      <NA>   1.41e9 3870… Hospital      370781       <NA>      
 9 THOMAS MCGA… <NA>   <NA>   1.43e9 7517… Hospital      370781       <NA>      
10 NICHO… RUSS… <NA>   <NA>   1.49e9 8426… Hospital      370781       <NA>      
11 DWAYNE SCHM… A      <NA>   1.57e9 3870… Hospital      370781       <NA>      
12 JANA   MORR… NIKOLE <NA>   1.63e9 6103… Hospital      370781       <NA>      
13 TIMOT… GRAH… AARON  <NA>   1.71e9 9739… Hospital      370781       <NA>      
14 RICHA… COST… F      JR.    1.71e9 2163… Hospital      370781       <NA>      
15 AMBER  PENA  M      <NA>   1.72e9 6507… Hospital      370781       <NA>      
16 TODD   REGI… S      <NA>   1.78e9 2668… Hospital      370781       <NA>      
17 CHRIS… KOOP… L      <NA>   1.78e9 1052… Hospital      370781       <NA>      
18 VEDMIA FONK… <NA>   <NA>   1.80e9 9436… Hospital      370781       <NA>      
19 JESS   ARMOR F      <NA>   1.92e9 9032… Hospital      370781       <NA>      
```

``` r
# Reassignment of Benefits
reassignments(
  first = starts_with("J"), 
  state = "GA", 
  specialty = contains("Gastro"))
✔ reassignments returned 86 results.
# A tibble: 86 × 14
   first   last  state specialty employers    npi pac   enid  org_name employees
 * <chr>   <chr> <chr> <chr>         <int>  <int> <chr> <chr> <chr>        <int>
 1 Jai Eun Min   GA    Gastroen…         2 1.51e9 2961… I201… Aga Cli…        36
 2 James   Barl… GA    Gastroen…         2 1.57e9 2668… I201… Aga Pro…       160
 3 Joel    Cami… GA    Gastroen…         3 1.14e9 1456… I201… Aga Pro…       160
 4 James   Camp… GA    Gastroen…         2 1.05e9 1658… I202… Aga Pro…       160
 5 Justin  Forde GA    Gastroen…         2 1.44e9 4082… I202… Aga Pro…       160
 6 Jay     Gart… GA    Gastroen…         2 1.83e9 3971… I200… Aga Pro…       160
 7 Jonath… Kand… GA    Gastroen…         3 1.04e9 3870… I202… Aga Pro…       160
 8 Justin  Mend… GA    Gastroen…         3 1.67e9 9335… I201… Aga Pro…       160
 9 Joyce   Peji  GA    Gastroen…         2 1.54e9 3870… I200… Aga Pro…       160
10 Jung    Suh   GA    Gastroen…         3 1.95e9 1355… I200… Aga Pro…       160
# ℹ 76 more rows
# ℹ 4 more variables: org_pac <chr>, org_enid <chr>, org_state <chr>,
#   rec_type <chr>
```

``` r
# Revoked Medicare Providers
revocations(
  specialty = contains("CARDIO"), 
  state = not("TX"))
✔ revocations returned 46 results.
# A tibble: 46 × 12
   org_name first    middle last       enid     npi multi state prov_desc reason
 * <chr>    <chr>    <chr>  <chr>      <chr>  <int> <int> <chr> <chr>     <chr> 
 1 <NA>     RONALD   A      CARLISH    I200… 1.64e9     0 CA    PRACTITI… 424.5…
 2 <NA>     STEVE    E      NOZAD      I200… 1.96e9     0 NY    PRACTITI… 424.5…
 3 <NA>     RAED     A      JITAN      I200… 1.03e9     0 WV    PRACTITI… 424.5…
 4 <NA>     RAYMOND  <NA>   CATANIA    I200… 1.02e9     0 NJ    PRACTITI… 424.5…
 5 <NA>     ROBERT   ALDO   VACCARINO  I200… 1.92e9     0 NY    PRACTITI… 424.5…
 6 <NA>     STEVEN   B      HEFTER     I200… 1.61e9     0 AL    PRACTITI… 424.5…
 7 <NA>     LAKKARAJ <NA>   RAJASEKHAR I200… 1.08e9     0 OH    PRACTITI… 424.5…
 8 <NA>     BRYAN    F      PERRY      I200… 1.24e9     0 OK    PRACTITI… 424.5…
 9 <NA>     KLAUS    P      RENTROP    I200… 1.19e9     0 NY    PRACTITI… 424.5…
10 <NA>     JOHN     MILES  MCCLURE    I200… 1.43e9     0 MI    PRACTITI… 424.5…
# ℹ 36 more rows
# ℹ 2 more variables: start_date <date>, end_date <date>
```

``` r
# Clinician Demographics
clinicians(
  city = c("Atlanta", "Macon"), 
  state = "GA", 
  gender = "F",
  grad_year = 2026)
✔ clinicians returned 2 results.
# A tibble: 2 × 20
  first middle last  suffix gender cred  school grad_year specialty    npi pac  
* <chr> <chr>  <chr> <chr>  <chr>  <chr> <chr>      <int> <chr>      <int> <chr>
1 CHRI… <NA>   AGYE… <NA>   F      <NA>  OTHER       2026 PHYSICIA… 1.15e9 5991…
2 CHRI… <NA>   AGYE… <NA>   F      <NA>  OTHER       2026 PHYSICIA… 1.15e9 5991…
# ℹ 9 more variables: enid <chr>, org_name <chr>, org_pac <chr>, org_mem <chr>,
#   org_city <chr>, org_state <chr>, org_zip <chr>, org_phone <chr>,
#   org_add <chr>
```

``` r
# Opt-Out Affidavits
opt_out(
  specialty = "Psychiatry", 
  order_refer = FALSE)
✔ opt_out returned 798 results.
# A tibble: 798 × 12
          npi first last  specialty start_date end_date   updated    city  state
 *      <int> <chr> <chr> <chr>     <date>     <date>     <date>     <chr> <chr>
 1 1720444581 Jona… Rain… Psychiat… 1998-01-30 2028-01-30 2026-02-16 GLAD… PA   
 2 1598802100 Mart… Leat… Psychiat… 2012-04-01 2026-04-01 2024-10-15 SAN … TX   
 3 1972623346 Nancy Shos… Psychiat… 2012-03-02 2026-03-02 2024-10-15 DALL… TX   
 4 1124116793 Namir Daml… Psychiat… 2020-07-26 2026-07-26 2024-08-15 ENCI… CA   
 5 1427146331 Lawr… Corm… Psychiat… 2012-05-10 2026-05-10 2024-10-15 DENV… CO   
 6 1114132313 Char… Scha… Psychiat… 2012-06-14 2026-06-14 2024-10-15 SACR… CA   
 7 1093894420 Andr… Popp… Psychiat… 2012-06-01 2026-06-01 2026-01-15 NEWT… MA   
 8 1871501395 Ingr… Schm… Psychiat… 2010-09-02 2026-09-02 2024-10-15 AUST… TX   
 9 1477614204 Lore… Henry Psychiat… 2012-05-26 2026-05-26 2024-10-15 COLL… TX   
10 1932284098 Patr… Mcgr… Psychiat… 2012-06-01 2026-06-01 2024-07-15 NEW … NY   
# ℹ 788 more rows
# ℹ 3 more variables: zip <chr>, order_refer <int>, address <chr>
```

``` r
# Ordering & Referral Eligibility
order_refer(
  ptb = TRUE,
  dme = TRUE,
  hha = FALSE,
  pmd = TRUE,
  hospice = FALSE)
✔ order_refer returned 51 results.
# A tibble: 51 × 8
   first    last               npi part_b   dme   hha   pmd hospice
 * <chr>    <chr>            <int>  <int> <int> <int> <int>   <int>
 1 ROBYN    AYER        1659094290      1     1     0     1       0
 2 MEGAN    BAUMGARDNER 1023796711      1     1     0     1       0
 3 KRISTINA BERRY       1295461192      1     1     0     1       0
 4 BONNIE   BETTS       1306821129      1     1     0     1       0
 5 LAURA    BOBROWSKI   1013297019      1     1     0     1       0
 6 LISA     CHRISTIAN   1235636697      1     1     0     1       0
 7 TRAVIS   DANIEL      1134813934      1     1     0     1       0
 8 LYNELL   DAWSON      1962852533      1     1     0     1       0
 9 BETH     DETRICH     1124364203      1     1     0     1       0
10 BRIDGET  DIETZ       1720522592      1     1     0     1       0
# ℹ 41 more rows
```

``` r
# Pending Enrollments
pending(
  first = ends_with("E"),
  last = starts_with("A"))
✔ pending returned 58 results.
• Physician     : 19
• Non-Physician : 39
# A tibble: 58 × 4
   prov_type first     last               npi
 * <chr>     <chr>     <chr>            <int>
 1 Physician JOSE      ABREU-ELIAS 1821010513
 2 Physician GEORGE    ADAMS       1649409947
 3 Physician ABOJE     ADUGBA      1184416976
 4 Physician LUCIE     AHN         1558209502
 5 Physician OLUMIDE   AJAYI       1740029511
 6 Physician JUDE      ALCIDE      1578876108
 7 Physician CATHERINE ALDER       1235996307
 8 Physician EMILIE    ALLAERT     1922809870
 9 Physician KATHERINE ALLEN       1851823488
10 Physician ILEANE    AMADOR      1568427268
# ℹ 48 more rows
```

``` r
# Medicare Enrollment
providers(
  first = contains("C"),
  state = "AK",
  prov_type = ends_with(50))
✔ providers returned 172 results.
# A tibble: 172 × 11
   org_name first     middle last   state prov_type prov_desc    npi multi pac  
 * <chr>    <chr>     <chr>  <chr>  <chr> <chr>     <chr>      <int> <int> <chr>
 1 <NA>     CHRISTINE M      BABCO… AK    14-50     PRACTITI… 1.01e9     0 3072…
 2 <NA>     MICHELE   R      AIKEN  AK    14-50     PRACTITI… 1.17e9     0 0840…
 3 <NA>     CHRISTINE <NA>   KRAMER AK    14-50     PRACTITI… 1.94e9     0 4688…
 4 <NA>     CATHERINE A      LIDDE… AK    14-50     PRACTITI… 1.63e9     0 0345…
 5 <NA>     REBECCA   A      YOUNG  AK    14-50     PRACTITI… 1.74e9     0 8729…
 6 <NA>     CHARLOTTE M      NELSON AK    14-50     PRACTITI… 1.07e9     0 7618…
 7 <NA>     CONNIE    L      CHEVA… AK    14-50     PRACTITI… 1.32e9     0 1850…
 8 <NA>     JOYCE     E      ZIMME… AK    14-50     PRACTITI… 1.32e9     0 5294…
 9 <NA>     DARCY     M      LUCEY  AK    14-50     PRACTITI… 1.37e9     0 7315…
10 <NA>     CYNTHIA   G      JONES  AK    14-50     PRACTITI… 1.96e9     0 3870…
# ℹ 162 more rows
# ℹ 1 more variable: enid <chr>
```

``` r
# Medicare Part A Hospitals
hospitals(
  state = "GA",
  subgroup = subgroups(
    acute = FALSE,
    psych = TRUE))
✔ hospitals returned 14 results.
# A tibble: 14 × 38
   org_name      org_dba enid  enid_state prov_type prov_desc    npi multi ccn  
 * <chr>         <chr>   <chr> <chr>      <chr>     <chr>      <int> <int> <chr>
 1 UHS OF SAVAN… COASTA… O200… GA         00-09     PART A P… 1.68e9     1 1140…
 2 HHC ST. SIMO… ST. SI… O200… GA         00-09     PART A P… 1.97e9     0 1140…
 3 UHS OF SUMMI… SUMMIT… O200… GA         00-09     PART A P… 1.41e9     0 1140…
 4 RIVERWOODS B… LAKEVI… O200… GA         00-09     PART A P… 1.77e9     1 1140…
 5 DEPARTMENT O… WEST C… O200… GA         00-09     PART A P… 1.91e9     0 1140…
 6 DEPARTMENT O… GEORGI… O200… GA         00-09     PART A P… 1.94e9     0 1140…
 7 UHS OF ANCHO… ANCHOR… O201… GA         00-09     PART A P… 1.02e9     1 1140…
 8 DEPARTMENT O… GEORGI… O201… GA         00-09     PART A P… 1.12e9     0 1140…
 9 UHS OF PEACH… PEACHF… O201… GA         00-09     PART A P… 1.09e9     0 1140…
10 GREENLEAF CE… GREENL… O201… GA         00-09     PART A P… 1.54e9     0 1140…
11 VEST MONROE,… RIDGEV… O201… GA         00-09     PART A P… 1.07e9     0 1140…
12 RV BEHAVIORA… RIDGEV… O201… GA         00-09     PART A P… 1.43e9     0 1140…
13 DONALSONVILL… <NA>    O201… GA         00-09     PART A P… 1.93e9     0 11S1…
14 HOSPITAL AUT… JEFFER… O202… GA         00-09     PART A P… 1.42e9     0 11S1…
# ℹ 29 more variables: pac <chr>, inc_date <date>, inc_state <chr>,
#   org_type <chr>, org_otxt <chr>, status <chr>, city <chr>, state <chr>,
#   zip <chr>, loc_type <chr>, loc_otxt <chr>, reh_ind <int>, reh_date <date>,
#   reh_ccn <chr>, sub_acute <int>, sub_gen <int>, sub_spec <int>,
#   sub_adu <int>, sub_child <int>, sub_ltc <int>, sub_psy <int>,
#   sub_irf <int>, sub_stc <int>, sub_sba <int>, sub_psu <int>, sub_iru <int>,
#   sub_oth <int>, sub_otxt <chr>, address <chr>
```

``` r
# CLIA Laboratories
clia(name = starts_with("CDC"))
✔ clia returned 23 results.
# A tibble: 23 × 82
   fac_name_1   fac_name_2 facility_ccn parent_ccn related_ccn xref  chown chowd
 * <chr>        <chr>      <chr>        <chr>      <chr>       <chr> <chr> <chr>
 1 CDC ACCESSC… <NA>       36D1074001   <NA>       <NA>        <NA>  0     <NA> 
 2 CDC ARCTIC … CENTERS F… 02D0873639   <NA>       <NA>        <NA>  0     <NA> 
 3 CDC HOME CA… <NA>       36D1072971   <NA>       <NA>        <NA>  0     <NA> 
 4 CDC HOMECAR… <NA>       36D2093880   <NA>       <NA>        <NA>  0     <NA> 
 5 CDC MIDDLEB… <NA>       36D2143885   <NA>       <NA>        <NA>  0     <NA> 
 6 CDC OCCUPAT… <NA>       06D2096269   <NA>       <NA>        <NA>  0     <NA> 
 7 CDC OCCUPAT… <NA>       06D2328787   <NA>       <NA>        <NA>  0     <NA> 
 8 CDC OCCUPAT… <NA>       11D2099528   <NA>       <NA>        <NA>  0     <NA> 
 9 CDC OF NE W… <NA>       09D0694204   092512     <NA>        <NA>  0     <NA> 
10 CDC OF SPRI… <NA>       49D0714214   492535     <NA>        <NA>  0     <NA> 
# ℹ 13 more rows
# ℹ 74 more variables: chowd_2 <chr>, poc <chr>, compliant <chr>, add_1 <chr>,
#   add_2 <chr>, phone_1 <chr>, phone_2 <chr>, city <chr>, state <chr>,
#   zip <chr>, reg_cd <chr>, reg_st <chr>, ssa_st <chr>, ssa_cty <chr>,
#   fips_st <chr>, fips_cty <chr>, cbsa_1 <chr>, cbsa_2 <chr>, elig <chr>,
#   term_pgm <chr>, term_clia <chr>, app_type <chr>, cert_type <chr>,
#   fac_type <chr>, owner <chr>, action <chr>, orig_date <chr>, …
```

``` r
# Hospital Transparency Enforcement
transparency(action = "warn", state = c("AL", "GA"))
✔ transparency returned 106 results.
# A tibble: 106 × 7
      id name                             address city  state action action_date
 * <int> <chr>                            <chr>   <chr> <chr> <chr>  <date>     
 1    42 Northside Hospital Atlanta       1000 J… Atla… GA    Warni… 2021-04-19 
 2    68 Wellstar Kennestone Regional Me… 677 Ch… Mari… GA    Warni… 2021-04-19 
 3    75 Northeast Georgia Medical Cente… 743 Sp… Gain… GA    Warni… 2021-04-19 
 4    99 Northside Hospital - Cherokee    450 No… Cant… GA    Warni… 2021-05-18 
 5   105 DCH Regional Medical Center      809 Un… Tusc… AL    Warni… 2021-05-18 
 6   116 Wellstar Atlanta Medical Center  303 Pa… Atla… GA    Warni… 2021-04-19 
 7   117 Tift Regional Medical Center     901 Ea… Tift… GA    Warni… 2023-03-01 
 8   127 Flowers Hospital                 4370 W… Doth… AL    Warni… 2023-01-13 
 9   136 Piedmont Columbus Regional Midt… 710 Ce… Colu… GA    Warni… 2021-04-19 
10   141 Mobile Infirmary Medical Center  5 Mobi… Mobi… AL    Warni… 2021-04-19 
# ℹ 96 more rows
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
