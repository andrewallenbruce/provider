# Facility Enrollment

Providers with pending Medicare enrollment applications.

## Usage

``` r
fqhc_enroll(
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
  count = FALSE,
  set = FALSE
)

hospice_enroll(
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
  count = FALSE,
  set = FALSE
)

rhc_enroll(
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
  count = FALSE,
  set = FALSE
)

snf_enroll(
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

- enid:

  `<chr>` Medicare Enrollment ID

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
#> fqhc_enroll Totals
#> • Rows  : 11,063
#> • Pages : 3     
#> 
hospice_enroll(count = TRUE)
#> hospice_enroll Totals
#> • Rows  : 6,066
#> • Pages : 2    
#> 
rhc_enroll(count = TRUE)
#> rhc_enroll Totals
#> • Rows  : 5,530
#> • Pages : 2    
#> 
snf_enroll(count = TRUE)
#> snf_enroll Totals
#> • Rows  : 14,426
#> • Pages : 3     
#> 

fqhc_enroll(state = c("GA", "FL")) |> str()
#> ✔ fqhc_enroll returned 768 results.
#> Error in ckmatch(cols, nam): Unknown columns: nhp_name, aff_name

hospice_enroll(state = c("GA", "FL")) |> str()
#> ✔ hospice_enroll returned 312 results.
#> Error in ckmatch(cols, nam): Unknown columns: nhp_name, aff_name

rhc_enroll(state = c("GA", "FL")) |> str()
#> ✔ rhc_enroll returned 220 results.
#> Error in ckmatch(cols, nam): Unknown columns: nhp_name, aff_name

snf_enroll(state = c("GA", "FL")) |> str()
#> ✔ snf_enroll returned 1,044 results.
#> snf_nrll [1,044 × 16] (S3: snf_enroll/tbl_df/tbl/data.frame)
#>  $ enid    : chr [1:1044] "O20020829000002" "O20020910000037" "O20020912000012" "O20020916000022" ...
#>  $ npi     : int [1:1044] 1265427934 1558308692 1235171174 1043252083 1952485989 1871519736 1235249368 1881628105 1962459487 1073677167 ...
#>  $ multi   : int [1:1044] 0 0 0 0 0 0 0 0 0 0 ...
#>  $ ccn     : chr [1:1044] "105319C" "115387" "115507" "115382" ...
#>  $ pac     : chr [1:1044] "5092622951" "6709793615" "3870400690" "0749197580" ...
#>  $ org_name: chr [1:1044] "SUN CITY CENTER ASSOCIATES LTD LP" "TOOMBS NURSING HOME LLC" "TAYLOR COUNTY HEALTH CARE LLC" "SPARTA HEALTH CARE LLC" ...
#>  $ org_dba : chr [1:1044] "SUN TERRACE HEALTH CARE CENTER" "OXLEY PARK HEALTH AND REHABILITATION" "TAYLOR COUNTY HEALTH AND REHABILITATION" "SPARTA HEALTH AND REHABILITATION" ...
#>  $ inc_date: Date[1:1044], format: "1963-01-12" "2002-07-01" ...
#>  $ org_type: chr [1:1044] "OTHER: LIMITED PARTNERSHIP" "LLC" "LLC" "LLC" ...
#>  $ status  : chr [1:1044] "P" "N" "N" "N" ...
#>  $ nhp_name: chr [1:1044] "SUN TERRACE HEALTH CARE CENTER" "OXLEY PARK HEALTH AND REHABILITATION" "TAYLOR COUNTY HEALTH AND REHABILITATION" "SPARTA HEALTH AND REHABILITATION" ...
#>  $ aff_name: chr [1:1044] "CLEAR CHOICE HEALTHCARE" "ETHICA HEALTH" "ETHICA HEALTH" "ETHICA HEALTH" ...
#>  $ address : chr [1:1044] "105 TRINITY LAKES DR" "181 OXLEY DR" "165 S BROAD ST" "11744 GA HIGHWAY 22" ...
#>  $ city    : chr [1:1044] "SUN CITY CENTER" "LYONS" "BUTLER" "SPARTA" ...
#>  $ state   : chr [1:1044] "FL" "GA" "GA" "GA" ...
#>  $ zip     : chr [1:1044] "335735728" "304365644" "310065526" "310871475" ...
```
