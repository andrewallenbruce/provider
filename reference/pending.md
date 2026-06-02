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
#> • Rows  : 11,737
#> • Pages : 2     
#> 

pending(first = "Victor", count = TRUE)
#> ✔ pending returned 7 results.
#> • Physician     : 5
#> • Non-Physician : 2

pending(first = starts("V"))
#> ✔ pending returned 159 results.
#> • Physician     : 66
#> • Non-Physician : 93
#> ℹ Retrieving 2 pages...
#> # A tibble: 186 × 4
#>    prov_type first     last                 npi
#>    <chr>     <chr>     <chr>              <int>
#>  1 Physician VADIN     LALL DASS     1144512724
#>  2 Physician VAIDEHI   KOTHARI       1447190517
#>  3 Physician VAIDHEESH VARAGANTIWAR  1265399984
#>  4 Physician VALENTINA SEDLACEK      1003590118
#>  5 Physician VALERIA   SILVA         1154292712
#>  6 Physician VALJEAN   BACOT-DAVIS   1407597651
#>  7 Physician VALYNN    ANTOINE       1811480510
#>  8 Physician VAMSI     REDDY MALLU   1750229845
#>  9 Physician VANESA    WEBB-BARRAGAN 1487502654
#> 10 Physician VANESSA   DE BARROS     1487529939
#> # ℹ 176 more rows
```
