# FQHC Owners

Providers with pending Medicare enrollment applications.

## Usage

``` r
fqhc_owner(
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
fqhc_owner(count = TRUE)
#> fqhc_owner Totals
#> • Rows  : 148,919
#> • Pages : 30     
#> 

fqhc_owner(state = c("GA", "FL"))
#> ✔ fqhc_owner returned 254 results.
#> # A tibble: 254 × 20
#>    enid       pac   org_name own_pac own_role own_date   own_org own_dba own_pct
#>  * <chr>      <chr> <chr>    <chr>   <chr>    <date>     <chr>   <chr>     <dbl>
#>  1 O20030417… 3577… NORTH B… 357747… 5% OR G… 1993-07-01 NORTH … BROWAR…     100
#>  2 O20030417… 3577… NORTH B… 357747… OPERATI… 1993-10-01 NORTH … BROWAR…     100
#>  3 O20030417… 3577… NORTH B… 357747… 5% OR G… 1993-07-01 NORTH … BROWAR…     100
#>  4 O20030417… 3577… NORTH B… 357747… OPERATI… 1993-07-01 NORTH … BROWAR…     100
#>  5 O20070613… 9931… FLORIDA… 993101… OPERATI… 2018-04-01 FLORID… FORT P…       0
#>  6 O20090826… 2365… TRENTON… 236535… OPERATI… 2014-02-27 TRENTO… PALMS …     100
#>  7 O20100510… 7214… MCR HEA… 721484… 5% OR G… 2009-11-02 MCR HE… MCR HE…      NA
#>  8 O20100809… 9931… FLORIDA… 993101… OPERATI… 2018-04-01 FLORID… FORT P…       0
#>  9 O20100902… 7214… MCR HEA… 721484… 5% OR G… 1977-10-11 MCR HE… MCR HE…      NA
#> 10 O20100907… 7214… MCR HEA… 721484… 5% OR G… 1977-10-11 MCR HE… MCR HE…      NA
#> # ℹ 244 more rows
#> # ℹ 11 more variables: entity <chr>, title <chr>, first <chr>, middle <chr>,
#> #   last <chr>, address <chr>, city <chr>, state <chr>, zip <chr>,
#> #   oth_txt <chr>, own_ind <chr>
```
