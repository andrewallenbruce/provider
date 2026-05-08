# Skilled Nursing Facilities

Providers with pending Medicare enrollment applications.

## Usage

``` r
snf_enroll(
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
snf_enroll(count = TRUE)
#> snf_enroll Totals
#> • Rows  : 14,426
#> • Pages : 3     
#> 

snf_enroll() |> str()
#> snf_enroll Totals
#> • Rows  : 14,426
#> • Pages : 3     
#> 
#> ! No Query ❯ Returning first 10 rows.
#> 
#> tibble [10 × 16] (S3: tbl_df/tbl/data.frame)
#>  $ enid    : chr [1:10] "O20020801000000" "O20020805000004" "O20020814000007" "O20020814000013" ...
#>  $ npi     : int [1:10] 1346210291 1912906694 1104838606 1477576346 1760479851 1750339438 1609864354 1265502405 1851362511 1427019413
#>  $ multi   : int [1:10] 0 0 0 0 0 0 0 0 0 0
#>  $ ccn     : chr [1:10] "345500" "375417" "445316" "445463" ...
#>  $ pac     : chr [1:10] "6103733167" "6901713973" "7012824014" "2466369467" ...
#>  $ org_name: chr [1:10] "WINDSOR POINT INC." "N&R OF WESTHAVEN L L C" "HILLCREST HEALTHCARE, LLC" "BELLS NURSING HOME INC" ...
#>  $ org_dba : chr [1:10] "WINDSOR POINT INC CCRC" "WESTHAVEN NURSING HOME" "HILLCREST HEALTHCARE" "BELLS NURSING AND REHABILITATION CENTER" ...
#>  $ inc_date: Date[1:10], format: "1995-07-07" NA ...
#>  $ org_type: chr [1:10] "CORPORATION" "LLC" "LLC" "CORPORATION" ...
#>  $ status  : chr [1:10] "P" "P" "P" "P" ...
#>  $ nhp_name: chr [1:10] "WINDSOR POINT CONTINUING CARE" "WESTHAVEN NURSING HOME" "HILLCREST HEALTHCARE CENTER" "BELLS NURSING AND REHABILITATION CENTER" ...
#>  $ aff_name: chr [1:10] NA NA NA NA ...
#>  $ address : chr [1:10] "1221 BROAD STREET" "WESTERN NURSING HOME" "111  PEMBERTON                     DR" "213 HERNDON DR" ...
#>  $ city    : chr [1:10] "FUQUAY-VARINA" "STILLWATER" "ASHLAND CITY" "BELLS" ...
#>  $ state   : chr [1:10] "NC" "OK" "TN" "TN" ...
#>  $ zip     : chr [1:10] "275263602" "740745151" "370151353" "380063654" ...
```
