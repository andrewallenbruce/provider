# Hospice Owners

Providers with pending Medicare enrollment applications.

## Usage

``` r
hospice_owner(
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
hospice_owner(count = TRUE)
#> hospice_owner Totals
#> • Rows  : 71,133
#> • Pages : 15    
#> 

hospice_owner(state = c("GA", "FL"))
#> ✔ hospice_owner returned 1,961 results.
#> # A tibble: 1,961 × 20
#>    org_enid    org_pac org_name pac   entity role  asc_date   first middle last 
#>  * <chr>       <chr>   <chr>    <chr> <chr>  <chr> <date>     <chr> <chr>  <chr>
#>  1 O200301150… 448656… CAPITAL… 2567… O      OPER… 2023-05-01 NA    NA     NA   
#>  2 O200304300… 448656… CAPITAL… 1254… O      OPER… 2004-08-26 NA    NA     NA   
#>  3 O200304300… 448656… CAPITAL… 2567… O      OPER… 2023-05-01 NA    NA     NA   
#>  4 O200308290… 094111… PORTERC… 5597… O      5% O… 2001-10-01 NA    NA     NA   
#>  5 O200308290… 094111… PORTERC… 5597… O      OPER… 2023-08-01 NA    NA     NA   
#>  6 O200310210… 660878… EAST BA… 2567… O      OPER… 2025-10-01 NA    NA     NA   
#>  7 O200402190… 822492… VITAS H… 4486… O      5% O… 2001-04-27 NA    NA     NA   
#>  8 O200402190… 822492… VITAS H… 7113… O      5% O… 2025-08-11 NA    NA     NA   
#>  9 O200404210… 569868… VITAS H… 4486… O      5% O… 2001-04-27 NA    NA     NA   
#> 10 O200404210… 569868… VITAS H… 7113… O      5% O… 2001-04-27 NA    NA     NA   
#> # ℹ 1,951 more rows
#> # ℹ 10 more variables: title <chr>, owner <chr>, dba <chr>, address <chr>,
#> #   city <chr>, state <chr>, zip <chr>, percent <dbl>, oth_txt <chr>,
#> #   owner_type <chr>
```
