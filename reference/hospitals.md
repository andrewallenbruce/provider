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
  subgroup = subgroups()
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

  `<subgroups>` Hospital’s subgroup/unit:

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
#>    org_name    dba_name enid  enid_state spec  specialty npi   multi ccn   ccn_2
#>    <chr>       <chr>    <chr> <chr>      <chr> <chr>     <chr> <chr> <chr> <chr>
#>  1 SOUTHERN T… HIGHPOI… O200… TN         00-09 PART A P… 1467… N     4400… NA   
#>  2 CENTRAL MA… NA       O200… ME         00-09 PART A P… 1689… N     2000… NA   
#>  3 ADCARE HOS… ADCARE … O200… MA         00-09 PART A P… 1134… N     2200… NA   
#>  4 CAPE COD H… CAPE CO… O200… MA         00-09 PART A P… 1114… N     2200… NA   
#>  5 CARRINGTON… CHI ST … O200… ND         00-85 PART A P… 1205… N     3513… NA   
#>  6 SELECT SPE… SELECT … O200… GA         00-09 PART A P… 1588… N     1120… NA   
#>  7 THE FINLEY… FINLEY … O200… IA         00-09 PART A P… 1942… N     1601… NA   
#>  8 ST CHARLES… NA       O200… NY         00-09 PART A P… 1164… N     3302… NA   
#>  9 WASHINGTON… NA       O200… AR         00-09 PART A P… 1083… N     0400… NA   
#> 10 ARIZONA SP… NA       O200… AZ         00-09 PART A P… 1396… N     0301… NA   
#> # ℹ 29 more variables: pac <chr>, inc_date <chr>, inc_state <chr>,
#> #   org_type <chr>, org_text <chr>, designation <chr>, add_1 <chr>,
#> #   add_2 <chr>, city <chr>, state <chr>, zip <chr>, location_type <chr>,
#> #   location_text <chr>, reh_ind <chr>, reh_date <chr>, sub_general <chr>,
#> #   sub_acute <chr>, sub_drug <chr>, sub_child <chr>, sub_long <chr>,
#> #   sub_psych <chr>, sub_rehab <chr>, sub_short <chr>, sub_swing <chr>,
#> #   sub_psych_unit <chr>, sub_rehab_unit <chr>, sub_specialty <chr>, …
hospitals(pac = 6103733050)
#> ✔ Query returned 2 results.
#> # A tibble: 2 × 39
#>   org_name     dba_name enid  enid_state spec  specialty npi   multi ccn   ccn_2
#>   <chr>        <chr>    <chr> <chr>      <chr> <chr>     <chr> <chr> <chr> <chr>
#> 1 ST CHARLES … NA       O200… NY         00-09 PART A P… 1164… N     3302… NA   
#> 2 ST CHARLES … NA       O200… NY         00-09 PART A P… 1225… N     33T2… NA   
#> # ℹ 29 more variables: pac <chr>, inc_date <chr>, inc_state <chr>,
#> #   org_type <chr>, org_text <chr>, designation <chr>, add_1 <chr>,
#> #   add_2 <chr>, city <chr>, state <chr>, zip <chr>, location_type <chr>,
#> #   location_text <chr>, reh_ind <chr>, reh_date <chr>, sub_general <chr>,
#> #   sub_acute <chr>, sub_drug <chr>, sub_child <chr>, sub_long <chr>,
#> #   sub_psych <chr>, sub_rehab <chr>, sub_short <chr>, sub_swing <chr>,
#> #   sub_psych_unit <chr>, sub_rehab_unit <chr>, sub_specialty <chr>, …
hospitals(state = "GA", reh = TRUE)
#> ✔ Query returned 1 result.
#> # A tibble: 1 × 39
#>   org_name     dba_name enid  enid_state spec  specialty npi   multi ccn   ccn_2
#>   <chr>        <chr>    <chr> <chr>      <chr> <chr>     <chr> <chr> <chr> <chr>
#> 1 IRWIN COUNT… PROGRES… O202… GA         00-24 PART A P… 1720… N     1107… 1101…
#> # ℹ 29 more variables: pac <chr>, inc_date <chr>, inc_state <chr>,
#> #   org_type <chr>, org_text <chr>, designation <chr>, add_1 <chr>,
#> #   add_2 <chr>, city <chr>, state <chr>, zip <chr>, location_type <chr>,
#> #   location_text <chr>, reh_ind <chr>, reh_date <chr>, sub_general <chr>,
#> #   sub_acute <chr>, sub_drug <chr>, sub_child <chr>, sub_long <chr>,
#> #   sub_psych <chr>, sub_rehab <chr>, sub_short <chr>, sub_swing <chr>,
#> #   sub_psych_unit <chr>, sub_rehab_unit <chr>, sub_specialty <chr>, …
hospitals(city = "Atlanta", state = "GA", subgroup = subgroups(acute = FALSE))
#> ✔ Query returned 12 results.
#> # A tibble: 12 × 39
#>    org_name    dba_name enid  enid_state spec  specialty npi   multi ccn   ccn_2
#>    <chr>       <chr>    <chr> <chr>      <chr> <chr>     <chr> <chr> <chr> <chr>
#>  1 SCOTTISH R… CHILDRE… O200… GA         00-09 PART A P… 1922… N     1133… NA   
#>  2 PIEDMONT H… NA       O200… GA         00-09 PART A P… 1962… N     1100… NA   
#>  3 EMORY UNIV… EMORY U… O200… GA         00-09 PART A P… 1437… Y     11S0… NA   
#>  4 EMORY UNIV… EMORY U… O200… GA         00-09 PART A P… 1356… Y     11T0… NA   
#>  5 ARTHUR M. … NA       O200… GA         00-09 PART A P… 1689… N     1133… NA   
#>  6 GRADY MEMO… GRADY H… O200… GA         00-09 PART A P… 1629… N     11S0… NA   
#>  7 UHS OF ANC… ANCHOR … O201… GA         00-09 PART A P… 1023… Y     1140… NA   
#>  8 UHS OF PEA… PEACHFO… O201… GA         00-09 PART A P… 1093… N     1140… NA   
#>  9 SHEPHERD C… NA       O201… GA         00-09 PART A P… 1043… N     1120… NA   
#> 10 ES REHABIL… EMORY R… O201… GA         00-09 PART A P… 1548… N     1130… NA   
#> 11 SELECT SPE… SELECT … O201… GA         00-09 PART A P… 1235… N     1120… NA   
#> 12 REHABILITA… REHABIL… O202… GA         00-09 PART A P… 1538… N     1130… NA   
#> # ℹ 29 more variables: pac <chr>, inc_date <chr>, inc_state <chr>,
#> #   org_type <chr>, org_text <chr>, designation <chr>, add_1 <chr>,
#> #   add_2 <chr>, city <chr>, state <chr>, zip <chr>, location_type <chr>,
#> #   location_text <chr>, reh_ind <chr>, reh_date <chr>, sub_general <chr>,
#> #   sub_acute <chr>, sub_drug <chr>, sub_child <chr>, sub_long <chr>,
#> #   sub_psych <chr>, sub_rehab <chr>, sub_short <chr>, sub_swing <chr>,
#> #   sub_psych_unit <chr>, sub_rehab_unit <chr>, sub_specialty <chr>, …
hospitals(state = "GA", subgroup = subgroups(psych = TRUE))
#> ✔ Query returned 15 results.
#> # A tibble: 15 × 39
#>    org_name    dba_name enid  enid_state spec  specialty npi   multi ccn   ccn_2
#>    <chr>       <chr>    <chr> <chr>      <chr> <chr>     <chr> <chr> <chr> <chr>
#>  1 UHS OF SAV… COASTAL… O200… GA         00-09 PART A P… 1679… Y     1140… NA   
#>  2 HHC ST. SI… ST. SIM… O200… GA         00-09 PART A P… 1972… N     1140… NA   
#>  3 UHS OF SUM… SUMMITR… O200… GA         00-09 PART A P… 1407… N     1140… NA   
#>  4 RIVERWOODS… LAKEVIE… O200… GA         00-09 PART A P… 1770… Y     1140… NA   
#>  5 DEPARTMENT… WEST CE… O200… GA         00-09 PART A P… 1912… N     1140… NA   
#>  6 DEPARTMENT… GEORGIA… O200… GA         00-09 PART A P… 1942… N     1140… NA   
#>  7 UHS OF ANC… ANCHOR … O201… GA         00-09 PART A P… 1023… Y     1140… NA   
#>  8 DEPARTMENT… GEORGIA… O201… GA         00-09 PART A P… 1124… N     1140… NA   
#>  9 UHS OF PEA… PEACHFO… O201… GA         00-09 PART A P… 1093… N     1140… NA   
#> 10 GREENLEAF … GREENLE… O201… GA         00-09 PART A P… 1538… N     1140… NA   
#> 11 ST FRANCIS… ST. FRA… O201… GA         00-09 PART A P… 1033… N     1101… NA   
#> 12 VEST MONRO… RIDGEVI… O201… GA         00-09 PART A P… 1073… N     1140… NA   
#> 13 RV BEHAVIO… RIDGEVI… O201… GA         00-09 PART A P… 1427… N     1140… NA   
#> 14 DONALSONVI… NA       O201… GA         00-09 PART A P… 1932… N     11S1… NA   
#> 15 HOSPITAL A… JEFFERS… O202… GA         00-09 PART A P… 1417… N     11S1… NA   
#> # ℹ 29 more variables: pac <chr>, inc_date <chr>, inc_state <chr>,
#> #   org_type <chr>, org_text <chr>, designation <chr>, add_1 <chr>,
#> #   add_2 <chr>, city <chr>, state <chr>, zip <chr>, location_type <chr>,
#> #   location_text <chr>, reh_ind <chr>, reh_date <chr>, sub_general <chr>,
#> #   sub_acute <chr>, sub_drug <chr>, sub_child <chr>, sub_long <chr>,
#> #   sub_psych <chr>, sub_rehab <chr>, sub_short <chr>, sub_swing <chr>,
#> #   sub_psych_unit <chr>, sub_rehab_unit <chr>, sub_specialty <chr>, …
```
