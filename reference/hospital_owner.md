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
#> # A tibble: 137 × 20
#>    org_enid    org_pac org_name pac   entity role  asc_date   first middle last 
#>  * <chr>       <chr>   <chr>    <chr> <chr>  <chr> <date>     <chr> <chr>  <chr>
#>  1 O200407090… 953714… PROMISE… 1759… O      5% O… 2014-03-17 NA    NA     NA   
#>  2 O200407090… 953714… PROMISE… 2860… O      5% O… 2003-11-04 NA    NA     NA   
#>  3 O200407090… 953714… PROMISE… 3577… O      5% O… 2014-03-17 NA    NA     NA   
#>  4 O200407090… 953714… PROMISE… 3971… O      5% O… 2004-06-30 NA    NA     NA   
#>  5 O200407090… 953714… PROMISE… 3971… O      OPER… 2004-06-30 NA    NA     NA   
#>  6 O200407090… 953714… PROMISE… 8224… O      5% O… 2003-11-04 NA    NA     NA   
#>  7 O200602030… 872998… BERT FI… 1456… O      OTHER 2011-06-30 NA    NA     NA   
#>  8 O200602030… 872998… BERT FI… 8729… O      5% O… 1995-03-13 NA    NA     NA   
#>  9 O200602130… 630585… HERNAND… 1759… O      5% O… 2014-01-27 NA    NA     NA   
#> 10 O200701230… 004212… MAYO CL… 5698… O      OPER… 2012-03-01 NA    NA     NA   
#> # ℹ 127 more rows
#> # ℹ 10 more variables: title <chr>, owner <chr>, dba <chr>, address <chr>,
#> #   city <chr>, state <chr>, zip <chr>, percent <dbl>, oth_txt <chr>,
#> #   owner_type <chr>
```
