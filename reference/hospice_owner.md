# Hospice Owners

Providers with pending Medicare enrollment applications.

## Usage

``` r
hospice_owner(
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
hospice_owner(count = TRUE)
#> ═ hospice_owner Totals
#> • Rows  : 71,133
#> • Pages : 15    
#> 

hospice_owner(own_state = c("GA", "FL")) |> str()
#> ✔ hospice_owner returned 1,961 results.
#> tibble [1,961 × 21] (S3: tbl_df/tbl/data.frame)
#>  $ enid      : chr [1:1961] "O20030115000001" "O20030430000023" "O20030430000023" "O20030829000035" ...
#>  $ pac       : chr [1:1961] "4486562394" "4486562394" "4486562394" "0941110886" ...
#>  $ org_name  : chr [1:1961] "CAPITAL HOSPICE" "CAPITAL HOSPICE" "CAPITAL HOSPICE" "PORTERCARE ADVENTIST HEALTH SYSTEM" ...
#>  $ own_pac   : chr [1:1961] "2567436199" "1254728306" "2567436199" "5597676429" ...
#>  $ own_type  : chr [1:1961] "O" "O" "O" "O" ...
#>  $ own_code  : int [1:1961] 43 43 43 34 43 43 34 34 34 35 ...
#>  $ own_role  : chr [1:1961] "OPERATIONAL/MANAGERIAL CONTROL" "OPERATIONAL/MANAGERIAL CONTROL" "OPERATIONAL/MANAGERIAL CONTROL" "5% OR GREATER DIRECT OWNERSHIP INTEREST" ...
#>  $ own_date  : Date[1:1961], format: "2023-05-01" "2004-08-26" ...
#>  $ own_first : chr [1:1961] NA NA NA NA ...
#>  $ own_middle: chr [1:1961] NA NA NA NA ...
#>  $ own_last  : chr [1:1961] NA NA NA NA ...
#>  $ own_title : chr [1:1961] NA NA NA NA ...
#>  $ own_org   : chr [1:1961] "CHAPTERS HEALTH SYSTEM INC" "CAPITAL CARING HEATLH INC" "CHAPTERS HEALTH SYSTEM INC" "ADVENTIST HEALTH SYSTEM SUNBELT HEALTHCARE CORPORATION" ...
#>  $ own_dba   : chr [1:1961] "CHAPTERS HEALTH SYSTEM" "CAPITAL CARING HEALTH" "CHAPTERS HEALTH SYSTEM" "SUNBELT HEALTH CARE AND SUBACUTE CENTER APOPKA" ...
#>  $ own_city  : chr [1:1961] "TEMPLE TERRACE" "TEMPLE TERRACE" "TEMPLE TERRACE" "ALTAMONTE SPRINGS" ...
#>  $ own_state : chr [1:1961] "FL" "FL" "FL" "FL" ...
#>  $ own_zip   : chr [1:1961] "336370904" "336370904" "336370904" "327141502" ...
#>  $ own_pct   : num [1:1961] 100 100 100 100 NA NA 100 100 100 100 ...
#>  $ oth_txt   : chr [1:1961] NA NA NA NA ...
#>  $ own_add   : chr [1:1961] "12470 TELECOM DR, STE 301" "12470 TELECOM DR, STE 301" "12470 TELECOM DR, STE 301" "900 HOPE WAY" ...
#>  $ var       : chr [1:1961] "Corporation" "Non Profit" "Corporation" "Corporation" ...
```
