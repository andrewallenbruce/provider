# Quality Payment Program Experience

Allows the user access to information on participation and performance
in the Merit-based Incentive Payment System (MIPS) and Advanced
Alternative Payment Models (APMs) tracks.

## Usage

``` r
quality_payment(
  year,
  npi = NULL,
  state = NULL,
  specialty = NULL,
  type = NULL,
  tidy = FALSE,
  nest = FALSE,
  eligibility = FALSE,
  ...
)

quality_payment_(year = qpp_years(), ...)
```

## Arguments

- year:

  \< *integer* \> // **required** Year data was reported, in `YYYY`
  format. Run
  [`qpp_years()`](https://andrewallenbruce.github.io/provider/reference/years.md)
  to return a vector of the years currently available.

- npi:

  `<int>` 10-digit Individual National Provider Identifier assigned to
  the clinician when they enrolled in Medicare. Multiple rows for the
  same NPI indicate multiple TIN/NPI combinations.

- state:

  `<chr>` State or US territory code location of the TIN associated with
  the clinician.

- specialty:

  `<chr>` Specialty corresponding to the type of service that the
  clinician submitted most on their Medicare Part B claims for this
  TIN/NPI combination.

  - Nurse Practitioner

  - Internal Medicine

  - Physician Assistant

  - Family Practice

  - Emergency Medicine

  - Diagnostic Radiology

  - Anesthesiology

  - Neurology

  - Cardiology

- type:

  `<chr>` Participation type; level at which the performance data was
  collected, submitted or reported for the final score attributed to the
  clinician; drives most of the data returned.

  - `"Group"`

  - `"Individual"`

  - `"MIPS APM"`

- tidy:

  `<lgl>` // **default:** `TRUE` Tidy output

- nest:

  `<lgl>` // **default:** `TRUE` Nest `status` & `measures`

- eligibility:

  `<lgl>` // **default:** `TRUE` Append results from
  [`quality_eligibility()`](https://andrewallenbruce.github.io/provider/reference/quality_eligibility.md)

- ...:

  Pass arguments to `quality_payment()`.

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
containing the search results.

## Quality Payment Program (QPP) Experience

The QPP dataset provides participation and performance information in
the Merit-based Incentive Payment System (MIPS) during each performance
year. They cover eligibility and participation, performance categories,
final score and payment adjustments. The dataset provides additional
details at the TIN/NPI level on what was published in the previous
performance year.

## Links

- [Quality Payment Program
  Experience](https://data.cms.gov/quality-of-care/quality-payment-program-experience)

## Update Frequency

**Annually**

## Examples

``` r
if (FALSE) { # interactive()
quality_payment(year = 2020, npi = 1144544834)

quality_payment(year = 2022, npi = 1043477615)
}
```
