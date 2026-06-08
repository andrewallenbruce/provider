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
  charges = NULL,
  services = NULL,
  final_score = NULL,
  adjustment = NULL,
  count = FALSE
)

metrics(year = NULL)
```

## Arguments

- year:

  `<int>` A vector of years from 2018 to 2025

- npi:

  `<int>` description

- state:

  description

- size:

  `<int>` description

- specialty:

  description

- years:

  `<int>` description

- patients:

  `<int>` description

- charges:

  `<int>` description

- services:

  `<int>` description

- final_score:

  `<int>` description

- adjustment:

  `<int>` description

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
quality(count = TRUE)
#> quality Totals
#> • Rows  : 6,154,354
#> • Pages : 1,233    
#> 

quality(year = c(2021, 2024), state = "GA", count = TRUE)
#> ✔ quality returned 41,788 results.
#> • 2021 : 23,617
#> • 2024 : 18,171

quality(npi = 1043245657)
#> ✔ quality returned 1 result.
#> • 2017 : 1
#> ✔ Retrieving 1 page
#> # A tibble: 1 × 25
#>    year    npi state  size specialty years patients charges services final_score
#>   <int>  <int> <chr> <int> <chr>     <int>    <int>   <int>    <int>       <dbl>
#> 1  2017 1.04e9 VT      936 Pathology    16    54678  4.47e7       NA        88.4
#> # ℹ 15 more variables: adjustment <dbl>, pi_score <int>, qa_score <dbl>,
#> #   complex_bonus <dbl>, part_opt <chr>, qi_score <dbl>, ia_score <int>,
#> #   cost_score <dbl>, indicators <chr>, cred <chr>, dual_ratio <dbl>,
#> #   small_bonus <int>, report_opt <chr>, mvp_title <chr>, ci_score <dbl>

quality(npi = c(1003026055, 1316939655))
#> ✔ quality returned 10 results.
#> • 2022 : 1
#> • 2021 : 2
#> • 2020 : 3
#> • 2019 : 1
#> • 2018 : 1
#> • 2017 : 2
#> ✔ Retrieving 6 pages
#> # A tibble: 10 × 25
#>     year        npi state  size specialty        years patients charges services
#>    <int>      <int> <chr> <int> <chr>            <int>    <int>   <int>    <int>
#>  1  2017 1003026055 FL      189 Endocrinology        8    13189  5.84e6       NA
#>  2  2017 1003026055 NC      191 Endocrinology        8    14784  8.90e6       NA
#>  3  2018 1003026055 FL      135 Endocrinology        8    12317  5.02e6        0
#>  4  2019 1003026055 FL      150 Endocrinology        9    12415  5.62e6    52009
#>  5  2020 1003026055 FL      151 Endocrinology       10    12917  5.46e6    53599
#>  6  2020 1003026055 FL        7 Endocrinology       10     1244  7.19e5     8160
#>  7  2020 1316939655 NY      295 Missing             16    22242  9.12e6   101308
#>  8  2021 1003026055 FL        9 Endocrinology       11     1181  6.98e5     7068
#>  9  2021 1316939655 NY      455 Physician Assis…    17    23586  1.09e7   116187
#> 10  2022 1316939655 NY      352 Physician Assis…    18    23244  1.05e7   110514
#> # ℹ 16 more variables: final_score <dbl>, adjustment <dbl>, pi_score <int>,
#> #   qa_score <dbl>, complex_bonus <dbl>, part_opt <chr>, qi_score <dbl>,
#> #   ia_score <int>, cost_score <dbl>, indicators <chr>, cred <chr>,
#> #   dual_ratio <dbl>, small_bonus <int>, report_opt <chr>, mvp_title <chr>,
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
