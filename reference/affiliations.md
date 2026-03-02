# Provider Facility Affiliations

`affiliations()` allows the user access to data concerning providers'
facility affiliations

## Usage

``` r
affiliations(
  id = list(npi = NULL, pac = NULL, ccn = NULL),
  name = list(first = NULL, middle = NULL, last = NULL, suff = NULL),
  facility_type = NULL,
  ...
)
```

## Arguments

- id:

  `<list>` List of parameters that uniquely identify a provider, any of
  the following: `npi`, `pac`, `ccn`.

- name:

  `<list>` Individual provider's name(s), any of the following: `first`,
  `middle`, `last`, `suffix`

- facility_type:

  `<chr>` type of facility:

  - `"hp"` Hospital

  - `"lt"` Long-Term Care Hospital

  - `"nh"` Nursing Home

  - `"irf"` Inpatient Rehabilitation Facility

  - `"hha"` Home Health Agency

  - `"snf"` Skilled Nursing Facility

  - `"hs"` Hospice

  - `"df"` Dialysis Facility

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

## Examples

``` r
if (FALSE) { # interactive()
affiliations(id = list(ccn = 670055))
}
```
