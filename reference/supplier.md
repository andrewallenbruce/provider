# Medical Equipment Suppliers

A list of Suppliers that indicates the supplies carried at that location
and the supplier's Medicare participation status.

## Usage

``` r
supplier(
  id = NULL,
  par = NULL,
  org_dba = NULL,
  org_name = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  specialty = NULL,
  prov_type = NULL,
  supplies = NULL,
  count = FALSE
)
```

## Source

- [API: Medical Equipment
  Suppliers](https://data.cms.gov/provider-data/dataset/ct36-nrcq)

## Arguments

- id:

  `<chr>` provider identifier

- par:

  `<lgl>` description

- org_dba:

  `<chr>` desc

- org_name:

  `<chr>` desc

- city, state, zip:

  `<chr>` desc

- specialty:

  description

- prov_type:

  description

- supplies:

  `<int>` desc

- count:

  `<lgl>` Return the total row count

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
containing the search results.

## Examples

``` r
supplier(count = TRUE)
#> ◼ supplier | 57,197 rows | 39 pages
supplier(state = "GA")
#> ✔ supplier returned 1,834 results
#> ✔ Retrieving 2 pages
#> [working] (0 + 0) -> 1 -> 1 | ■■■■■■■■■■■■■■■■                  50%
#> [working] (0 + 0) -> 0 -> 2 | ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  100%
#> # A tibble: 1,834 × 15
#>      provid   par start_date org_dba org_name specialty prov_type supplies   cba
#>       <int> <int> <date>     <chr>   <chr>    <chr>     <chr>     <chr>    <int>
#>  1 34362943     1 2026-03-20 MEDICA… MEDICAL… Medical … NA        Orthose…     0
#>  2 34362817     1 2025-12-04 PEACHT… PEACHTR… Certifie… NA        Epoetin…     0
#>  3 34362619     0 2025-11-28 CRESCE… CRESCEN… Pharmacy  NA        Epoetin…     0
#>  4 34361935     1 2025-10-01 MA MED… MA MED … Medical … NA        Blood G…     0
#>  5 34361731     0 2025-09-15 TWIST … TWIST N… Medical … NA        Blood G…     0
#>  6 34362859     1 2026-02-27 VITA P… VITA PA… Medical … NA        Commode…     0
#>  7 34362853     1 2026-02-27 HEALTH… HEALTHY… MSC With… NA        Hospita…     0
#>  8 21609063     0 2026-01-01 CARMIC… CARMICH… Pharmacy  NA        Epoetin…     0
#>  9 34362557     1 2026-01-26 INFUSI… INFUSIO… Certifie… NA        Epoetin…     0
#> 10 20505233     0 2026-01-01 LILY'S… LILY'S … Pharmacy  NA        Epoetin…     0
#> # ℹ 1,824 more rows
#> # ℹ 6 more variables: lat <dbl>, lon <dbl>, address <chr>, city <chr>,
#> #   state <chr>, zip <chr>
```
