# Provider-Facility Affiliations

Access information concerning individual providers' affiliations with
organizations/facilities.

## Usage

``` r
affiliations(
  npi = NULL,
  pac = NULL,
  first = NULL,
  last = NULL,
  fac_type = NULL,
  ccn = NULL,
  parent_ccn = NULL,
  count = FALSE
)
```

## Source

- [API: Physician Facility
  Affiliations](https://data.cms.gov/provider-data/dataset/27ea-46a8)

## Arguments

- npi:

  `<int>` Individual National Provider Identifier

- pac:

  `<chr>` Individual PECOS Associate Control ID

- first, last:

  `<chr>` Individual provider's name

- fac_type:

  `<enum>` facility type:

  - `esrd` = Dialysis facility

  - `hha` = Home health agency

  - `hospice` = Hospice

  - `hospital` = Hospital

  - `irf` = Inpatient rehabilitation facility

  - `ltch` = Long-term care hospital

  - `nurse` = Nursing home

  - `snf` = Skilled nursing facility

- ccn:

  `<chr>` CCN of `fac_type` column's facility **or** of a **unit**
  within the hospital where the individual provider provides services.

- parent_ccn:

  `<int>` CCN of the **primary** hospital containing the unit where the
  individual provider provides services.

- count:

  `<lgl>` Return the total row count

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
containing the search results.

## Examples

``` r
affiliations(count = TRUE)
#> Error in httr2::req_perform(httr2::request(flatten_pdc(S7::prop(x, "url"),     S7::prop(x, "query"), results = "false"))): HTTP 503 Service Unavailable.
affiliations(ccn = 331302)
#> Error in httr2::req_perform(httr2::request(flatten_pdc(S7::prop(x, "url"),     S7::prop(x, "query"), results = "false"))): HTTP 503 Service Unavailable.
affiliations(parent_ccn = 331302)
#> Error in httr2::req_perform(httr2::request(flatten_pdc(S7::prop(x, "url"),     S7::prop(x, "query"), results = "false"))): HTTP 503 Service Unavailable.
```
