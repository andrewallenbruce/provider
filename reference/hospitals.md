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
  subgroup = subgroups(),
  count = FALSE
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

  `<chr>`

  - `"00-09"`: Hospital

  - `"00-24"`: Rural Emergency Hospital

  - `"00-85"`: Critical Access Hospital

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

  `<chr>` `"Proprietor"`/`"Non-Profit"`

- multi:

  `<lgl>` Hospital has more than one NPI

- reh:

  `<lgl>` Former Hospital/CAH now a Rural Emergency Hospital

- subgroup:

  `<subgroups>` Hospital’s subgroup/unit. See
  [`subgroups()`](https://andrewallenbruce.github.io/provider/reference/subgroups.md).

- count:

  `<lgl>` Return the dataset's total row count

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)

## References

- [Hospital Enrollments
  API](https://data.cms.gov/provider-characteristics/hospitals-and-other-facilities/hospital-enrollments)

## Examples

``` r
hospitals(count = TRUE)
#> ✔ `hospitals()` returned 9,196 results.
hospitals(pac = 6103733050)
#> ✔ `hospitals()` returned 2 results.
#> # A tibble: 2 × 39
#>   org_name      org_dba enid  enid_state spec  specialty npi   multi ccn   ccn_2
#>   <chr>         <chr>   <chr> <chr>      <chr> <chr>     <chr> <chr> <chr> <chr>
#> 1 ST CHARLES H… NA      O200… NY         00-09 PART A P… 1164… N     3302… NA   
#> 2 ST CHARLES H… NA      O200… NY         00-09 PART A P… 1225… N     33T2… NA   
#> # ℹ 29 more variables: pac <chr>, inc_date <chr>, inc_state <chr>,
#> #   struct <chr>, struct_otext <chr>, design <chr>, add_1 <chr>, add_2 <chr>,
#> #   city <chr>, state <chr>, zip <chr>, location <chr>, loc_otext <chr>,
#> #   reh_ind <chr>, reh_date <chr>, sub_general <chr>, sub_acute <chr>,
#> #   sub_drug <chr>, sub_child <chr>, sub_long <chr>, sub_psych <chr>,
#> #   sub_rehab <chr>, sub_short <chr>, sub_swing <chr>, sub_psych_unit <chr>,
#> #   sub_rehab_unit <chr>, sub_specialty <chr>, sub_other <chr>, …
hospitals(state = "GA", reh = TRUE)
#> ✔ `hospitals()` returned 1 result.
#> # A tibble: 1 × 39
#>   org_name      org_dba enid  enid_state spec  specialty npi   multi ccn   ccn_2
#>   <chr>         <chr>   <chr> <chr>      <chr> <chr>     <chr> <chr> <chr> <chr>
#> 1 IRWIN COUNTY… PROGRE… O202… GA         00-24 PART A P… 1720… N     1107… 1101…
#> # ℹ 29 more variables: pac <chr>, inc_date <chr>, inc_state <chr>,
#> #   struct <chr>, struct_otext <chr>, design <chr>, add_1 <chr>, add_2 <chr>,
#> #   city <chr>, state <chr>, zip <chr>, location <chr>, loc_otext <chr>,
#> #   reh_ind <chr>, reh_date <chr>, sub_general <chr>, sub_acute <chr>,
#> #   sub_drug <chr>, sub_child <chr>, sub_long <chr>, sub_psych <chr>,
#> #   sub_rehab <chr>, sub_short <chr>, sub_swing <chr>, sub_psych_unit <chr>,
#> #   sub_rehab_unit <chr>, sub_specialty <chr>, sub_other <chr>, …
hospitals(city = "Atlanta", state = "GA", subgroup = subgroups(acute = FALSE))
#> ✔ `hospitals()` returned 12 results.
#> # A tibble: 12 × 39
#>    org_name     org_dba enid  enid_state spec  specialty npi   multi ccn   ccn_2
#>    <chr>        <chr>   <chr> <chr>      <chr> <chr>     <chr> <chr> <chr> <chr>
#>  1 SCOTTISH RI… CHILDR… O200… GA         00-09 PART A P… 1922… N     1133… NA   
#>  2 PIEDMONT HO… NA      O200… GA         00-09 PART A P… 1962… N     1100… NA   
#>  3 EMORY UNIVE… EMORY … O200… GA         00-09 PART A P… 1437… Y     11S0… NA   
#>  4 EMORY UNIVE… EMORY … O200… GA         00-09 PART A P… 1356… Y     11T0… NA   
#>  5 ARTHUR M. B… NA      O200… GA         00-09 PART A P… 1689… N     1133… NA   
#>  6 GRADY MEMOR… GRADY … O200… GA         00-09 PART A P… 1629… N     11S0… NA   
#>  7 UHS OF ANCH… ANCHOR… O201… GA         00-09 PART A P… 1023… Y     1140… NA   
#>  8 UHS OF PEAC… PEACHF… O201… GA         00-09 PART A P… 1093… N     1140… NA   
#>  9 SHEPHERD CE… NA      O201… GA         00-09 PART A P… 1043… N     1120… NA   
#> 10 ES REHABILI… EMORY … O201… GA         00-09 PART A P… 1548… N     1130… NA   
#> 11 SELECT SPEC… SELECT… O201… GA         00-09 PART A P… 1235… N     1120… NA   
#> 12 REHABILITAT… REHABI… O202… GA         00-09 PART A P… 1538… N     1130… NA   
#> # ℹ 29 more variables: pac <chr>, inc_date <chr>, inc_state <chr>,
#> #   struct <chr>, struct_otext <chr>, design <chr>, add_1 <chr>, add_2 <chr>,
#> #   city <chr>, state <chr>, zip <chr>, location <chr>, loc_otext <chr>,
#> #   reh_ind <chr>, reh_date <chr>, sub_general <chr>, sub_acute <chr>,
#> #   sub_drug <chr>, sub_child <chr>, sub_long <chr>, sub_psych <chr>,
#> #   sub_rehab <chr>, sub_short <chr>, sub_swing <chr>, sub_psych_unit <chr>,
#> #   sub_rehab_unit <chr>, sub_specialty <chr>, sub_other <chr>, …
hospitals(state = "GA", subgroup = subgroups(psych = TRUE))
#> ✔ `hospitals()` returned 15 results.
#> # A tibble: 15 × 39
#>    org_name     org_dba enid  enid_state spec  specialty npi   multi ccn   ccn_2
#>    <chr>        <chr>   <chr> <chr>      <chr> <chr>     <chr> <chr> <chr> <chr>
#>  1 UHS OF SAVA… COASTA… O200… GA         00-09 PART A P… 1679… Y     1140… NA   
#>  2 HHC ST. SIM… ST. SI… O200… GA         00-09 PART A P… 1972… N     1140… NA   
#>  3 UHS OF SUMM… SUMMIT… O200… GA         00-09 PART A P… 1407… N     1140… NA   
#>  4 RIVERWOODS … LAKEVI… O200… GA         00-09 PART A P… 1770… Y     1140… NA   
#>  5 DEPARTMENT … WEST C… O200… GA         00-09 PART A P… 1912… N     1140… NA   
#>  6 DEPARTMENT … GEORGI… O200… GA         00-09 PART A P… 1942… N     1140… NA   
#>  7 UHS OF ANCH… ANCHOR… O201… GA         00-09 PART A P… 1023… Y     1140… NA   
#>  8 DEPARTMENT … GEORGI… O201… GA         00-09 PART A P… 1124… N     1140… NA   
#>  9 UHS OF PEAC… PEACHF… O201… GA         00-09 PART A P… 1093… N     1140… NA   
#> 10 GREENLEAF C… GREENL… O201… GA         00-09 PART A P… 1538… N     1140… NA   
#> 11 ST FRANCIS … ST. FR… O201… GA         00-09 PART A P… 1033… N     1101… NA   
#> 12 VEST MONROE… RIDGEV… O201… GA         00-09 PART A P… 1073… N     1140… NA   
#> 13 RV BEHAVIOR… RIDGEV… O201… GA         00-09 PART A P… 1427… N     1140… NA   
#> 14 DONALSONVIL… NA      O201… GA         00-09 PART A P… 1932… N     11S1… NA   
#> 15 HOSPITAL AU… JEFFER… O202… GA         00-09 PART A P… 1417… N     11S1… NA   
#> # ℹ 29 more variables: pac <chr>, inc_date <chr>, inc_state <chr>,
#> #   struct <chr>, struct_otext <chr>, design <chr>, add_1 <chr>, add_2 <chr>,
#> #   city <chr>, state <chr>, zip <chr>, location <chr>, loc_otext <chr>,
#> #   reh_ind <chr>, reh_date <chr>, sub_general <chr>, sub_acute <chr>,
#> #   sub_drug <chr>, sub_child <chr>, sub_long <chr>, sub_psych <chr>,
#> #   sub_rehab <chr>, sub_short <chr>, sub_swing <chr>, sub_psych_unit <chr>,
#> #   sub_rehab_unit <chr>, sub_specialty <chr>, sub_other <chr>, …
```
