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
#> ✔ `pending` returned 9,759 results.
#> • Physician     : 3,252
#> • Non-Physician : 6,507
pending(first = "Victor", count = TRUE)
#> ✔ `pending` returned 9 results.
#> • Physician     : 7
#> • Non-Physician : 2
pending(first = starts_with("V"))
#> ✔ `pending` returned 145 results.
#> • Physician     : 43 
#> • Non-Physician : 102
#> # A tibble: 145 × 4
#>    prov_type first     last           npi       
#>    <fct>     <chr>     <chr>          <chr>     
#>  1 Physician VADIN     LALL DASS      1144512724
#>  2 Physician VALENTINA RODRIGUEZ      1710270442
#>  3 Physician VALERIA   LOZADA MIRANDA 1881291540
#>  4 Physician VALERIE   ESPINOZA       1669050084
#>  5 Physician VALJEAN   BACOT-DAVIS    1407597651
#>  6 Physician VANESSA   BUCKLEY        1588467930
#>  7 Physician VANESSA   LOUISSAINT     1386093193
#>  8 Physician VANESSA   PARVEZ         1982465530
#>  9 Physician VANESSA   SANCHEZ        1275197329
#> 10 Physician VANESSA   STOLOFF        1477616779
#> # ℹ 135 more rows
```
