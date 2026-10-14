# **provider**

> **Tidy Healthcare Provider API Interface**

You can install `provider` from [GitHub](https://github.com/) with:

``` r

# install.packages("pak")
pak::pak("andrewallenbruce/provider")
```

The `provider` package is a high-level interface designed to streamline
access to publicly available healthcare provider data from the Centers
for Medicare and Medicaid Services (CMS) and other federal sources. It
provides a unified, tidy framework for querying complex datasets that
are essential for medical coding, billing, and healthcare revenue cycle
management.

### 🚀 Basic Usage Patterns

Most functions in `provider` follow a similar pattern: they accept
identifiers (like an `npi`) or search criteria (like an `org_name`) and
return a `tibble`.

``` r

library(provider)
```

#### 🏢 Facility Affiliations

``` r
affiliations(last = "Bruce")
✔ affiliations returned 330 results
# A tibble: 330 × 7
   first    last         npi pac        fac_type ccn    parent_ccn
   <chr>    <chr>      <int> <chr>      <chr>    <chr>  <chr>     
 1 SIDNEY   BRUCE 1003044520 2466795406 Hospital 150173 <NA>      
 2 SIDNEY   BRUCE 1003044520 2466795406 Hospital 151312 <NA>      
 3 SIDNEY   BRUCE 1003044520 2466795406 Hospital 151316 <NA>      
 4 MARGARET BRUCE 1003444332 0840619235 Hospital 500016 <NA>      
 5 LAUREN   BRUCE 1003863192 4385530377 Hospital 390331 <NA>      
 6 TIMOTHY  BRUCE 1013228907 7315239902 Hospital 520008 <NA>      
 7 TIMOTHY  BRUCE 1013228907 7315239902 Hospital 520051 <NA>      
 8 SARAH    BRUCE 1023571882 8224498597 Hospital 390111 <NA>      
 9 ROBERT   BRUCE 1033799341 1456825231 Hospital 470003 <NA>      
10 ROBERT   BRUCE 1033799341 1456825231 Hospital 471307 <NA>      
# ℹ 320 more rows
```

#### 🤝 Reassignment of Benefits

``` r
reassigned(
  org_enid = starts("I"), 
  members = greater(50, equal = TRUE)
)
✔ reassigned returned 51 results
# A tibble: 51 × 13
        npi pac   enid  first last  state specialty memberships org_pac org_enid
      <int> <chr> <chr> <chr> <chr> <chr> <chr>           <int> <chr>   <chr>   
 1   1.83e9 6103… I201… Hila… Alva… TX    Family P…           2 175932… I201208…
 2   1.92e9 9638… I200… James Bagg… TX    Emergenc…           2 175932… I201208…
 3   1.37e9 5799… I200… Todd  Baker TX    Family P…           2 175932… I201208…
 4   1.84e9 5193… I200… Ami   Besh… TX    Family P…           2 175932… I201208…
 5   1.86e9 2567… I201… Denn… Bish… TX    Emergenc…           6 175932… I201208…
 6   1.32e9 3452… I201… Cris… Blej… TX    Family P…           2 175932… I201208…
 7   1.84e9 3274… I201… James Bugg  TX    Family P…           2 175932… I201208…
 8   1.89e9 5092… I200… Rich… Camp… TX    Emergenc…           2 175932… I201208…
 9   1.01e9 8820… I200… John  Cantu TX    Family P…           2 175932… I201208…
10   1.82e9 7416… I201… David Cart… TX    Family P…           5 175932… I201208…
# ℹ 41 more rows
# ℹ 3 more variables: org_name <chr>, members <int>, org_state <chr>
```

#### 👎 Revoked Medicare Providers

``` r
revoked(state = "GA", org_name = not_blank())
✔ revoked returned 142 results
# A tibble: 142 × 11
   org         first last  enid      npi multi state prov_desc reason start_date
   <chr>       <chr> <chr> <chr>   <int> <int> <chr> <chr>     <chr>  <date>    
 1 PROGRESSIV… <NA>  <NA>  O200… NA          0 GA    PART B S… 424.5… 2024-06-20
 2 EMMANUEL O… <NA>  <NA>  O200…  1.34e9     0 GA    PART B S… 424.5… 2022-09-20
 3 COMPREHENS… <NA>  <NA>  O200…  1.13e9     0 GA    PART B S… 424.5… 2018-06-07
 4 RIVERSIDE … <NA>  <NA>  O200…  1.31e9     0 GA    PART B S… 424.5… 2017-03-08
 5 PAIN MANAG… <NA>  <NA>  O200…  1.54e9     0 GA    PART B S… 424.5… 2024-03-01
 6 DEEP SOUTH… <NA>  <NA>  O200…  1.07e9     0 GA    PART B S… 424.5… 2025-01-05
 7 SIGHT SAVE… <NA>  <NA>  O200… NA          0 GA    PART B S… 424.5… 2019-06-12
 8 SENIOR PSY… <NA>  <NA>  O200…  1.23e9     0 GA    PART B S… 424.5… 2023-03-04
 9 WALLACE ST… <NA>  <NA>  O200…  1.98e9     0 GA    PART B S… 424.5… 2022-06-30
10 FULGHUM DR… <NA>  <NA>  O200…  1.41e9     1 GA    PART B S… 424.5… 2019-07-31
# ℹ 132 more rows
# ℹ 1 more variable: end_date <date>
```

#### 🪪 Clinician Demographics

``` r
clinician(
  state = "GA", 
  school = not("OTHER"), 
  org_name = not_blank(),
  year = 2025
)
✔ clinician returned 228 results
# A tibble: 228 × 17
        npi pac   enid  first last  gender cred  school  year specialty org_name
      <int> <chr> <chr> <chr> <chr> <chr>  <chr> <chr>  <int> <chr>     <chr>   
 1   1.26e9 9830… I202… LUIS  RAMI… M      <NA>  UNIVE…  2025 NURSE PR… APPALAC…
 2   1.97e9 3274… I202… SUWA… GASS… M      CNA   BAYLO…  2025 CERTIFIE… HOSPITA…
 3   1.74e9 7517… I202… NUPUR MISH… F      MD    SOUTH…  2025 INTERNAL… PIEDMON…
 4   1.04e9 7214… I202… BRIT… STEN… F      <NA>  MERCE…  2025 PHYSICIA… NORTHSI…
 5   1.73e9 3375… I202… NEO   SANS… M      <NA>  EMORY…  2025 ANESTHES… NORTH A…
 6   1.04e9 7214… I202… BRIT… STEN… F      <NA>  MERCE…  2025 PHYSICIA… NORTHSI…
 7   1.27e9 4880… I202… FORE… HARD… M      <NA>  EDWAR…  2025 ANESTHES… NORTH A…
 8   1.82e9 9638… I202… WESL… LONG  M      CNA   UNIVE…  2025 CERTIFIE… NORTH A…
 9   1.97e9 2163… I202… STEF… SHINE F      <NA>  SOUTH…  2025 OPTOMETRY EUGENE …
10   1.54e9 6709… I202… COLE  STUA… M      DC    LIFE …  2025 CHIROPRA… WHITEHA…
# ℹ 218 more rows
# ℹ 6 more variables: org_pac <chr>, members <int>, address <chr>, city <chr>,
#   state <chr>, zip <chr>
```

##### 📤 Opt-Out Affidavits

``` r
opted_out(state = "GA", order_refer = FALSE)
✔ opted_out returned 638 results
# A tibble: 638 × 12
        npi first last  specialty start_date end_date   updated    address city 
      <int> <chr> <chr> <chr>     <date>     <date>     <date>     <chr>   <chr>
 1   1.88e9 Ana   Adel… Clinical… 2012-07-01 2028-07-01 2026-08-14 675 SE… ATLA…
 2   1.98e9 Joan  Mill… Clinical… 2014-07-01 2028-07-01 2026-08-14 2520 W… MARI…
 3   1.70e9 Nich… Hume  Clinical… 2018-07-01 2028-07-01 2026-08-14 693 MO… ATLA…
 4   1.51e9 Mich… Fish… General … 2012-04-01 2028-04-01 2026-04-16 5448 Y… ATLA…
 5   1.48e9 Clem… Hsiao Obstetri… 2012-07-01 2028-07-01 2026-08-14 3180 N… ALPH…
 6   1.88e9 Barb… Da V… Psychiat… 2012-07-01 2028-07-01 2026-08-14 143 FO… ST S…
 7   1.95e9 Mich… Milt… Family P… 2013-07-01 2027-07-01 2025-08-15 6030 B… CUMM…
 8   1.31e9 Chri… Reck… Internal… 2013-10-01 2027-10-01 2025-11-14 2350 L… GAIN…
 9   1.71e9 Jerry Will… Neurology 2018-07-06 2028-07-06 2026-08-14 1004 M… SAVA…
10   1.82e9 Mich… Swag… Clinical… 2013-10-01 2027-10-01 2025-11-14 1150 S… ATHE…
# ℹ 628 more rows
# ℹ 3 more variables: state <chr>, zip <chr>, order_refer <chr>
```

##### 🧾 Order & Referral Eligibility

``` r
order_refer(first = "Jennifer", last = "Smith")
✔ order_refer returned 136 results
# A tibble: 136 × 8
          npi first    last  ptb_ind dme_ind hha_ind pmd_ind hsp_ind
        <int> <chr>    <chr>   <int>   <int>   <int>   <int>   <int>
 1 1124421995 JENNIFER SMITH       1       1       1       1       0
 2 1134344286 JENNIFER SMITH       1       1       1       1       1
 3 1811218712 JENNIFER SMITH       1       1       1       1       1
 4 1215468897 JENNIFER SMITH       1       1       1       1       0
 5 1053340471 JENNIFER SMITH       1       1       1       1       0
 6 1154778181 JENNIFER SMITH       1       1       1       1       1
 7 1982792206 JENNIFER SMITH       1       1       1       1       0
 8 1336652726 JENNIFER SMITH       1       1       1       1       0
 9 1407299431 JENNIFER SMITH       1       1       1       1       1
10 1962707042 JENNIFER SMITH       1       1       1       1       0
# ℹ 126 more rows
```

##### 🧑‍⚕️ Medicare Provider Enrollments

``` r
enrolled(state = "GA", org_name = contains("West"))
✔ enrolled returned 142 results
# A tibble: 142 × 10
          npi pac     enid  prov_type prov_desc org_name first last  state multi
        <int> <chr>   <chr> <chr>     <chr>     <chr>    <chr> <chr> <chr> <int>
 1 1982631321 599161… O200… 00-17     PART A P… TMC WES… <NA>  <NA>  GA        0
 2 1417048885 539565… O200… 12-65     PART B S… WEST CO… <NA>  <NA>  GA        0
 3 1114075694 206231… O200… 12-70     PART B S… WEST GE… <NA>  <NA>  GA        0
 4 1992756894 206231… O200… 12-70     PART B S… SOUTHWE… <NA>  <NA>  GA        0
 5 1861461790 276937… O200… 00-03     PART A P… SOUTHWE… <NA>  <NA>  GA        0
 6 1710946900 276937… O200… 00-03     PART A P… SOUTHWE… <NA>  <NA>  GA        0
 7 1386635852 670977… O200… 12-70     PART B S… PRIMARY… <NA>  <NA>  GA        0
 8 1295704138 276937… O200… 00-03     PART A P… SOUTHWE… <NA>  <NA>  GA        0
 9 1982701124 660876… O200… 12-70     PART B S… WEST GE… <NA>  <NA>  GA        0
10 1730158775 276937… O200… 00-03     PART A P… SOUTHWE… <NA>  <NA>  GA        0
# ℹ 132 more rows
```

##### 📆 Pending Enrollments

``` r
pending(first = starts("E"), last = ends("A"))
✔ pending returned 47 results
# A tibble: 47 × 4
   prov_type        npi first        last            
   <chr>          <int> <chr>        <chr>           
 1 Physician 1225925753 EANAS        ABUTAHA         
 2 Physician 1730882564 EDMUNDO      ESPARZA         
 3 Physician 1952440083 EILEEN       SANTA           
 4 Physician 1306478979 ELENA        BENZAQUEN GARCIA
 5 Physician 1508660655 ELIAS        SALAMA          
 6 Physician 1942230891 ELIZABETH    PERAZZA         
 7 Physician 1467253393 EMILY        SIERRA          
 8 Physician 1386497477 ENRIQUE      SANTANA VELA    
 9 Physician 1245915321 ERIC         GRAULOU RIVERA  
10 Physician 1134049760 ERICHA MARLA GEVERA          
# ℹ 37 more rows
```

##### 🏥 Medicare Hospitals

``` r
hospital(city = "Valdosta", state = "GA")
✔ hospital returned 3 results
# A tibble: 3 × 16
  org_name     org_dba ccn      npi pac   enid  multi inc_date   org_type status
* <chr>        <chr>   <chr>  <int> <chr> <chr> <int> <date>     <chr>    <chr> 
1 GREENLEAF C… GREENL… 1140… 1.54e9 7416… O201…     0 2012-07-13 LLC      For-P…
2 SOUTH GEORG… SGMC H… 1101… 1.14e9 1052… O202…     0 2021-11-09 Corp     Non-P…
3 SOUTH GEORG… <NA>    11T1… 1.60e9 1052… O202…     0 2021-11-09 Corp     Non-P…
# ℹ 6 more variables: loc_type <chr>, address <chr>, city <chr>, state <chr>,
#   zip <chr>, sub_group <chr>
```

##### 🧪 CLIA Laboratories

``` r
clia(name = starts("SGMC"), state = "GA")
✔ clia returned 32 results
# A tibble: 32 × 20
   name        ccn   clia  status  labs sites certificate address fac_type owner
 * <chr>       <chr> <chr> <chr>  <int> <int> <chr>       <chr>   <chr>    <chr>
 1 SGMC HEALTH 11D0… <NA>  Active     1     0 Accreditat… 2501 N… Hospital [GOV…
 2 SGMC- SMIT… 11D0… <NA>  Active     1     0 Accreditat… 4280 N… ASC      [GOV…
 3 SGMC WOMEN… 11D0… <NA>  Active     0     0 Waiver      3312 N… Physici… Other
 4 SGMC VALDO… 11D0… <NA>  Active     2     0 Waiver      3207 C… Physici… Other
 5 SGMC- LANI… 11D0… <NA>  Active     3     2 Accreditat… 116 WE… Hospital Priv…
 6 SGMC-BERRI… 11D0… <NA>  Active     8     0 Accreditat… 1221 E… Hospital Other
 7 SGMC PRIMA… 11D0… <NA>  Active     0     0 Waiver      410 CO… Physici… Other
 8 SGMC HEALT… 11D0… <NA>  Active     0     0 Waiver      138 WE… SNF      Other
 9 SGMC PRIMA… 11D0… <NA>  Active     1     0 Waiver      4370 K… Physici… Other
10 SGMC FAMIL… 11D0… <NA>  Active     0     0 Waiver      1225 E… SNF      Other
# ℹ 22 more rows
# ℹ 10 more variables: action <chr>, cert_date <date>, eff_date <date>,
#   term_date <date>, elig <int>, city <chr>, state <chr>, zip <chr>,
#   multi <chr>, accredit <chr>
```

##### 🔎 Hospital Transparency Enforcement

``` r
transparency(action = "cap", state = "GA")
✔ transparency returned 60 results
# A tibble: 60 × 7
    case name                             address city  state action action_date
   <int> <chr>                            <chr>   <chr> <chr> <chr>  <date>     
 1  2672 Jefferson Hospital               1067 P… Loui… GA    CAP R… 2025-03-26 
 2  6440 Willingway Hospital              311 Jo… Stat… GA    CAP R… 2025-12-19 
 3    42 Northside Hospital Atlanta       1000 J… Atla… GA    CAP R… 2021-09-30 
 4    68 Wellstar Kennestone Regional Me… 677 Ch… Mari… GA    CAP R… 2021-09-30 
 5    75 Northeast Georgia Medical Cente… 743 Sp… Gain… GA    CAP R… 2021-09-30 
 6    99 Northside Hospital - Cherokee    450 No… Cant… GA    CAP R… 2021-10-27 
 7   116 Wellstar Atlanta Medical Center  303 Pa… Atla… GA    CAP R… 2021-09-30 
 8   117 Tift Regional Medical Center     901 18… Tift… GA    CAP R… 2023-06-06 
 9   136 Piedmont Columbus Regional Midt… 710 Ce… Colu… GA    CAP R… 2021-09-30 
10   256 Coffee Regional Medical Center   1101 O… Doug… GA    CAP R… 2023-06-15 
# ℹ 50 more rows
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
