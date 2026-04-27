# **provider**

> **Tidy Healthcare Provider API Interface**

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

## Purpose & Scope

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

### 🚀 Basic Usage Patterns

Most functions in `provider` follow a similar pattern: they accept
identifiers (like an `npi`) or search criteria (like an `org_name`) and
return a `tibble`.

#### Query Modifiers

`provider` supports query modifiers for more precise filtering. These
are implemented as Modifier S7 classes

``` r
library(provider)
```

#### 🏢 Facility Affiliations

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

#### 🤝 Reassignment of Benefits

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

#### 👎 Revoked Medicare Providers

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

#### 🪪 Clinician Demographics

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
#   org_phone <chr>, org_add <chr>
```

##### 📤 Opt-Out Affidavits

``` r
opt_out(
  first = starts("B"),
  specialty = starts("Oral"))
✔ opt_out returned 214 results.
# A tibble: 214 × 12
          npi first last  specialty start_date end_date   updated    city  state
 *      <int> <chr> <chr> <chr>     <date>     <date>     <date>     <chr> <chr>
 1 1689981722 Byron Capps Oral And… 2025-10-27 2027-10-27 2026-01-15 GREE… NC   
 2 1295740603 Brian Pick… Oral Sur… 2012-03-23 2028-03-23 2026-04-16 COLO… CO   
 3 1164493581 Brian Wilk… Oral Sur… 2012-05-10 2026-05-10 2024-06-15 LAWR… KS   
 4 1114910668 Bern… Krupp Oral Sur… 2012-07-01 2026-07-01 2024-08-15 TOWS… MD   
 5 1376656900 Brian Reig… Oral Sur… 2006-07-07 2026-07-07 2024-08-15 SPRI… PA   
 6 1255308789 Brian Camp  Oral Sur… 2012-05-29 2026-05-29 2024-06-15 RALE… NC   
 7 1780603688 Byron Henry Oral Sur… 2012-07-09 2026-07-09 2024-08-15 WORT… OH   
 8 1760438410 Barry Coop… Oral Sur… 2012-07-22 2026-07-22 2024-08-15 HEWL… NY   
 9 1730114950 Bob   Onei… Oral Sur… 2012-08-16 2026-08-16 2024-09-15 CHES… VA   
10 1932137825 Brad… Trot… Oral Sur… 2017-02-09 2027-02-09 2025-03-17 HAMP… VA   
# ℹ 204 more rows
# ℹ 3 more variables: zip <chr>, order_refer <int>, address <chr>
```

##### 🧾 Order & Referral Eligibility

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

##### 🧑‍⚕️ Medicare Enrollments

``` r
providers(
  org_name = starts("SGMC"),
  state = "GA")
✔ providers returned 2 results.
# A tibble: 2 × 11
  org_name first middle last  state prov_type prov_desc    npi multi pac   enid 
* <chr>    <chr> <chr>  <chr> <chr> <chr>     <chr>      <int> <int> <chr> <chr>
1 SGMC PH… <NA>  <NA>   <NA>  GA    12-70     PART B S… 1.42e9     0 4082… O202…
2 SGMC AF… <NA>  <NA>   <NA>  GA    12-70     PART B S… 1.11e9     0 5496… O202…
```

##### 📆 Pending Enrollments

``` r
pending(
  first = contains("A"),
  last = ends("E"))
✔ pending returned 539 results.
• Physician     : 159
• Non-Physician : 380
# A tibble: 539 × 4
   prov_type first     last                 npi
 * <chr>     <chr>     <chr>              <int>
 1 Physician BABATUNDE ADESEYE       1558204693
 2 Physician MIA       ALDRIDGE      1437890761
 3 Physician ETHAN     ANGLE         1821939810
 4 Physician SOCHIMA   ANIKE         1265019822
 5 Physician HARLEY    ARRAUT-WHITE  1548906621
 6 Physician ADESEYE   AWE           1942796479
 7 Physician FRANCISCO BARAJAS DUQUE 1710794219
 8 Physician FRANTZ    BAZILE        1285826180
 9 Physician HANNA     BERUKE        1235433905
