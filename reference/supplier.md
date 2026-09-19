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
#> ◼ supplier | 56,898 rows | 38 pages
supplier(state = "GA")
#> ✔ supplier returned 1,800 results
#> [working] (0 + 0) -> 1 -> 1 | ■■■■■■■■■■■■■■■■                  50%
#> [working] (0 + 0) -> 0 -> 2 | ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  100%
#> # A tibble: 1,800 × 15
#>      provid   par start_date org_dba org_name specialty prov_type supplies   cba
#>       <int> <int> <date>     <chr>   <chr>    <chr>     <chr>     <chr>    <int>
#>  1 34363005     1 2025-12-23 RAPID … RAPID S… Medical … NA        Commode…     0
#>  2 34362765     0 2025-11-28 CRESCE… CRESCEN… Pharmacy  NA        Epoetin…     0
#>  3 20505233     0 2026-01-01 LILY'S… LILY'S … Pharmacy  NA        Epoetin…     0
#>  4 34360635     1 2025-05-05 RADIAN… RADIANT… Medical … NA        Commode…     0
#>  5 34361985     1 2025-08-14 FOOT S… FOOT SO… NA        CERTIFIE… Limb Pr…     0
#>  6 20547527     1 2026-01-01 REHAB … REHAB M… Medical … NA        Hospita…     0
#>  7 34362759     1 2025-04-12 MAGNOL… MAGNOLI… NA        NURSE PR… Contrac…     0
#>  8 20685137     0 2025-03-31 DENTAL… DENTAL … Orthotic… ORAL SUR… Orthose…     0
#>  9 34360703     1 2025-02-05 ORTHOX… ORTHOXP… NA        PHYSICIA… Canes a…     0
#> 10 34362817     1 2025-12-04 PEACHT… PEACHTR… Certifie… NA        Epoetin…     0
#> # ℹ 1,790 more rows
#> # ℹ 6 more variables: lat <dbl>, lon <dbl>, address <chr>, city <chr>,
#> #   state <chr>, zip <chr>
```
