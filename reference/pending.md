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

  description

- npi:

  `<int>` National Provider Identifier

- first, last:

  `<chr>` Provider's name

- count:

  `<lgl>` Return the total row count

## Examples

``` r
pending(count = TRUE)
#> pending Totals
#> Error in purrr::map_int(url, base_request, query = query): ℹ In index: 1.
#> Caused by error in `httr2::req_perform()`:
#> ! HTTP 429 Too Many Requests.

pending(first = "Victor", count = TRUE)
#> Error in purrr::map_int(url, base_request, query = query): ℹ In index: 1.
#> Caused by error in `httr2::req_perform()`:
#> ! HTTP 429 Too Many Requests.

pending(first = starts("V"))
#> Error in purrr::map_int(url, base_request, query = query): ℹ In index: 1.
#> Caused by error in `httr2::req_perform()`:
#> ! HTTP 429 Too Many Requests.
```
