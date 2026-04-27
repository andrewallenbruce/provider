# Rural Health Clinic Owners

Providers with pending Medicare enrollment applications.

## Usage

``` r
rhc_owner(npi = NULL, first = NULL, last = NULL, count = FALSE, set = FALSE)
```

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
rhc_owner(count = TRUE)
#> Error in c("cli::cli_alert_info(c(\"{.strong {endpoint}} has \", \"{.strong {mark(x)}} \", ", "    \"{cli::qty(x)}row{?s}.\"))"): ! Could not evaluate cli `{}` expression: `mark(x)`.
#> Caused by error in `uuid_cms(self@end)`:
#> ! `endpoint` "eval" is invalid.

rhc_owner() |> str()
#> ! eval ❯ No Query
#> ℹ Returning first 10 rows...
#> Error in uuid_cms(self@end): `endpoint` "eval" is invalid.
```
