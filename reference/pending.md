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
