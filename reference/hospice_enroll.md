# Hospice Facilities

Providers with pending Medicare enrollment applications.

## Usage

``` r
hospice_enroll(
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
hospice_enroll(count = TRUE)
#> ═ hospice_enroll Totals
#> • Rows  : 6,066
#> • Pages : 2    
#> 

hospice_enroll() |> str()
#> ═ hospice_enroll Totals
#> • Rows  : 6,066
#> • Pages : 2    
#> 
#> ! No Query ❯ Returning first 10 rows...
#> 
#> tibble [10 × 17] (S3: tbl_df/tbl/data.frame)
#>  $ enid      : chr [1:10] "O20020813000008" "O20020813000010" "O20020820000009" "O20020823000006" ...
#>  $ enid_state: chr [1:10] "KS" "PA" "PA" "OR" ...
#>  $ npi       : int [1:10] 1144260498 1053393447 1548201957 1841221306 1215084876 1366449951 1265433247 1417068461 1881764736 1629025911
#>  $ multi     : int [1:10] 0 0 0 0 0 0 0 0 0 0
#>  $ ccn       : chr [1:10] "171523" "391518" "391551" "381546" ...
#>  $ pac       : chr [1:10] "3274440268" "3476461872" "4789591710" "2365359296" ...
#>  $ org_name  : chr [1:10] "HOSPITAL DISTRICT NO 1 OF DICKINSON COUNTY KANSAS" "CENTRE HOMECARE, INC." "GENERAL CARE SERVICES INC" "MORROW COUNTY HEALTH DISTRICT" ...
#>  $ org_dba   : chr [1:10] "HOSPICE OF DICKINSON COUNTY" "CENTRE CROSSINGS HOSPICE" "HOSPICE OF WARREN COUNTY" "PIONEER MEMORIAL HOSPICE" ...
#>  $ inc_date  : Date[1:10], format: "1959-12-07" "1965-02-01" ...
#>  $ inc_state : chr [1:10] "KS" "PA" "PA" "OR" ...
#>  $ org_type  : chr [1:10] "OTHER" "CORPORATION" "CORPORATION" "OTHER" ...
#>  $ org_otxt  : chr [1:10] "GOVERNMENTAL" NA NA "DISTRICT" ...
#>  $ status    : chr [1:10] "N" "N" "N" "N" ...
#>  $ city      : chr [1:10] "ABILENE" "STATE COLLEGE" "WARREN" "HEPPNER" ...
#>  $ state     : chr [1:10] "KS" "PA" "PA" "OR" ...
#>  $ zip       : chr [1:10] "674101804" "168017454" "163652116" "978365001" ...
#>  $ address   : chr [1:10] "1111 N BRADY ST, STE B" "2437 COMMERCIAL BLVD, STE 280" "1 MAIN AVE" "162 N MAIN ST" ...
```
