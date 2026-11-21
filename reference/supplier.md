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
#> ◼ supplier | 56,777 rows | 38 pages
supplier(state = "GA")
#> ✔ supplier returned 1,788 results
#> # A tibble: 1,788 × 15
#>      provid   par start_date org_dba org_name specialty prov_type supplies   cba
#>       <int> <int> <date>     <chr>   <chr>    <chr>     <chr>     <chr>    <int>
#>  1 34362426     1 2025-11-25 BLUE M… BLUE ME… Medical … NA        Commode…     0
#>  2 34362765     0 2025-11-28 CRESCE… CRESCEN… Pharmacy  NA        Epoetin…     0
#>  3 34361175     1 2025-06-24 SOUTHE… SOUTHER… NA        NURSE PR… Commode…     0
#>  4 34362054     0 2025-10-06 KABAFU… KABAFUS… Pharmacy  NA        Infusio…     0
#>  5 34360632     0 2025-05-30 ATLANT… ATLANTA… Medical … NA        Commode…     0
#>  6 20407661     1 2026-06-24 1ST AM… 1ST AME… Pharmacy  NA        Blood G…     0
#>  7 20684987     1 2025-01-29 DND RX… DND RX … Pharmacy  NA        Epoetin…     0
#>  8 20591843     0 2026-01-01 VALENT… VALENTI… Medical … OXYGEN &… Commode…     0
#>  9 34362817     1 2025-12-04 PEACHT… PEACHTR… Certifie… NA        Epoetin…     0
#> 10 34362619     0 2025-11-28 CRESCE… CRESCEN… Pharmacy  NA        Epoetin…     0
#> # ℹ 1,778 more rows
#> # ℹ 6 more variables: lat <dbl>, lon <dbl>, address <chr>, city <chr>,
#> #   state <chr>, zip <chr>
```
