# FQHC Owners

Providers with pending Medicare enrollment applications.

## Usage

``` r
fqhc_owner(
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
fqhc_owner(count = TRUE)
#> fqhc_owner Totals
#> • Rows  : 148,919
#> • Pages : 30     
#> 

fqhc_owner(state = c("GA", "FL"))
#> ✔ fqhc_owner returned 254 results.
#> # A tibble: 254 × 19
#>    org_enid   org_pac org_name pac   role  asc_date   owner dba   percent entity
#>    <chr>      <chr>   <chr>    <chr> <chr> <date>     <chr> <chr>   <dbl> <chr> 
#>  1 O20101007… 014312… CENTRAL… 0143… 5% O… 1994-10-01 CENT… CENT…     100 O     
#>  2 O20160930… 014312… CENTRAL… 0143… 5% O… 2016-09-30 CENT… CENT…      NA O     
#>  3 O20160930… 014312… CENTRAL… 0143… 5% O… 2020-01-01 CENT… CENT…      NA O     
#>  4 O20160930… 014312… CENTRAL… 0143… 5% O… 2016-08-01 CENT… CENT…      NA O     
#>  5 O20200608… 014312… CENTRAL… 0143… 5% O… 2020-05-11 CENT… CENT…      NA O     
#>  6 O20220309… 014312… CENTRAL… 0143… 5% O… 2022-04-01 CENT… CENT…     100 O     
#>  7 O20240515… 014312… CENTRAL… 0143… 5% O… 2024-05-02 CENT… CENT…     100 O     
#>  8 O20221216… 024422… SMA HEA… 0244… OPER… 2022-10-01 SMA … NA        100 O     
#>  9 O20221216… 024422… SMA HEA… 0244… OTHER 2022-10-01 SMA … NA          0 O     
#> 10 O20190326… 044615… PROJECT… 0446… 5% O… 1974-12-12 PROJ… LANG…     100 O     
#> # ℹ 244 more rows
#> # ℹ 9 more variables: title <chr>, first <chr>, middle <chr>, last <chr>,
#> #   address <chr>, city <chr>, state <chr>, zip <chr>, owner_type <chr>
```
