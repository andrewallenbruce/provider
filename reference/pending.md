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

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)

## Examples

``` r
pending(count = TRUE)
#> Error in c("cli::cli_alert_info(c(\"{.strong {endpoint}} has \", \"{.strong {mark(x)}} \", ", "    \"{cli::qty(x)}row{?s}.\"))"): ! Could not evaluate cli `{}` expression: `mark(x)`.
#> Caused by error in `uuid_cms_list(self@end)`:
#> ! `endpoint` "eval" is invalid.

pending(first = "Victor", count = TRUE)
#> Error in uuid_cms_list(self@end): `endpoint` "eval" is invalid.

pending(first = starts("V"))
#> Error in uuid_cms_list(self@end): `endpoint` "eval" is invalid.
```
