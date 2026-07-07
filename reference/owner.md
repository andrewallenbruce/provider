# Owners

Owners of facilities enrolled in Medicare.

## Usage

``` r
owner(
  fac_type = NULL,
  fac_enid = NULL,
  fac_pac = NULL,
  fac_name = NULL,
  own_pac = NULL,
  own_org = NULL,
  own_dba = NULL,
  own_pct = NULL,
  own_role = NULL,
  own_entity = NULL,
  own_first = NULL,
  own_last = NULL,
  own_title = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  count = FALSE
)
```

## Source

Medicare

## Arguments

- fac_type:

  `<enum>` Facility type; if NULL (default), will search all:

  - `HHA` = Home Health Agency

  - `RHC` = Rural Health Clinic

  - `FQHC` = Federally Qualified Health Clinic

  - `SNF` = Skilled Nursing Facility

  - `Hospice` = Hospice

  - `Hospital` = Hospital

- own_pac:

  `<chr>` Provider's name

- own_org:

  `<chr>` Provider's name

- own_dba:

  `<chr>` Provider's name

- own_pct:

  `<dbl>` Provider's name

- own_role:

  `<chr>` Provider's name

- own_entity:

  `<enum>` Provider's name

- own_first, own_last:

  `<chr>` Provider's name

- own_title:

  `<chr>` Provider's name

- city, state, zip:

  `<chr>` Provider's name

- count:

  `<lgl>` Return the total row count

- enid:

  `<chr>` National Provider Identifier

- pac:

  `<chr>` Provider's name

- org_name:

  `<chr>` Provider's name

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
containing the search results.

## Examples

``` r
owner(count = TRUE)
#> ◼ owner | 526,704 rows | 109 pages
owner(city = "Valdosta", state = "GA")
#> ✔ owner returned 13 results
#> ✔ Retrieving 4 pages
#> # A tibble: 13 × 18
#>    fac_name         fac_type fac_pac fac_enid own_org own_dba own_date   own_pac
#>  * <chr>            <chr>    <chr>   <chr>    <chr>   <chr>   <date>     <chr>  
#>  1 GHHS HEALTHCARE… HHA      317378… O201204… LJP ME… NA      2011-06-23 286065…
#>  2 GHHS HEALTHCARE… HHA      317378… O201204… LJP ME… NA      2011-06-23 286065…
#>  3 HOSPITAL AUTHOR… SNF      135533… O201406… HOSPIT… SOUTH … 2014-05-04 135533…
#>  4 SOUTH GEORGIA M… SNF      105276… O202403… SOUTH … SGMC H… 2023-11-01 105276…
#>  5 SOUTH GEORGIA H… Hospice  135535… O200602… SOUTH … HOSPIC… 2006-07-07 135535…
#>  6 HOSPITAL AUTHOR… Hospital 135533… O200803… HOSPIT… SOUTH … 2014-07-25 135533…
#>  7 HOSPITAL AUTHOR… Hospital 135533… O200803… HOSPIT… SOUTH … 2014-07-25 135533…
#>  8 HOSPITAL AUTHOR… Hospital 135533… O201405… HOSPIT… SOUTH … 2014-05-01 135533…
#>  9 HOSPITAL AUTHOR… Hospital 135533… O201406… HOSPIT… SOUTH … 2014-05-01 135533…
#> 10 SOUTH GEORGIA M… Hospital 105276… O202401… SOUTH … SGMC H… 2023-11-01 105276…
#> 11 SOUTH GEORGIA M… Hospital 105276… O202403… SOUTH … SGMC H… 2023-11-01 105276…
#> 12 SOUTH GEORGIA M… Hospital 105276… O202404… SOUTH … SGMC H… 2023-11-01 105276…
#> 13 SOUTH GEORGIA M… Hospital 105276… O202404… SOUTH … SGMC H… 2023-11-01 105276…
#> # ℹ 10 more variables: own_title <chr>, own_first <chr>, own_last <chr>,
#> #   own_pct <dbl>, own_role <chr>, address <chr>, city <chr>, state <chr>,
#> #   zip <chr>, own_type <chr>
```
