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
  ownership = NULL,
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
#>     ENROLLMENT ID ENROLLMENT STATE PROVIDER TYPE CODE
#> 1 O20100521000547               GA              00-09
#> 2 O20100803001043               GA              00-09
#>           PROVIDER TYPE TEXT        NPI MULTIPLE NPI FLAG    CCN ASSOCIATE ID
#> 1 PART A PROVIDER - HOSPITAL 1023095429                 Y 114032   4486684784
#> 2 PART A PROVIDER - HOSPITAL 1093781544                 N 114010   9234123894
#>        ORGANIZATION NAME                        DOING BUSINESS AS NAME
#> 1     UHS OF ANCHOR L.P.                               ANCHOR HOSPITAL
#> 2 UHS OF PEACHFORD, L.P. PEACHFORD BEHAVIORAL HEALTH SYSTEM OF ATLANTA
#>   INCORPORATION DATE INCORPORATION STATE ORGANIZATION TYPE STRUCTURE
#> 1         2000-06-02                  DE                 PARTNERSHIP
#> 2         2000-06-02                  DE                 PARTNERSHIP
#>   ORGANIZATION OTHER TYPE TEXT PROPRIETARY NONPROFIT       ADDRESS LINE 1
#> 1                                                  P 5454 YORKTOWNE DRIVE
#> 2                                                  P  2151 PEACHFORD ROAD
#>    ADDRESS LINE 2    CITY STATE  ZIP CODE           PRACTICE LOCATION TYPE
#> 1 ANCHOR HOSPITAL ATLANTA    GA 303495317 OTHER HOSPITAL PRACTICE LOCATION
#> 2                 ATLANTA    GA 303386534 OTHER HOSPITAL PRACTICE LOCATION
#>   LOCATION OTHER TYPE TEXT SUBGROUP - GENERAL SUBGROUP - ACUTE CARE
#> 1                                           N                     N
#> 2                                           N                     N
#>   SUBGROUP - ALCOHOL DRUG SUBGROUP - CHILDRENS SUBGROUP - LONG-TERM
#> 1                       N                    N                    N
#> 2                       N                    N                    N
#>   SUBGROUP - PSYCHIATRIC SUBGROUP - REHABILITATION SUBGROUP - SHORT-TERM
#> 1                      Y                         N                     N
#> 2                      Y                         N                     N
#>   SUBGROUP - SWING-BED APPROVED SUBGROUP - PSYCHIATRIC UNIT
#> 1                             N                           N
#> 2                             N                           Y
#>   SUBGROUP - REHABILITATION UNIT SUBGROUP - SPECIALTY HOSPITAL SUBGROUP - OTHER
#> 1                              N                             N                N
#> 2                              N                             N                N
#>   SUBGROUP - OTHER TEXT REH CONVERSION FLAG REH CONVERSION DATE
#> 1                                         N                    
#> 2                                         N                    
#>   CAH OR HOSPITAL CCN
#> 1                    
#> 2                    

hospitals2(ccn = x$ccn)
#> ℹ hospitals2 has 5,426 rows.
#> ! hospitals2 ❯ No Query
#> ℹ Returning first 10 rows...
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

x <- hospitals2()
#> ℹ hospitals2 has 5,426 rows.
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
