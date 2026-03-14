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
pending(first = "John")
#> ✔ Query returned 41 results.
#> # A tibble: 41 × 3
#>    npi        first last   
#>    <chr>      <chr> <chr>  
#>  1 1881791739 JOHN  ADAMS  
#>  2 1255696514 JOHN  BAUMANN
#>  3 1841280963 JOHN  BIGBEE 
#>  4 1619996378 JOHN  BODDEN 
#>  5 1902873300 JOHN  BRET   
#>  6 1588744569 JOHN  BRUNO  
#>  7 1861142556 JOHN  BURKE  
#>  8 1306817531 JOHN  COMBS  
#>  9 1376571554 JOHN  FLYNN  
#> 10 1689774804 JOHN  FREEMAN
#> # ℹ 31 more rows
```
