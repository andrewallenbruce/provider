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
#> ◼ supplier | 56,962 rows | 38 pages
supplier(state = "GA")
#> ✔ supplier returned 1,806 results
#> [working] (0 + 0) -> 1 -> 1 | ■■■■■■■■■■■■■■■■                  50%
#> [working] (0 + 0) -> 0 -> 2 | ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  100%
#> # A tibble: 1,806 × 15
#>      provid   par start_date org_dba org_name specialty prov_type supplies   cba
#>       <int> <int> <date>     <chr>   <chr>    <chr>     <chr>     <chr>    <int>
#>  1 34362830     1 2026-01-23 VISION… VISION … Optometr… NA        Prosthe…     0
#>  2 34363460     1 2026-01-20 LIFELI… LIFELIN… Medical … NA        Blood G…     0
#>  3 20575007     1 2026-01-01 REHAB … REHAB M… Medical … NA        Hospita…     0
#>  4 34362054     0 2025-10-06 KABAFU… KABAFUS… Pharmacy  NA        Infusio…     0
#>  5 34360632     0 2025-05-30 ATLANT… ATLANTA… Medical … NA        Commode…     0
#>  6 34360638     1 2025-05-27 EASE E… EASE EQ… Medical … NA        Blood G…     0
#>  7 34360656     1 2025-05-14 ON TIM… ON TIME… Medical … INDEPEND… Urologi…     0
#>  8 34360668     1 2025-05-14 RJ MED… RJ MEDI… Medical … NA        Blood G…     0
#>  9 34362146     1 2025-10-01 SV ORT… SV ORTH… MSC With… NA        Orthose…     0
#> 10 34360652     1 2025-05-14 ATLANT… ATLANTA… Medical … NA        Commode…     0
#> # ℹ 1,796 more rows
#> # ℹ 6 more variables: lat <dbl>, lon <dbl>, address <chr>, city <chr>,
#> #   state <chr>, zip <chr>
```
