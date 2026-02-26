# Beneficiary Enrollment in Medicare

Access current data on enrolled Medicare beneficiaries.

## Usage

``` r
beneficiaries(
  year = NULL,
  period = NULL,
  level = NULL,
  state = NULL,
  county = NULL,
  fips = NULL,
  tidy = TRUE,
  ...
)
```

## Arguments

- year:

  \< *integer* \> Calendar year of Medicare enrollment; current years
  can be checked with:

  - `bene_years("year")`: Years available for all 12 months

  - `bene_years("month")`: Years available for individual months

- period:

  \< *character* \> Time frame of Medicare enrollment; options are
  `"Year"`, `Month`, or any individual month name

- level:

  \< *character* \> Geographic level of data; options are `"National"`,
  `"State"`, or `"County"`

- state:

  \< *character* \> Full state name or abbreviation of beneficiary
  residence

- county:

  \< *character* \> County of beneficiary residence

- fips:

  \< *character* \> FIPS code of beneficiary residence

- tidy:

  \< *boolean* \> // **default:** `TRUE` Tidy output

- ...:

  Empty

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
with the columns:

|                     |                                                         |
|---------------------|---------------------------------------------------------|
| **Field**           | **Description**                                         |
| `year`              | Enrollment calendar year                                |
| `period`            | Enrollment time frame                                   |
| `level`             | Geographic level of data                                |
| `state`             | Beneficiary residence state                             |
| `state_name`        | Beneficiary residence state name                        |
| `county`            | Beneficiary residence county                            |
| `fips`              | Beneficiary residence FIPS code                         |
| `bene_total`        | Total Medicare beneficiaries                            |
| `bene_orig`         | Original Medicare beneficiaries                         |
| `bene_ma_oth`       | Medicare Advantage beneficiaries                        |
| `bene_total_aged`   | Aged beneficiaries                                      |
| `bene_aged_esrd`    | Aged beneficiaries with ESRD                            |
| `bene_aged_no_esrd` | Aged beneficiaries without ESRD                         |
| `bene_total_dsb`    | Disabled beneficiaries                                  |
| `bene_dsb_esrd`     | Disabled with ESRD and ESRD-only beneficiaries          |
| `bene_dsb_no_esrd`  | Disabled beneficiaries without ESRD                     |
| `bene_total_ab`     | Total Medicare Part A and B beneficiaries               |
| `bene_ab_orig`      | Original Medicare Part A and B beneficiaries            |
| `bene_ab_ma_oth`    | Medicare Advantage Part A and B beneficiaries           |
| `bene_total_rx`     | Total Medicare Part D beneficiaries                     |
| `bene_rx_pdp`       | Medicare Prescription Drug Plan beneficiaries           |
| `bene_rx_mapd`      | Medicare Advantage Prescription Drug Plan beneficiaries |
| `bene_rx_lis_elig`  | Part D Low Income Subsidy Eligible (Full) Beneficiaries |
| `bene_rx_lis_full`  | Part D Low Income Subsidy Full Beneficiaries            |
| `bene_rx_lis_part`  | Part D Low Income Subsidy Partial Beneficiaries         |
| `bene_rx_lis_no`    | Part D No Low Income Subsidy Beneficiaries              |

## Medicare Monthly Enrollment

Current monthly information on the number of Medicare beneficiaries with
hospital/medical coverage and prescription drug coverage, available for
several geographic areas including national, state and county.

The hospital/medical coverage data can be broken down further by health
care delivery (Original Medicare versus Medicare Advantage and Other
Health Plans) and the prescription drug coverage data can be examined by
those enrolled in stand-alone Prescription Drug Plans and those enrolled
in Medicare Advantage Prescription Drug plans.

The dataset includes enrollee counts on a *rolling 12 month basis*.

## Links

- [Medicare Monthly
  Enrollment](https://data.cms.gov/summary-statistics-on-beneficiary-enrollment/medicare-and-medicaid-reports/medicare-monthly-enrollment)

*Update Frequency:* **Monthly**

## Examples

``` r
if (FALSE) { # interactive()
beneficiaries(year   = 2022,
              period = "Year",
              level  = "County",
              county = "Autauga")

beneficiaries(year   = 2022,
              period = "July",
              state  = "Georgia")

beneficiaries(level = "State", fips  = "10")
}
```
