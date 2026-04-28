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
#> ℹ pending has 9,722 rows.
#> • Physician     : 3,696
#> • Non-Physician : 6,026

pending(first = "Victor", count = TRUE)
#> ✔ pending returned 7 results.
#> • Physician     : 5
#> • Non-Physician : 2

pending(first = starts("V"))
#> ✔ pending returned 121 results.
#> • Physician     : 44
#> • Non-Physician : 77
#> # A tibble: 121 × 4
#>    prov_type first         last                    npi
#>  * <chr>     <chr>         <chr>                 <int>
#>  1 Physician VADIN         LALL DASS        1144512724
#>  2 Physician VALENTINA     TURBAY CABALLERO 1689304545
#>  3 Physician VALERIE       SOTO             1215825310
#>  4 Physician VALJEAN       BACOT-DAVIS      1407597651
#>  5 Physician VAMSI KRISHNA LAVU             1407534472
#>  6 Physician VANDAN        PATEL            1588308712
#>  7 Physician VANESSA       NWOKOYE          1205530045
#>  8 Physician VANI          SENTHIL          1700774759
#>  9 Physician VANITA        JAYSWAL          1790626414
#> 10 Physician VANSHANI      PATEL            1649118753
#> # ℹ 111 more rows
```
