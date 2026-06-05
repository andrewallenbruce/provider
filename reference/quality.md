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
#>   year  state size  specialty years npi    patients charges services final_score
#>   <chr> <chr> <chr> <chr>     <chr> <chr>  <chr>    <chr>   <chr>          <dbl>
#> 1 2017  VT    936   Pathology 16    10432… 54678    447356… NA              88.4
#> # ℹ 9 more variables: adjustment <dbl>, complex_bonus <dbl>, qa_score <dbl>,
#> #   pi_score <dbl>, part_opt <chr>, qi_bonus <dbl>, ia_score <dbl>,
#> #   cost_score <dbl>, indicators <chr>

quality(npi = c(1003026055, 1316939655))
#> ✔ quality returned 10 results.
#> • 2024 : 0
#> • 2023 : 0
#> • 2022 : 1
#> • 2021 : 2
#> • 2020 : 3
#> • 2019 : 1
#> • 2018 : 1
#> • 2017 : 2
#> # A tibble: 8 × 23
#>   year  state size  specialty  years npi   patients charges services final_score
#>   <chr> <chr> <chr> <chr>      <chr> <chr> <chr>    <chr>   <chr>          <dbl>
#> 1 2017  FL    189   Endocrino… 8     1003… 13189    5840610 NA              60  
#> 2 2018  FL    135   Endocrino… 8     1003… 12317    5022828 0               57.7
#> 3 2019  FL    150   Endocrino… 9     1003… 12415    5616617 52009           78.5
#> 4 2020  FL    151   Endocrino… 10    1003… 12917    5464461 53599           51.0
#> 5 2020  NY    295   Missing    16    1316… 22242    9118669 101308          93.2
#> 6 2021  FL    9     Endocrino… 11    1003… 1181     698003  7068            60  
#> 7 2021  NY    455   Physician… 17    1316… 23586    109495… 116187          91.1
#> 8 2022  NY    352   Physician… 18    1316… 23244    105141… 110514          80.3
#> # ℹ 13 more variables: adjustment <dbl>, complex_bonus <dbl>, qa_score <dbl>,
#> #   pi_score <dbl>, part_opt <chr>, qi_bonus <dbl>, ia_score <dbl>,
#> #   cost_score <dbl>, indicators <chr>, cred <chr>, dual_ratio <dbl>,
#> #   qi_score <chr>, small_bonus <chr>

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
