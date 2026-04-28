# Federally Qualified Healthcare Clinics

Providers with pending Medicare enrollment applications.

## Usage

``` r
fqhc_enroll(
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
  count = FALSE,
  set = FALSE
)
```

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

- count:

  `<lgl>` Return the total row count

- set:

  `<lgl>` Return the entire dataset

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)

## Examples

``` r
fqhc_enroll(count = TRUE)
#> ℹ fqhc_enroll has 11,063 rows.

fqhc_enroll() |> str()
#> ! fqhc_enroll ❯ No Query
#> ℹ Returning first 10 rows...
#> tibble [10 × 20] (S3: tbl_df/tbl/data.frame)
#>  $ enid      : chr [1:10] "O20020819000009" "O20020829000010" "O20020927000008" "O20021011000005" ...
#>  $ enid_state: chr [1:10] "FL" "NY" "FL" "IL" ...
#>  $ prov_type : chr [1:10] "00-04" "00-04" "00-04" "00-04" ...
#>  $ prov_desc : chr [1:10] "PART A PROVIDER - FEDERALLY QUALIFIED HEALTH CENTER (FQHC)" "PART A PROVIDER - FEDERALLY QUALIFIED HEALTH CENTER (FQHC)" "PART A PROVIDER - FEDERALLY QUALIFIED HEALTH CENTER (FQHC)" "PART A PROVIDER - FEDERALLY QUALIFIED HEALTH CENTER (FQHC)" ...
#>  $ npi       : int [1:10] 1801826268 1619969458 1164642419 1629156807 1417149766 1598895542 1417005919 1629078274 1245246917 1487764759
#>  $ multi     : chr [1:10] "0" "0" "0" "0" ...
#>  $ ccn       : chr [1:10] "101936" "331916" "101937" "141927" ...
#>  $ pac       : chr [1:10] "2365359387" "6608783568" "2365359387" "9537076112" ...
#>  $ org_name  : chr [1:10] "TRENTON MEDICAL CENTER INC" "SUN RIVER HEALTH INC." "TRENTON MEDICAL CENTER INC" "ACCESS COMMUNITY HEALTH NETWORK" ...
#>  $ org_dba   : chr [1:10] "PALMS MEDICAL GROUP" NA "PALMS MEDICAL GROUP" "AUBURN-GRESHAM FAMILY HEALTH CENTER" ...
#>  $ inc_date  : Date[1:10], format: "1988-01-14" "1975-08-05" ...
#>  $ inc_state : chr [1:10] "FL" "NY" "FL" "IL" ...
#>  $ org_type  : chr [1:10] "CORPORATION" "CORPORATION" "CORPORATION" "CORPORATION" ...
#>  $ org_otxt  : chr [1:10] NA NA NA NA ...
#>  $ status    : chr [1:10] "N" "N" "N" "N" ...
#>  $ city      : chr [1:10] "TRENTON" "POUGHKEEPSIE" "BELL" "CHICAGO" ...
#>  $ state     : chr [1:10] "FL" "NY" "FL" "IL" ...
#>  $ zip       : chr [1:10] "326933239" "126012303" "326194713" "606204625" ...
#>  $ phone     : chr [1:10] "3524632374" "8457907990" "3524631100" "7738741400" ...
#>  $ address   : chr [1:10] "911 S MAIN ST" "75 WASHINGTON ST" "1830 N MAIN ST" "8234 S ASHLAND AVE" ...
```
