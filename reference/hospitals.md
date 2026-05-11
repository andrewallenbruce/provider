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

- enid:

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
x |> str()
#> tibble [2 × 17] (S3: tbl_df/tbl/data.frame)
#>  $ enid    : chr [1:2] "O20100521000547" "O20100803001043"
#>  $ npi     : int [1:2] 1023095429 1093781544
#>  $ multi   : int [1:2] 1 0
#>  $ ccn     : chr [1:2] "114032" "114010"
#>  $ pac     : chr [1:2] "4486684784" "9234123894"
#>  $ org_name: chr [1:2] "UHS OF ANCHOR L.P." "UHS OF PEACHFORD, L.P."
#>  $ org_dba : chr [1:2] "ANCHOR HOSPITAL" "PEACHFORD BEHAVIORAL HEALTH SYSTEM OF ATLANTA"
#>  $ inc_date: Date[1:2], format: "2000-06-02" "2000-06-02"
#>  $ org_type: chr [1:2] "PARTNERSHIP" "PARTNERSHIP"
#>  $ status  : chr [1:2] "P" "P"
#>  $ address : chr [1:2] "ANCHOR HOSPITAL" ""
#>  $ city    : chr [1:2] "ATLANTA" "ATLANTA"
#>  $ state   : chr [1:2] "GA" "GA"
#>  $ zip     : chr [1:2] "303495317" "303386534"
#>  $ loc_type: chr [1:2] "OTHER HOSPITAL PRACTICE LOCATION" "OTHER HOSPITAL PRACTICE LOCATION"
#>  $ reh_date: Date[1:2], format: NA NA
#>  $ subgroup: chr [1:2] "Psych" "Psych"

hospitals2(ccn = x$ccn)
#> ✔ hospitals2 returned 2 results.
#> # A tibble: 2 × 10
#>   ccn    org_name       address city  state zip   county prov_type status rating
#> * <chr>  <chr>          <chr>   <chr> <chr> <chr> <chr>  <chr>     <chr>   <int>
#> 1 114010 PEACHFORD BEH… 2151 P… ATLA… GA    30338 DE KA… Psychiat… Propr…     NA
#> 2 114032 SO CRESCENT B… 5454 Y… COLL… GA    30349 FULTON Psychiat… Gover…     NA

x <- hospitals2()
#> hospitals2 Totals
#> • Rows  : 5,426
#> • Pages : 4    
#> 
#> ! No Query ❯ Returning first 10 rows.
#> 
x
#> # A tibble: 10 × 10
#>    ccn    org_name      address city  state zip   county prov_type status rating
#>  * <chr>  <chr>         <chr>   <chr> <chr> <chr> <chr>  <chr>     <chr>   <int>
#>  1 010001 SOUTHEAST HE… 1108 R… DOTH… AL    36301 HOUST… Acute Ca… Gover…      4
#>  2 010005 MARSHALL MED… 2505 U… BOAZ  AL    35957 MARSH… Acute Ca… Gover…      3
#>  3 010006 NORTH ALABAM… 1701 V… FLOR… AL    35630 LAUDE… Acute Ca… Propr…      2
#>  4 010007 MIZELL MEMOR… 702 N … OPP   AL    36467 COVIN… Acute Ca… Volun…      1
#>  5 010008 CRENSHAW COM… 101 HO… LUVE… AL    36049 CRENS… Acute Ca… Propr…     NA
#>  6 010011 ST. VINCENT'… 50 MED… BIRM… AL    35235 JEFFE… Acute Ca… Volun…      2
#>  7 010012 DEKALB REGIO… 200 ME… FORT… AL    35968 DE KA… Acute Ca… Propr…      3
#>  8 010016 SHELBY BAPTI… 1000 F… ALAB… AL    35007 SHELBY Acute Ca… Volun…      2
#>  9 010018 CALLAHAN EYE… 1720 U… BIRM… AL    35233 JEFFE… Acute Ca… Volun…     NA
#> 10 010019 HELEN KELLER… 1300 S… SHEF… AL    35660 COLBE… Acute Ca… Gover…      2

