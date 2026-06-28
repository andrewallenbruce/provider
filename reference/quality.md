# Quality Payment Program

The Quality Payment Program (QPP) Experience dataset provides
participation and performance information in the Merit-based Incentive
Payment System (MIPS) during each performance year. They cover
eligibility and participation, performance categories, and final score
and payment adjustments.

## Usage

``` r
quality(
  year = NULL,
  npi = NULL,
  state = NULL,
  size = NULL,
  specialty = NULL,
  years = NULL,
  patients = NULL,
  services = NULL,
  charges = NULL,
  final_score = NULL,
  adjustment = NULL,
  count = FALSE
)

metrics(year = NULL)
```

## Arguments

- year:

  `<int>` A vector of years; for `quality()`, 2013-2024; for `metrics()`
  2018-2025

- npi:

  `<int>` National Provider Identifier. Multiple rows for the same NPI
  indicate that an individual clinician has reassigned billing rights to
  multiple TINs and was identified as a MIPS eligible clinician under
  multiple TIN/NPI combinations.

- state:

  `<chr>` The practice state of the TIN associated with the clinician.

- size:

  `<int>` Number of clinicians associated with the TIN through Medicare
  Part B claims for the performance year.

- specialty:

  `<chr>` Derived from the specialty codes in Medicare Part B claims.

- years:

  `<int>` Number of years since NPI's first approved enrollment date
  across all enrollments in PECOS.

- patients:

  `<int>` Number of Medicare patients who received covered professional
  services during MIPS eligibility determination period.

- services:

  `<int>` Number of covered professional services provided to Medicare
  Part B patients with a service date during MIPS eligibility
  determination period.

- charges:

  `<int>` Allowed charges under the PFS on Medicare Part B claims with a
  service date during MIPS eligibility determination period.

- final_score:

  `<int>` The MIPS final score attributed to the clinician (identified
  by TIN/NPI combination).

- adjustment:

  `<dbl>` Determined by comparing the `final_score` to performance
  thresholds and scaling to ensure budget neutrality.

  - The **Maximum negative** adjustment is `-9%`. (`final_score` = 0 -
    18.75)

  - A **negative** adjustment is between `-9%` and`0%`. (`final_score` =
    18.76 - 74.99)

  - A **neutral** adjustment is `0%`. (`final_score` = 75)

  - A **positive** adjustment is greater than `0%`. (`final_score` =
    75.01 - 100)

- count:

  `<lgl>` Return the total row count

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
containing the search results.

## Details

The dataset provides additional details at the TIN/NPI level on what was
published in the previous performance year. You can sort the data by
variables like clinician type, practice size, scores, and payment
adjustments.

## Examples

``` r
quality(year = c(2021, 2024), state = "GA", count = TRUE)
#> Error in switch(x, pending = list(Physician = "6bd6b1dd-208c-4f9c-88b8-b15fec6db548",     `Non-Physician` = "261b83b6-b89f-43ad-ae7b-0d419a3bc24b"),     facility = list(HHA = "15f64ab4-3172-4a27-b589-ebd67a6d28aa",         RHC = "3b7e7659-067e-41ea-8e36-f9ee2036e1f6", FQHC = "4bcae866-3411-439a-b762-90a6187c194b",         SNF = "5f2c306f-3b1c-42cd-b037-187b2ce22126", Hospice = "25704213-e833-4b8b-9dbc-58dd17149209"),     owner = list(HHA = "fc009b2d-7846-44b1-b4a1-692f0c143879",         RHC = "ab03c9bc-0c22-4ca4-b032-21dd3408210d", FQHC = "ed289c89-0bb8-4221-a20a-85776066381b",         SNF = "a4358712-e910-4eaf-8f24-5e90ba3cf8d0", Hospice = "e983965e-1603-4cb8-82b5-c40090e380d1",         Hospital = "60625dc8-b621-45f0-9423-077fd133b13e"), quality = cms_temporal("^Quality"),     utilization = cms_temporal("Practitioners - by Provider :"),     service = cms_temporal("Practitioners - by Provider and Service :"),     geography = cms_temporal("Practitioners - by Geography and Service :"),     cli::cli_abort("{.strong {.pkg CMS LIST} Endpoint} `{.field {x}}` not found.")): EXPR must be a length 1 vector

quality(npi = c(1003026055, 1316939655))
#> Error in switch(x, pending = list(Physician = "6bd6b1dd-208c-4f9c-88b8-b15fec6db548",     `Non-Physician` = "261b83b6-b89f-43ad-ae7b-0d419a3bc24b"),     facility = list(HHA = "15f64ab4-3172-4a27-b589-ebd67a6d28aa",         RHC = "3b7e7659-067e-41ea-8e36-f9ee2036e1f6", FQHC = "4bcae866-3411-439a-b762-90a6187c194b",         SNF = "5f2c306f-3b1c-42cd-b037-187b2ce22126", Hospice = "25704213-e833-4b8b-9dbc-58dd17149209"),     owner = list(HHA = "fc009b2d-7846-44b1-b4a1-692f0c143879",         RHC = "ab03c9bc-0c22-4ca4-b032-21dd3408210d", FQHC = "ed289c89-0bb8-4221-a20a-85776066381b",         SNF = "a4358712-e910-4eaf-8f24-5e90ba3cf8d0", Hospice = "e983965e-1603-4cb8-82b5-c40090e380d1",         Hospital = "60625dc8-b621-45f0-9423-077fd133b13e"), quality = cms_temporal("^Quality"),     utilization = cms_temporal("Practitioners - by Provider :"),     service = cms_temporal("Practitioners - by Provider and Service :"),     geography = cms_temporal("Practitioners - by Geography and Service :"),     cli::cli_abort("{.strong {.pkg CMS LIST} Endpoint} `{.field {x}}` not found.")): EXPR must be a length 1 vector

metrics()
#> # A tibble: 32 × 4
#>     year category   metric               mean
#>    <int> <chr>      <chr>               <dbl>
#>  1  2018 Group      Dual Eligible Ratio 0.230
#>  2  2019 Group      Dual Eligible Ratio 0.216
#>  3  2020 Group      Dual Eligible Ratio 0.210
#>  4  2021 Group      Dual Eligible Ratio 0.208
#>  5  2022 Group      Dual Eligible Ratio 0.211
#>  6  2023 Group      Dual Eligible Ratio 0.206
#>  7  2024 Group      Dual Eligible Ratio 0.202
#>  8  2025 Group      Dual Eligible Ratio 0.202
#>  9  2018 Individual Dual Eligible Ratio 0.288
#> 10  2019 Individual Dual Eligible Ratio 0.269
#> # ℹ 22 more rows
```
