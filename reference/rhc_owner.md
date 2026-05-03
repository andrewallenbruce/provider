# Rural Health Clinic Owners

Providers with pending Medicare enrollment applications.

## Usage

``` r
rhc_owner(
  enid = NULL,
  pac = NULL,
  org_name = NULL,
  own_pac = NULL,
  own_type = NULL,
  own_role = NULL,
  own_first = NULL,
  own_middle = NULL,
  own_last = NULL,
  own_title = NULL,
  own_org = NULL,
  own_dba = NULL,
  own_address = NULL,
  own_city = NULL,
  own_state = NULL,
  own_zip = NULL,
  own_pct = NULL,
  count = FALSE,
  set = FALSE
)
```

## Arguments

- enid:

  `<chr>` National Provider Identifier

- pac:

  `<chr>` Provider's name

- org_name:

  `<chr>` Provider's name

- own_pac:

  `<chr>` Provider's name

- own_type:

  `<chr>` Provider's name

- own_role:

  `<chr>` Provider's name

- own_first:

  `<chr>` Provider's name

- own_middle:

  `<chr>` Provider's name

- own_last:

  `<chr>` Provider's name

- own_title:

  `<chr>` Provider's name

- own_org:

  `<chr>` Provider's name

- own_dba:

  `<chr>` Provider's name

- own_address:

  `<chr>` Provider's name

- own_city:

  `<chr>` Provider's name

- own_state:

  `<chr>` Provider's name

- own_zip:

  `<chr>` Provider's name

- own_pct:

  `<chr>` Provider's name

- count:

  `<lgl>` Return the total row count

- set:

  `<lgl>` Return the entire dataset

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)

## Examples

``` r
rhc_owner(count = TRUE)
#> ═ rhc_owner Totals
#> • Rows  : 65,551
#> • Pages : 14    
#> 

rhc_owner() |> str()
#> ═ rhc_owner Totals
#> • Rows  : 65,551
#> • Pages : 14    
#> 
#> ! No Query ❯ Returning first 10 rows...
#> 
#> tibble [10 × 37] (S3: tbl_df/tbl/data.frame)
#>  $ enid      : chr [1:10] "O20020813000023" "O20020813000023" "O20020813000023" "O20020813000023" ...
#>  $ pac       : chr [1:10] "0042127045" "0042127045" "0042127045" "0042127045" ...
#>  $ org_name  : chr [1:10] "WEST RIVER HEALTH SERVICES" "WEST RIVER HEALTH SERVICES" "WEST RIVER HEALTH SERVICES" "WEST RIVER HEALTH SERVICES" ...
#>  $ own_pac   : chr [1:10] "3072814896" "3072814896" "6305216268" "6305216268" ...
#>  $ own_type  : chr [1:10] "I" "I" "I" "I" ...
#>  $ own_code  : int [1:10] 40 42 40 42 41 41 40 40 42 40
#>  $ own_role  : chr [1:10] "CORPORATE OFFICER" "W-2 MANAGING EMPLOYEE" "CORPORATE OFFICER" "W-2 MANAGING EMPLOYEE" ...
#>  $ own_date  : Date[1:10], format: "2025-11-03" "2025-11-03" ...
#>  $ own_first : chr [1:10] "KURT" "KURT" "ALYSON" "ALYSON" ...
#>  $ own_middle: chr [1:10] NA NA NA NA ...
#>  $ own_last  : chr [1:10] "SARGENT" "SARGENT" "FREELAND" "FREELAND" ...
#>  $ own_title : chr [1:10] "CHIEF FINANCIAL OFFICER" "CHIEF FINANCIAL OFFICER" "CHIEF EXECUTIVE OFFICER" "AD;" ...
#>  $ own_org   : chr [1:10] NA NA NA NA ...
#>  $ own_dba   : chr [1:10] NA NA NA NA ...
#>  $ own_city  : chr [1:10] NA NA NA NA ...
#>  $ own_state : chr [1:10] NA NA NA NA ...
#>  $ own_zip   : chr [1:10] NA NA NA NA ...
#>  $ own_pct   : num [1:10] 0 0 0 0 NA NA NA 0 0 0
#>  $ acq_ind   : int [1:10] NA NA NA NA NA NA NA NA NA NA
#>  $ corp_ind  : int [1:10] NA NA NA NA NA NA NA NA NA NA
#>  $ llc_ind   : int [1:10] NA NA NA NA NA NA NA NA NA NA
#>  $ mps_ind   : int [1:10] NA NA NA NA NA NA NA NA NA NA
#>  $ msr_ind   : int [1:10] NA NA NA NA NA NA NA NA NA NA
#>  $ mst_ind   : int [1:10] NA NA NA NA NA NA NA NA NA NA
#>  $ hld_ind   : int [1:10] NA NA NA NA NA NA NA NA NA NA
#>  $ inv_ind   : int [1:10] NA NA NA NA NA NA NA NA NA NA
#>  $ fin_ind   : int [1:10] NA NA NA NA NA NA NA NA NA NA
#>  $ con_ind   : int [1:10] NA NA NA NA NA NA NA NA NA NA
#>  $ fp_ind    : int [1:10] NA NA NA NA NA NA NA NA NA NA
#>  $ np_ind    : int [1:10] NA NA NA NA NA NA NA NA NA NA
#>  $ pe_ind    : int [1:10] NA NA NA NA NA NA NA NA NA NA
#>  $ reit_ind  : int [1:10] NA NA NA NA NA NA NA NA NA NA
#>  $ cho_ind   : int [1:10] NA NA NA NA NA NA NA NA NA NA
#>  $ oth_ind   : int [1:10] NA NA NA NA NA NA NA NA NA NA
#>  $ oth_txt   : chr [1:10] NA NA NA NA ...
#>  $ ano_ind   : int [1:10] NA NA NA NA NA NA NA NA NA NA
#>  $ own_add   : chr [1:10] NA NA NA NA ...
```
