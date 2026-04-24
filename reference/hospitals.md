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

  - `swing` = Hospital Swing-Bed Unit

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
#> # A tibble: 44 × 37
#>    org_name      org_dba enid  enid_state prov_type prov_desc    npi multi ccn  
#>  * <chr>         <chr>   <chr> <chr>      <chr>     <chr>      <int> <int> <chr>
#>  1 GUADALUPE CO… GUADAL… O202… NM         00-24     PART A P… 1.35e9     0 3207…
#>  2 CROSBYTON CL… NA      O202… TX         00-24     PART A P… 1.06e9     0 6707…
#>  3 STILLWATER M… STILLW… O202… OK         00-24     PART A P… 1.00e9     0 3707…
#>  4 ANSON HOSPIT… ANSON … O202… TX         00-24     PART A P… 1.46e9     0 6707…
#>  5 FALLS COMMUN… NA      O202… TX         00-24     PART A P… 1.84e9     0 6707…
#>  6 IRWIN COUNTY… PROGRE… O202… GA         00-24     PART A P… 1.72e9     0 1107…
#>  7 MEMORIAL MED… CHI ST… O202… TX         00-24     PART A P… 1.58e9     0 6707…
#>  8 STILLWATER M… STILLW… O202… OK         00-24     PART A P… 1.10e9     0 3707…
#>  9 OUR LADY OF … NA      O202… LA         00-24     PART A P… 1.61e9     0 1907…
#> 10 STURGIS HOSP… STURGI… O202… MI         00-24     PART A P… 1.60e9     0 2307…
#> # ℹ 34 more rows
#> # ℹ 28 more variables: pac <chr>, inc_date <date>, inc_state <chr>,
#> #   org_type <chr>, org_otxt <chr>, status <chr>, city <chr>, state <chr>,
#> #   zip <chr>, loc_type <chr>, loc_otxt <chr>, reh_date <date>, reh_ccn <chr>,
#> #   sub_acute <int>, sub_gen <int>, sub_spec <int>, sub_adu <int>,
#> #   sub_child <int>, sub_ltc <int>, sub_psy <int>, sub_irf <int>,
#> #   sub_stc <int>, sub_sba <int>, sub_psu <int>, sub_iru <int>, …

x <- hospitals(
  city = "Atlanta",
  state = "GA",
  subgroup = subgroups(
    acute = FALSE,
    psych = TRUE))
#> ✔ hospitals returned 2 results.
x
#> # A tibble: 2 × 37
#>   org_name org_dba enid  enid_state prov_type prov_desc    npi multi ccn   pac  
#> * <chr>    <chr>   <chr> <chr>      <chr>     <chr>      <int> <int> <chr> <chr>
#> 1 UHS OF … ANCHOR… O201… GA         00-09     PART A P… 1.02e9     1 1140… 4486…
#> 2 UHS OF … PEACHF… O201… GA         00-09     PART A P… 1.09e9     0 1140… 9234…
#> # ℹ 27 more variables: inc_date <date>, inc_state <chr>, org_type <chr>,
#> #   org_otxt <chr>, status <chr>, city <chr>, state <chr>, zip <chr>,
#> #   loc_type <chr>, loc_otxt <chr>, reh_date <date>, reh_ccn <chr>,
#> #   sub_acute <int>, sub_gen <int>, sub_spec <int>, sub_adu <int>,
#> #   sub_child <int>, sub_ltc <int>, sub_psy <int>, sub_irf <int>,
#> #   sub_stc <int>, sub_sba <int>, sub_psu <int>, sub_iru <int>, sub_oth <int>,
#> #   sub_otxt <int>, address <chr>

hospitals2(ccn = x$ccn)
#> ✔ hospitals2 returned 2 results.
#> # A tibble: 2 × 11
#>   ccn    org_name      address city  state zip   county phone type  owner rating
#> * <chr>  <chr>         <chr>   <chr> <chr> <chr> <chr>  <chr> <chr> <chr> <chr> 
#> 1 114010 PEACHFORD BE… 2151 P… ATLA… GA    30338 DE KA… (770… Psyc… Prop… Not A…
#> 2 114032 SO CRESCENT … 5454 Y… COLL… GA    30349 FULTON (770… Psyc… Gove… Not A…

x <- hospitals2()
#> ! hospitals2 ◯ No Query
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
#> # A tibble: 8 × 37
#>   org_name org_dba enid  enid_state prov_type prov_desc    npi multi ccn   pac  
#> * <chr>    <chr>   <chr> <chr>      <chr>     <chr>      <int> <int> <chr> <chr>
#> 1 HOUSTON… SOUTHE… O200… AL         00-09     PART A P… 1.16e9     0 0100… 9436…
#> 2 HH HEAL… MARSHA… O201… AL         00-09     PART A P… 1.41e9     0 0100… 8527…
#> 3 RCHP - … NORTH … O201… AL         00-09     PART A P… 1.48e9     0 0100… 8123…
#> 4 MIZELL … NA      O200… AL         00-09     PART A P… 1.01e9     0 0100… 6507…
#> 5 ST. VIN… ST. VI… O200… AL         00-09     PART A P… 1.84e9     0 0100… 8921…
#> 6 HH HEAL… DEKALB… O202… AL         00-09     PART A P… 1.77e9     0 0100… 6709…
#> 7 BBH SBM… BAPTIS… O201… AL         00-09     PART A P… 1.81e9     0 0100… 7810…
#> 8 HH HEAL… HELEN … O201… AL         00-09     PART A P… 1.51e9     0 0100… 1759…
#> # ℹ 27 more variables: inc_date <date>, inc_state <chr>, org_type <chr>,
#> #   org_otxt <chr>, status <chr>, city <chr>, state <chr>, zip <chr>,
#> #   loc_type <chr>, loc_otxt <chr>, reh_date <date>, reh_ccn <chr>,
#> #   sub_acute <int>, sub_gen <int>, sub_spec <int>, sub_adu <int>,
#> #   sub_child <int>, sub_ltc <int>, sub_psy <int>, sub_irf <int>,
#> #   sub_stc <int>, sub_sba <int>, sub_psu <int>, sub_iru <int>, sub_oth <int>,
#> #   sub_otxt <int>, address <chr>
```
