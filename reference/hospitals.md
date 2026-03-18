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
  org_name = NULL,
  dba_name = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  multi = NULL,
  org_type = NULL,
  provider_type = NULL,
  location_type = NULL,
  subgroup = subgroups(),
  count = FALSE
)

subgroups(
  acute = NULL,
  drug = NULL,
  child = NULL,
  general = NULL,
  long = NULL,
  short = NULL,
  psych = NULL,
  rehab = NULL,
  swing = NULL,
  psych_unit = NULL,
  rehab_unit = NULL,
  specialty = NULL,
  other = NULL
)
```

## Source

- [API: Hospital
  Enrollments](https://data.cms.gov/provider-characteristics/hospitals-and-other-facilities/hospital-enrollments)

## Arguments

- npi:

  `<int>` National Provider Identifier

- ccn:

  `<int>` CMS Certification Number

- pac:

  `<chr>` PECOS Associate Control ID

- enid, enid_state:

  `<chr>` Medicare Enrollment ID, Enrollment state

- org_name:

  `<chr>` Legal business name

- dba_name:

  `<chr>` Doing-business-as name

- city, state, zip:

  `<chr>` Location city, state, zip

- multi:

  `<lgl>` Does hospital have more than one NPI?

- org_type:

  `<enum>` `P`: Proprietary, `N`: Non-Profit, `D`: Unknown

- provider_type:

  `<enum>` Provider type; `hospital`: Part A Hospital, `reh`: Rural
  Emergency Hospital, or `cah`: Critical Access Hospital

- location_type:

  `<enum>` Location type; `primary`, `psych`, `rehab`, `extension`,
  `other`

- subgroup:

  `<subgroups>` Hospital’s subgroup/unit. See `subgroups()`.

- count:

  `<lgl>` Return the total row count

- acute:

  `<lgl>` Acute Care

- drug:

  `<lgl>` Alcohol/Drug Treatment

- child:

  `<lgl>` Children's Hospital

- general:

  `<lgl>` General Hospital

- long:

  `<lgl>` Long-Term Care

- short:

  `<lgl>` Short-Term Care

- psych:

  `<lgl>` Psychiatric

- rehab:

  `<lgl>` Rehabilitation

- swing:

  `<lgl>` Swing-Bed Approved

- psych_unit:

  `<lgl>` Psychiatric Unit

- rehab_unit:

  `<lgl>` Rehabilitation Unit

- specialty:

  `<lgl>` Specialty Hospital

- other:

  `<lgl>` Unlisted on CMS form

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)

A `<subgroups>` object

## Examples

``` r
hospitals(count = TRUE)
#> ✔ `hospitals` returned 9,187 results.
hospitals(state = "GA", provider_type = "reh")
#> ✔ `hospitals` returned 1 result.
#> # A tibble: 1 × 39
#>   org_name      org_dba enid  enid_state spec  specialty npi   multi ccn   ccn_2
#>   <chr>         <chr>   <chr> <chr>      <chr> <chr>     <chr> <chr> <chr> <chr>
#> 1 IRWIN COUNTY… PROGRE… O202… GA         00-24 PART A P… 1720… N     1107… 1101…
#> # ℹ 29 more variables: pac <chr>, inc_date <chr>, inc_state <chr>, str <chr>,
#> #   str_otxt <chr>, design <chr>, add_1 <chr>, add_2 <chr>, city <chr>,
#> #   state <chr>, zip <chr>, loc <chr>, loc_otxt <chr>, reh_ind <chr>,
#> #   reh_date <chr>, sub_general <chr>, sub_acute <chr>, sub_drug <chr>,
#> #   sub_child <chr>, sub_long <chr>, sub_psych <chr>, sub_rehab <chr>,
#> #   sub_short <chr>, sub_swing <chr>, sub_psych_unit <chr>,
#> #   sub_rehab_unit <chr>, sub_specialty <chr>, sub_other <chr>, …
hospitals(
  city = "Atlanta",
  state = "GA",
  subgroup = subgroups(
    acute = FALSE,
    psych = TRUE
  )
)
#> ✔ `hospitals` returned 2 results.
#> # A tibble: 2 × 39
#>   org_name      org_dba enid  enid_state spec  specialty npi   multi ccn   ccn_2
#>   <chr>         <chr>   <chr> <chr>      <chr> <chr>     <chr> <chr> <chr> <chr>
#> 1 UHS OF ANCHO… ANCHOR… O201… GA         00-09 PART A P… 1023… Y     1140… NA   
#> 2 UHS OF PEACH… PEACHF… O201… GA         00-09 PART A P… 1093… N     1140… NA   
#> # ℹ 29 more variables: pac <chr>, inc_date <chr>, inc_state <chr>, str <chr>,
#> #   str_otxt <chr>, design <chr>, add_1 <chr>, add_2 <chr>, city <chr>,
#> #   state <chr>, zip <chr>, loc <chr>, loc_otxt <chr>, reh_ind <chr>,
#> #   reh_date <chr>, sub_general <chr>, sub_acute <chr>, sub_drug <chr>,
#> #   sub_child <chr>, sub_long <chr>, sub_psych <chr>, sub_rehab <chr>,
#> #   sub_short <chr>, sub_swing <chr>, sub_psych_unit <chr>,
#> #   sub_rehab_unit <chr>, sub_specialty <chr>, sub_other <chr>, …
subgroups(acute = TRUE, rehab = TRUE)
#> <subgroups>
#> • SUBGROUP %2D ACUTE CARE     : Y
#> • SUBGROUP %2D REHABILITATION : Y
```
