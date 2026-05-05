
<!-- README.md is generated from README.Rmd. Please edit that file -->

# <b>provider</b> <a href="https://andrewallenbruce.github.io/provider/"><img src="man/figures/logo.svg" align="right" height="139" alt="provider website" /></a>

> <b>Tidy Healthcare Provider API Interface</b>

<!-- badges: start -->

[![Ask
DeepWiki](https://deepwiki.com/badge.svg)](https://deepwiki.com/andrewallenbruce/provider)
[![zread](https://img.shields.io/badge/Ask_Zread-_.svg?style=flat&color=00b0aa&labelColor=000000&logo=data%3Aimage%2Fsvg%2Bxml%3Bbase64%2CPHN2ZyB3aWR0aD0iMTYiIGhlaWdodD0iMTYiIHZpZXdCb3g9IjAgMCAxNiAxNiIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHBhdGggZD0iTTQuOTYxNTYgMS42MDAxSDIuMjQxNTZDMS44ODgxIDEuNjAwMSAxLjYwMTU2IDEuODg2NjQgMS42MDE1NiAyLjI0MDFWNC45NjAxQzEuNjAxNTYgNS4zMTM1NiAxLjg4ODEgNS42MDAxIDIuMjQxNTYgNS42MDAxSDQuOTYxNTZDNS4zMTUwMiA1LjYwMDEgNS42MDE1NiA1LjMxMzU2IDUuNjAxNTYgNC45NjAxVjIuMjQwMUM1LjYwMTU2IDEuODg2NjQgNS4zMTUwMiAxLjYwMDEgNC45NjE1NiAxLjYwMDFaIiBmaWxsPSIjZmZmIi8%2BCjxwYXRoIGQ9Ik00Ljk2MTU2IDEwLjM5OTlIMi4yNDE1NkMxLjg4ODEgMTAuMzk5OSAxLjYwMTU2IDEwLjY4NjQgMS42MDE1NiAxMS4wMzk5VjEzLjc1OTlDMS42MDE1NiAxNC4xMTM0IDEuODg4MSAxNC4zOTk5IDIuMjQxNTYgMTQuMzk5OUg0Ljk2MTU2QzUuMzE1MDIgMTQuMzk5OSA1LjYwMTU2IDE0LjExMzQgNS42MDE1NiAxMy43NTk5VjExLjAzOTlDNS42MDE1NiAxMC42ODY0IDUuMzE1MDIgMTAuMzk5OSA0Ljk2MTU2IDEwLjM5OTlaIiBmaWxsPSIjZmZmIi8%2BCjxwYXRoIGQ9Ik0xMy43NTg0IDEuNjAwMUgxMS4wMzg0QzEwLjY4NSAxLjYwMDEgMTAuMzk4NCAxLjg4NjY0IDEwLjM5ODQgMi4yNDAxVjQuOTYwMUMxMC4zOTg0IDUuMzEzNTYgMTAuNjg1IDUuNjAwMSAxMS4wMzg0IDUuNjAwMUgxMy43NTg0QzE0LjExMTkgNS42MDAxIDE0LjM5ODQgNS4zMTM1NiAxNC4zOTg0IDQuOTYwMVYyLjI0MDFDMTQuMzk4NCAxLjg4NjY0IDE0LjExMTkgMS42MDAxIDEzLjc1ODQgMS42MDAxWiIgZmlsbD0iI2ZmZiIvPgo8cGF0aCBkPSJNNCAxMkwxMiA0TDQgMTJaIiBmaWxsPSIjZmZmIi8%2BCjxwYXRoIGQ9Ik00IDEyTDEyIDQiIHN0cm9rZT0iI2ZmZiIgc3Ryb2tlLXdpZHRoPSIxLjUiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIvPgo8L3N2Zz4K&logoColor=ffffff)](https://zread.ai/andrewallenbruce/provider)
[![Codecov test
coverage](https://codecov.io/gh/andrewallenbruce/provider/branch/main/graph/badge.svg)](https://app.codecov.io/gh/andrewallenbruce/provider?branch=main)
[![CodeFactor](https://www.codefactor.io/repository/github/andrewallenbruce/provider/badge)](https://www.codefactor.io/repository/github/andrewallenbruce/provider)
[![code
size](https://img.shields.io/github/languages/code-size/andrewallenbruce/provider.svg)](https://github.com/andrewallenbruce/provider)
<!-- badges: end -->

You can install `provider` from [GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("andrewallenbruce/provider")
```

## Overview

The `provider` package is a high-level interface designed to streamline
access to publicly available healthcare provider data from the Centers
for Medicare and Medicaid Services (CMS) and other federal sources. It
provides a unified, tidy framework for querying complex datasets that
are essential for medical coding, billing, and healthcare revenue cycle
management.

The provider package is a technical interface for accessing publicly
available healthcare provider data from the Centers for Medicare and
Medicaid Services (CMS) and the Health Resources and Services
Administration (HRSA). It provides a unified, tidy API for querying
complex datasets such as the NPPES NPI Registry, PECOS enrollment data,
and hospital transparency records.

### Purpose & Scope

Navigating the healthcare data ecosystem often involves disparate APIs
with inconsistent field names and data structures. `provider` abstracts
these complexities into a consistent set of R functions that return
“tidy” data frames.

The package targets several key data domains:

- **Individual Providers**: Clinician demographics, enrollments, and
  opt-out affidavits
- **Organizational Providers**: Hospital data, CLIA labs, and Rural
  Health Clinics (RHC)
- **Compliance & Sanctions**: Medicare revocations and hospital price
  transparency enforcement
- **General Registry**: NPPES NPI registry and reassignment of benefits

### :rocket: Basic Usage Patterns

Most functions in `provider` follow a similar pattern: they accept
identifiers (like an `npi`) or search criteria (like an `org_name`) and
return a `tibble`.

#### Query Modifiers

`provider` supports query modifiers for more precise filtering. These
are implemented as Modifier S7 classes

``` r
library(provider)
```

#### :office: Facility Affiliations

``` r
affiliations(facility_ccn = 110122)
✔ affiliations returned 397 results.
# A tibble: 397 × 9
   first  last  middle suffix    npi pac   facility_type facility_ccn parent_ccn
 * <chr>  <chr> <chr>  <chr>   <int> <chr> <chr>         <chr>        <chr>     
 1 JEREMY COLY… STEPH… <NA>   1.00e9 1254… Hospital      110122       <NA>      
 2 COLE   BURG… <NA>   <NA>   1.00e9 1850… Hospital      110122       <NA>      
 3 VIVEK  YADAV <NA>   <NA>   1.00e9 2365… Hospital      110122       <NA>      
 4 FELIX  VALD… G      <NA>   1.02e9 2860… Hospital      110122       <NA>      
 5 STEPH… FOX   G      <NA>   1.02e9 5698… Hospital      110122       <NA>      
 6 ERIC   STIE… CHRIS… <NA>   1.02e9 5799… Hospital      110122       <NA>      
 7 ROBERT BENN… D      <NA>   1.02e9 1759… Hospital      110122       <NA>      
 8 NATHAN ROBE… KELLY  <NA>   1.02e9 6507… Hospital      110122       <NA>      
 9 WILLI… MULL… THOMAS JR.    1.02e9 8527… Hospital      110122       <NA>      
10 RACHEL ARMS… KATHL… <NA>   1.03e9 7113… Hospital      110122       <NA>      
# ℹ 387 more rows
```

#### :handshake: Reassignment of Benefits

``` r
reassignments(
  org_name = starts("SGMC"),
  state = "GA")
✔ reassignments returned 210 results.
# A tibble: 210 × 14
   first   last  state specialty employers    npi pac   enid  org_name employees
 * <chr>   <chr> <chr> <chr>         <int>  <int> <chr> <chr> <chr>        <int>
 1 Carter  Adams GA    Nurse Pr…         2 1.50e9 8628… I202… Sgmc Af…        49
 2 Jessica Alfe… GA    Nurse Pr…         9 1.24e9 7416… I201… Sgmc Af…        49
 3 Ginger  Ambr… GA    Nurse Pr…         2 1.88e9 3779… I202… Sgmc Af…        49
 4 Grant   Bark… GA    Emergenc…         2 1.48e9 4082… I202… Sgmc Af…        49
 5 Stacy   Beck  GA    Nurse Pr…         3 1.73e9 4385… I201… Sgmc Af…        49
 6 Lila    Benn… GA    Nurse Pr…         3 1.93e9 5991… I201… Sgmc Af…        49
 7 Margar… Cart… GA    Nurse Pr…         8 1.24e9 6507… I201… Sgmc Af…        49
 8 Clayton Char… GA    Hospital…         4 1.08e9 6204… I201… Sgmc Af…        49
 9 Michel… Char… GA    Nurse Pr…         3 1.44e9 4183… I201… Sgmc Af…        49
10 Hunter  Clan… GA    Nurse Pr…         4 1.45e9 9032… I202… Sgmc Af…        49
# ℹ 200 more rows
# ℹ 4 more variables: org_pac <chr>, org_enid <chr>, org_state <chr>,
#   rec_type <chr>
```

#### :-1: Revoked Medicare Providers

``` r
revocations(state = "GA")
✔ revocations returned 213 results.
# A tibble: 213 × 12
   org_name first    middle last       enid     npi multi state prov_desc reason
 * <chr>    <chr>    <chr>  <chr>      <chr>  <int> <int> <chr> <chr>     <chr> 
 1 <NA>     WALLACE  S      ANDERSON   I200… 1.88e9     0 GA    PRACTITI… 424.5…
 2 <NA>     LEO      G      FRANGIPANE I200… 1.07e9     0 GA    PRACTITI… 424.5…
 3 <NA>     ANTHONY  D      MILLS      I200… 1.27e9     0 GA    PRACTITI… 424.5…
 4 <NA>     JEFFREY  M.     GALLUPS    I200… 1.85e9     0 GA    PRACTITI… 424.5…
 5 <NA>     CURTIS   <NA>   CHEEKS     I200… 1.53e9     0 GA    PRACTITI… 424.5…
 6 <NA>     ZAVIER   C      ASH        I200… 1.77e9     0 GA    PRACTITI… 424.5…
 7 <NA>     SHAWN    E      TYWON      I200… 1.68e9     0 GA    PRACTITI… 424.5…
 8 <NA>     ANAND    P      LALAJI     I200… 1.65e9     0 GA    PRACTITI… 424.5…
 9 <NA>     TIFFANNI D      FORBES     I200… 1.21e9     0 GA    PRACTITI… 424.5…
10 <NA>     STEPHEN  T      BASHUK     I200… 1.95e9     0 GA    PRACTITI… 424.5…
# ℹ 203 more rows
# ℹ 2 more variables: start_date <date>, end_date <date>
```

#### :identification_card: Clinician Demographics

``` r
clinicians(
  org_name = starts("SGMC"),
  org_state = "GA")
✔ clinicians returned 167 results.
# A tibble: 167 × 20
   first    middle last    suffix gender cred  school grad_year specialty    npi
 * <chr>    <chr>  <chr>   <chr>  <chr>  <chr> <chr>      <int> <chr>      <int>
 1 MANDY    <NA>   LUCAS   <NA>   F      <NA>  MEHAR…      2011 FAMILY P… 1.35e9
 2 BHUMIBEN KUSHAL PATEL   <NA>   F      NP    OTHER       2018 NURSE PR… 1.47e9
 3 WILLIAM  <NA>   NASH    <NA>   M      MD    MEDIC…      1992 FAMILY P… 1.24e9
 4 VERA     C      GARCIA  <NA>   M      MD    OTHER       1991 FAMILY P… 1.15e9
 5 ALBERTO  E      GARCIA  <NA>   M      MD    OTHER       1996 FAMILY P… 1.52e9
 6 JULENE   D      SMITH   <NA>   F      NP    OTHER       2015 NURSE PR… 1.08e9
 7 KASSI    LAITEN COPELA… <NA>   F      <NA>  OTHER       2025 NURSE PR… 1.16e9
 8 JYNGER   MORRIS HULING  <NA>   F      <NA>  OTHER       2003 MENTAL H… 1.35e9
 9 WENDY    <NA>   VANDEM… <NA>   F      MD    NORTH…      2000 PSYCHIAT… 1.39e9
10 MYRA     <NA>   JORDAN  <NA>   F      <NA>  OTHER       2004 MARRIAGE… 1.46e9
# ℹ 157 more rows
# ℹ 10 more variables: pac <chr>, enid <chr>, org_name <chr>, org_pac <chr>,
#   org_mem <int>, org_city <chr>, org_state <chr>, org_zip <chr>,
#   org_add <chr>, specialty <chr>
```

##### :outbox_tray: Opt-Out Affidavits

``` r
opt_out(
  city = "Valdosta",
  state = "GA")
✔ opt_out returned 4 results.
# A tibble: 4 × 12
         npi first  last  specialty start_date end_date   updated    city  state
*      <int> <chr>  <chr> <chr>     <date>     <date>     <date>     <chr> <chr>
1 1992848659 Jeffe… Wood  Maxillof… 2016-01-11 2028-01-11 2026-02-16 VALD… GA   
2 1073632659 Ferna… Alva… Oral Sur… 2017-07-01 2027-07-01 2025-08-15 VALD… GA   
3 1811005655 Sonya  Merr… Plastic … 2022-01-01 2028-01-01 2026-01-15 VALD… GA   
4 1720717887 Rebec… Schi… Mental H… 2024-03-22 2028-03-22 2026-04-16 VALD… GA   
# ℹ 3 more variables: zip <chr>, order_refer <int>, address <chr>
```

##### :receipt: Order & Referral Eligibility

``` r
order_refer(
  first = contains("LESS"),
  ptb = TRUE,
  hospice = FALSE,
  hha = FALSE)
✔ order_refer returned 38 results.
# A tibble: 38 × 8
   first       last                  npi   ptb   dme   hha   pmd hospice
 * <chr>       <chr>               <int> <int> <int> <int> <int>   <int>
 1 ALESSANDRA  ALTOVINO       1518559350     1     1     0     0       0
 2 VELESSAUNIA BRIDGES-WILSON 1649501503     1     1     0     0       0
 3 ALESSANDRA  CALHOUN        1730412420     1     1     0     0       0
 4 ALESSANDRA  CARUSO         1790206852     1     1     0     0       0
 5 ALESSANDRA  CARVALHO       1851178206     1     1     0     0       0
 6 BLESSY      CHACKO         1659024842     1     1     0     0       0
 7 BLESSING    CHINEDUOBI     1205255106     1     1     0     0       0
 8 ALESSANDRA  CITRO          1639875172     1     1     0     0       0
 9 MELESSA     DILLINGHAM     1992341721     1     1     0     0       0
10 ARLESS      DODSON         1346520582     1     1     0     0       0
# ℹ 28 more rows
```

##### :health_worker: Medicare Enrollments

``` r
providers(
  org_name = contains("SGMC"),
  state = "GA")
✔ providers returned 2 results.
# A tibble: 2 × 11
  org_name first middle last  state prov_type prov_desc    npi multi pac   enid 
* <chr>    <chr> <chr>  <chr> <chr> <chr>     <chr>      <int> <int> <chr> <chr>
1 SGMC PH… <NA>  <NA>   <NA>  GA    12-70     PART B S… 1.42e9     0 4082… O202…
2 SGMC AF… <NA>  <NA>   <NA>  GA    12-70     PART B S… 1.11e9     0 5496… O202…
```

##### :calendar: Pending Enrollments

``` r
pending(
  first = contains("A"),
  last = ends("E"))
✔ pending returned 551 results.
• Physician     : 176
• Non-Physician : 375
# A tibble: 551 × 3
   first     last                npi
 * <chr>     <chr>             <int>
 1 BABATUNDE ADESEYE      1558204693
 2 MELISSA   ALDRIDGE     1073132429
 3 MIA       ALDRIDGE     1437890761
 4 ETHAN     ANGLE        1821939810
 5 SOCHIMA   ANIKE        1265019822
 6 HARLEY    ARRAUT-WHITE 1548906621
 7 JUAN      ARROYAVE     1104766104
 8 MARIAM    ATOBILOYE    1992405476
 9 ADESEYE   AWE          1942796479
10 KALENE    BADREE       1578405635
# ℹ 541 more rows
```

##### :hospital: Medicare Hospitals

``` r
hospitals(org_dba = contains("SGMC"))
✔ hospitals returned 1 result.
# A tibble: 1 × 37
  org_name org_dba enid  enid_state prov_type prov_desc    npi multi ccn   pac  
* <chr>    <chr>   <chr> <chr>      <chr>     <chr>      <int> <int> <chr> <chr>
1 SOUTH G… SGMC H… O202… GA         00-09     PART A P… 1.14e9     0 1101… 1052…
# ℹ 27 more variables: inc_date <date>, inc_state <chr>, org_type <chr>,
#   org_otxt <chr>, status <chr>, city <chr>, state <chr>, zip <chr>,
#   loc_type <chr>, loc_otxt <chr>, reh_date <date>, reh_ccn <chr>,
#   sub_acute <int>, sub_gen <int>, sub_spec <int>, sub_adu <int>,
#   sub_child <int>, sub_ltc <int>, sub_psy <int>, sub_irf <int>,
#   sub_stc <int>, sub_sba <int>, sub_psu <int>, sub_iru <int>, sub_oth <int>,
#   sub_otxt <int>, address <chr>
```

##### :test_tube: CLIA Laboratories

``` r
clia(
  facility_name = starts("SGMC"),
  state = "GA")
✔ clia returned 32 results.
# A tibble: 32 × 58
   facility_ccn parent_ccn xref_ccn shared_ccn mac   chown chow_date poc_ind
 * <chr>        <chr>      <chr>    <chr>      <chr> <int> <date>      <int>
 1 11D0022233   110122     <NA>     <NA>       <NA>      0 NA              0
 2 11D0022241   110037     <NA>     <NA>       <NA>      0 NA              0
 3 11D0265511   <NA>       <NA>     <NA>       <NA>      0 NA              0
 4 11D0265607   258589220A <NA>     <NA>       <NA>      0 NA              0
 5 11D0265646   110097     <NA>     <NA>       <NA>      0 NA              0
 6 11D0265664   11-0112    <NA>     <NA>       <NA>      0 NA              0
 7 11D0699064   256864445D <NA>     <NA>       <NA>      0 NA              0
 8 11D0915865   <NA>       <NA>     <NA>       <NA>      0 NA              0
 9 11D0933615   <NA>       <NA>     <NA>       <NA>      0 NA              0
10 11D0948594   <NA>       <NA>     <NA>       <NA>      0 NA              0
# ℹ 22 more rows
# ℹ 50 more variables: compliant <chr>, city <chr>, state <chr>, zip <chr>,
#   elig_ind <int>, term_pgm <chr>, term_clia <chr>, app_type <chr>,
#   cert_type <chr>, fac_type <chr>, own_type <chr>, act_type <chr>,
#   orig_date <date>, cert_date <date>, eff_date <date>, term_date <date>,
#   a2la_date <date>, a2la_ind <int>, aabb_date <date>, aabb_ind <int>,
#   aoa_date <date>, aoa_ind <int>, ashi_date <date>, ashi_ind <int>, …
```

##### :mag_right: Hospital Transparency Enforcement

``` r
transparency(
  action = "closure", 
  state = "WA")
✔ transparency returned 39 results.
# A tibble: 39 × 7
    case name                             address city  state action action_date
 * <int> <chr>                            <chr>   <chr> <chr> <chr>  <date>     
 1  1291 Arbor Health Morton Hospital     521 Ad… Mort… WA    Closu… 2023-04-13 
 2  2248 Arbor Health Morton Hospital     521 Ad… Mort… WA    Closu… 2024-05-30 
 3  2849 Astria Toppenish Hospital        502 W … Topp… WA    Closu… 2024-12-30 
 4  6638 Cascade Medical Center           817 Co… Leav… WA    Closu… 2025-12-18 
 5  4578 CHI Franciscan Rehabilitation H… 815 S … Taco… WA    Closu… 2025-08-25 
 6  6707 Columbia Basin Hospital          200 Na… Ephr… WA    Closu… 2026-01-12 
 7  6717 Coulee Medical Center            411 Fo… Gran… WA    Closu… 2025-12-30 
 8  6731 Dayton General Hospital          1012 S… Dayt… WA    Closu… 2025-12-01 
 9   866 East Adams Rural Healthcare      903 S … Ritz… WA    Closu… 2024-02-29 
10  6191 EvergreenHealth Kirkland         12040 … Kirk… WA    Closu… 2025-12-19 
# ℹ 29 more rows
```

------------------------------------------------------------------------

### :balance_scale: Code of Conduct

Please note that the **`provider`** project is released with a
[Contributor Code of
Conduct](https://andrewallenbruce.github.io/provider/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.

### :classical_building: Governance

This project is primarily maintained by [Andrew
Bruce](https://github.com/andrewallenbruce). Other authors may
occasionally assist with some of these duties.
