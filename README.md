
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
affiliations(last = "Bruce")
✔ affiliations returned 247 results.
# A tibble: 247 × 8
   first    last  middle        npi pac        prov_type prov_ccn parent_ccn
   <chr>    <chr> <chr>       <int> <chr>      <chr>     <chr>    <chr>     
 1 SIDNEY   BRUCE D      1003044520 2466795406 Hospital  150173   <NA>      
 2 SIDNEY   BRUCE D      1003044520 2466795406 Hospital  151312   <NA>      
 3 SIDNEY   BRUCE D      1003044520 2466795406 Hospital  151316   <NA>      
 4 MARGARET BRUCE E      1003444332 0840619235 Hospital  500016   <NA>      
 5 LAUREN   BRUCE C      1003863192 4385530377 Hospital  390331   <NA>      
 6 TIMOTHY  BRUCE <NA>   1013228907 7315239902 Hospital  520008   <NA>      
 7 SARAH    BRUCE <NA>   1023571882 8224498597 Hospital  390111   <NA>      
 8 DAVID    BRUCE S      1043213069 6406929694 Hospital  190036   <NA>      
 9 DAVID    BRUCE <NA>   1043634017 0840422127 Hospital  110107   <NA>      
10 CARLEIGH BRUCE NICOLE 1043772858 8729403746 Hospital  520177   <NA>      
# ℹ 237 more rows
```

#### :handshake: Reassignment of Benefits

``` r
reassignments(
  employers = greater(40), 
  state = "GA"
)
✔ reassignments returned 86 results.
# A tibble: 86 × 13
   first   last  state specialty employers    npi pac   enid  org_name employees
   <chr>   <chr> <chr> <chr>         <int>  <int> <chr> <chr> <chr>        <int>
 1 Naushe… Nave… GA    Diagnost…        42 1.51e9 8022… I201… Advance…         1
 2 Dean    Moes… GA    Diagnost…        44 1.51e9 6709… I200… Amboy M…         1
 3 Naushe… Nave… GA    Diagnost…        42 1.51e9 8022… I201… Atlanti…        40
 4 Dean    Moes… GA    Diagnost…        44 1.51e9 6709… I200… Baxter …         1
 5 Naushe… Nave… GA    Diagnost…        42 1.51e9 8022… I201… Brooks …        48
 6 Dean    Moes… GA    Diagnost…        44 1.51e9 6709… I200… Butler …         4
 7 Naushe… Nave… GA    Diagnost…        42 1.51e9 8022… I201… Central…        34
 8 Dean    Moes… GA    Diagnost…        44 1.51e9 6709… I200… Charles…         5
 9 Dean    Moes… GA    Diagnost…        44 1.51e9 6709… I200… Coastal…        51
10 Naushe… Nave… GA    Diagnost…        42 1.51e9 8022… I201… Concord…         4
# ℹ 76 more rows
# ℹ 3 more variables: org_pac <chr>, org_enid <chr>, org_state <chr>
```

#### :-1: Revoked Medicare Providers

``` r
revocations(
  state = "NY", 
  org_name = not_blank()
)
✔ revocations returned 350 results.
# A tibble: 350 × 12
   org_name        first middle last  enid      npi multi state prov_desc reason
   <chr>           <chr> <chr>  <chr> <chr>   <int> <int> <chr> <chr>     <chr> 
 1 CARDIO VASC IM… <NA>  <NA>   <NA>  O200… NA          0 NY    PART B S… 424.5…
 2 BROOKLYN NUCLE… <NA>  <NA>   <NA>  O200…  1.52e9     1 NY    PART B S… 424.5…
 3 SO NASSAU CARD… <NA>  <NA>   <NA>  O200… NA          0 NY    PART B S… 424.5…
 4 MEADOWS NUCLEA… <NA>  <NA>   <NA>  O200… NA          0 NY    PART B S… 424.5…
 5 STONY BROOK RA… <NA>  <NA>   <NA>  O200…  1.30e9     0 NY    PART B S… 424.5…
 6 FOREST HILLS N… <NA>  <NA>   <NA>  O200…  1.34e9     0 NY    PART B S… 424.5…
 7 MEADOWS NUCLEA… <NA>  <NA>   <NA>  O200…  1.96e9     0 NY    PART B S… 424.5…
 8 GRAMERCY CARDI… <NA>  <NA>   <NA>  O200…  1.34e9     1 NY    PART B S… 424.5…
 9 MEDICAL OFFICE… <NA>  <NA>   <NA>  O200…  1.13e9     0 NY    PART B S… 424.5…
