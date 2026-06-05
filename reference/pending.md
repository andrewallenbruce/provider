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
#> ✔ pending returned 12,236 results.
#> • Physician     : 6,057
#> • Non-Physician : 6,179

pending(first = "Victor", count = TRUE)
#> ✔ pending returned 7 results.
#> • Physician     : 5
#> • Non-Physician : 2

pending(first = starts("V"))
#> ✔ pending returned 165 results.
#> • Physician     : 74
#> • Non-Physician : 91
#> ℹ Retrieving 2 pages
#> Error in "\"id\" %in% names(args)": ! Could not evaluate cli `{}` expression: `x@pages`.
#> Caused by error in `eval(expr, envir = envir)`:
#> ! object 'x' not found
#> ✖ Retrieving 2 pages [675ms]
#> 
```
