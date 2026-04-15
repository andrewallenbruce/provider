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

  - `part` = Partnership

  - `sole` = Sole Proprietor

- prov_type:

  `<enum>` Provider type;

  - `hospital` = Part A Hospital

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

hospitals(prov_type = "reh")
#> ✔ hospitals returned 44 results.
#> # A tibble: 44 × 39
#>    org_name org_dba enid  enid_state prov_type prov_desc npi   multi ccn   ccn2 
#>  * <chr>    <chr>   <chr> <chr>      <chr>     <chr>     <chr> <chr> <chr> <chr>
#>  1 GUADALU… GUADAL… O202… NM         00-24     PART A P… 1346… N     3207… 3200…
#>  2 CROSBYT… NA      O202… TX         00-24     PART A P… 1063… N     6707… 4513…
#>  3 STILLWA… STILLW… O202… OK         00-24     PART A P… 1003… N     3707… 3701…
#>  4 ANSON H… ANSON … O202… TX         00-24     PART A P… 1457… N     6707… 4500…
#>  5 FALLS C… NA      O202… TX         00-24     PART A P… 1841… N     6707… 4503…
#>  6 IRWIN C… PROGRE… O202… GA         00-24     PART A P… 1720… N     1107… 1101…
#>  7 MEMORIA… CHI ST… O202… TX         00-24     PART A P… 1578… N     6707… 4513…
#>  8 STILLWA… STILLW… O202… OK         00-24     PART A P… 1104… N     3707… 3700…
#>  9 OUR LAD… NA      O202… LA         00-24     PART A P… 1609… N     1907… 1913…
#> 10 STURGIS… STURGI… O202… MI         00-24     PART A P… 1598… N     2307… 2300…
#> # ℹ 34 more rows
#> # ℹ 29 more variables: pac <chr>, inc_date <chr>, inc_state <chr>,
#> #   org_type <chr>, org_otxt <chr>, org_status <chr>, add_1 <chr>, add_2 <chr>,
#> #   city <chr>, state <chr>, zip <chr>, loc_type <chr>, loc_otxt <chr>,
#> #   reh_ind <chr>, reh_date <chr>, sub_gen <chr>, sub_acute <chr>,
#> #   sub_adu <chr>, sub_child <chr>, sub_ltc <chr>, sub_psych <chr>,
#> #   sub_irf <chr>, sub_stc <chr>, sub_sba <chr>, sub_psychu <chr>, …

x <- hospitals(
  city = "Atlanta",
  state = "GA",
  subgroup = subgroups(
    acute = FALSE,
    psych = TRUE))
#> ✔ hospitals returned 2 results.
x
#> # A tibble: 2 × 39
#>   org_name  org_dba enid  enid_state prov_type prov_desc npi   multi ccn   ccn2 
#> * <chr>     <chr>   <chr> <chr>      <chr>     <chr>     <chr> <chr> <chr> <chr>
#> 1 UHS OF A… ANCHOR… O201… GA         00-09     PART A P… 1023… Y     1140… NA   
#> 2 UHS OF P… PEACHF… O201… GA         00-09     PART A P… 1093… N     1140… NA   
#> # ℹ 29 more variables: pac <chr>, inc_date <chr>, inc_state <chr>,
#> #   org_type <chr>, org_otxt <chr>, org_status <chr>, add_1 <chr>, add_2 <chr>,
#> #   city <chr>, state <chr>, zip <chr>, loc_type <chr>, loc_otxt <chr>,
#> #   reh_ind <chr>, reh_date <chr>, sub_gen <chr>, sub_acute <chr>,
#> #   sub_adu <chr>, sub_child <chr>, sub_ltc <chr>, sub_psych <chr>,
#> #   sub_irf <chr>, sub_stc <chr>, sub_sba <chr>, sub_psychu <chr>,
#> #   sub_iru <chr>, sub_spec <chr>, sub_other <chr>, sub_otxt <chr>
hospitals2(ccn = x$ccn)
#> ✔ hospitals2 returned 2 results.
#> # A tibble: 2 × 11
#>   ccn    org_name      address city  state zip   county phone type  owner rating
#> * <chr>  <chr>         <chr>   <chr> <chr> <chr> <chr>  <chr> <chr> <chr> <chr> 
#> 1 114010 PEACHFORD BE… 2151 P… ATLA… GA    30338 DE KA… (770… Psyc… Prop… Not A…
#> 2 114032 SO CRESCENT … 5454 Y… COLL… GA    30349 FULTON (770… Psyc… Gove… Not A…

