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
#> # A tibble: 1,961 × 19
#>    org_enid    org_pac org_name pac   entity role  asc_date   first middle last 
#>    <chr>       <chr>   <chr>    <chr> <chr>  <chr> <date>     <chr> <chr>  <chr>
#>  1 O201512220… 347685… AUGUSTA… 0143… O      5% O… 2025-12-31 NA    NA     NA   
#>  2 O201803150… 539500… GODLY H… 0244… O      5% O… 2022-02-14 NA    NA     NA   
#>  3 O200603080… 347656… CATHOLI… 0345… O      OPER… 2010-04-16 NA    NA     NA   
#>  4 O200711280… 367847… THE MED… 0345… O      5% O… 1994-11-01 NA    NA     NA   
#>  5 O201202230… 408287… ST. JOS… 0345… O      5% O… 2010-11-09 NA    NA     NA   
#>  6 O201203130… 408287… ST. JOS… 0345… O      5% O… 2010-11-09 NA    NA     NA   
#>  7 O201112140… 135551… SERENIT… 0446… O      5% O… 2020-10-30 NA    NA     NA   
#>  8 O201405290… 226459… ST CROI… 0446… O      5% O… 2020-10-30 NA    NA     NA   
#>  9 O201508070… 226459… ST CROI… 0446… O      5% O… 2020-10-30 NA    NA     NA   
#> 10 O201906260… 226459… ST CROI… 0446… O      5% O… 2020-10-30 NA    NA     NA   
#> # ℹ 1,951 more rows
#> # ℹ 9 more variables: title <chr>, owner_name <chr>, owner_dba <chr>,
#> #   address <chr>, city <chr>, state <chr>, zip <chr>, percent <dbl>,
#> #   owner_type <chr>
```
