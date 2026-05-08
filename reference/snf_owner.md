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
#> # A tibble: 4,175 × 19
#>    org_enid    org_pac org_name pac   entity role  asc_date   first middle last 
#>    <chr>       <chr>   <chr>    <chr> <chr>  <chr> <date>     <chr> <chr>  <chr>
#>  1 O200507280… 933517… HILL HA… 0042… O      5% O… 2005-06-23 NA    NA     NA   
#>  2 O200507280… 933517… HILL HA… 0042… O      OPER… 2005-06-23 NA    NA     NA   
#>  3 O201401090… 094143… PLEASAN… 0042… O      5% O… 2014-01-01 NA    NA     NA   
#>  4 O201402250… 004244… HENDERS… 0042… O      5% O… 2014-01-01 NA    NA     NA   
#>  5 O201402250… 781012… INMAN H… 0042… O      5% O… 2013-12-01 NA    NA     NA   
#>  6 O201403110… 812325… SHERMAN… 0042… O      5% O… 2014-01-01 NA    NA     NA   
#>  7 O202301130… 731531… SUMTER … 0042… O      5% O… 2022-11-08 NA    NA     NA   
#>  8 O202301270… 771935… SENECA … 0042… O      5% O… 2022-12-15 NA    NA     NA   
#>  9 O202502270… 741647… OAK GLE… 0042… O      5% O… 2024-12-06 NA    NA     NA   
#> 10 O200901060… 014311… HOSPITA… 0143… O      OPER… 2008-11-21 NA    NA     NA   
#> # ℹ 4,165 more rows
#> # ℹ 9 more variables: title <chr>, owner_name <chr>, owner_dba <chr>,
#> #   address <chr>, city <chr>, state <chr>, zip <chr>, percent <dbl>,
#> #   owner_type <chr>
```
