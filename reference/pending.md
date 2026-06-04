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
#> ✔ pending returned 11,737 results.
#> • Physician     : 5,613
#> • Non-Physician : 6,124

pending(first = "Victor", count = TRUE)
#> ✔ pending returned 7 results.
#> • Physician     : 5
#> • Non-Physician : 2
#> Error in purrr::map_int(url, base_request, query = query): ℹ In index: 1.
#> Caused by error in `httr2::req_perform()`:
#> ! Failed to parse error body with method defined in `req_error()`.
#> Caused by error in `httr2::resp_body_json()`:
#> ! Unexpected content type "text/html".
#> • Expecting type "application/json" or suffix "json".

pending(first = starts("V"))
#> Error in purrr::map_int(url, base_request, query = query): ℹ In index: 1.
#> Caused by error in `httr2::req_perform()`:
#> ! Failed to parse error body with method defined in `req_error()`.
#> Caused by error in `httr2::resp_body_json()`:
#> ! Unexpected content type "text/html".
#> • Expecting type "application/json" or suffix "json".
```
