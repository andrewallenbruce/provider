# Skilled Nursing Facility Owners

Providers with pending Medicare enrollment applications.

## Usage

``` r
snf_owner(
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
snf_owner(count = TRUE)
#> snf_owner Totals
#> • Rows  : 116,973
#> • Pages : 24     
#> 

snf_owner(state = c("GA", "FL"))
#> ✔ snf_owner returned 4,175 results.
#> # A tibble: 4,175 × 20
#>    org_enid    org_pac org_name pac   entity role  asc_date   first middle last 
#>  * <chr>       <chr>   <chr>    <chr> <chr>  <chr> <date>     <chr> <chr>  <chr>
#>  1 O200302100… 428454… 13000 V… 8527… O      5% O… 1998-06-01 NA    NA     NA   
#>  2 O200304020… 549666… SENIOR … 3577… O      5% O… 2002-04-02 NA    NA     NA   
#>  3 O200304020… 549666… SENIOR … 3577… O      5% O… 2002-06-20 NA    NA     NA   
#>  4 O200401150… 690170… HEBREW … 4981… O      5% O… 2003-03-03 NA    NA     NA   
#>  5 O200401150… 690170… HEBREW … 6901… O      5% O… 2003-03-03 NA    NA     NA   
#>  6 O200402120… 741686… SENIOR … 3577… O      5% O… 2002-10-16 NA    NA     NA   
#>  7 O200402120… 741686… SENIOR … 3577… O      5% O… 2002-10-16 NA    NA     NA   
#>  8 O200402120… 741686… SENIOR … 3577… O      OPER… 2003-12-01 NA    NA     NA   
#>  9 O200405060… 307250… CARDINA… 0143… O      5% O… 2011-12-30 NA    NA     NA   
#> 10 O200405060… 307250… CARDINA… 2062… O      5% O… 2011-12-30 NA    NA     NA   
#> # ℹ 4,165 more rows
#> # ℹ 10 more variables: title <chr>, owner <chr>, dba <chr>, address <chr>,
#> #   city <chr>, state <chr>, zip <chr>, percent <dbl>, oth_txt <chr>,
#> #   owner_type <chr>
```
