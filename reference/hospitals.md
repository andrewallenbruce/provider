# Hospital General Information

A list of all hospitals that have been registered with Medicare. The
list includes addresses, phone numbers, hospital type, and overall
hospital rating.

Hospitals currently enrolled in Medicare. Data includes the hospital's
sub-group types, legal business name, doing-business-as name,
organization type and address.

## Usage

``` r
hospitals2(
  ccn = NULL,
  org_name = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  county = NULL,
  hosp_type = NULL,
  own_type = NULL,
  rating = NULL,
  count = FALSE,
  set = FALSE
)

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
```

## Source

- [API: Hospital General
  Information](https://data.cms.gov/provider-data/dataset/27ea-46a8)

- [API: Data
  Dictionary](https://data.cms.gov/provider-data/dataset/xubh-q36u#data-dictionary)

&nbsp;

- [API: Hospital
  Enrollments](https://data.cms.gov/provider-characteristics/hospitals-and-other-facilities/hospital-enrollments)

## Arguments

- ccn:

  `<int>` CMS Certification Number

- org_name:

  `<chr>` Legal business name

- city, state, zip:

  `<chr>` Location city, state, zip

- county:

  `<chr>` Location county

- hosp_type:

  `<enum>` Provider type:

  - `acute` = Acute Care

  - `cah` = Critical Access Hospital

  - `child` = Childrens' Hospital

  - `dod` = Acute Care - Department of Defense

  - `ltc` = Long-term

  - `psych` = Psychiatric

  - `reh` = Rural Emergency Hospital

  - `vha` = Acute Care - Veterans Administration

- own_type:

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

  `<int>` Hospital rating; 1-5 or "Not Available"

- count:

  `<lgl>` Return the total row count

- set:

  `<lgl>` Return the entire dataset

- npi:

  `<int>` National Provider Identifier

- pac:

  `<chr>` PECOS Associate Control ID

- enid, enid_state:

  `<chr>` Medicare Enrollment ID, Enrollment state

- org_dba:

  `<chr>` Doing-business-as name

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

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)

## Examples

``` r
hospitals(count = TRUE)
#> hospitals Totals
#> • Rows  : 9,182
#> • Pages : 2    
#> 

hospitals2(count = TRUE)
#> hospitals2 Totals
#> • Rows  : 5,426
#> • Pages : 4    
#> 

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
#> # A tibble: 2 × 17
#>   org_name     org_dba enid     npi multi ccn   pac   inc_date   org_type status
#> * <chr>        <chr>   <chr>  <int> <int> <chr> <chr> <date>     <chr>    <chr> 
#> 1 UHS OF ANCH… ANCHOR… O201… 1.02e9     1 1140… 4486… 2000-06-02 PARTNER… P     
#> 2 UHS OF PEAC… PEACHF… O201… 1.09e9     0 1140… 9234… 2000-06-02 PARTNER… P     
#> # ℹ 7 more variables: address <chr>, city <chr>, state <chr>, zip <chr>,
#> #   loc_type <chr>, reh_date <date>, subgroup <chr>

hospitals2(ccn = x$ccn)
#> ✔ hospitals2 returned 2 results.
#> # A tibble: 2 × 10
#>   ccn    org_name     prov_type own_type rating address city  state zip   county
#> * <chr>  <chr>        <chr>     <chr>     <int> <chr>   <chr> <chr> <chr> <chr> 
#> 1 114010 PEACHFORD B… Psychiat… Proprie…     NA 2151 P… ATLA… GA    30338 DE KA…
#> 2 114032 SO CRESCENT… Psychiat… Governm…     NA 5454 Y… COLL… GA    30349 FULTON

x <- hospitals2()
#> hospitals2 Totals
#> • Rows  : 5,426
#> • Pages : 4    
#> 
#> ! No Query ❯ Returning first 10 rows.
#> 
x
#> # A tibble: 10 × 10
#>    ccn    org_name    prov_type own_type rating address city  state zip   county
#>  * <chr>  <chr>       <chr>     <chr>     <int> <chr>   <chr> <chr> <chr> <chr> 
#>  1 010001 SOUTHEAST … Acute Ca… Governm…      4 1108 R… DOTH… AL    36301 HOUST…
#>  2 010005 MARSHALL M… Acute Ca… Governm…      3 2505 U… BOAZ  AL    35957 MARSH…
#>  3 010006 NORTH ALAB… Acute Ca… Proprie…      2 1701 V… FLOR… AL    35630 LAUDE…
#>  4 010007 MIZELL MEM… Acute Ca… Volunta…      1 702 N … OPP   AL    36467 COVIN…
#>  5 010008 CRENSHAW C… Acute Ca… Proprie…     NA 101 HO… LUVE… AL    36049 CRENS…
#>  6 010011 ST. VINCEN… Acute Ca… Volunta…      2 50 MED… BIRM… AL    35235 JEFFE…
#>  7 010012 DEKALB REG… Acute Ca… Proprie…      3 200 ME… FORT… AL    35968 DE KA…
#>  8 010016 SHELBY BAP… Acute Ca… Volunta…      2 1000 F… ALAB… AL    35007 SHELBY
#>  9 010018 CALLAHAN E… Acute Ca… Volunta…     NA 1720 U… BIRM… AL    35233 JEFFE…
#> 10 010019 HELEN KELL… Acute Ca… Governm…      2 1300 S… SHEF… AL    35660 COLBE…

hospitals(ccn = x$ccn)
#> ✔ hospitals returned 8 results.
#> # A tibble: 8 × 17
#>   org_name     org_dba enid     npi multi ccn   pac   inc_date   org_type status
#> * <chr>        <chr>   <chr>  <int> <int> <chr> <chr> <date>     <chr>    <chr> 
#> 1 HOUSTON COU… SOUTHE… O200… 1.16e9     0 0100… 9436… 1957-09-01 CORPORA… N     
#> 2 HH HEALTH S… MARSHA… O201… 1.41e9     0 0100… 8527… 2018-08-20 OTHER: … N     
#> 3 RCHP - FLOR… NORTH … O201… 1.48e9     0 0100… 8123… 2010-04-28 LLC      P     
#> 4 MIZELL MEMO… NA      O200… 1.01e9     0 0100… 6507… 1945-11-26 CORPORA… N     
#> 5 ST. VINCENT… ST. VI… O200… 1.84e9     0 0100… 8921… 1968-07-22 CORPORA… N     
#> 6 HH HEALTH S… DEKALB… O202… 1.77e9     0 0100… 6709… NA         LLC      P     
#> 7 BBH SBMC, L… BAPTIS… O201… 1.81e9     0 0100… 7810… 2015-06-19 LLC      P     
#> 8 HH HEALTH S… HELEN … O201… 1.51e9     0 0100… 1759… 2014-11-14 LLC      N     
#> # ℹ 7 more variables: address <chr>, city <chr>, state <chr>, zip <chr>,
#> #   loc_type <chr>, reh_date <date>, subgroup <chr>

hospitals2(state = "GA", rating = 5) |> str()
#> ✔ hospitals2 returned 4 results.
#> tibble [4 × 10] (S3: tbl_df/tbl/data.frame)
#>  $ ccn      : chr [1:4] "110050" "110128" "110200" "110237"
#>  $ org_name : chr [1:4] "ADVENTHEALTH MURRAY" "MEMORIAL HEALTH MEADOWS HOSPITAL" "PIEDMONT COLUMBUS REGIONAL NORTHSIDE" "NORTHEAST GEORGIA MEDICAL CENTER LUMPKIN"
#>  $ prov_type: chr [1:4] "Acute Care Hospitals" "Acute Care Hospitals" "Acute Care Hospitals" "Acute Care Hospitals"
#>  $ own_type : chr [1:4] "Voluntary non-profit - Private" "Proprietary" "Proprietary" "Voluntary non-profit - Other"
#>  $ rating   : int [1:4] 5 5 5 5
#>  $ address  : chr [1:4] "707 OLD DALTON ELLIJAY ROAD, PO BOX 1406" "ONE MEADOWS PARKWAY" "100 FRIST COURT" "227 MOUNTAIN DRIVE"
#>  $ city     : chr [1:4] "CHATSWORTH" "VIDALIA" "COLUMBUS" "DAHLONEGA"
#>  $ state    : chr [1:4] "GA" "GA" "GA" "GA"
#>  $ zip      : chr [1:4] "30705" "30474" "31909" "30533"
#>  $ county   : chr [1:4] "MURRAY" "TOOMBS" "MUSCOGEE" "LUMPKIN"
```
