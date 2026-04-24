# Pending Medicare Enrollments

Providers with pending Medicare enrollment applications.

The *Pending Initial Logging and Tracking (L & T)* dataset provides a
list of pending applications for both Physicians and Non-Physicians that
have not been processed by CMS contractors.

## Usage

``` r
pending(npi = NULL, first = NULL, last = NULL, count = FALSE, set = FALSE)
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

  `<lgl>` Return the total row count

- set:

  `<lgl>` Return the entire dataset

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)

## Examples

``` r
pending(count = TRUE)
#> ℹ pending has 9,580 rows.
#> • Physician     : 3,537
#> • Non-Physician : 6,043

pending(first = "Victor", count = TRUE)
#> ✔ pending returned 6 results.
#> • Physician     : 4
#> • Non-Physician : 2

pending(first = starts_with("V"))
#> ✔ pending returned 128 results.
#> • Physician     : 41
#> • Non-Physician : 87
#> # A tibble: 128 × 4
#>    prov_type first     last                    npi
#>  * <chr>     <chr>     <chr>                 <int>
#>  1 Physician VADIN     LALL DASS        1144512724
#>  2 Physician VALENTINA LOGUNOVA         1871909960
#>  3 Physician VALENTINA TURBAY CABALLERO 1689304545
#>  4 Physician VALENTINE NRIAGU           1942904024
#>  5 Physician VALERIE   SOTO             1215825310
#>  6 Physician VALJEAN   BACOT-DAVIS      1407597651
#>  7 Physician VANDAN    PATEL            1588308712
#>  8 Physician VANESSA   NWOKOYE          1205530045
#>  9 Physician VANSHANI  PATEL            1649118753
#> 10 Physician VARUNIL   SHAH             1972442267
#> # ℹ 118 more rows
```
