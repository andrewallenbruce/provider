# Rural Health Clinics

Providers with pending Medicare enrollment applications.

## Usage

``` r
rhc_enroll(
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

- count:

  `<lgl>` Return the total row count

- set:

  `<lgl>` Return the entire dataset

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)

## Examples

``` r
rhc_enroll(count = TRUE)
#> ℹ rhc_enroll has 5,530 rows.

rhc_enroll() |> str()
#> ! rhc_enroll ❯ No Query
#> ℹ Returning first 10 rows...
#> tibble [10 × 18] (S3: tbl_df/tbl/data.frame)
#>  $ enid      : chr [1:10] "O20020813000023" "O20020813000025" "O20020814000001" "O20020814000004" ...
#>  $ enid_state: chr [1:10] "ND" "ND" "SD" "ND" ...
#>  $ npi       : int [1:10] 1497856025 1760570394 1801987904 1831286160 1558389338 1801811666 1669491262 1144207671 1295818524 1669560199
#>  $ multi     : int [1:10] 0 0 0 0 0 0 0 0 0 0
#>  $ ccn       : chr [1:10] "353982" "353983" "433987" "353981" ...
#>  $ pac       : chr [1:10] "0042127045" "0042127045" "0042127045" "0042127045" ...
#>  $ org_name  : chr [1:10] "WEST RIVER HEALTH SERVICES" "WEST RIVER HEALTH SERVICES" "WEST RIVER HEALTH SERVICES" "WEST RIVER HEALTH SERVICES" ...
#>  $ org_dba   : chr [1:10] "BOWMAN CLINIC" "WEST RIVER HEALTH CLINIC - SCRANTON" NA "NEW ENGLAND CLINIC" ...
#>  $ inc_date  : Date[1:10], format: "1977-01-06" NA ...
#>  $ inc_state : chr [1:10] "ND" NA "ND" "ND" ...
#>  $ org_type  : chr [1:10] "CORPORATION" "CORPORATION" "CORPORATION" "CORPORATION" ...
#>  $ org_otxt  : chr [1:10] NA NA NA NA ...
#>  $ status    : chr [1:10] "N" "N" "N" "N" ...
#>  $ city      : chr [1:10] "BOWMAN" "SCRANTON" "LEMMON" "NEW ENGLAND" ...
#>  $ state     : chr [1:10] "ND" "ND" "SD" "ND" ...
#>  $ zip       : chr [1:10] "586234507" "58653" "576381420" "586477017" ...
#>  $ phone     : chr [1:10] "7015233271" "7012756336" "6053743773" "7015794507" ...
#>  $ address   : chr [1:10] "608 HIGHWAY 12 WEST" "211 S MAIN ST" "411 MAIN AVE" "820 2ND AVE W" ...
```