x <- hospitals2()
#> ! hospitals2 ✖ No Query
#> ℹ Returning first 10 rows...
x
#> # A tibble: 10 × 11
#>    ccn    org_name     address city  state zip   county phone type  owner rating
#>  * <chr>  <chr>        <chr>   <chr> <chr> <chr> <chr>  <chr> <chr> <chr> <chr> 
#>  1 010001 SOUTHEAST H… 1108 R… DOTH… AL    36301 HOUST… (334… Acut… Gove… 4     
#>  2 010005 MARSHALL ME… 2505 U… BOAZ  AL    35957 MARSH… (256… Acut… Gove… 3     
#>  3 010006 NORTH ALABA… 1701 V… FLOR… AL    35630 LAUDE… (256… Acut… Prop… 2     
#>  4 010007 MIZELL MEMO… 702 N … OPP   AL    36467 COVIN… (334… Acut… Volu… 1     
#>  5 010008 CRENSHAW CO… 101 HO… LUVE… AL    36049 CRENS… (334… Acut… Prop… Not A…
#>  6 010011 ST. VINCENT… 50 MED… BIRM… AL    35235 JEFFE… (205… Acut… Volu… 2     
#>  7 010012 DEKALB REGI… 200 ME… FORT… AL    35968 DE KA… (256… Acut… Prop… 3     
#>  8 010016 SHELBY BAPT… 1000 F… ALAB… AL    35007 SHELBY (205… Acut… Volu… 2     
#>  9 010018 CALLAHAN EY… 1720 U… BIRM… AL    35233 JEFFE… (205… Acut… Volu… Not A…
#> 10 010019 HELEN KELLE… 1300 S… SHEF… AL    35660 COLBE… (256… Acut… Gove… 2     
hospitals(ccn = x$ccn)
#> ✔ hospitals returned 8 results.
#> # A tibble: 8 × 39
#>   org_name  org_dba enid  enid_state prov_type prov_desc npi   multi ccn   ccn2 
#> * <chr>     <chr>   <chr> <chr>      <chr>     <chr>     <chr> <chr> <chr> <chr>
#> 1 HOUSTON … SOUTHE… O200… AL         00-09     PART A P… 1164… N     0100… NA   
#> 2 HH HEALT… MARSHA… O201… AL         00-09     PART A P… 1407… N     0100… NA   
#> 3 RCHP - F… NORTH … O201… AL         00-09     PART A P… 1477… N     0100… NA   
#> 4 MIZELL M… NA      O200… AL         00-09     PART A P… 1013… N     0100… NA   
#> 5 ST. VINC… ST. VI… O200… AL         00-09     PART A P… 1841… N     0100… NA   
#> 6 HH HEALT… DEKALB… O202… AL         00-09     PART A P… 1770… N     0100… NA   
#> 7 BBH SBMC… BAPTIS… O201… AL         00-09     PART A P… 1811… N     0100… NA   
#> 8 HH HEALT… HELEN … O201… AL         00-09     PART A P… 1508… N     0100… NA   
#> # ℹ 29 more variables: pac <chr>, inc_date <chr>, inc_state <chr>,
#> #   org_type <chr>, org_otxt <chr>, org_status <chr>, add_1 <chr>, add_2 <chr>,
#> #   city <chr>, state <chr>, zip <chr>, loc_type <chr>, loc_otxt <chr>,
#> #   reh_ind <chr>, reh_date <chr>, sub_gen <chr>, sub_acute <chr>,
#> #   sub_adu <chr>, sub_child <chr>, sub_ltc <chr>, sub_psych <chr>,
#> #   sub_irf <chr>, sub_stc <chr>, sub_sba <chr>, sub_psychu <chr>,
#> #   sub_iru <chr>, sub_spec <chr>, sub_other <chr>, sub_otxt <chr>
```
