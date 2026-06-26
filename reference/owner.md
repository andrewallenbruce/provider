# Owners

Owners of facilities enrolled in Medicare.

## Usage

``` r
owner(
  fac_type = NULL,
  org_enid = NULL,
  org_pac = NULL,
  org_name = NULL,
  pac = NULL,
  owner = NULL,
  dba = NULL,
  percent = NULL,
  role = NULL,
  entity = NULL,
  first = NULL,
  last = NULL,
  title = NULL,
  address = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  count = FALSE
)
```

## Source

Medicare

## Arguments

- fac_type:

  `<enum>` Facility type; if NULL (default), will search all:

  - `HHA` = Home Health Agency

  - `RHC` = Rural Health Clinic

  - `FQHC` = Federally Qualified Health Clinic

  - `SNF` = Skilled Nursing Facility

  - `Hospice` = Hospice

  - `Hospital` = Hospital

- org_enid:

  `<chr>` National Provider Identifier

- org_pac:

  `<chr>` Provider's name

- org_name:

  `<chr>` Provider's name

- pac:

  `<chr>` Provider's name

- owner:

  `<chr>` Provider's name

- dba:

  `<chr>` Provider's name

- percent:

  `<dbl>` Provider's name

- role:

  `<chr>` Provider's name

- entity:

  `<enum>` Provider's name

- first, last:

  `<chr>` Provider's name

- title:

  `<chr>` Provider's name

- address, city, state, zip:

  `<chr>` Provider's name

- count:

  `<lgl>` Return the total row count

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
containing the search results.

## Examples

``` r
owner(city = "Valdosta", state = "GA")
#> ✔ owner returned 13 results
#> ✔ Retrieving 4 pages
#> Error in purrr::map(httr2::req_perform_parallel(purrr::map(flatten_cms(u,     x@query), httr2::request), on_error = "continue"), parse_string): ℹ In index: 1.
#> Caused by error in `httr2::resp_body_string()`:
#> ! `resp` must be an HTTP response object, not a <httr2_failure> object.
```
