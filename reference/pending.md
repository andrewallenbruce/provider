# Pending Medicare Enrollments

Providers with pending Medicare enrollment applications.

The *Pending Initial Logging and Tracking (L & T)* dataset provides a
list of pending applications for both Physicians and Non-Physicians that
have not been processed by CMS contractors.

## Usage

``` r
pending(prov_type = NULL, npi = NULL, first = NULL, last = NULL, count = FALSE)
```

## Source

Medicare Pending Initial Logging and Tracking:

- [API:
  Physicians](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/pending-initial-logging-and-tracking-physicians)

- [API:
  Non-Physicians](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/pending-initial-logging-and-tracking-non-physicians)

## Arguments

- prov_type:

  `<chr>` `"Physician"` or `"Non-Physician"`

- npi:

  `<int>` National Provider Identifier

- first, last:

  `<chr>` Provider's name

- count:

  `<lgl>` Return the total row count

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
containing the search results.

## Examples

``` r
pending(count = TRUE)
#> ◼ pending | 14,216 rows | 4 pages

pending(first = starts("V"))
#> ✔ pending returned 204 results
#> ✔ Retrieving 2 pages
#> Error in purrr::map(httr2::req_perform_parallel(purrr::map(flatten_cms(u,     x@query), httr2::request), on_error = "continue"), parse_string): ℹ In index: 1.
#> Caused by error in `httr2::resp_body_string()`:
#> ! `resp` must be an HTTP response object, not a <httr2_failure> object.
```
