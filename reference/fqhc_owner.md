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
#>    org_enid org_pac org_name pac   role  asc_date   owner_name owner_dba percent
#>    <chr>    <chr>   <chr>    <chr> <chr> <date>     <chr>      <chr>       <dbl>
#>  1 O201010… 014312… CENTRAL… 0143… 5% O… 1994-10-01 CENTRAL F… CENTRAL …     100
#>  2 O201609… 014312… CENTRAL… 0143… 5% O… 2016-09-30 CENTRAL F… CENTRAL …      NA
#>  3 O201609… 014312… CENTRAL… 0143… 5% O… 2020-01-01 CENTRAL F… CENTRAL …      NA
#>  4 O201609… 014312… CENTRAL… 0143… 5% O… 2016-08-01 CENTRAL F… CENTRAL …      NA
#>  5 O202006… 014312… CENTRAL… 0143… 5% O… 2020-05-11 CENTRAL F… CENTRAL …      NA
#>  6 O202203… 014312… CENTRAL… 0143… 5% O… 2022-04-01 CENTRAL F… CENTRAL …     100
#>  7 O202405… 014312… CENTRAL… 0143… 5% O… 2024-05-02 CENTRAL F… CENTRAL …     100
#>  8 O202212… 024422… SMA HEA… 0244… OPER… 2022-10-01 SMA HEALT… NA            100
#>  9 O202212… 024422… SMA HEA… 0244… OTHER 2022-10-01 SMA HEALT… NA              0
#> 10 O201903… 044615… PROJECT… 0446… 5% O… 1974-12-12 PROJECT H… LANGLEY …     100
#> # ℹ 244 more rows
#> # ℹ 10 more variables: entity <chr>, title <chr>, first <chr>, middle <chr>,
#> #   last <chr>, address <chr>, city <chr>, state <chr>, zip <chr>,
#> #   owner_type <chr>
```
