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
#> • Pages : 8        
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
#> • Pages : 8        
#> 
#> ! No Query ❯ Returning first 10 rows.
#> 
#> quality [60 × 22] (S3: quality/tbl_df/tbl/data.frame)
#>  $ year         : int [1:60] 2021 2021 2021 2021 2021 2021 2021 2021 2021 2021 ...
#>  $ npi          : int [1:60] 1487963492 1417413022 1598059354 1609097500 1780868182 1932201423 1932495876 1619234945 1699154567 1649275769 ...
#>  $ state        : chr [1:60] "WI" "VA" "WI" "GA" ...
#>  $ size         : int [1:60] 3985 13 1 4 1678 216 371 568 374 337 ...
#>  $ specialty    : chr [1:60] "Internal Medicine" "Physician Assistant" "Podiatry" "Physical Therapist in Private Practice" ...
#>  $ years        : int [1:60] 10 3 10 15 11 18 11 8 6 18 ...
#>  $ patients     : int [1:60] 105665 1148 384 126 27358 23182 40417 17508 19603 23432 ...
#>  $ charges      : int [1:60] 111610820 176315 201105 149650 33151499 11949059 4690599 14930044 15503921 16122113 ...
#>  $ services     : int [1:60] 1253108 1468 2412 4810 303940 125172 73230 154328 164262 166671 ...
#>  $ final_score  : num [1:60] 100 79.6 85.1 100 100 ...
#>  $ adjustment   : num [1:60] 2.34 0.06 0.2 2.34 2.34 2.09 0.07 1.5 2.34 2.34 ...
#>  $ complex_bonus: num [1:60] 6.16 4.7 3.28 3.18 7.02 6.34 4.34 7.24 5.2 4.62 ...
#>  $ qa_score     : num [1:60] 99.5 70.5 74 100 86.1 ...
#>  $ pi_score     : num [1:60] 100 0 87 0 100 ...
#>  $ part_option  : chr [1:60] "MIPS APM" "Group" "Individual" "Group" ...
#>  $ qi_bonus     : num [1:60] 0 0 0.32 0 0 0 1.2 0 0 0.7 ...
#>  $ ia_score     : num [1:60] 40 40 40 40 40 40 40 40 40 40 ...
#>  $ cost_score   : num [1:60] 0 0 0 0 0 0 0 0 0 0 ...
#>  $ cred         : chr [1:60] NA NA NA NA ...
#>  $ dual_ratio   : num [1:60] NA NA NA NA NA NA NA NA NA NA ...
#>  $ small_bonus  : chr [1:60] NA NA NA NA ...
#>  $ indicators   : chr [1:60] "Engaged" "Engaged" "Engaged" "Opted Into MIPS" ...

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
#> ℹ Retrieving 3 pages...
#> # A tibble: 3 × 22
#>    year    npi state  size specialty years patients charges services final_score
#>   <int>  <int> <chr> <int> <chr>     <int>    <int>   <int>    <int>       <dbl>
#> 1  2021 1.32e9 NY      455 Physicia…    17    23586  1.09e7   116187        91.1
#> 2  2020 1.32e9 NY      295 Missing      16    22242  9.12e6   101308        93.2
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
