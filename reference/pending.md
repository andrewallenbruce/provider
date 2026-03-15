# Pending Medicare Enrollments

Providers with pending Medicare enrollment applications.

## Usage

``` r
pending(npi = NULL, first = NULL, last = NULL, count = FALSE)
```

## Arguments

- npi:

  `<int>` National Provider Identifier

- first, last:

  `<chr>` Provider's name

- count:

  `<lgl>` Return the dataset's total row count

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)

## References

- [Medicare Pending Initial Logging and Tracking Physicians
  API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/pending-initial-logging-and-tracking-physicians)

- [Medicare Pending Initial Logging and Tracking Non-Physicians
  API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/pending-initial-logging-and-tracking-non-physicians)

## Examples

``` r
pending(count = TRUE)
#> ✔ `pending()` returned 9,899 results.
pending(first = "John")
#> ✔ `pending()` returned 66 results.
#> # A tibble: 66 × 4
#>    prov_type first last    npi       
#>    <fct>     <chr> <chr>   <chr>     
#>  1 Physician JOHN  ADAMS   1881791739
#>  2 Physician JOHN  BAUMANN 1255696514
#>  3 Physician JOHN  BIGBEE  1841280963
#>  4 Physician JOHN  BODDEN  1619996378
#>  5 Physician JOHN  BRET    1902873300
#>  6 Physician JOHN  BRUNO   1588744569
#>  7 Physician JOHN  BURKE   1861142556
#>  8 Physician JOHN  COMBS   1306817531
#>  9 Physician JOHN  FLYNN   1376571554
#> 10 Physician JOHN  FREEMAN 1689774804
#> # ℹ 56 more rows
pending(first = starts_with("J"))
#> ✔ `pending()` returned 0 results.
```
