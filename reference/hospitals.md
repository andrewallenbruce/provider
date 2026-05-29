# Hospitals Enrolled in Medicare

Hospitals currently enrolled in Medicare. Data includes the hospital's
sub-group types, legal business name, doing-business-as name,
organization type and address.

A list of all hospitals that have been registered with Medicare. The
list includes addresses, phone numbers, hospital type, and overall
hospital rating.

## Usage

``` r
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
```

## Source

- [API: Hospital
  Enrollments](https://data.cms.gov/provider-characteristics/hospitals-and-other-facilities/hospital-enrollments)

&nbsp;

- [API: Hospital General
  Information](https://data.cms.gov/provider-data/dataset/27ea-46a8)

- [API: Data
  Dictionary](https://data.cms.gov/provider-data/dataset/xubh-q36u#data-dictionary)

## Arguments

- npi:

  `<int>` National Provider Identifier

- ccn:

  `<int>` CMS Certification Number

- pac:

  `<chr>` PECOS Associate Control ID

- enid:

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

## Examples

``` r
hospitals(count = TRUE)
#> hospitals Totals
#> • Rows  : 9,175
#> • Pages : 2    
#> 
hospitals2(count = TRUE)
#> hospitals2 Totals
#> • Rows  : 5,432
#> • Pages : 4    
#> 

hospitals(prov_type = "reh", count = TRUE)
#> ✔ hospitals returned 48 results.
hospitals2(hosp_type = "reh", count = TRUE)
#> ✔ hospitals2 returned 41 results.

x <- hospitals(
  city = "Atlanta",
  state = "GA",
  subgroup = subgroups(
    acute = FALSE,
    psych = TRUE))
#> ✔ hospitals returned 2 results.
x |> str()
#> hospitls [2 × 18] (S3: hospitals/provider/tbl_df/tbl/data.frame)
#>  $ org_name : chr [1:2] "UHS OF ANCHOR L.P." "UHS OF PEACHFORD, L.P."
#>  $ org_dba  : chr [1:2] "ANCHOR HOSPITAL" "PEACHFORD BEHAVIORAL HEALTH SYSTEM OF ATLANTA"
#>  $ enid     : chr [1:2] "O20100521000547" "O20100803001043"
#>  $ npi      : int [1:2] 1023095429 1093781544
#>  $ multi    : int [1:2] 1 0
#>  $ ccn      : chr [1:2] "114032" "114010"
#>  $ pac      : chr [1:2] "4486684784" "9234123894"
#>  $ inc_date : Date[1:2], format: "2000-06-02" "2000-06-02"
#>  $ org_type : chr [1:2] "PARTNERSHIP" "PARTNERSHIP"
#>  $ status   : chr [1:2] "For-Profit" "For-Profit"
#>  $ address  : chr [1:2] "5454 YORKTOWNE DRIVE, ANCHOR HOSPITAL" "2151 PEACHFORD ROAD"
#>  $ city     : chr [1:2] "ATLANTA" "ATLANTA"
#>  $ state    : chr [1:2] "GA" "GA"
#>  $ zip      : chr [1:2] "303495317" "303386534"
#>  $ loc_type : chr [1:2] "Other" "Other"
#>  $ reh_date : Date[1:2], format: NA NA
#>  $ prov_type: chr [1:2] NA NA
#>  $ sub_group: chr [1:2] "Psych" "Psych, Psych Unit"

hospitals2(ccn = x$ccn)
#> ✔ hospitals2 returned 2 results.
#> # A tibble: 2 × 10
#>   ccn    org_name       prov_type status rating address city  state zip   county
#>   <chr>  <chr>          <chr>     <chr>   <int> <chr>   <chr> <chr> <chr> <chr> 
#> 1 114010 PEACHFORD BEH… Psychiat… Propr…     NA 2151 P… ATLA… GA    30338 DE KA…
#> 2 114032 SO CRESCENT B… Psychiat… Gover…     NA 5454 Y… COLL… GA    30349 FULTON

x <- hospitals2()
#> hospitals2 Totals
#> • Rows  : 5,432
#> • Pages : 4    
#> 
#> ! No Query ❯ Returning first 10 rows.
#> 
x
#> # A tibble: 10 × 10
#>    ccn    org_name      prov_type status rating address city  state zip   county
#>    <chr>  <chr>         <chr>     <chr>   <int> <chr>   <chr> <chr> <chr> <chr> 
#>  1 010001 SOUTHEAST HE… Acute Ca… Gover…      4 1108 R… DOTH… AL    36301 HOUST…
#>  2 010005 MARSHALL MED… Acute Ca… Gover…      3 2505 U… BOAZ  AL    35957 MARSH…
#>  3 010006 NORTH ALABAM… Acute Ca… Propr…      2 1701 V… FLOR… AL    35630 LAUDE…
#>  4 010007 MIZELL MEMOR… Acute Ca… Volun…      1 702 N … OPP   AL    36467 COVIN…
#>  5 010011 ST. VINCENT'… Acute Ca… Volun…      3 50 MED… BIRM… AL    35235 JEFFE…
#>  6 010012 DEKALB REGIO… Acute Ca… Propr…      2 200 ME… FORT… AL    35968 DE KA…
#>  7 010016 SHELBY BAPTI… Acute Ca… Volun…      2 1000 F… ALAB… AL    35007 SHELBY
#>  8 010018 UAB CALLAHAN… Acute Ca… Volun…     NA 1720 U… BIRM… AL    35233 JEFFE…
#>  9 010019 HELEN KELLER… Acute Ca… Gover…      2 1300 S… SHEF… AL    35660 COLBE…
#> 10 010021 DALE MEDICAL… Acute Ca… Gover…     NA 126 HO… OZARK AL    36360 DALE  

hospitals(ccn = x$ccn) |> str()
#> ✔ hospitals returned 9 results.
#> hospitls [9 × 18] (S3: hospitals/provider/tbl_df/tbl/data.frame)
#>  $ org_name : chr [1:9] "HOUSTON COUNTY HEALTHCARE AUTHORITY" "HH HEALTH SYSTEM - MARSHALL LLC" "RCHP - FLORENCE LLC" "MIZELL MEMORIAL HOSPITAL, INC." ...
#>  $ org_dba  : chr [1:9] "SOUTHEAST HEALTH MEDICAL CENTER" "MARSHALL MEDICAL CENTERS" "NORTH ALABAMA MEDICAL CENTER" NA ...
#>  $ enid     : chr [1:9] "O20080425000450" "O20190513002452" "O20101122000631" "O20080922000250" ...
#>  $ npi      : int [1:9] 1164403861 1407313760 1477874337 1013937705 1841308020 1770344665 1811341167 1508952235 1942380357
#>  $ multi    : int [1:9] 0 0 0 0 0 0 0 0 0
#>  $ ccn      : chr [1:9] "010001" "010005" "010006" "010007" ...
#>  $ pac      : chr [1:9] "9436062296" "8527301654" "8123151354" "6507820990" ...
#>  $ inc_date : Date[1:9], format: "1957-09-01" "2018-08-20" ...
#>  $ org_type : chr [1:9] "CORPORATION" "Other: HEALTH CARE AUTHORITY" "LLC" "CORPORATION" ...
#>  $ status   : chr [1:9] "Non-Profit" "Non-Profit" "For-Profit" "Non-Profit" ...
#>  $ address  : chr [1:9] "1108 ROSS CLARK CIR" "2505 US HIGHWAY 431" "1701 VETERANS DR" "702N MAIN ST" ...
#>  $ city     : chr [1:9] "DOTHAN" "BOAZ" "FLORENCE" "OPP" ...
#>  $ state    : chr [1:9] "AL" "AL" "AL" "AL" ...
#>  $ zip      : chr [1:9] "363013022" "359575908" "356304928" "364671626" ...
#>  $ loc_type : chr [1:9] "Primary" "Other" "Primary" "Primary" ...
#>  $ reh_date : Date[1:9], format: NA NA ...
#>  $ prov_type: chr [1:9] NA NA NA NA ...
#>  $ sub_group: chr [1:9] "Acute" "Acute, General" "Acute, General" "Acute, Swing-Bed, Psych Unit" ...

hospitals2(state = "GA", rating = 5) |> str()
#> ✔ hospitals2 returned 6 results.
#> hosptls2 [6 × 10] (S3: hospitals2/provider/tbl_df/tbl/data.frame)
#>  $ ccn      : chr [1:6] "110016" "110050" "110128" "110200" ...
#>  $ org_name : chr [1:6] "WELLSTAR WEST GEORGIA MEDICAL CENTER" "ADVENTHEALTH MURRAY" "MEMORIAL HEALTH MEADOWS HOSPITAL" "PIEDMONT COLUMBUS REGIONAL NORTHSIDE" ...
#>  $ prov_type: chr [1:6] "Acute Care Hospitals" "Acute Care Hospitals" "Acute Care Hospitals" "Acute Care Hospitals" ...
#>  $ status   : chr [1:6] "Voluntary non-profit - Private" "Voluntary non-profit - Private" "Proprietary" "Proprietary" ...
#>  $ rating   : int [1:6] 5 5 5 5 5 5
#>  $ address  : chr [1:6] "1514 VERNON ROAD" "707 OLD DALTON ELLIJAY ROAD, PO BOX 1406" "ONE MEADOWS PARKWAY" "100 FRIST COURT" ...
#>  $ city     : chr [1:6] "LAGRANGE" "CHATSWORTH" "VIDALIA" "COLUMBUS" ...
#>  $ state    : chr [1:6] "GA" "GA" "GA" "GA" ...
#>  $ zip      : chr [1:6] "30240" "30705" "30474" "31909" ...
#>  $ county   : chr [1:6] "TROUP" "MURRAY" "TOOMBS" "MUSCOGEE" ...
```
