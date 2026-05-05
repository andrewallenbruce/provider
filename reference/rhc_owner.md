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

rhc_owner(own_state = c("GA", "FL")) |> str()
#> ✔ rhc_owner returned 136 results.
#> tibble [136 × 21] (S3: tbl_df/tbl/data.frame)
#>  $ enid      : chr [1:136] "O20030724000023" "O20031013000024" "O20040217000406" "O20040712000362" ...
#>  $ pac       : chr [1:136] "7214848027" "3476462078" "6204721566" "8426036930" ...
#>  $ org_name  : chr [1:136] "TRI-COUNTY PRIMARY CARE INC" "ACV COMMUNITY SERVICES LLC" "LONDON WOMEN'S CARE LLC" "ACUTE CARE PEDIATRICS,PA" ...
#>  $ own_pac   : chr [1:136] "5496911505" "3476462078" "8224385521" "8729997929" ...
#>  $ own_type  : chr [1:136] "O" "O" "O" "O" ...
#>  $ own_code  : int [1:136] 34 34 43 34 34 34 34 35 35 35 ...
#>  $ own_role  : chr [1:136] "5% OR GREATER DIRECT OWNERSHIP INTEREST" "5% OR GREATER DIRECT OWNERSHIP INTEREST" "OPERATIONAL/MANAGERIAL CONTROL" "5% OR GREATER DIRECT OWNERSHIP INTEREST" ...
#>  $ own_date  : Date[1:136], format: "2021-06-26" "2003-11-01" ...
#>  $ own_first : chr [1:136] NA NA NA NA ...
#>  $ own_middle: chr [1:136] NA NA NA NA ...
#>  $ own_last  : chr [1:136] NA NA NA NA ...
#>  $ own_title : chr [1:136] NA NA NA NA ...
#>  $ own_org   : chr [1:136] "GNT ASSOCIATES LLC" "ACV COMMUNITY SERVICES LLC" "PHYSICIAN BUSINESS SERVICES, LLC" "NORTH FLORIDA PEDIATRICS, PA" ...
#>  $ own_dba   : chr [1:136] NA "ADVENTR CHRISTIAN VILLAGE HOME CARE AGENCY" NA NA ...
#>  $ own_city  : chr [1:136] "GAINESVILLE" "LIVE OAK" "TAMPA" "LAKE CITY" ...
#>  $ own_state : chr [1:136] "FL" "FL" "FL" "FL" ...
#>  $ own_zip   : chr [1:136] "326069331" "320608243" "336091104" "320256966" ...
#>  $ own_pct   : num [1:136] 100 NA 100 NA 100 100 100 6.49 6.49 6.49 ...
#>  $ oth_txt   : chr [1:136] "FILLING AS S-CORP" NA NA NA ...
#>  $ own_add   : chr [1:136] "13603 NW 30TH RD" "10820 MARVIN E JONES BLVD" "5002 W LEMON ST" "1859 SW NEWLAND WAY" ...
#>  $ own_ind   : chr [1:136] "LLC, Other" "LLC" "LLC, For-Profit" "Corporation, For-Profit, Owned by Another Org/Ind" ...
```