10 CHOICE SPINE J… <NA>  <NA>   <NA>  O200…  1.11e9     0 NY    PART B S… 424.5…
# ℹ 340 more rows
# ℹ 2 more variables: start_date <date>, end_date <date>
```

#### :identification_card: Clinician Demographics

``` r
clinicians(
  state = "GA", 
  school = not("OTHER"), 
  grad_year = 2025
)
✔ clinicians returned 192 results.
# A tibble: 192 × 18
   first middle last  gender cred  school grad_year specialty    npi pac   enid 
   <chr> <chr>  <chr> <chr>  <chr> <chr>      <int> <chr>      <int> <chr> <chr>
 1 MADI… MANN   HANC… F      PA    UNIVE…      2025 PHYSICIA… 1.00e9 5698… I202…
 2 BRIT… MARIE  STEN… F      <NA>  MERCE…      2025 PHYSICIA… 1.04e9 7214… I202…
 3 FORE… STUART HARD… M      <NA>  EDWAR…      2025 ANESTHES… 1.27e9 4880… I202…
 4 ASIA  ZENNE… WATK… F      <NA>  EMORY…      2025 PHYSICIA… 1.88e9 9830… I202…
 5 BRIT… MARIE  STEN… F      <NA>  MERCE…      2025 PHYSICIA… 1.04e9 7214… I202…
 6 WESL… WHITF… LONG  M      CNA   UNIVE…      2025 CERTIFIE… 1.82e9 9638… I202…
 7 HAYL… N      LAKE  F      <NA>  UNIVE…      2025 PHYSICIA… 1.40e9 4981… I202…
 8 COLE  THORN… STUA… M      DC    LIFE …      2025 CHIROPRA… 1.54e9 6709… I202…
 9 SUMM… LYNN   LIND… F      <NA>  MERCE…      2025 PHYSICIA… 1.15e9 5991… I202…
10 NICH… <NA>   HADL… M      <NA>  UNIVE…      2025 PHYSICAL… 1.19e9 3971… I202…
# ℹ 182 more rows
# ℹ 7 more variables: org_name <chr>, org_pac <chr>, members <int>,
#   address <chr>, city <chr>, state <chr>, zip <chr>
```

##### :outbox_tray: Opt-Out Affidavits

``` r
x <- opt_out(
  city = "Atlanta",
  state = "GA")
✔ opt_out returned 352 results.
x
# A tibble: 352 × 12
        npi first last  specialty start_date end_date   updated    address city 
      <int> <chr> <chr> <chr>     <date>     <date>     <date>     <chr>   <chr>
 1   1.88e9 Ana   Adel… Clinical… 2012-07-01 2026-07-01 2024-08-15 SUITE … ATLA…
 2   1.68e9 Sher… Born… Clinical… 2012-04-01 2028-04-01 2026-04-16 SUITE … ATLA…
 3   1.70e9 Nich… Hume  Clinical… 2018-07-01 2026-07-01 2024-08-15 693 MO… ATLA…
 4   1.31e9 Keri… Anas… Nurse Pr… 2012-07-01 2026-07-01 2024-08-15 SUITE … ATLA…
 5   1.60e9 Carol Kran… Psychiat… 2012-01-01 2028-01-01 2026-01-15 STE 210 ATLA…
 6   1.12e9 Lawr… Gius… Psychiat… 2012-07-01 2026-07-01 2024-08-15 STE 202 ATLA…
 7   1.39e9 Ceana Nezh… Obstetri… 2012-10-01 2026-10-01 2024-11-15 SUITE … ATLA…
 8   1.07e9 Frank Mata… Integrat… 2018-04-11 2026-04-11 2024-05-15 STE 405 ATLA…
 9   1.07e9 Vikt… Bouq… General … 2012-10-01 2026-10-01 2024-11-15 4646 N… ATLA…
