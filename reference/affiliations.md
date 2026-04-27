# Provider-Facility Affiliations

Access information concerning individual providers' affiliations with
organizations/facilities.

## Usage

``` r
affiliations(
  npi = NULL,
  pac = NULL,
  first = NULL,
  middle = NULL,
  last = NULL,
  suffix = NULL,
  facility_type = NULL,
  facility_ccn = NULL,
  parent_ccn = NULL,
  count = FALSE,
  set = FALSE
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

- first, middle, last, suffix:

  `<chr>` Individual provider's name

- facility_type:

  `<enum>` facility type:

  - `esrd` = Dialysis facility

  - `hha` = Home health agency

  - `hospice` = Hospice

  - `hospital` = Hospital

  - `irf` = Inpatient rehabilitation facility

  - `ltch` = Long-term care hospital

  - `nurse` = Nursing home

  - `snf` = Skilled nursing facility

- facility_ccn:

  `<chr>` CCN of `facility_type` column's facility **or** of a **unit**
  within the hospital where the individual provider provides services.

- parent_ccn:

  `<int>` CCN of the **primary** hospital containing the unit where the
  individual provider provides services.

- count:

  `<lgl>` Return the total row count

- set:

  `<lgl>` Return the entire dataset

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)

## Examples

``` r
affiliations(count = TRUE)
#> Error in c("cli::cli_alert_info(c(\"{.strong {endpoint}} has \", \"{.strong {mark(x)}} \", ", "    \"{cli::qty(x)}row{?s}.\"))"): ! Could not evaluate cli `{}` expression: `mark(x)`.
#> Caused by error in `uuid_prov(self@end)`:
#> ! `endpoint` "eval" is invalid.
affiliations(count = TRUE, facility_ccn = 331302)
#> Error in uuid_prov(self@end): `endpoint` "eval" is invalid.
affiliations()
#> ! eval ❯ No Query
#> ℹ Returning first 10 rows...
#> Error in uuid_prov(self@end): `endpoint` "eval" is invalid.
affiliations(parent_ccn = 331302)
#> Error in uuid_prov(self@end): `endpoint` "eval" is invalid.
affiliations(facility_ccn = 331302)
#> Error in uuid_prov(self@end): `endpoint` "eval" is invalid.
affiliations(first = "Andrew",
             last = contains("B"),
             facility_type = "hospital")
#> Error in uuid_prov(self@end): `endpoint` "eval" is invalid.
```
