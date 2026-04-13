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
  status = NULL,
  org_type = NULL,
  prov_type = NULL,
  loc_type = NULL,
  subgroup = subgroups(),
  count = FALSE,
  set = FALSE
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

- status:

  `<enum>` Organization status

  - `P` = Proprietary

  - `N` = Non-Profit

  - `D` = Unknown

- org_type:

  `<enum>` Organization structure type

  - `corp` = Corporation

  - `other` = Other

  - `llc` = LLC

  - `partner` = Partnership

  - `sole` = Sole Proprietor

- prov_type:

  `<enum>` Provider type;

  - `hosp` = Part A Hospital

  - `reh` = Rural Emergency Hospital

  - `cah` = Critical Access Hospital

- loc_type:

  `<enum>` Practice location type

  - `main` = Main/Primary Hospital Location

  - `psych` = Hospital Psychiatric Unit

  - `rehab` = Hospital Rehabilitation Unit

  - `ext` = Opt Extension Site

  - `other` = Other Hospital Practice Location

- subgroup:

  `<subgroups>` Hospital’s subgroup/unit. See
  [`subgroups()`](https://andrewallenbruce.github.io/provider/reference/subgroups.md).

- count:

  `<lgl>` Return the total row count

- set:

  `<lgl>` Return the entire dataset

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)

## Examples

