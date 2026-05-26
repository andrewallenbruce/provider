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

## Examples

``` r
pending(count = TRUE)
#> pending Totals
#> • Rows  : 11,647
#> • Pages : 4     
#> 

pending(first = "Victor", count = TRUE)
#> ✔ pending returned 6 results.
#> • Physician     : 4
#> • Non-Physician : 2

pending(first = starts("V"))
#> ✔ pending returned 169 results.
#> • Physician     : 72
#> • Non-Physician : 97
#> ℹ Retrieving 2 pages...
#> # A tibble: 169 × 4
#>    prov_type first     last                    npi
#>    <chr>     <chr>     <chr>                 <int>
#>  1 Physician VADIN     LALL DASS        1144512724
#>  2 Physician VAIBHAV   SATIJA           1629564828
#>  3 Physician VAIDEHI   KOTHARI          1447190517
#>  4 Physician VAIDHEESH VARAGANTIWAR     1265399984
#>  5 Physician VAISHNAVI GURUMURTHY       1972281194
#>  6 Physician VALENTINA SEDLACEK         1003590118
#>  7 Physician VALENTINA TURBAY CABALLERO 1689304545
#>  8 Physician VALERIA   SILVA            1154292712
#>  9 Physician VALERIE   SOTO             1215825310
#> 10 Physician VALJEAN   BACOT-DAVIS      1407597651
#> # ℹ 159 more rows
```
