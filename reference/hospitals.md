# Hospitals Enrolled in Medicare

Hospitals currently enrolled in Medicare. Data includes the hospital's
sub-group types, legal business name, doing-business-as name,
organization type and address.

A list of all hospitals that have been registered with Medicare. The
list includes addresses, phone numbers, hospital type, and overall
hospital rating.

\#' @source

- [API: Hospital General
  Information](https://data.cms.gov/provider-data/dataset/27ea-46a8)

- [API: Data
  Dictionary](https://data.cms.gov/provider-data/dataset/xubh-q36u#data-dictionary)

## Usage

``` r
hospitals(
  npi = NULL,
  ccn = NULL,
  pac = NULL,
  enid = NULL,
  enid_state = NULL,
  org_name = NULL,
  org_dba = NULL,
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

hospitals2(
  ccn = NULL,
  org_name = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  county = NULL,
  hosp_type = NULL,
  ownership = NULL,
  rating = NULL,
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

- org_dba:

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

  `<enum>` Provider type:

  - `hospital` = Medicare Part A Hospital

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

- county:

  `<chr>` Location county

- hosp_type:

  `<enum>` Provider type:

  - `acute` = Acute Care Hospitals

  - `cah` = Critical Access Hospitals

  - `child` = Children's

  - `dod` = Acute Care - Department of Defense

  - `ltc` = Long-term

  - `psych` = Psychiatric

  - `reh` = Rural Emergency Hospital

  - `vha` = Acute Care - Veterans Administration

- ownership:

  `<enum>` Ownership type:

  - `private` = Voluntary non-profit - Private

  - `other` = Voluntary non-profit - Other

  - `church` = Voluntary non-profit - Church

  - `district` = Government - Hospital District or Authority

  - `local` = Government - Local

  - `federal` = Government - Federal

  - `state` = Government - State

  - `dod` = Department of Defense

  - `profit` = Proprietary

  - `physician` = Physician

  - `tribal` = Tribal

  - `vha` = Veterans Health Administration

- rating:

  `<num>` Hospital rating; 1-5 or "Not Available"

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)

## Examples

``` r
hospitals(count = TRUE)
#> ℹ hospitals has 9,182 rows.

hospitals2(count = TRUE)
#> ℹ hospitals2 has 5,426 rows.

hospitals(prov_type = "reh", count = TRUE)
#> ✔ hospitals returned 48 results.
hospitals2(hosp_type = "reh", count = TRUE)
#> ✔ hospitals2 returned 39 results.

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
#>   ccn    org_name    hosp_type ownership rating address city  state zip   county
#> * <chr>  <chr>       <chr>     <chr>      <int> <chr>   <chr> <chr> <chr> <chr> 
#> 1 114010 PEACHFORD … Psychiat… Propriet…     NA 2151 P… ATLA… GA    30338 DE KA…
#> 2 114032 SO CRESCEN… Psychiat… Governme…     NA 5454 Y… COLL… GA    30349 FULTON
#> # ℹ 1 more variable: phone <chr>

x <- hospitals2()
#> ! hospitals2 ❯ No Query
#> ℹ Returning first 10 rows...
x
#> # A tibble: 10 × 11
#>    ccn    org_name   hosp_type ownership rating address city  state zip   county
#>  * <chr>  <chr>      <chr>     <chr>      <int> <chr>   <chr> <chr> <chr> <chr> 
#>  1 010001 SOUTHEAST… Acute Ca… Governme…      4 1108 R… DOTH… AL    36301 HOUST…
#>  2 010005 MARSHALL … Acute Ca… Governme…      3 2505 U… BOAZ  AL    35957 MARSH…
#>  3 010006 NORTH ALA… Acute Ca… Propriet…      2 1701 V… FLOR… AL    35630 LAUDE…
#>  4 010007 MIZELL ME… Acute Ca… Voluntar…      1 702 N … OPP   AL    36467 COVIN…
#>  5 010008 CRENSHAW … Acute Ca… Propriet…     NA 101 HO… LUVE… AL    36049 CRENS…
#>  6 010011 ST. VINCE… Acute Ca… Voluntar…      2 50 MED… BIRM… AL    35235 JEFFE…
#>  7 010012 DEKALB RE… Acute Ca… Propriet…      3 200 ME… FORT… AL    35968 DE KA…
#>  8 010016 SHELBY BA… Acute Ca… Voluntar…      2 1000 F… ALAB… AL    35007 SHELBY
#>  9 010018 CALLAHAN … Acute Ca… Voluntar…     NA 1720 U… BIRM… AL    35233 JEFFE…
#> 10 010019 HELEN KEL… Acute Ca… Governme…      2 1300 S… SHEF… AL    35660 COLBE…
#> # ℹ 1 more variable: phone <chr>

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

hospitals2(state = "GA", rating = 5) |> str()
#> ✔ hospitals2 returned 4 results.
#> tibble [4 × 11] (S3: tbl_df/tbl/data.frame)
#>  $ ccn      : chr [1:4] "110050" "110128" "110200" "110237"
#>  $ org_name : chr [1:4] "ADVENTHEALTH MURRAY" "MEMORIAL HEALTH MEADOWS HOSPITAL" "PIEDMONT COLUMBUS REGIONAL NORTHSIDE" "NORTHEAST GEORGIA MEDICAL CENTER LUMPKIN"
#>  $ hosp_type: chr [1:4] "Acute Care Hospitals" "Acute Care Hospitals" "Acute Care Hospitals" "Acute Care Hospitals"
#>  $ ownership: chr [1:4] "Voluntary non-profit - Private" "Proprietary" "Proprietary" "Voluntary non-profit - Other"
#>  $ rating   : int [1:4] 5 5 5 5
#>  $ address  : chr [1:4] "707 OLD DALTON ELLIJAY ROAD, PO BOX 1406" "ONE MEADOWS PARKWAY" "100 FRIST COURT" "227 MOUNTAIN DRIVE"
#>  $ city     : chr [1:4] "CHATSWORTH" "VIDALIA" "COLUMBUS" "DAHLONEGA"
#>  $ state    : chr [1:4] "GA" "GA" "GA" "GA"
#>  $ zip      : chr [1:4] "30705" "30474" "31909" "30533"
#>  $ county   : chr [1:4] "MURRAY" "TOOMBS" "MUSCOGEE" "LUMPKIN"
#>  $ phone    : chr [1:4] "(706) 517-2031" "(912) 535-5828" "(706) 494-2101" "(770) 219-7146"
```