10   1.79e9 Will… Oven  Clinical… 2017-01-23 2027-01-23 2025-02-15 SUITE … ATLA…
# ℹ 342 more rows
# ℹ 3 more variables: state <chr>, zip <chr>, order_refer <int>
```

##### :receipt: Order & Referral Eligibility

``` r
order_refer(
  npi = x[x$order_refer == 1L, ]$npi[1:100]
)
✔ order_refer returned 100 results.
# A tibble: 100 × 8
   first   last             npi   ptb   dme   hha   pmd hospice
   <chr>   <chr>          <int> <int> <int> <int> <int>   <int>
 1 SHAMINA HENKEL    1003851494     1     1     1     1       1
 2 APRIL   TEFFAULT  1003890211     1     1     0     0       0
 3 MAURIE  MINTZ     1033231048     1     1     1     1       1
 4 LAUREN  BRASWELL  1033309828     1     1     0     0       0
 5 LAURA   WESTEN    1043454150     1     1     0     0       0
 6 BARBARA NAMA      1053472894     1     1     0     0       0
 7 SANDRA  HAYES     1053608489     1     1     1     1       0
 8 VIKTOR  BOUQUETTE 1073730552     1     1     1     1       1
 9 FRANK   MATALONE  1073739249     1     1     1     0       1
10 GARLAND ANDRES    1083850630     1     1     1     1       0
# ℹ 90 more rows
```

##### :health_worker: Medicare Enrollments

``` r
providers(
  org_name = contains("West"),
  state = "GA"
)
✔ providers returned 144 results.
# A tibble: 144 × 11
   org_name      first middle last  state prov_type prov_desc    npi multi pac  
   <chr>         <chr> <chr>  <chr> <chr> <chr>     <chr>      <int> <int> <chr>
 1 WESTSIDE END… <NA>  <NA>   <NA>  GA    12-49     PART B S… 1.49e9     0 0143…
 2 WEST GEORGIA… <NA>  <NA>   <NA>  GA    12-70     PART B S… 1.88e9     0 0244…
 3 WEST PACES S… <NA>  <NA>   <NA>  GA    12-49     PART B S… 1.99e9     0 0345…
 4 NORTHWEST GE… <NA>  <NA>   <NA>  GA    12-70     PART B S… 1.57e9     0 0345…
 5 CROSSROADS T… <NA>  <NA>   <NA>  GA    12-D5     PART B S… 1.36e9     0 0345…
 6 WEST GEORGIA… <NA>  <NA>   <NA>  GA    12-70     PART B S… 1.84e9     0 0446…
 7 PREFERRED VA… <NA>  <NA>   <NA>  GA    12-70     PART B S… 1.79e9     0 0446…
 8 WEST COBB SP… <NA>  <NA>   <NA>  GA    12-A5     PART B S… 1.18e9     0 0446…
 9 NORTHWEST IO… <NA>  <NA>   <NA>  GA    12-70     PART B S… 1.22e9     0 0749…
10 NORTHWEST EN… <NA>  <NA>   <NA>  GA    12-49     PART B S… 1.99e9     0 0749…
# ℹ 134 more rows
# ℹ 1 more variable: enid <chr>
```

##### :calendar: Pending Enrollments

``` r
pending(
  first = starts("E"),
  last = ends("A"))
✔ pending returned 36 results.
• Physician     : 16
• Non-Physician : 20
# A tibble: 36 × 4
   prov_type first     last             npi
   <chr>     <chr>     <chr>          <int>
 1 Physician EDMUND    TAKATA    1518808906
 2 Physician EDWARD    KEDDA     1639871965
 3 Physician EILEEN    SANTA     1952440083
 4 Physician ELIAS     SALAMA    1508660655
 5 Physician ELISABETH HODARA    1447871546
 6 Physician ELIZABETH CARADONNA 1073453312
 7 Physician ELIZABETH PERAZZA   1942230891
 8 Physician ELLEN     HUHULEA   1659219442
 9 Physician ELYSSA    MOLINA    1508624891
