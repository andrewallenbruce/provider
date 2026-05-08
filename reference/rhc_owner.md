# Rural Health Clinic Owners

Providers with pending Medicare enrollment applications.

## Usage

``` r
rhc_owner(
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
rhc_owner(count = TRUE)
#> rhc_owner Totals
#> • Rows  : 65,551
#> • Pages : 14    
#> 

rhc_owner(state = c("GA", "FL"))
#> ✔ rhc_owner returned 136 results.
#> # A tibble: 136 × 20
#>    org_enid   org_pac org_name pac   role  asc_date   owner dba   percent entity
#>  * <chr>      <chr>   <chr>    <chr> <chr> <date>     <chr> <chr>   <dbl> <chr> 
#>  1 O20030724… 721484… TRI-COU… 5496… 5% O… 2021-06-26 GNT … NA     100    O     
#>  2 O20031013… 347646… ACV COM… 3476… 5% O… 2003-11-01 ACV … ADVE…   NA    O     
#>  3 O20040217… 620472… LONDON … 8224… OPER… 2020-12-31 PHYS… NA     100    O     
#>  4 O20040712… 842603… ACUTE C… 8729… 5% O… 2024-05-01 NORT… NA      NA    O     
#>  5 O20061202… 953716… HEARTLA… 7618… 5% O… 2014-01-01 CENT… NA     100    O     
#>  6 O20070507… 468877… HEARTLA… 7618… 5% O… 2014-01-01 CENT… NA     100    O     
#>  7 O20071016… 549684… ACUTE C… 8729… 5% O… 2024-05-01 NORT… NA     100    O     
#>  8 O20080915… 620490… TATTNAL… 9638… 5% O… 2018-07-20 AURO… NA       6.49 O     
#>  9 O20080915… 620490… TATTNAL… 2860… 5% O… 2018-07-20 AURO… NA       6.49 O     
#> 10 O20090621… 620490… TATTNAL… 2860… 5% O… 2018-07-20 AURO… NA       6.49 O     
#> # ℹ 126 more rows
#> # ℹ 10 more variables: title <chr>, first <chr>, middle <chr>, last <chr>,
#> #   address <chr>, city <chr>, state <chr>, zip <chr>, oth_txt <chr>,
#> #   owner_type <chr>
```
