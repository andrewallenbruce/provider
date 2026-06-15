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

## Details

The dataset provides additional details at the TIN/NPI level on what was
published in the previous performance year. You can sort the data by
variables like clinician type, practice size, scores, and payment
adjustments.

## Examples

``` r
quality(year = c(2021, 2024), state = "GA", count = TRUE)
#> ✔ quality returned 41,788 results

quality(npi = c(1003026055, 1316939655))
#> ✔ quality returned 10 results
#> ✔ Retrieving 6 pages
#> Error in purrr::map(c(2017, 2022, 2023), function(year) quality_get(x,     year)): ℹ In index: 1.
#> Caused by error in `collapse::recode_char()`:
#> ! X needs to be character or a list

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
