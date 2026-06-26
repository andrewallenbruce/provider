# Facilities

Facilities enrolled in Medicare.

## Usage

``` r
facility(
  fac_type = NULL,
  npi = NULL,
  ccn = NULL,
  pac = NULL,
  enid = NULL,
  org_name = NULL,
  org_dba = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  multi = NULL,
  status = NULL,
  org_type = NULL,
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

- npi:

  `<int>` National Provider Identifier

- ccn:

  `<int>` CMS Certification Number

- pac:

  `<chr>` PECOS Associate Control ID

- enid:

  `<chr>` Medicare Enrollment ID

- org_name:

  `<chr>` Legal business name

- org_dba:

  `<chr>` Doing-business-as name

- city, state, zip:

  `<chr>` Location city, state, zip

- multi:

  `<lgl>` Does facility have more than one NPI?

- status:

  `<enum>` Facility organization status

  - `P` = Proprietary

  - `N` = Non-Profit

  - `D` = Unknown

- org_type:

  `<enum>` Facility organization structure type

  - `corp` = Corporation

  - `other` = Other

  - `llc` = LLC

  - `part` = Partnership

  - `sole` = Sole Proprietor

- count:

  `<lgl>` Return the total row count

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
containing the search results.

## Examples

``` r
facility(city = "Valdosta", state = "GA")
#> ✔ facility returned 12 results
#> ✔ Retrieving 4 pages
#> Error in purrr::map(httr2::req_perform_parallel(purrr::map(flatten_cms(u,     x@query), httr2::request), on_error = "continue"), parse_string): ℹ In index: 1.
#> Caused by error in `httr2::resp_body_string()`:
#> ! `resp` must be an HTTP response object, not a <httr2_failure> object.
```