10 Physician KATHLEEN  BLAINE        1457904690
# ℹ 529 more rows
```

##### 🏥 Medicare Hospitals

``` r
hospitals(ccn = "110122")
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

##### 🧪 CLIA Laboratories

``` r
clia(
  facility_name = starts("SGMC"),
  state = "GA")
✔ clia returned 32 results.
# A tibble: 32 × 82
   fac_name_1   fac_name_2 facility_ccn parent_ccn related_ccn xref  chown chowd
 * <chr>        <chr>      <chr>        <chr>      <chr>       <chr> <chr> <chr>
 1 SGMC HEALTH  <NA>       11D0022233   110122     <NA>        <NA>  0     <NA> 
 2 SGMC- SMITH… <NA>       11D0022241   110037     <NA>        <NA>  0     <NA> 
 3 SGMC WOMENS… <NA>       11D0265511   <NA>       <NA>        <NA>  0     <NA> 
 4 SGMC VALDOS… <NA>       11D0265607   258589220A <NA>        <NA>  0     <NA> 
 5 SGMC- LANIE… <NA>       11D0265646   110097     <NA>        <NA>  0     <NA> 
 6 SGMC-BERRIE… <NA>       11D0265664   11-0112    <NA>        <NA>  0     <NA> 
 7 SGMC PRIMAR… <NA>       11D0699064   256864445D <NA>        <NA>  0     <NA> 
 8 SGMC HEALTH… <NA>       11D0915865   <NA>       <NA>        <NA>  0     <NA> 
 9 SGMC PRIMAR… <NA>       11D0933615   <NA>       <NA>        <NA>  0     <NA> 
10 SGMC FAMILY… <NA>       11D0948594   <NA>       <NA>        <NA>  0     <NA> 
# ℹ 22 more rows
# ℹ 74 more variables: chowd_2 <chr>, poc <chr>, compliant <chr>, add_1 <chr>,
#   add_2 <chr>, phone_1 <chr>, phone_2 <chr>, city <chr>, state <chr>,
#   zip <chr>, reg_cd <chr>, reg_st <chr>, ssa_st <chr>, ssa_cty <chr>,
#   fips_st <chr>, fips_cty <chr>, cbsa_1 <chr>, cbsa_2 <chr>, elig <chr>,
#   term_pgm <chr>, term_clia <chr>, app_type <chr>, cert_type <chr>,
#   fac_type <chr>, owner <chr>, action <chr>, orig_date <chr>, …
```

##### 🔎 Hospital Transparency Enforcement

``` r
transparency(
  action = "closure", 
  state = "WA")
✔ transparency returned 38 results.
# A tibble: 38 × 7
    case name                             address city  state action action_date
 * <int> <chr>                            <chr>   <chr> <chr> <chr>  <date>     
 1   164 UW Medical Center - Montlake     1959 N… Seat… WA    Closu… 2023-03-17 
 2   253 Valley Medical Center            400 S.… Rent… WA    Closu… 2024-08-09 
 3   344 Providence Sacred Heart Childre… 101 We… Spok… WA    Closu… 2023-05-08 
 4   416 Providence Regional Medical Cen… 916 Pa… Ever… WA    Closu… 2023-03-23 
 5   578 Fairfax Behavioral Health        10200 … Kirk… WA    Closu… 2023-07-20 
 6   836 Overlake Medical Center          1035 1… Bell… WA    Closu… 2024-07-03 
 7   866 East Adams Rural Healthcare      903 S … Ritz… WA    Closu… 2024-02-29 
 8   871 Forks Community Hospital         530 Bo… Forks WA    Closu… 2023-04-26 
 9   886 Othello Community Hospital       315 N … Othe… WA    Closu… 2023-09-01 
10   918 Newport Hospital and Health Ser… 714 We… Newp… WA    Closu… 2023-06-23 
# ℹ 28 more rows
```

------------------------------------------------------------------------

### ⚖️ Code of Conduct

Please note that the **`provider`** project is released with a
[Contributor Code of
Conduct](https://andrewallenbruce.github.io/provider/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.

### 🏛️ Governance

This project is primarily maintained by [Andrew
Bruce](https://github.com/andrewallenbruce). Other authors may
occasionally assist with some of these duties.
