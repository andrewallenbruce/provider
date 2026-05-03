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
#> ══ pending Totals ══
#> • Rows  : 10,013
#> • Pages : 3     
#> 

pending(first = "Victor", count = TRUE)
#> ✔ pending returned 7 results.
#> • Physician     : 5
#> • Non-Physician : 2

pending(first = starts("V"))
#> ✔ pending returned 129 results.
#> • Physician     : 51
#> • Non-Physician : 78
#> ✔ pending returned 129 results.
#> • Physician     : 51
#> • Non-Physician : 78
#> # A tibble: 129 × 3
#>    first     last                    npi
#>  * <chr>     <chr>                 <int>
#>  1 VADIN     LALL DASS        1144512724
#>  2 VALENTINA TURBAY CABALLERO 1689304545
#>  3 VALERIE   SOTO             1215825310
#>  4 VALJEAN   BACOT-DAVIS      1407597651
#>  5 VANDAN    PATEL            1588308712
#>  6 VANI      SENTHIL          1700774759
#>  7 VANITA    JAYSWAL          1790626414
#>  8 VANSHANI  PATEL            1649118753
#>  9 VARUNIL   SHAH             1972442267
#> 10 VASILIY   SAKHONENKO       1518831262
#> # ℹ 119 more rows
```
