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
#> # A tibble: 254 × 20
#>    org_enid   org_pac org_name pac   role  asc_date   owner dba   percent entity
#>  * <chr>      <chr>   <chr>    <chr> <chr> <date>     <chr> <chr>   <dbl> <chr> 
#>  1 O20030417… 357747… NORTH B… 3577… 5% O… 1993-07-01 NORT… BROW…     100 O     
#>  2 O20030417… 357747… NORTH B… 3577… OPER… 1993-10-01 NORT… BROW…     100 O     
#>  3 O20030417… 357747… NORTH B… 3577… 5% O… 1993-07-01 NORT… BROW…     100 O     
#>  4 O20030417… 357747… NORTH B… 3577… OPER… 1993-07-01 NORT… BROW…     100 O     
#>  5 O20070613… 993101… FLORIDA… 9931… OPER… 2018-04-01 FLOR… FORT…       0 O     
#>  6 O20090826… 236535… TRENTON… 2365… OPER… 2014-02-27 TREN… PALM…     100 O     
#>  7 O20100510… 721484… MCR HEA… 7214… 5% O… 2009-11-02 MCR … MCR …      NA O     
#>  8 O20100809… 993101… FLORIDA… 9931… OPER… 2018-04-01 FLOR… FORT…       0 O     
#>  9 O20100902… 721484… MCR HEA… 7214… 5% O… 1977-10-11 MCR … MCR …      NA O     
#> 10 O20100907… 721484… MCR HEA… 7214… 5% O… 1977-10-11 MCR … MCR …      NA O     
#> # ℹ 244 more rows
#> # ℹ 10 more variables: title <chr>, first <chr>, middle <chr>, last <chr>,
#> #   address <chr>, city <chr>, state <chr>, zip <chr>, oth_txt <chr>,
#> #   owner_type <chr>
```
