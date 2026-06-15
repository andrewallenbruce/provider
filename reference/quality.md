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
#> # A tibble: 10 × 25
#>     year        npi state  size specialty        years patients services charges
#>    <int>      <int> <chr> <int> <chr>            <int>    <int>    <int>   <int>
#>  1  2017 1003026055 FL      189 Endocrinology        8    13189       NA  5.84e6
#>  2  2017 1003026055 NC      191 Endocrinology        8    14784       NA  8.90e6
#>  3  2018 1003026055 FL      135 Endocrinology        8    12317        0  5.02e6
#>  4  2019 1003026055 FL      150 Endocrinology        9    12415    52009  5.62e6
#>  5  2020 1003026055 FL      151 Endocrinology       10    12917    53599  5.46e6
#>  6  2020 1003026055 FL        7 Endocrinology       10     1244     8160  7.19e5
#>  7  2020 1316939655 NY      295 Missing             16    22242   101308  9.12e6
#>  8  2021 1003026055 FL        9 Endocrinology       11     1181     7068  6.98e5
#>  9  2021 1316939655 NY      455 Physician Assis…    17    23586   116187  1.09e7
#> 10  2022 1316939655 NY      352 Physician Assis…    18    23244   110514  1.05e7
#> # ℹ 16 more variables: final_score <dbl>, adjustment <dbl>, pi_score <int>,
#> #   qa_score <dbl>, complex_bonus <dbl>, participation <chr>, qi_score <dbl>,
#> #   ia_score <int>, cost_score <dbl>, indicators <chr>, cred <chr>,
#> #   dual_ratio <dbl>, small_bonus <int>, reporting <chr>, mvp <chr>,
#> #   ci_score <dbl>

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