10 Physician EMILY     MEARA     1508706516
# ℹ 26 more rows
```

##### :hospital: Medicare Hospitals

``` r
hospitals(
  city = "Valdosta", 
  state = "GA"
) |> str()
✔ hospitals returned 3 results.
hospitls [3 × 17] (S3: hospitals/tbl_df/tbl/data.frame)
 $ org_name: chr [1:3] "GREENLEAF CENTER LLC" "SOUTH GEORGIA MEDICAL CENTER INC" "SOUTH GEORGIA MEDICAL CENTER INC"
 $ org_dba : chr [1:3] "GREENLEAF BEHAVIORAL HEALTH HOSPITAL" "SGMC HEALTH" NA
 $ enid    : chr [1:3] "O20121213000437" "O20240409003369" "O20240410002397"
 $ npi     : int [1:3] 1538417753 1144096553 1598531907
 $ multi   : int [1:3] 0 0 0
 $ ccn     : chr [1:3] "114036" "110122" "11T122"
 $ pac     : chr [1:3] "7416109731" "1052764677" "1052764677"
 $ inc_date: Date[1:3], format: "2012-07-13" "2021-11-09" ...
 $ org_type: chr [1:3] "LLC" "CORPORATION" "CORPORATION"
 $ status  : chr [1:3] "P" "N" "N"
 $ address : chr [1:3] "2209 PINEVIEW DRIVE" "2501 N PATTERSON ST" "2501 N PATTERSON ST"
 $ city    : chr [1:3] "VALDOSTA" "VALDOSTA" "VALDOSTA"
 $ state   : chr [1:3] "GA" "GA" "GA"
 $ zip     : chr [1:3] "316027316" "316021735" "316021735"
 $ loc_type: chr [1:3] "MAIN/PRIMARY HOSPITAL LOCATION" "MAIN/PRIMARY HOSPITAL LOCATION" "HOSPITAL REHABILITATION UNIT"
 $ reh_date: Date[1:3], format: NA NA ...
 $ subgroup: chr [1:3] "Psych" "Acute" "IRF Unit"
```

##### :test_tube: CLIA Laboratories

``` r
clia(
  facility_name = starts("SGMC"),
  state = "GA"
) |> str()
✔ clia returned 32 results.
clia [32 × 24] (S3: clia/tbl_df/tbl/data.frame)
 $ fac_name  : chr [1:32] "SGMC HEALTH" "SGMC- SMITH NORTHVIEW CAMPUS" "SGMC WOMENS HEALTH - OAK" "SGMC VALDOSTA MEDICAL CLINIC" ...
 $ fac_ccn   : chr [1:32] "11D0022233" "11D0022241" "11D0265511" "11D0265607" ...
 $ clia_ccn  : chr [1:32] "110122" "110037" NA "258589220A" ...
 $ xrf_ccn   : chr [1:32] NA NA NA NA ...
 $ shr_ccn   : chr [1:32] NA NA NA NA ...
 $ chows     : int [1:32] 0 0 0 0 0 0 0 0 0 0 ...
 $ address   : chr [1:32] "2501 N PATTERSON STREET" "4280 NORTH VALDOSTA ROAD" "3312 NORTH OAK STREET, SUITE F & G" "3207 COUNTRY CLUB DRIVE" ...
 $ city      : chr [1:32] "VALDOSTA" "VALDOSTA" "VALDOSTA" "VALDOSTA" ...
 $ state     : chr [1:32] "GA" "GA" "GA" "GA" ...
 $ zip       : chr [1:32] "31602" "31602" "31605" "31605" ...
 $ term      : chr [1:32] "Active" "Active" "Active" "Active" ...
 $ cert      : chr [1:32] "Accreditation" "Accreditation" "Waiver" "Waiver" ...
 $ facility  : chr [1:32] "Hospital" "ASC" "Physician" "Physician" ...
 $ owner     : chr [1:32] "[GOE] County" "[GOE] County" "Other" "Other" ...
 $ action    : chr [1:32] "Validate" "Validate" NA "Initial" ...
 $ cert_date : Date[1:32], format: "2003-12-09" "2012-02-08" ...
 $ eff_date  : Date[1:32], format: "2025-02-28" "2025-12-07" ...
 $ term_date : Date[1:32], format: "2027-02-27" "2027-12-06" ...
 $ labs      : int [1:32] 1 1 0 2 3 8 0 0 1 0 ...
 $ sites     : int [1:32] 0 0 0 0 2 0 0 0 0 0 ...
 $ multi     : chr [1:32] NA NA NA NA ...
 $ compliance: chr [1:32] "Compliant (Survey), Eligible (CMS)" "Compliant (Survey), Eligible (CMS)" NA "Compliant (Survey), Eligible (CMS)" ...
 $ acr_org   : chr [1:32] "JCAHO" "CAP" NA NA ...
 $ acr_date  : Date[1:32], format: "2016-06-06" "2023-05-17" ...
```

##### :mag_right: Hospital Transparency Enforcement

``` r
transparency(
  action = "closure", 
  state = "WA")
✔ transparency returned 39 results.
# A tibble: 39 × 7
    case name                             address city  state action action_date
   <int> <chr>                            <chr>   <chr> <chr> <chr>  <date>     
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
