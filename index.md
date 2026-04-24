# **provider**

> **Tidy Healthcare Provider API Interface**

You can install `provider` from [GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("andrewallenbruce/provider")
```

### 🔰 Usage

``` r
library(provider)
```

``` r
# Provider/Facility Affiliations
affiliations(first = starts_with("Ab"), facility_type = "ltch")
✔ affiliations returned 21 results.
# A tibble: 21 × 9
   first  last  middle suffix    npi pac   facility_type facility_ccn parent_ccn
 * <chr>  <chr> <chr>  <chr>   <int> <chr> <chr>         <chr>        <chr>     
 1 ABIGA… MALL… E      <NA>   1.01e9 5597… Long-term ca… 052031       <NA>      
 2 ABHA   GUPTA <NA>   <NA>   1.06e9 2264… Long-term ca… 102022       <NA>      
 3 ABANA  AZAR… <NA>   <NA>   1.06e9 4385… Long-term ca… 112003       <NA>      
 4 ABDUL… KAZMI IBRAH… <NA>   1.16e9 5193… Long-term ca… 232012       <NA>      
 5 ABA    BARD… YVONNE <NA>   1.36e9 5698… Long-term ca… 392050       <NA>      
 6 ABID   IQBAL MD     <NA>   1.36e9 8921… Long-term ca… 452118       <NA>      
 7 ABIGA… THOM… <NA>   <NA>   1.58e9 9032… Long-term ca… 332006       <NA>      
 8 ABUBA… TAUS… <NA>   <NA>   1.59e9 4183… Long-term ca… 282001       <NA>      
 9 ABDUL  SHAI… S      <NA>   1.62e9 5294… Long-term ca… 232034       <NA>      
10 ABRAH… GOLB… <NA>   <NA>   1.64e9 8325… Long-term ca… 052050       <NA>      
# ℹ 11 more rows
```

``` r
# Reassignment of Benefits
reassignments(
  first = starts_with("J"), 
  state = "MI", 
  employers = greater_than(20, equal = TRUE))
✔ reassignments returned 21 results.
# A tibble: 21 × 14
   first   last  state specialty employers    npi pac   enid  org_name employees
 * <chr>   <chr> <chr> <chr>         <int>  <int> <chr> <chr> <chr>        <int>
 1 Jennif… Azel… MI    Nurse Pr…        21 1.12e9 9931… I202… <NA>             3
 2 Jennif… Azel… MI    Nurse Pr…        21 1.12e9 9931… I202… <NA>             3
 3 Jennif… Azel… MI    Nurse Pr…        21 1.12e9 9931… I202… Alma Fa…        10
 4 Jennif… Azel… MI    Nurse Pr…        21 1.12e9 9931… I202… Annu Mo…         9
 5 Jennif… Azel… MI    Nurse Pr…        21 1.12e9 9931… I202… Bay Are…        13
 6 Jennif… Azel… MI    Nurse Pr…        21 1.12e9 9931… I202… Capital…       107
 7 Jennif… Azel… MI    Nurse Pr…        21 1.12e9 9931… I202… Clinton…        30
 8 Jennif… Azel… MI    Nurse Pr…        21 1.12e9 9931… I202… Coordin…         7
 9 Jennif… Azel… MI    Nurse Pr…        21 1.12e9 9931… I202… Docksid…         4
10 Jennif… Azel… MI    Nurse Pr…        21 1.12e9 9931… I202… Franken…         8
# ℹ 11 more rows
# ℹ 4 more variables: org_pac <chr>, org_enid <chr>, org_state <chr>,
#   rec_type <chr>
```

``` r
# Revoked Medicare Providers
revocations(org_name = starts_with("B"), state = "GA")
✔ revocations returned 6 results.
# A tibble: 6 × 12
  org_name          first middle last  enid     npi multi state prov_desc reason
* <chr>             <chr> <chr>  <chr> <chr>  <int> <int> <chr> <chr>     <chr> 
1 BENDER ORTHOPAED… <NA>  <NA>   <NA>  O201… 1.97e9     0 GA    PART B S… 424.5…
2 BRASSTOWN PROFES… <NA>  <NA>   <NA>  O201… 1.73e9     0 GA    DME SUPP… 424.5…
3 BLAIRSVILLE FAMI… <NA>  <NA>   <NA>  O201… 1.32e9     0 GA    PART B S… 424.5…
4 BEAUFILS CONSULT… <NA>  <NA>   <NA>  O201… 1.12e9     0 GA    PART B S… 424.5…
5 BRIDGEWAY POINT … <NA>  <NA>   <NA>  O202… 1.76e9     0 GA    PART B S… 424.5…
6 BENZER PHARMACY … <NA>  <NA>   <NA>  O202… 1.14e9     0 GA    DME SUPP… 424.5…
# ℹ 2 more variables: start_date <date>, end_date <date>
```

``` r
# Clinician Demographics
clinicians(
  org_state = "GA", 
  org_name = starts_with("North"),
  gender = "M",
  specialty = "Nurse Practitioner",
  grad_year = 2023:2025)
✔ clinicians returned 16 results.
# A tibble: 16 × 20
   first      middle last  suffix gender cred  school grad_year specialty    npi
 * <chr>      <chr>  <chr> <chr>  <chr>  <chr> <chr>      <int> <chr>      <int>
 1 RYLEY      CADE   SNELL <NA>   M      <NA>  OTHER       2023 NURSE PR… 1.45e9
 2 DAN        H      BUI   <NA>   M      <NA>  OTHER       2023 NURSE PR… 1.75e9
 3 EMMANUEL   <NA>   GWIB… <NA>   M      <NA>  OTHER       2023 NURSE PR… 1.06e9
 4 ROBERT     BLAKE  JOHN… <NA>   M      <NA>  OTHER       2023 NURSE PR… 1.75e9
 5 GREGORY    NATHAN GART… <NA>   M      <NA>  UNIVE…      2023 NURSE PR… 1.72e9
 6 TAYLOR     JAMES  HARK… <NA>   M      NP    UNIVE…      2023 NURSE PR… 1.03e9
 7 TAYLOR     JAMES  HARK… <NA>   M      NP    UNIVE…      2023 NURSE PR… 1.03e9
 8 TAYLOR     JAMES  HARK… <NA>   M      NP    UNIVE…      2023 NURSE PR… 1.03e9
 9 ALEXANDER  <NA>   GRAH… <NA>   M      <NA>  OTHER       2025 NURSE PR… 1.65e9
10 TAYLOR     JAMES  HARK… <NA>   M      NP    UNIVE…      2023 NURSE PR… 1.03e9
11 CANDLER    DASHER ONEAL <NA>   M      <NA>  OTHER       2025 NURSE PR… 1.63e9
12 ROBERT     BLAKE  JOHN… <NA>   M      <NA>  OTHER       2023 NURSE PR… 1.75e9
13 COLIN      PATRI… ANDE… <NA>   M      NP    OTHER       2024 NURSE PR… 1.53e9
14 ROBERT     BLAKE  JOHN… <NA>   M      <NA>  OTHER       2023 NURSE PR… 1.75e9
15 CHRISTOPH… ALAN   NELMS <NA>   M      <NA>  OTHER       2024 NURSE PR… 1.75e9
16 JOHN       T      MACL… <NA>   M      <NA>  OTHER       2023 NURSE PR… 1.75e9
# ℹ 10 more variables: pac <chr>, enid <chr>, org_name <chr>, org_pac <chr>,
#   org_mem <int>, org_city <chr>, org_state <chr>, org_zip <chr>,
#   org_phone <chr>, org_add <chr>
```

``` r
# Opt-Out Affidavits
opt_out(
  first = starts_with("Bo"),
  specialty = contains("Obstetrics"))
✔ opt_out returned 3 results.
# A tibble: 3 × 12
         npi first  last  specialty start_date end_date   updated    city  state
*      <int> <chr>  <chr> <chr>     <date>     <date>     <date>     <chr> <chr>
1 1831162130 Bobbie Behr… Obstetri… 2015-11-04 2027-11-04 2025-12-15 SOLD… AK   
2 1386694990 Bobby  Tack… Obstetri… 2015-02-23 2027-02-23 2025-03-17 MARI… GA   
3 1871559120 Bonnie Wise  Obstetri… 2015-05-11 2027-05-11 2025-06-15 CHIC… IL   
# ℹ 3 more variables: zip <chr>, order_refer <int>, address <chr>
```

``` r
# Ordering & Referral Eligibility
order_refer(
  first = contains("ABAY"),
  ptb = TRUE,
  dme = TRUE,
  hha = FALSE)
✔ order_refer returned 2 results.
# A tibble: 2 × 8
  first   last             npi   ptb   dme   hha   pmd hospice
* <chr>   <chr>          <int> <int> <int> <int> <int>   <int>
1 ABAYOMI ADEBOWALE 1558649616     1     1     0     0       0
2 ABAYOMI TAIWO     1871126086     1     1     0     0       0
```

``` r
# Pending Enrollments
pending(
  first = starts_with("A"),
  last = ends_with("E"))
✔ pending returned 78 results.
• Physician     : 21
• Non-Physician : 57
# A tibble: 78 × 4
   prov_type first     last              npi
 * <chr>     <chr>     <chr>           <int>
 1 Physician ABIGAIL   LOVE       1912885047
 2 Physician ADESEYE   AWE        1942796479
 3 Physician ADITYA    SATHE      1750021168
 4 Physician AIDEN     O'ROURKE   1164484002
 5 Physician AIYANA    SAFERITE   1609670405
 6 Physician ALBERTO   DELA TORRE 1144390303
 7 Physician ALEX      MOORE      1083318315
 8 Physician ALEXANDRA LEE        1841130457
 9 Physician ALEXANDRA LEE        1861332124
10 Physician ALEXANDRA VOLPE      1356805519
# ℹ 68 more rows
```

``` r
# Medicare Enrollment
providers(
  org_name = contains("ARL"),
  state = "AL")
✔ providers returned 19 results.
# A tibble: 19 × 11
   org_name      first middle last  state prov_type prov_desc    npi multi pac  
 * <chr>         <chr> <chr>  <chr> <chr> <chr>     <chr>      <int> <int> <chr>
 1 ARLINGTON RE… <NA>  <NA>   <NA>  AL    00-18     PART A P… 1.68e9     0 8325…
 2 CHARLES D WO… <NA>  <NA>   <NA>  AL    12-70     PART B S… 1.40e9     0 7315…
 3 MARLA H WOHL… <NA>  <NA>   <NA>  AL    12-70     PART B S… 1.30e9     0 1355…
 4 CHARLES W. N… <NA>  <NA>   <NA>  AL    12-70     PART B S… 1.89e9     0 9537…
 5 CHARLES HEND… <NA>  <NA>   <NA>  AL    12-70     PART B S… 1.35e9     0 2264…
 6 CHARLES T NE… <NA>  <NA>   <NA>  AL    12-70     PART B S… 1.35e9     0 5890…
 7 DR CHARLES J… <NA>  <NA>   <NA>  AL    12-70     PART B S… 1.06e9     0 2860…
 8 GARLOCK ENTE… <NA>  <NA>   <NA>  AL    12-59     PART B S… 1.68e9     0 0749…
 9 CHARLES E WI… <NA>  <NA>   <NA>  AL    12-70     PART B S… 1.17e9     0 9638…
10 SCOTT A. CHA… <NA>  <NA>   <NA>  AL    12-70     PART B S… 1.03e9     0 9133…
11 HARLOW CHIRO… <NA>  <NA>   <NA>  AL    12-70     PART B S… 1.42e9     0 1052…
12 CHARLES T. R… <NA>  <NA>   <NA>  AL    12-70     PART B S… 1.50e9     0 6305…
13 R CHARLES GO… <NA>  <NA>   <NA>  AL    12-70     PART B S… 1.61e9     0 1850…
14 DR CHARLES J… <NA>  <NA>   <NA>  AL    30-41     DME SUPP… 1.06e9     0 2860…
15 CARLE WEST P… <NA>  <NA>   <NA>  AL    12-70     PART B S… 1.47e9     0 8921…
16 EARLY BIRD C… <NA>  <NA>   <NA>  AL    12-70     PART B S… 1.30e9     0 1254…
17 LAC QUI PARL… <NA>  <NA>   <NA>  AL    12-70     PART B S… 1.14e9     0 5799…
18 CHARLES R SP… <NA>  <NA>   <NA>  AL    12-73     PART B S… 1.56e9     0 7618…
19 CHARLES R SP… <NA>  <NA>   <NA>  AL    30-A5     DME SUPP… 1.56e9     0 7618…
# ℹ 1 more variable: enid <chr>
```

``` r
# Medicare Part A Hospitals
hospitals(
  dba_name = starts_with("Pied"),
  state = "GA",
  subgroup = subgroups(
    psych = FALSE,
    psych_unit = TRUE))
✔ hospitals returned 2 results.
# A tibble: 2 × 37
  org_name org_dba enid  enid_state prov_type prov_desc    npi multi ccn   pac  
* <chr>    <chr>   <chr> <chr>      <chr>     <chr>      <int> <int> <chr> <chr>
1 EASTSID… PIEDMO… O200… GA         00-09     PART A P… 1.47e9     0 11S1… 4183…
2 COLISEU… PIEDMO… O201… GA         00-09     PART A P… 1.76e9     0 11S1… 6406…
# ℹ 27 more variables: inc_date <date>, inc_state <chr>, org_type <chr>,
#   org_otxt <chr>, status <chr>, city <chr>, state <chr>, zip <chr>,
#   loc_type <chr>, loc_otxt <chr>, reh_date <date>, reh_ccn <chr>,
#   sub_acute <int>, sub_gen <int>, sub_spec <int>, sub_adu <int>,
#   sub_child <int>, sub_ltc <int>, sub_psy <int>, sub_irf <int>,
#   sub_stc <int>, sub_sba <int>, sub_psu <int>, sub_iru <int>, sub_oth <int>,
#   sub_otxt <int>, address <chr>
```

``` r
# CLIA Laboratories
clia(city = "Valdosta", parent_ccn = not_blank())
✔ clia returned 29 results.
# A tibble: 29 × 82
   fac_name_1   fac_name_2 facility_ccn parent_ccn related_ccn xref  chown chowd
 * <chr>        <chr>      <chr>        <chr>      <chr>       <chr> <chr> <chr>
 1 SGMC HEALTH  <NA>       11D0022233   110122     <NA>        <NA>  0     <NA> 
 2 SGMC- SMITH… <NA>       11D0022241   110037     <NA>        <NA>  0     <NA> 
 3 DANIEL FELD… <NA>       11D0265516   00205114A3 <NA>        <NA>  0     <NA> 
 4 SOUTHWELL A… DBA SOUTH… 11D0265545   00264228A3 <NA>        <NA>  0     <NA> 
 5 PRUITTHEATL… <NA>       11D0265565   115385     <NA>        <NA>  0     <NA> 
 6 SMITH & DEN… <NA>       11D0265567   254623647A <NA>        <NA>  0     <NA> 
 7 GHHS HEALTH… DBA GEORG… 11D0265571   117058     <NA>        <NA>  0     <NA> 
 8 PRUITTHEALT… <NA>       11D0265573   115377     <NA>        <NA>  0     <NA> 
 9 PRUITTHEALT… <NA>       11D0265574   00141479A  <NA>        <NA>  0     <NA> 
10 JOHN B HUNT… <NA>       11D0265576   34BDBBJ    <NA>        <NA>  0     <NA> 
# ℹ 19 more rows
# ℹ 74 more variables: chowd_2 <chr>, poc <chr>, compliant <chr>, add_1 <chr>,
#   add_2 <chr>, phone_1 <chr>, phone_2 <chr>, city <chr>, state <chr>,
#   zip <chr>, reg_cd <chr>, reg_st <chr>, ssa_st <chr>, ssa_cty <chr>,
#   fips_st <chr>, fips_cty <chr>, cbsa_1 <chr>, cbsa_2 <chr>, elig <chr>,
#   term_pgm <chr>, term_clia <chr>, app_type <chr>, cert_type <chr>,
#   fac_type <chr>, owner <chr>, action <chr>, orig_date <chr>, …
```

``` r
# Hospital Transparency Enforcement
transparency(action = "warn", state = "GA")
✔ transparency returned 61 results.
# A tibble: 61 × 7
    case name                             address city  state action action_date
 * <int> <chr>                            <chr>   <chr> <chr> <chr>  <date>     
 1    42 Northside Hospital Atlanta       1000 J… Atla… GA    Warni… 2021-04-19 
 2    68 Wellstar Kennestone Regional Me… 677 Ch… Mari… GA    Warni… 2021-04-19 
 3    75 Northeast Georgia Medical Cente… 743 Sp… Gain… GA    Warni… 2021-04-19 
 4    99 Northside Hospital - Cherokee    450 No… Cant… GA    Warni… 2021-05-18 
 5   116 Wellstar Atlanta Medical Center  303 Pa… Atla… GA    Warni… 2021-04-19 
 6   117 Tift Regional Medical Center     901 Ea… Tift… GA    Warni… 2023-03-01 
 7   136 Piedmont Columbus Regional Midt… 710 Ce… Colu… GA    Warni… 2021-04-19 
 8   163 Emory Johns Creek Hospital       6325 H… John… GA    Warni… 2021-06-23 
 9   248 Ridgeview Institute Smyrna       3995 S… Smyr… GA    Warni… 2024-02-02 
10   265 Archbold Memorial                915 Go… Thom… GA    Warni… 2022-12-22 
# ℹ 51 more rows
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