``` r
hospitals(count = TRUE)
#> ℹ hospitals has 9,187 rows.
hospitals2(count = TRUE)
#> ℹ hospitals2 has 5,426 rows.

hospitals(state = "GA", prov_type = "reh")
#> ✔ hospitals returned 1 result.
#> # A data frame: 1 × 39
#>   org_name      org_dba enid  enid_state spec  specialty npi   multi ccn   ccn_2
#> * <chr>         <chr>   <chr> <chr>      <chr> <chr>     <chr> <chr> <chr> <chr>
#> 1 IRWIN COUNTY… PROGRE… O202… GA         00-24 PART A P… 1720… N     1107… 1101…
#> # ℹ 29 more variables: pac <chr>, inc_date <chr>, inc_state <chr>,
#> #   org_type <chr>, org_otxt <chr>, org_status <chr>, add_1 <chr>, add_2 <chr>,
#> #   city <chr>, state <chr>, zip <chr>, loc_type <chr>, loc_otxt <chr>,
#> #   reh_ind <chr>, reh_date <chr>, sub_general <chr>, sub_acute <chr>,
#> #   sub_drug <chr>, sub_child <chr>, sub_long <chr>, sub_psych <chr>,
#> #   sub_rehab <chr>, sub_short <chr>, sub_swing <chr>, sub_psych_unit <chr>,
#> #   sub_rehab_unit <chr>, sub_specialty <chr>, sub_other <chr>, …

x <- hospitals(
  city = "Atlanta",
  state = "GA",
  subgroup = subgroups(
    acute = FALSE,
    psych = TRUE))
#> ✔ hospitals returned 2 results.
x
#> # A data frame: 2 × 39
#>   org_name      org_dba enid  enid_state spec  specialty npi   multi ccn   ccn_2
#> * <chr>         <chr>   <chr> <chr>      <chr> <chr>     <chr> <chr> <chr> <chr>
#> 1 UHS OF ANCHO… ANCHOR… O201… GA         00-09 PART A P… 1023… Y     1140… NA   
#> 2 UHS OF PEACH… PEACHF… O201… GA         00-09 PART A P… 1093… N     1140… NA   
#> # ℹ 29 more variables: pac <chr>, inc_date <chr>, inc_state <chr>,
#> #   org_type <chr>, org_otxt <chr>, org_status <chr>, add_1 <chr>, add_2 <chr>,
#> #   city <chr>, state <chr>, zip <chr>, loc_type <chr>, loc_otxt <chr>,
#> #   reh_ind <chr>, reh_date <chr>, sub_general <chr>, sub_acute <chr>,
#> #   sub_drug <chr>, sub_child <chr>, sub_long <chr>, sub_psych <chr>,
#> #   sub_rehab <chr>, sub_short <chr>, sub_swing <chr>, sub_psych_unit <chr>,
#> #   sub_rehab_unit <chr>, sub_specialty <chr>, sub_other <chr>, …
hospitals2(ccn = x$ccn)
#> ✔ hospitals2 returned 2 results.
#> # A data frame: 2 × 11
#>   ccn    org_name  address city  state zip   county phone type  ownership rating
#> * <chr>  <chr>     <chr>   <chr> <chr> <chr> <chr>  <chr> <chr> <chr>     <chr> 
#> 1 114010 PEACHFOR… 2151 P… ATLA… GA    30338 DE KA… (770… Psyc… Propriet… Not A…
#> 2 114032 SO CRESC… 5454 Y… COLL… GA    30349 FULTON (770… Psyc… Governme… Not A…

x <- hospitals2()
#> ! hospitals2 ✖ No Query
#> ℹ Returning first 10 rows...
x
#> # A data frame: 10 × 11
#>    ccn    org_name address city  state zip   county phone type  ownership rating
#>  * <chr>  <chr>    <chr>   <chr> <chr> <chr> <chr>  <chr> <chr> <chr>     <chr> 
#>  1 010001 SOUTHEA… 1108 R… DOTH… AL    36301 HOUST… (334… Acut… Governme… 4     
#>  2 010005 MARSHAL… 2505 U… BOAZ  AL    35957 MARSH… (256… Acut… Governme… 3     
#>  3 010006 NORTH A… 1701 V… FLOR… AL    35630 LAUDE… (256… Acut… Propriet… 2     
#>  4 010007 MIZELL … 702 N … OPP   AL    36467 COVIN… (334… Acut… Voluntar… 1     
#>  5 010008 CRENSHA… 101 HO… LUVE… AL    36049 CRENS… (334… Acut… Propriet… Not A…
#>  6 010011 ST. VIN… 50 MED… BIRM… AL    35235 JEFFE… (205… Acut… Voluntar… 2     
#>  7 010012 DEKALB … 200 ME… FORT… AL    35968 DE KA… (256… Acut… Propriet… 3     
#>  8 010016 SHELBY … 1000 F… ALAB… AL    35007 SHELBY (205… Acut… Voluntar… 2     
#>  9 010018 CALLAHA… 1720 U… BIRM… AL    35233 JEFFE… (205… Acut… Voluntar… Not A…
#> 10 010019 HELEN K… 1300 S… SHEF… AL    35660 COLBE… (256… Acut… Governme… 2     
hospitals(ccn = x$ccn)
#> ✔ hospitals returned 8 results.
#> # A data frame: 8 × 39
#>   org_name      org_dba enid  enid_state spec  specialty npi   multi ccn   ccn_2
#> * <chr>         <chr>   <chr> <chr>      <chr> <chr>     <chr> <chr> <chr> <chr>
#> 1 HOUSTON COUN… SOUTHE… O200… AL         00-09 PART A P… 1164… N     0100… NA   
#> 2 HH HEALTH SY… MARSHA… O201… AL         00-09 PART A P… 1407… N     0100… NA   
#> 3 RCHP - FLORE… NORTH … O201… AL         00-09 PART A P… 1477… N     0100… NA   
#> 4 MIZELL MEMOR… NA      O200… AL         00-09 PART A P… 1013… N     0100… NA   
#> 5 ST. VINCENT'… ST. VI… O200… AL         00-09 PART A P… 1841… N     0100… NA   
#> 6 HH HEALTH SY… DEKALB… O202… AL         00-09 PART A P… 1770… N     0100… NA   
#> 7 BBH SBMC, LLC BAPTIS… O201… AL         00-09 PART A P… 1811… N     0100… NA   
#> 8 HH HEALTH SY… HELEN … O201… AL         00-09 PART A P… 1508… N     0100… NA   
#> # ℹ 29 more variables: pac <chr>, inc_date <chr>, inc_state <chr>,
#> #   org_type <chr>, org_otxt <chr>, org_status <chr>, add_1 <chr>, add_2 <chr>,
#> #   city <chr>, state <chr>, zip <chr>, loc_type <chr>, loc_otxt <chr>,
#> #   reh_ind <chr>, reh_date <chr>, sub_general <chr>, sub_acute <chr>,
#> #   sub_drug <chr>, sub_child <chr>, sub_long <chr>, sub_psych <chr>,
#> #   sub_rehab <chr>, sub_short <chr>, sub_swing <chr>, sub_psych_unit <chr>,
#> #   sub_rehab_unit <chr>, sub_specialty <chr>, sub_other <chr>, …
```
