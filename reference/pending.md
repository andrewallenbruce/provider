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
#> • Rows  : 11,364
#> • Pages : 4     
#> 

pending(first = "Victor", count = TRUE)
#> ✔ pending returned 7 results.
#> • Physician     : 5
#> • Non-Physician : 2

pending(first = starts("V"))
#> ✔ pending returned 166 results.
#> • Physician     : 69
#> • Non-Physician : 97
#> ℹ Retrieving 2 pages...
#> # A tibble: 166 × 4
#>    prov_type first         last                    npi
#>    <chr>     <chr>         <chr>                 <int>
#>  1 Physician VADIN         LALL DASS        1144512724
#>  2 Physician VAIBHAV       SATIJA           1629564828
#>  3 Physician VAIDHEESH     VARAGANTIWAR     1265399984
#>  4 Physician VAISHNAVI     GURUMURTHY       1972281194
#>  5 Physician VALENTINA     TURBAY CABALLERO 1689304545
#>  6 Physician VALERIA       SILVA            1154292712
#>  7 Physician VALERIE       SOTO             1215825310
#>  8 Physician VALJEAN       BACOT-DAVIS      1407597651
#>  9 Physician VALYNN        ANTOINE          1811480510
#> 10 Physician VAMSI KRISHNA LAVU             1407534472
#> # ℹ 156 more rows
```
