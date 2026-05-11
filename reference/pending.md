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
#> • Rows  : 10,579
#> • Pages : 3     
#> 

pending(first = "Victor", count = TRUE)
#> ✔ pending returned 7 results.
#> • Physician     : 6
#> • Non-Physician : 1

pending(first = starts("V"))
#> ✔ pending returned 141 results.
#> • Physician     : 61
#> • Non-Physician : 80
#> # A tibble: 141 × 4
#>    prov_type first         last                    npi
#>    <chr>     <chr>         <chr>                 <int>
#>  1 Physician VADIN         LALL DASS        1144512724
#>  2 Physician VALENTINA     TURBAY CABALLERO 1689304545
#>  3 Physician VALERIE       GRAVES           1265373518
#>  4 Physician VALERIE       SOTO             1215825310
#>  5 Physician VALJEAN       BACOT-DAVIS      1407597651
#>  6 Physician VAMSI KRISHNA LAVU             1407534472
#>  7 Physician VANESA        CARRENO          1437094257
#>  8 Physician VANESSA       DONALDSON        1861237943
#>  9 Physician VARTAN        PAHALYANTS       1518545672
#> 10 Physician VARUNIL       SHAH             1972442267
#> # ℹ 131 more rows
```
