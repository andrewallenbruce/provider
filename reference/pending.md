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
#> ✔ `pending()` returned 0 results.
pending(first = starts_with("J"))
#> ✔ `pending()` returned 0 results.
```
