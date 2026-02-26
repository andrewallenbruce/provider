# Provider Facility Affiliations

`affiliations()` allows the user access to data concerning providers'
facility affiliations

## Usage

``` r
affiliations(
  npi = NULL,
  pac = NULL,
  first = NULL,
  middle = NULL,
  last = NULL,
  type = NULL,
  ccn_unit = NULL,
  ccn_parent = NULL,
  tidy = TRUE,
  ...
)
```

## Arguments

- npi:

  `<chr>` Unique 10-digit National Provider Identifier number issued by
  CMS to US healthcare providers through NPPES.

- pac:

  `<int>` Unique 10-digit Provider Associate-level Control ID (PAC),
  assigned to each individual or organization in PECOS. The PAC ID links
  all entity-level information (e.g., tax identification numbers and
  organizational names) and may be associated with multiple enrollment
  IDs if the individual or organization enrolled multiple times under
  different circumstances.

- first, middle, last:

  `<chr>` Individual provider's name(s)

- type:

  `<chr>` Type of facility, one of the following:

  - `"hp"` = Hospital

  - `"lt"` = Long-term care hospital

  - `"nh"` = Nursing home

  - `"irf"` = Inpatient rehabilitation facility

  - `"hha"` = Home health agency

  - `"snf"` = Skilled nursing facility

  - `"hs"` = Hospice

  - `"df"` = Dialysis facility

- ccn_unit:

  `<chr>` 6-digit CCN of facility or unit within hospital where an
  individual provider provides service.

- ccn_parent:

  `<int>` 6-digit CCN of a sub-unit's primary hospital, should the
  provider provide services in said unit.

- tidy:

  `<lgl>` Tidy output; **default** is `TRUE`

- ...:

  Empty dots

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
containing the search results.

## Links

- [Physician Facility
  Affiliations](https://data.cms.gov/provider-data/dataset/27ea-46a8)

- [Certification Number (CCN) State
  Codes](https://www.cms.gov/Medicare/Provider-Enrollment-and-Certification/SurveyCertificationGenInfo/Downloads/Survey-and-Cert-Letter-16-09.pdf)

*Update Frequency:* **Monthly**

## Examples

``` r
if (FALSE) { # interactive()
affiliations(parent_ccn = 670055)
}
```
