# Hospital Owners

Providers with pending Medicare enrollment applications.

## Usage

``` r
hospital_owner(
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
hospital_owner(count = TRUE)
#> hospital_owner Totals
#> • Rows  : 23,028
#> • Pages : 5     
#> 

hospital_owner(own_state = c("GA", "FL")) |> str()
#> ✔ hospital_owner returned 137 results.
#> tibble [137 × 21] (S3: tbl_df/tbl/data.frame)
#>  $ enid      : chr [1:137] "O20040709000649" "O20040709000649" "O20040709000649" "O20040709000649" ...
#>  $ pac       : chr [1:137] "9537147244" "9537147244" "9537147244" "9537147244" ...
#>  $ org_name  : chr [1:137] "PROMISE HOSPITAL OF EAST LOS ANGELES LP" "PROMISE HOSPITAL OF EAST LOS ANGELES LP" "PROMISE HOSPITAL OF EAST LOS ANGELES LP" "PROMISE HOSPITAL OF EAST LOS ANGELES LP" ...
#>  $ own_pac   : chr [1:137] "1759514318" "2860470572" "3577796143" "3971415928" ...
#>  $ own_type  : chr [1:137] "O" "O" "O" "O" ...
#>  $ own_code  : int [1:137] 35 34 35 35 43 34 44 34 35 43 ...
#>  $ own_role  : chr [1:137] "5% OR GREATER INDIRECT OWNERSHIP INTEREST" "5% OR GREATER DIRECT OWNERSHIP INTEREST" "5% OR GREATER INDIRECT OWNERSHIP INTEREST" "5% OR GREATER INDIRECT OWNERSHIP INTEREST" ...
#>  $ own_date  : Date[1:137], format: "2014-03-17" "2003-11-04" ...
#>  $ own_first : chr [1:137] NA NA NA NA ...
#>  $ own_middle: chr [1:137] NA NA NA NA ...
#>  $ own_last  : chr [1:137] NA NA NA NA ...
#>  $ own_title : chr [1:137] NA NA NA NA ...
#>  $ own_org   : chr [1:137] "PROMISE HEALTHCARE HOLDINGS, INC." "PROMISE HEALTHCARE OF CALIFORNIA, INC." "PROMISE HEALTHCARE GROUP, LLC" "PROMISE HEALTHCARE, INC" ...
#>  $ own_dba   : chr [1:137] NA NA NA "PROMISE HEALTHCARE" ...
#>  $ own_city  : chr [1:137] "BOCA RATON" "BOCA RATON" "BOCA RATON" "BOCA RATON" ...
#>  $ own_state : chr [1:137] "FL" "FL" "FL" "FL" ...
#>  $ own_zip   : chr [1:137] "334314477" "334314477" "334314477" "334314477" ...
#>  $ own_pct   : num [1:137] 96 50 96 100 100 50 100 100 99 NA ...
#>  $ oth_txt   : chr [1:137] NA NA NA NA ...
#>  $ own_add   : chr [1:137] "999 YAMATO RD, FL 3" "999 YAMATO RD, FL 3" "999 YAMATO RD, FL 3" "999 YAMATO ROAD, THIRD FLOOR" ...
#>  $ own_ind   : chr [1:137] "Corporation" "Created for Aquisition, Corporation" "LLC" "Corporation, For-Profit" ...
```
