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
#> ℹ pending has 9,477 rows.
#> • Physician     : 3,402
#> • Non-Physician : 6,075
pending(first = "Victor", count = TRUE)
#> ✔ pending returned 5 results.
#> • Physician     : 3
#> • Non-Physician : 2
pending(first = starts_with("V"))
#> ✔ pending returned 132 results.
#> • Physician     : 38
#> • Non-Physician : 94
#> # A tibble: 132 × 4
#>    prov_type first        last                    npi
#>  * <chr>     <chr>        <chr>                 <int>
#>  1 Physician VADIN        LALL DASS        1144512724
#>  2 Physician VAJEH        VATANKHAHI       1003754821
#>  3 Physician VALENTINA    TURBAY CABALLERO 1689304545
#>  4 Physician VALJEAN      BACOT-DAVIS      1407597651
#>  5 Physician VANESSA      KARIMI           1104445022
#>  6 Physician VANESSA      NWOKOYE          1205530045
#>  7 Physician VANSHANI     PATEL            1649118753
#>  8 Physician VENKATARAMAN PATLA            1124038419
#>  9 Physician VENNELA      PULIKANTI        1821238999
#> 10 Physician VERNON       SHARP            1023616224
#> # ℹ 122 more rows
```
