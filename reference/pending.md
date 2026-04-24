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
#> ℹ pending has 9,661 rows.
#> • Physician     : 3,626
#> • Non-Physician : 6,035

pending(first = "Victor", count = TRUE)
#> ✔ pending returned 7 results.
#> • Physician     : 5
#> • Non-Physician : 2

pending(first = starts_with("V"))
#> ✔ pending returned 121 results.
#> • Physician     : 39
#> • Non-Physician : 82
#> # A tibble: 121 × 4
#>    prov_type first        last                    npi
#>  * <chr>     <chr>        <chr>                 <int>
#>  1 Physician VADIN        LALL DASS        1144512724
#>  2 Physician VALENTINA    TURBAY CABALLERO 1689304545
#>  3 Physician VALERIE      SOTO             1215825310
#>  4 Physician VALJEAN      BACOT-DAVIS      1407597651
#>  5 Physician VANESSA      NWOKOYE          1205530045
#>  6 Physician VANITA       JAYSWAL          1790626414
#>  7 Physician VANSHANI     PATEL            1649118753
#>  8 Physician VARUNIL      SHAH             1972442267
#>  9 Physician VENKATARAMAN PATLA            1124038419
#> 10 Physician VENNELA      PULIKANTI        1821238999
#> # ℹ 111 more rows
```