hospitals(ccn = x$ccn) |> str()
#> ✔ hospitals returned 8 results.
#> tibble [8 × 17] (S3: tbl_df/tbl/data.frame)
#>  $ enid    : chr [1:8] "O20080425000450" "O20190513002452" "O20101122000631" "O20080922000250" ...
#>  $ npi     : int [1:8] 1164403861 1407313760 1477874337 1013937705 1841308020 1770344665 1811341167 1508952235
#>  $ multi   : int [1:8] 0 0 0 0 0 0 0 0
#>  $ ccn     : chr [1:8] "010001" "010005" "010006" "010007" ...
#>  $ pac     : chr [1:8] "9436062296" "8527301654" "8123151354" "6507820990" ...
#>  $ org_name: chr [1:8] "HOUSTON COUNTY HEALTHCARE AUTHORITY" "HH HEALTH SYSTEM - MARSHALL LLC" "RCHP - FLORENCE LLC" "MIZELL MEMORIAL HOSPITAL, INC." ...
#>  $ org_dba : chr [1:8] "SOUTHEAST HEALTH MEDICAL CENTER" "MARSHALL MEDICAL CENTERS" "NORTH ALABAMA MEDICAL CENTER" "" ...
#>  $ inc_date: Date[1:8], format: "1957-09-01" "2018-08-20" ...
#>  $ org_type: chr [1:8] "CORPORATION" "OTHER: HEALTH CARE AUTHORITY" "LLC" "CORPORATION" ...
#>  $ status  : chr [1:8] "N" "N" "P" "N" ...
#>  $ address : chr [1:8] "1108 ROSS CLARK CIR" "2505 US HIGHWAY 431" "1701 VETERANS DR" "702N MAIN ST" ...
#>  $ city    : chr [1:8] "DOTHAN" "BOAZ" "FLORENCE" "OPP" ...
#>  $ state   : chr [1:8] "AL" "AL" "AL" "AL" ...
#>  $ zip     : chr [1:8] "363013022" "359575908" "356304928" "364671626" ...
#>  $ loc_type: chr [1:8] "MAIN/PRIMARY HOSPITAL LOCATION" "OTHER HOSPITAL PRACTICE LOCATION" "MAIN/PRIMARY HOSPITAL LOCATION" "MAIN/PRIMARY HOSPITAL LOCATION" ...
#>  $ reh_date: Date[1:8], format: NA NA ...
#>  $ subgroup: chr [1:8] "Acute" "Acute" "Acute" "Acute" ...

hospitals2(state = "GA", rating = 5) |> str()
#> ✔ hospitals2 returned 4 results.
#> tibble [4 × 10] (S3: tbl_df/tbl/data.frame)
#>  $ ccn      : chr [1:4] "110050" "110128" "110200" "110237"
#>  $ org_name : chr [1:4] "ADVENTHEALTH MURRAY" "MEMORIAL HEALTH MEADOWS HOSPITAL" "PIEDMONT COLUMBUS REGIONAL NORTHSIDE" "NORTHEAST GEORGIA MEDICAL CENTER LUMPKIN"
#>  $ address  : chr [1:4] "707 OLD DALTON ELLIJAY ROAD, PO BOX 1406" "ONE MEADOWS PARKWAY" "100 FRIST COURT" "227 MOUNTAIN DRIVE"
#>  $ city     : chr [1:4] "CHATSWORTH" "VIDALIA" "COLUMBUS" "DAHLONEGA"
#>  $ state    : chr [1:4] "GA" "GA" "GA" "GA"
#>  $ zip      : chr [1:4] "30705" "30474" "31909" "30533"
#>  $ county   : chr [1:4] "MURRAY" "TOOMBS" "MUSCOGEE" "LUMPKIN"
#>  $ prov_type: chr [1:4] "Acute Care Hospitals" "Acute Care Hospitals" "Acute Care Hospitals" "Acute Care Hospitals"
#>  $ status   : chr [1:4] "Voluntary non-profit - Private" "Proprietary" "Proprietary" "Voluntary non-profit - Other"
#>  $ rating   : int [1:4] 5 5 5 5
```
