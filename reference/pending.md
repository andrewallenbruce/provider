# Pending Medicare Enrollments

Providers with pending Medicare enrollment applications.

The Pending Initial Logging and Tracking (L & T) dataset provides a list
of pending applications for both Physicians and Non-Physicians that have
not been processed by CMS contractors.

## Usage

``` r
pending(npi = NULL, first = NULL, last = NULL, count = FALSE)
```

## Source

Medicare Pending Initial Logging and Tracking:

- [API:
  Physicians](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/pending-initial-logging-and-tracking-physicians)

- [API:
  Non-Physicians](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/pending-initial-logging-and-tracking-non-physicians)

## Arguments

- npi:

  `<int>` National Provider Identifier

- first, last:

  `<chr>` Provider's name

- count:

  `<lgl>` Return the dataset's total row count

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)

## Examples

``` r
pending(count = TRUE)
#> ✔ `pending` returned 9,594 results.
#> • Physician     : 3,290
#> • Non-Physician : 6,304
pending(first = "Victor", count = TRUE)
#> ✔ `pending` returned 5 results.
#> • Physician     : 4
#> • Non-Physician : 1
pending(first = starts_with("V"))
#> ✔ `pending` returned 143 results.
#> • Physician     : 40 
#> • Non-Physician : 103
#> # A tibble: 143 × 4
#>    prov_type first     last             npi       
#>    <fct>     <chr>     <chr>            <chr>     
#>  1 Physician VADIN     LALL DASS        1144512724
#>  2 Physician VAIBHAVI  SHAH             1437952843
#>  3 Physician VALENTINA TURBAY CABALLERO 1689304545
#>  4 Physician VALERIA   LOZADA MIRANDA   1881291540
#>  5 Physician VALERIE   ESPINOZA         1669050084
#>  6 Physician VALJEAN   BACOT-DAVIS      1407597651
#>  7 Physician VANESSA   LOUISSAINT       1386093193
#>  8 Physician VANESSA   NWOKOYE          1205530045
#>  9 Physician VANSHANI  PATEL            1649118753
#> 10 Physician VEDATTA   MAHARAJ          1811637556
#> # ℹ 133 more rows
```
