# Hospitals Enrolled in Medicare

Hospitals currently enrolled in Medicare. Data includes the hospital's
sub-group types, legal business name, doing-business-as name,
organization type and address.

## Usage

``` r
hospitals(
  npi = NULL,
  ccn = NULL,
  pac = NULL,
  enid = NULL,
  enid_state = NULL,
  specialty = NULL,
  org_name = NULL,
  dba_name = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  designation = NULL,
  multi = NULL,
  reh = NULL,
  subgroup = list(acute = NULL, drug = NULL, child = NULL, general = NULL, long = NULL,
    short = NULL, psych = NULL, rehab = NULL, swing = NULL, psych_unit = NULL, rehab_unit
    = NULL, specialty = NULL, other = NULL)
)
```

## Arguments

- npi:

  `<int>` National Provider Identifier

- ccn:

  `<int>` CMS Certification Number

- pac:

  `<chr>` PECOS Associate Control ID

- enid:

  `<chr>` Medicare Enrollment ID

- enid_state:

  `<chr>` Enrollment State

- specialty:

  `<chr>` Part A Provider Specialty:

  - `"00-09"`: Hospital

  - `"00-24"`: REH (Rural Emergency Hospital)

  - `"00-85"`: CAH (Critical Access Hospital)

- org_name:

  `<chr>` Legal Business Name

- dba_name:

  `<chr>` Doing-Business-As Name

- city:

  `<chr>` Practice Location City

- state:

  `<chr>` Practice Location State

- zip:

  `<chr>` Practice Location Zip Code

- designation:

  `<chr>` IRS designation; `"Proprietor"`/`"Non-Profit"`

- multi:

  `<lgl>` Hospital has more than one NPI

- reh:

  `<lgl>` Former Hospital/CAH now a Rural Emergency Hospital

- subgroup:

  `<list>` Hospital’s subgroup/unit:

  - `acute`: Acute Care

  - `drug`: Alcohol/Drug Treatment

  - `child`: Children's Hospital

  - `general`: General Hospital

  - `long`: Long-Term Care

  - `short`: Short-Term Care

  - `psych`: Psychiatric

  - `rehab`: Rehabilitation

  - `swing`: Swing-Bed Approved

  - `psych_unit`: Psychiatric Unit

  - `rehab_unit`: Rehabilitation Unit

  - `specialty`: Specialty Hospital

  - `other`: Unlisted on CMS form

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)

## References

