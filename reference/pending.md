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
#> ✔ `pending` returned 9,799 results.
#> • Physician     : 3,225
#> • Non-Physician : 6,574
pending(first = "Victor", count = TRUE)
#> ✔ `pending` returned 9 results.
#> • Physician     : 7
#> • Non-Physician : 2
pending(first = starts_with("V"))
#> ✔ `pending` returned 136 results.
#> • Physician     : 37
#> • Non-Physician : 99
#> # A tibble: 136 × 4
#>    prov_type first   last        npi       
#>    <fct>     <chr>   <chr>       <chr>     
#>  1 Physician VADIN   LALL DASS   1144512724
#>  2 Physician VALERIE ESPINOZA    1669050084
#>  3 Physician VALERIE LOPEZ       1073258638
#>  4 Physician VALJEAN BACOT-DAVIS 1407597651
#>  5 Physician VANESSA LOUISSAINT  1386093193
#>  6 Physician VANESSA PARVEZ      1982465530
#>  7 Physician VANESSA SANCHEZ     1275197329
#>  8 Physician VANESSA STOLOFF     1477616779
#>  9 Physician VANESSA TRIVINO     1124765284
#> 10 Physician VANESSA WOOSLEY     1326877440
#> # ℹ 126 more rows
```
