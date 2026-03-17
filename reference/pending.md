# Pending Medicare Enrollments

Providers with pending Medicare enrollment applications.

## Usage

``` r
pending(npi = NULL, first = NULL, last = NULL, count = FALSE)
```

## Source

- [Medicare Pending Initial Logging and Tracking Physicians
  API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/pending-initial-logging-and-tracking-physicians)

- [Medicare Pending Initial Logging and Tracking Non-Physicians
  API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/pending-initial-logging-and-tracking-non-physicians)

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
#> ✔ `pending` returned 9,899 results.
#> ◉ Physician     : 3,271
#> ◉ Non-Physician : 6,628
pending(first = "Victor", count = TRUE)
#> ✔ `pending` returned 8 results.
#> ◉ Physician     : 6
#> ◉ Non-Physician : 2
pending(first = starts_with("V"), count = TRUE)
#> ✔ `pending` returned 139 results.
#> ◉ Physician     : 39 
#> ◉ Non-Physician : 100
```
