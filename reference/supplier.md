# Medical Equipment Suppliers

Access information concerning individual providers' affiliations with
organizations/facilities.

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

- [API: Physician Facility
  Affiliations](https://data.cms.gov/provider-data/dataset/27ea-46a8)

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
#> ◼ supplier | 57,298 rows | 39 pages
supplier(state = "GA")
#> ✔ supplier returned 1,838 results
#> ✔ Retrieving 2 pages
#> [working] (0 + 0) -> 1 -> 1 | ■■■■■■■■■■■■■■■■                  50%
#> [working] (0 + 0) -> 0 -> 2 | ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  100%
#> # A tibble: 1,838 × 15
#>      provid   par start_date org_dba org_name specialty prov_type supplies   cba
#>       <int> <int> <date>     <chr>   <chr>    <chr>     <chr>     <chr>    <int>
#>  1 34362830     1 2026-01-23 VISION… VISION … Optometr… NA        Prosthe…     0
#>  2 34361594     1 2025-08-13 FAYETT… FAYETTE… Pharmacy  NA        Blood G…     0
#>  3 34362502     0 2026-01-14 SOULFU… SOULFUL… Medical … NA        Canes a…     0
#>  4 34361524     1 2025-08-28 ANGELS… ANGELS … Medical … NA        Commode…     0
#>  5 34360690     0 2025-04-09 SUPERI… SUPERIO… Medical … NA        Commode…     0
#>  6 23284231     1 2025-04-09 NORTH … NORTH F… Optician  NA        Prosthe…     0
#>  7 20684819     0 2025-03-21 FLOWIN… FLOWING… Medical … NA        Orthose…     0
#>  8 20575007     1 2026-01-01 REHAB … REHAB M… Medical … NA        Hospita…     0
#>  9 34361402     1 2025-07-09 REVIVI… REVIVIF… Medical … NA        Orthose…     0
#> 10 34362853     1 2026-02-27 HEALTH… HEALTHY… MSC With… NA        Hospita…     0
#> # ℹ 1,828 more rows
#> # ℹ 6 more variables: lat <dbl>, lon <dbl>, address <chr>, city <chr>,
#> #   state <chr>, zip <chr>
```
