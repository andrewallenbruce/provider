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
#> ◼ supplier | 57,176 rows | 39 pages
supplier(state = "GA")
#> ✔ supplier returned 1,831 results
#> # A tibble: 1,831 × 15
#>      provid   par start_date org_dba org_name specialty prov_type supplies   cba
#>       <int> <int> <date>     <chr>   <chr>    <chr>     <chr>     <chr>    <int>
#>  1 34362765     0 2025-11-28 CRESCE… CRESCEN… Pharmacy  NA        Epoetin…     0
#>  2 34362557     1 2026-01-26 INFUSI… INFUSIO… Certifie… NA        Epoetin…     0
#>  3 34361985     1 2025-08-14 FOOT S… FOOT SO… NA        CERTIFIE… Limb Pr…     0
#>  4 34362759     1 2025-04-12 MAGNOL… MAGNOLI… NA        NURSE PR… Contrac…     0
#>  5 20685137     0 2025-03-31 DENTAL… DENTAL … Orthotic… ORAL SUR… Facial …     0
#>  6 34361175     1 2025-06-24 SOUTHE… SOUTHER… NA        NURSE PR… Commode…     0
#>  7 34361459     1 2025-08-29 BROWNS… BROWNS … Medical … NA        Commode…     0
#>  8 34361477     1 2025-08-13 A PLUS… A PLUS … Medical … NA        Orthose…     0
#>  9 34361315     1 2025-08-04 CARE M… CARE ME… Medical … NA        Commode…     0
#> 10 20684837     1 2025-03-24 EMPOWE… EMPOWER… Medical … NA        Commode…     0
#> # ℹ 1,821 more rows
#> # ℹ 6 more variables: lat <dbl>, lon <dbl>, address <chr>, city <chr>,
#> #   state <chr>, zip <chr>
```
