# Quality Payment Program Eligibility

Access to information on eligibility in the Merit-based Incentive
Payment System (MIPS) and Advanced Alternative Payment Models (APMs)
tracks.

Data pulled from across CMS is used to create an eligibility
determination for a clinician. Using what CMS knows about a clinician
from their billing patterns and enrollments, eligibility is "calculated"
multiple times before and during the performance year.

## Usage

``` r
quality_eligibility(
  year,
  npi,
  tidy = TRUE,
  unnest = TRUE,
  pivot = TRUE,
  na.rm = FALSE,
  stats = FALSE,
  ...
)

quality_eligibility_(year = 2017:2023, ...)
```

## Arguments

- year:

  \< *integer* \> // **required** Year data was reported, in `YYYY`
  format. Run
  [`qpp_years()`](https://andrewallenbruce.github.io/provider/reference/years.md)
  to return a vector of the years currently available.

- npi:

  \< *integer* \> 10-digit Individual National Provider Identifier
  assigned to the clinician when they enrolled in Medicare. Multiple
  rows for the same NPI indicate multiple TIN/NPI combinations.

- tidy:

  \< *boolean* \> // **default:** `TRUE` Tidy output

- unnest:

  \< *boolean* \> // **default:** `TRUE` Tidy output

- pivot:

  \< *boolean* \> // **default:** `TRUE` Tidy output

- na.rm:

  \< *boolean* \> // **default:** `FALSE` Remove empty rows and columns

- stats:

  \< *boolean* \> // **default:** `FALSE` Return QPP stats

- ...:

  Pass arguments to `quality_eligibility()`.

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
containing the search results.

## Quality Payment Program (QPP) Eligibility

The QPP Eligibility System aggregates data from across CMS to create an
eligibility determination for every clinician in the system. Using what
CMS knows about a clinician from their billing patterns and enrollments,
eligibility is "calculated" multiple times before and during the
performance year.

The information contained in these endpoints includes basic enrollment
information, associated organizations, information about those
organizations, individual and group special status information, and in
the future, any available Alternative Payment Model (APM) affiliations.

## Types

- **Clinicians** represent healthcare providers and are referenced using
  a NPI.

- **Practices** represent a clinician or group of clinicians that assign
  their billing rights to the same TIN. These are represented with a
  TIN, EIN, or SSN, and querying by this number requires an
  authorization token.

- **Virtual Groups** represent a combination of two or more TINs with
  certain characteristics, represented by a virtual group identifier,
  also requiring an authorization token.

- **APM Entities** represent a group of practices which participate in
  an APM, characterized by an APM Entity ID.

## **stats** == `TRUE`

Public statistics derived from all QPP providers:

### HCC Risk Score Average:

National average individual (NPI) or group (TIN) risk score for MIPS
eligible individual/group. Scores are calculated as follows:

- **Individual** = `sum(Clinician Risk Scores) / n(Eligible Clinicians)`

- **Group** = `sum(Practice Risk Scores) / n(Eligible Practices)`

### Dual Eligibility Average:

National average individual (NPI) or group (TIN) dual-eligibility score
for MIPS eligible individual/group.

- **Individual** =
  `sum(Clinician Dual-Eligibility Scores) / n(Eligible Clinicians)`

- **Group** = sum(Practice Dual-Eligibility Scores) / n(Eligible
  Practices)

## Links

- [QPP Eligibility API
  Documentation](https://cmsgov.github.io/qpp-eligibility-docs/)

- [QPP Eligibility & MVP/CAHPS/Subgroups Registration Services
  (v6)](https://qpp.cms.gov/api/eligibility/docs/?urls.primaryName=Eligibility%2C%20v6)

- [QPP Eligibility & MVP/CAHPS/Subgroups Registration Services (v6)
  (Multiple
  NPIs)](https://qpp.cms.gov/api/eligibility/docs/?urls.primaryName=Eligibility%2C%20v6#/Unauthenticated/get_api_eligibility_npis__npi_)

## Update Frequency

**Annually**

## Examples

``` r
if (FALSE) { # interactive()
# Single NPI/year
quality_eligibility(year = 2020, npi = 1144544834)

# Multiple NPIs
aff_npis <- affiliations(facility_ccn = 331302) |>
            dplyr::pull(npi)

quality_eligibility(year = 2021,
                    npi = c(aff_npis[1:5],
                            1234567893,
                            1043477615,
                            1144544834))

# Multiple NPIs/years
2017:2023 |>
purrr::map(\(x)
       quality_eligibility(year = x,
                           npi = c(aff_npis[1:5],
                                   1234567893,
                                   1043477615,
                                   1144544834))) |>
       purrr::list_rbind()

# Same as
quality_eligibility_(npi = c(aff_npis[1:5],
                             1234567893,
                             1043477615,
                             1144544834))

# Quality Stats
2017:2023 |>
purrr::map(\(x) quality_eligibility(year = x, stats = TRUE)) |>
purrr::list_rbind()

# Same as
quality_eligibility_(stats = TRUE)
}
```
