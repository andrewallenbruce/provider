# Pending Medicare Enrollments

Providers with pending Medicare enrollment applications.

## Usage

``` r
pending(npi = NULL, first = NULL, last = NULL)
```

## Arguments

- npi:

  `<int>` National Provider Identifier

- first, last:

  `<chr>` Provider's name

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)

## References

- [Medicare Pending Initial Logging and Tracking Physicians
  API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/pending-initial-logging-and-tracking-physicians)

- [Medicare Pending Initial Logging and Tracking Non-Physicians
  API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/pending-initial-logging-and-tracking-non-physicians)

## Examples

``` r
# pending(first = "John")
```
