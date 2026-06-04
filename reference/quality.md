# Quality Payment Program

The Quality Payment Program (QPP) Experience dataset provides
participation and performance information in the Merit-based Incentive
Payment System (MIPS) during each performance year. They cover
eligibility and participation, performance categories, and final score
and payment adjustments.

## Usage

``` r
quality(
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

- year:

  `<int>` A vector of years from 2018 to 2025

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

quality(count = TRUE, state = "GA")
#> ✔ quality returned 203,295 results.
#> • 2024 : 18,171
#> • 2023 : 17,948
#> • 2022 : 20,903
#> • 2021 : 23,617
#> • 2020 : 32,565
#> • 2019 : 31,468
#> • 2018 : 27,308
#> • 2017 : 31,315

quality() |> str()
#> quality Totals
#> • Rows  : 6,154,354
#> • Pages : 1,233    
#> 
#> ! No Query ❯ Returning first 10 rows.
#> 
#> quality [70 × 22] (S3: quality/tbl_df/tbl/data.frame)
#>  $ year         : int [1:70] 2017 2017 2017 2017 2017 2017 2017 2017 2017 2017 ...
#>  $ npi          : int [1:70] 1750366498 1679729883 1407858475 1376501338 1578720843 1588735799 1093727166 1255388914 1720380108 1770763724 ...
#>  $ state        : chr [1:70] "AZ" "IL" "GA" "TN" ...
#>  $ size         : int [1:70] 78 38 79 130 104 104 55 97 3 13 ...
#>  $ specialty    : chr [1:70] "Diagnostic Radiology" "Neurology" "Orthopedic Surgery" "Missing" ...
#>  $ years        : int [1:70] 12 9 13 NA 11 10 9 15 7 9 ...
#>  $ patients     : int [1:70] 534 2241 698 11911 6177 6177 333 10038 436 410 ...
#>  $ charges      : int [1:70] 109886 977923 398097 11569717 1081724 1081724 130316 8114580 208050 51136 ...
#>  $ services     : int [1:70] NA NA NA NA NA NA NA NA NA NA ...
#>  $ final_score  : num [1:70] 15 88.7 77.5 94 77.3 ...
#>  $ adjustment   : num [1:70] 0.04 1.27 0.68 1.55 0.67 0.67 0.1 1.82 1.17 0.04 ...
#>  $ complex_bonus: num [1:70] NA NA NA NA NA NA NA NA NA NA ...
#>  $ qa_score     : num [1:70] 0 81.2 62.6 100 73.3 73.3 0 98.7 91.9 0 ...
#>  $ pi_score     : num [1:70] 0 100 100 79.8 0 ...
#>  $ part_option  : chr [1:70] "Group" "Group" "Individual" "MIPS APM" ...
#>  $ qi_bonus     : num [1:70] 0 0 0 0 0 0 0 0 0 0 ...
#>  $ ia_score     : num [1:70] 40 40 40 40 40 40 40 40 40 40 ...
#>  $ cost_score   : num [1:70] NA NA NA NA NA NA NA NA NA NA ...
#>  $ cred         : chr [1:70] NA NA NA NA ...
#>  $ dual_ratio   : num [1:70] NA NA NA NA NA NA NA NA NA NA ...
#>  $ small_bonus  : chr [1:70] NA NA NA NA ...
#>  $ indicators   : chr [1:70] "HPSA Clinician" "HPSA Clinician" "Extreme Uncontrollable Circumstance" "HPSA Clinician" ...

quality(npi = 1316939655)
#> ✔ quality returned 3 results.
#> • 2024 : 0
#> • 2023 : 0
#> • 2022 : 1
#> • 2021 : 1
#> • 2020 : 1
#> • 2019 : 0
#> • 2018 : 0
#> • 2017 : 0
#> # A tibble: 3 × 22
#>    year    npi state  size specialty years patients charges services final_score
#>   <int>  <int> <chr> <int> <chr>     <int>    <int>   <int>    <int>       <dbl>
#> 1  2020 1.32e9 NY      295 Missing      16    22242  9.12e6   101308        93.2
#> 2  2021 1.32e9 NY      455 Physicia…    17    23586  1.09e7   116187        91.1
#> 3  2022 1.32e9 NY      352 Physicia…    18    23244  1.05e7   110514        80.3
#> # ℹ 12 more variables: adjustment <dbl>, complex_bonus <dbl>, qa_score <dbl>,
#> #   pi_score <dbl>, part_option <chr>, qi_bonus <dbl>, ia_score <dbl>,
#> #   cost_score <dbl>, cred <chr>, dual_ratio <dbl>, small_bonus <chr>,
#> #   indicators <chr>

quality(npi = 1043245657)
#> ✔ quality returned 1 result.
#> • 2024 : 0
#> • 2023 : 0
#> • 2022 : 0
#> • 2021 : 0
#> • 2020 : 0
#> • 2019 : 0
#> • 2018 : 0
#> • 2017 : 1
#> # A tibble: 1 × 19
#>    year    npi state  size specialty years patients charges services final_score
#>   <int>  <int> <chr> <int> <chr>     <int>    <int>   <int>    <int>       <dbl>
#> 1  2017 1.04e9 VT      936 Pathology    16    54678  4.47e7       NA        88.4
#> # ℹ 9 more variables: adjustment <dbl>, complex_bonus <dbl>, qa_score <dbl>,
#> #   pi_score <dbl>, part_option <chr>, qi_bonus <dbl>, ia_score <dbl>,
#> #   cost_score <dbl>, indicators <chr>

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