- [Hospital Enrollments
  API](https://data.cms.gov/provider-characteristics/hospitals-and-other-facilities/hospital-enrollments)

## Examples

``` r
hospitals()
#> ! No Query → Returning first 10 rows.
#> # A tibble: 10 × 39
#>    enid   enid_state spec_cd specialty npi   multi ccn   pac   org_name dba_name
#>    <chr>  <chr>      <chr>   <chr>     <chr> <chr> <chr> <chr> <chr>    <chr>   
#>  1 O2002… TN         00-09   PART A P… 1467… N     4400… 5193… SOUTHER… HIGHPOI…
#>  2 O2002… ME         00-09   PART A P… 1689… N     2000… 2567… CENTRAL… NA      
#>  3 O2002… MA         00-09   PART A P… 1134… N     2200… 8325… ADCARE … ADCARE …
#>  4 O2002… MA         00-09   PART A P… 1114… N     2200… 8921… CAPE CO… CAPE CO…
#>  5 O2002… ND         00-85   PART A P… 1205… N     3513… 0547… CARRING… CHI ST …
#>  6 O2002… GA         00-09   PART A P… 1588… N     1120… 6002… SELECT … SELECT …
#>  7 O2002… IA         00-09   PART A P… 1942… N     1601… 5092… THE FIN… FINLEY …
#>  8 O2002… NY         00-09   PART A P… 1164… N     3302… 6103… ST CHAR… NA      
#>  9 O2002… AR         00-09   PART A P… 1083… N     0400… 7214… WASHING… NA      
#> 10 O2002… AZ         00-09   PART A P… 1396… N     0301… 4486… ARIZONA… NA      
#> # ℹ 29 more variables: inc_date <chr>, inc_state <chr>, org_type <chr>,
#> #   org_text <chr>, designation <chr>, add_1 <chr>, add_2 <chr>, city <chr>,
#> #   state <chr>, zip <chr>, location_type <chr>, location_text <chr>,
#> #   sub_general <chr>, sub_acute <chr>, sub_drug <chr>, sub_child <chr>,
#> #   sub_long <chr>, sub_psych <chr>, sub_rehab <chr>, sub_short <chr>,
#> #   sub_swing <chr>, sub_psych_unit <chr>, sub_rehab_unit <chr>,
#> #   sub_specialty <chr>, sub_other <chr>, sub_otext <chr>, reh_ind <chr>, …
hospitals(pac = 6103733050)
#> ✔ Query returned 2 results.
#> # A tibble: 2 × 39
#>   enid    enid_state spec_cd specialty npi   multi ccn   pac   org_name dba_name
#>   <chr>   <chr>      <chr>   <chr>     <chr> <chr> <chr> <chr> <chr>    <chr>   
#> 1 O20020… NY         00-09   PART A P… 1164… N     3302… 6103… ST CHAR… NA      
#> 2 O20090… NY         00-09   PART A P… 1225… N     33T2… 6103… ST CHAR… NA      
#> # ℹ 29 more variables: inc_date <chr>, inc_state <chr>, org_type <chr>,
#> #   org_text <chr>, designation <chr>, add_1 <chr>, add_2 <chr>, city <chr>,
#> #   state <chr>, zip <chr>, location_type <chr>, location_text <chr>,
#> #   sub_general <chr>, sub_acute <chr>, sub_drug <chr>, sub_child <chr>,
#> #   sub_long <chr>, sub_psych <chr>, sub_rehab <chr>, sub_short <chr>,
#> #   sub_swing <chr>, sub_psych_unit <chr>, sub_rehab_unit <chr>,
#> #   sub_specialty <chr>, sub_other <chr>, sub_otext <chr>, reh_ind <chr>, …
hospitals(state = "GA", reh = TRUE)
#> ✔ Query returned 1 result.
#> # A tibble: 1 × 39
#>   enid    enid_state spec_cd specialty npi   multi ccn   pac   org_name dba_name
#>   <chr>   <chr>      <chr>   <chr>     <chr> <chr> <chr> <chr> <chr>    <chr>   
#> 1 O20230… GA         00-24   PART A P… 1720… N     1107… 7618… IRWIN C… PROGRES…
#> # ℹ 29 more variables: inc_date <chr>, inc_state <chr>, org_type <chr>,
#> #   org_text <chr>, designation <chr>, add_1 <chr>, add_2 <chr>, city <chr>,
#> #   state <chr>, zip <chr>, location_type <chr>, location_text <chr>,
#> #   sub_general <chr>, sub_acute <chr>, sub_drug <chr>, sub_child <chr>,
#> #   sub_long <chr>, sub_psych <chr>, sub_rehab <chr>, sub_short <chr>,
#> #   sub_swing <chr>, sub_psych_unit <chr>, sub_rehab_unit <chr>,
#> #   sub_specialty <chr>, sub_other <chr>, sub_otext <chr>, reh_ind <chr>, …
hospitals(city = "Atlanta", state = "GA", subgroup = list(acute = FALSE))
#> ✔ Query returned 12 results.
#> # A tibble: 12 × 39
#>    enid   enid_state spec_cd specialty npi   multi ccn   pac   org_name dba_name
#>    <chr>  <chr>      <chr>   <chr>     <chr> <chr> <chr> <chr> <chr>    <chr>   
#>  1 O2004… GA         00-09   PART A P… 1922… N     1133… 4981… SCOTTIS… CHILDRE…
#>  2 O2008… GA         00-09   PART A P… 1962… N     1100… 8628… PIEDMON… NA      
#>  3 O2008… GA         00-09   PART A P… 1437… Y     11S0… 3173… EMORY U… EMORY U…
#>  4 O2008… GA         00-09   PART A P… 1356… Y     11T0… 3173… EMORY U… EMORY U…
#>  5 O2008… GA         00-09   PART A P… 1689… N     1133… 2567… ARTHUR … NA      
#>  6 O2008… GA         00-09   PART A P… 1629… N     11S0… 7517… GRADY M… GRADY H…
#>  7 O2010… GA         00-09   PART A P… 1023… Y     1140… 4486… UHS OF … ANCHOR …
#>  8 O2010… GA         00-09   PART A P… 1093… N     1140… 9234… UHS OF … PEACHFO…
#>  9 O2010… GA         00-09   PART A P… 1043… N     1120… 1052… SHEPHER… NA      
#> 10 O2014… GA         00-09   PART A P… 1548… N     1130… 1254… ES REHA… EMORY R…
#> 11 O2016… GA         00-09   PART A P… 1235… N     1120… 6305… SELECT … SELECT …
#> 12 O2024… GA         00-09   PART A P… 1538… N     1130… 5698… REHABIL… REHABIL…
#> # ℹ 29 more variables: inc_date <chr>, inc_state <chr>, org_type <chr>,
#> #   org_text <chr>, designation <chr>, add_1 <chr>, add_2 <chr>, city <chr>,
#> #   state <chr>, zip <chr>, location_type <chr>, location_text <chr>,
#> #   sub_general <chr>, sub_acute <chr>, sub_drug <chr>, sub_child <chr>,
#> #   sub_long <chr>, sub_psych <chr>, sub_rehab <chr>, sub_short <chr>,
#> #   sub_swing <chr>, sub_psych_unit <chr>, sub_rehab_unit <chr>,
#> #   sub_specialty <chr>, sub_other <chr>, sub_otext <chr>, reh_ind <chr>, …
hospitals(state = "GA", subgroup = list(psych = TRUE))
#> ✔ Query returned 15 results.
#> # A tibble: 15 × 39
#>    enid   enid_state spec_cd specialty npi   multi ccn   pac   org_name dba_name
#>    <chr>  <chr>      <chr>   <chr>     <chr> <chr> <chr> <chr> <chr>    <chr>   
#>  1 O2004… GA         00-09   PART A P… 1679… Y     1140… 0547… UHS OF … COASTAL…
#>  2 O2006… GA         00-09   PART A P… 1972… N     1140… 7911… HHC ST.… ST. SIM…
#>  3 O2008… GA         00-09   PART A P… 1407… N     1140… 5890… UHS OF … SUMMITR…
#>  4 O2008… GA         00-09   PART A P… 1770… Y     1140… 7719… RIVERWO… LAKEVIE…
#>  5 O2008… GA         00-09   PART A P… 1912… N     1140… 2163… DEPARTM… WEST CE…
#>  6 O2008… GA         00-09   PART A P… 1942… N     1140… 2163… DEPARTM… GEORGIA…
#>  7 O2010… GA         00-09   PART A P… 1023… Y     1140… 4486… UHS OF … ANCHOR …
#>  8 O2010… GA         00-09   PART A P… 1124… N     1140… 7416… DEPARTM… GEORGIA…
#>  9 O2010… GA         00-09   PART A P… 1093… N     1140… 9234… UHS OF … PEACHFO…
#> 10 O2012… GA         00-09   PART A P… 1538… N     1140… 7416… GREENLE… GREENLE…
#> 11 O2016… GA         00-09   PART A P… 1033… N     1101… 1456… ST FRAN… ST. FRA…
#> 12 O2017… GA         00-09   PART A P… 1073… N     1140… 1850… VEST MO… RIDGEVI…
#> 13 O2017… GA         00-09   PART A P… 1427… N     1140… 3476… RV BEHA… RIDGEVI…
#> 14 O2017… GA         00-09   PART A P… 1932… N     11S1… 7113… DONALSO… NA      
#> 15 O2020… GA         00-09   PART A P… 1417… N     11S1… 7214… HOSPITA… JEFFERS…
#> # ℹ 29 more variables: inc_date <chr>, inc_state <chr>, org_type <chr>,
#> #   org_text <chr>, designation <chr>, add_1 <chr>, add_2 <chr>, city <chr>,
#> #   state <chr>, zip <chr>, location_type <chr>, location_text <chr>,
#> #   sub_general <chr>, sub_acute <chr>, sub_drug <chr>, sub_child <chr>,
#> #   sub_long <chr>, sub_psych <chr>, sub_rehab <chr>, sub_short <chr>,
#> #   sub_swing <chr>, sub_psych_unit <chr>, sub_rehab_unit <chr>,
#> #   sub_specialty <chr>, sub_other <chr>, sub_otext <chr>, reh_ind <chr>, …
```
