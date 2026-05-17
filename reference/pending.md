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
#> pending Totals
#> • Rows  : 11,068
#> • Pages : 4     
#> 

pending(first = "Victor", count = TRUE)
#> ✔ pending returned 8 results.
#> • Physician     : 6
#> • Non-Physician : 2

pending(first = starts("V"))
#> ✔ pending returned 157 results.
#> • Physician     : 69
#> • Non-Physician : 88
#> ℹ Retrieving 2 pages...
#> # A tibble: 157 × 4
#>    prov_type first         last                        npi
#>    <chr>     <chr>         <chr>                     <int>
#>  1 Physician VADIN         LALL DASS            1144512724
#>  2 Physician VALENTINA     TURBAY CABALLERO     1689304545
#>  3 Physician VALERIA       SILVA                1154292712
#>  4 Physician VALERIE       BETSIS               1851235493
#>  5 Physician VALERIE       GRAVES               1265373518
#>  6 Physician VALERIE       SOTO                 1215825310
#>  7 Physician VALJEAN       BACOT-DAVIS          1407597651
#>  8 Physician VALYNN        ANTOINE              1811480510
#>  9 Physician VAMSI KRISHNA LAVU                 1407534472
#> 10 Physician VANESSA       BERMUDEZ-VILLALPANDO 1053251975
#> # ℹ 147 more rows
```
