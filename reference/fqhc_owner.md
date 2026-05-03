# FQHC Owners

Providers with pending Medicare enrollment applications.

## Usage

``` r
fqhc_owner(
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
fqhc_owner(count = TRUE)
#> ═ fqhc_owner Totals
#> • Rows  : 148,919
#> • Pages : 30     
#> 

fqhc_owner() |> str()
#> ═ fqhc_owner Totals
#> • Rows  : 148,919
#> • Pages : 30     
#> 
#> ! No Query ❯ Returning first 10 rows...
#> 
#> tibble [10 × 37] (S3: tbl_df/tbl/data.frame)
#>  $ enid      : chr [1:10] "O20020819000009" "O20020819000009" "O20020819000009" "O20020819000009" ...
#>  $ pac       : chr [1:10] "2365359387" "2365359387" "2365359387" "2365359387" ...
#>  $ org_name  : chr [1:10] "TRENTON MEDICAL CENTER INC" "TRENTON MEDICAL CENTER INC" "TRENTON MEDICAL CENTER INC" "TRENTON MEDICAL CENTER INC" ...
#>  $ own_pac   : chr [1:10] "0547500936" "1153649553" "1254787765" "1557445707" ...
#>  $ own_type  : chr [1:10] "I" "I" "I" "I" ...
#>  $ own_code  : int [1:10] 41 44 41 41 40 42 44 44 41 41
#>  $ own_role  : chr [1:10] "CORPORATE DIRECTOR" "OTHER" "CORPORATE DIRECTOR" "CORPORATE DIRECTOR" ...
#>  $ own_date  : Date[1:10], format: "2018-09-20" "2022-01-01" ...
#>  $ own_first : chr [1:10] "STEPHEN" "SARAH" "ANDREW" "GAIL" ...
#>  $ own_middle: chr [1:10] NA NA NA "M" ...
#>  $ own_last  : chr [1:10] "ELDER" "CATALANOTTA" "JONES" "OSTEEN" ...
#>  $ own_title : chr [1:10] NA NA "CFO" "BOARD MEMBER" ...
#>  $ own_org   : chr [1:10] NA NA NA NA ...
#>  $ own_dba   : chr [1:10] NA NA NA NA ...
#>  $ own_city  : chr [1:10] NA NA NA NA ...
#>  $ own_state : chr [1:10] NA NA NA NA ...
#>  $ own_zip   : chr [1:10] NA NA NA NA ...
#>  $ own_pct   : num [1:10] NA NA NA NA 100 100 NA NA NA NA
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
