# Hospital Owners

Providers with pending Medicare enrollment applications.

## Usage

``` r
hospital_owner(
  org_enid = NULL,
  org_pac = NULL,
  org_name = NULL,
  pac = NULL,
  owner = NULL,
  dba = NULL,
  percent = NULL,
  role = NULL,
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

- pac:

  `<chr>` Provider's name

- owner:

  `<chr>` Provider's name

- dba:

  `<chr>` Provider's name

- percent:

  `<chr>` Provider's name

- role:

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
hospital_owner(count = TRUE)
#> hospital_owner Totals
#> • Rows  : 23,028
#> • Pages : 5     
#> 

hospital_owner(state = c("GA", "FL"))
#> ✔ hospital_owner returned 137 results.
#> # A tibble: 137 × 19
#>    org_enid    org_pac org_name pac   entity role  asc_date   first middle last 
#>    <chr>       <chr>   <chr>    <chr> <chr>  <chr> <date>     <chr> <chr>  <chr>
#>  1 O201101120… 761816… MHA LLC  0143… O      5% O… 2010-12-07 NA    NA     NA   
#>  2 O201607150… 630513… SELECT … 0143… O      5% O… 2023-01-01 NA    NA     NA   
#>  3 O201711140… 539500… NAVICEN… 0345… O      5% O… 2017-11-02 NA    NA     NA   
#>  4 O202201260… 135574… NAVICEN… 0345… O      5% O… 2017-10-01 NA    NA     NA   
#>  5 O201701310… 892138… LIFEBRI… 0345… O      5% O… 2016-10-12 NA    NA     NA   
#>  6 O201701310… 892138… LIFEBRI… 0345… O      OPER… 2016-10-12 NA    NA     NA   
#>  7 O201701310… 892138… LIFEBRI… 0345… O      5% O… 2017-01-30 NA    NA     NA   
#>  8 O202409100… 155780… BRADLEY… 0446… O      5% O… 2024-08-01 NA    NA     NA   
#>  9 O202011170… 660828… OHI WES… 0547… O      5% O… 2020-10-01 NA    NA     NA   
#> 10 O202011170… 660828… OHI WES… 0547… O      OTHER 2020-10-01 NA    NA     NA   
#> # ℹ 127 more rows
#> # ℹ 9 more variables: title <chr>, owner_name <chr>, owner_dba <chr>,
#> #   address <chr>, city <chr>, state <chr>, zip <chr>, percent <dbl>,
#> #   owner_type <chr>
```
