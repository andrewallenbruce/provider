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
  subgroup = subgroups(),
  count = FALSE
)
```

## Source

- [Hospital Enrollments
  API](https://data.cms.gov/provider-characteristics/hospitals-and-other-facilities/hospital-enrollments)

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

  `<chr>` `"hospital"`, `"reh"`, `"cah"`

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

- subgroup:

  `<subgroups>` Hospital’s subgroup/unit. See
  [`subgroups()`](https://andrewallenbruce.github.io/provider/reference/subgroups.md).

- count:

  `<lgl>` Return the dataset's total row count

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)

## Examples

``` r
hospitals(count = TRUE)
#> ✔ `hospitals()` returned 9,187 results.
hospitals(state = "GA", specialty = "reh")
#> ✔ `hospitals()` returned 1 result.
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
#> ✔ `hospitals()` returned 2 results.
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
```
