# Rural Health Clinic Owners

Providers with pending Medicare enrollment applications.

## Usage

``` r
rhc_owner(
  org_enid = NULL,
  org_pac = NULL,
  org_name = NULL,
  own_pac = NULL,
  own_org = NULL,
  own_dba = NULL,
  own_pct = NULL,
  own_role = NULL,
  entity = NULL,
  first = NULL,
  middle = NULL,
  last = NULL,
  title = NULL,
  address = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  count = FALSE,
  set = FALSE
)
```

## Arguments

- org_enid:

  `<chr>` National Provider Identifier

- org_pac:

  `<chr>` Provider's name

- org_name:

  `<chr>` Provider's name

- own_pac:

  `<chr>` Provider's name

- own_org:

  `<chr>` Provider's name

- own_dba:

  `<chr>` Provider's name

- own_pct:

  `<chr>` Provider's name

- own_role:

  `<chr>` Provider's name

- entity:

  `<chr>` Provider's name

- first, middle, last:

  `<chr>` Provider's name

- title:

  `<chr>` Provider's name

- address, city, state, zip:

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
#> rhc_owner Totals
#> • Rows  : 65,551
#> • Pages : 14    
#> 

rhc_owner(state = c("GA", "FL")) |> str()
#> ✔ rhc_owner returned 136 results.
#> tibble [136 × 20] (S3: tbl_df/tbl/data.frame)
#>  $ enid    : chr [1:136] "O20030724000023" "O20031013000024" "O20040217000406" "O20040712000362" ...
#>  $ pac     : chr [1:136] "7214848027" "3476462078" "6204721566" "8426036930" ...
#>  $ org_name: chr [1:136] "TRI-COUNTY PRIMARY CARE INC" "ACV COMMUNITY SERVICES LLC" "LONDON WOMEN'S CARE LLC" "ACUTE CARE PEDIATRICS,PA" ...
#>  $ own_pac : chr [1:136] "5496911505" "3476462078" "8224385521" "8729997929" ...
#>  $ own_role: chr [1:136] "5% OR GREATER DIRECT OWNERSHIP INTEREST" "5% OR GREATER DIRECT OWNERSHIP INTEREST" "OPERATIONAL/MANAGERIAL CONTROL" "5% OR GREATER DIRECT OWNERSHIP INTEREST" ...
#>  $ own_date: Date[1:136], format: "2021-06-26" "2003-11-01" ...
#>  $ own_org : chr [1:136] "GNT ASSOCIATES LLC" "ACV COMMUNITY SERVICES LLC" "PHYSICIAN BUSINESS SERVICES, LLC" "NORTH FLORIDA PEDIATRICS, PA" ...
#>  $ own_dba : chr [1:136] NA "ADVENTR CHRISTIAN VILLAGE HOME CARE AGENCY" NA NA ...
#>  $ own_pct : num [1:136] 100 NA 100 NA 100 100 100 6.49 6.49 6.49 ...
#>  $ entity  : chr [1:136] "O" "O" "O" "O" ...
#>  $ title   : chr [1:136] NA NA NA NA ...
#>  $ first   : chr [1:136] NA NA NA NA ...
#>  $ middle  : chr [1:136] NA NA NA NA ...
#>  $ last    : chr [1:136] NA NA NA NA ...
#>  $ add_1   : chr [1:136] "13603 NW 30TH RD" "10820 MARVIN E JONES BLVD" "5002 W LEMON ST" "1859 SW NEWLAND WAY" ...
#>  $ city    : chr [1:136] "GAINESVILLE" "LIVE OAK" "TAMPA" "LAKE CITY" ...
#>  $ state   : chr [1:136] "FL" "FL" "FL" "FL" ...
#>  $ zip     : chr [1:136] "326069331" "320608243" "336091104" "320256966" ...
#>  $ oth_txt : chr [1:136] "FILLING AS S-CORP" NA NA NA ...
#>  $ own_ind : chr [1:136] "LLC, Other" "LLC" "LLC, For-Profit" "Corporation, For-Profit, Owned by Another Org/Ind" ...
```
