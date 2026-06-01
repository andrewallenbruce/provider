# Quality Payment Program

The Quality Payment Program (QPP) Experience dataset provides
participation and performance information in the Merit-based Incentive
Payment System (MIPS) during each performance year. They cover
eligibility and participation, performance categories, and final score
and payment adjustments.

## Usage

``` r
quality_metrics(year)

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
```

## Arguments

- year:

  `<int>` A vector of years from 2018 to 2025

- npi:

  description

- state:

  description

- size:

  description

- specialty:

  description

- years:

  description

- patients:

  description

- charges:

  description

- services:

  description

- final_score:

  description

- adjustment:

  description

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
#> tibble [80 × 22] (S3: tbl_df/tbl/data.frame)
#>  $ year         : int [1:80] 2021 2021 2021 2021 2021 2021 2021 2021 2021 2021 ...
#>  $ npi          : int [1:80] 1487963492 1417413022 1598059354 1609097500 1780868182 1932201423 1932495876 1619234945 1699154567 1649275769 ...
#>  $ state        : chr [1:80] "WI" "VA" "WI" "GA" ...
#>  $ size         : int [1:80] 3985 13 1 4 1678 216 371 568 374 337 ...
#>  $ specialty    : chr [1:80] "Internal Medicine" "Physician Assistant" "Podiatry" "Physical Therapist in Private Practice" ...
#>  $ years        : int [1:80] 10 3 10 15 11 18 11 8 6 18 ...
#>  $ patients     : int [1:80] 105665 1148 384 126 27358 23182 40417 17508 19603 23432 ...
#>  $ charges      : int [1:80] 111610820 176315 201105 149650 33151499 11949059 4690599 14930044 15503921 16122113 ...
#>  $ services     : int [1:80] 1253108 1468 2412 4810 303940 125172 73230 154328 164262 166671 ...
#>  $ final_score  : num [1:80] 100 79.6 85.1 100 100 ...
#>  $ adjustment   : num [1:80] 2.34 0.06 0.2 2.34 2.34 2.09 0.07 1.5 2.34 2.34 ...
#>  $ complex_bonus: num [1:80] 6.16 4.7 3.28 3.18 7.02 6.34 4.34 7.24 5.2 4.62 ...
#>  $ qa_score     : num [1:80] 99.5 70.5 74 100 86.1 ...
#>  $ pi_score     : num [1:80] 100 0 87 0 100 ...
#>  $ part_option  : chr [1:80] "MIPS APM" "Group" "Individual" "Group" ...
#>  $ qi_bonus     : num [1:80] 0 0 0.32 0 0 0 1.2 0 0 0.7 ...
#>  $ ia_score     : num [1:80] 40 40 40 40 40 40 40 40 40 40 ...
#>  $ cost_score   : num [1:80] 0 0 0 0 0 0 0 0 0 0 ...
#>  $ cred         : chr [1:80] NA NA NA NA ...
#>  $ dual_ratio   : num [1:80] NA NA NA NA NA NA NA NA NA NA ...
#>  $ small_bonus  : num [1:80] NA NA NA NA NA NA NA NA NA NA ...
#>  $ indicators   : chr [1:80] NA NA NA NA ...


quality_metrics(2018:2025)
#> # A tibble: 32 × 4
#>     year category metric               mean
#>  * <int> <chr>    <chr>               <dbl>
#>  1  2018 ind      HCC Risk Score      1.84 
#>  2  2018 ind      Dual Eligible Ratio 0.288
#>  3  2018 group    HCC Risk Score      1.44 
#>  4  2018 group    Dual Eligible Ratio 0.230
#>  5  2019 ind      HCC Risk Score      1.64 
#>  6  2019 ind      Dual Eligible Ratio 0.269
#>  7  2019 group    HCC Risk Score      1.32 
#>  8  2019 group    Dual Eligible Ratio 0.216
#>  9  2020 ind      HCC Risk Score      1.57 
#> 10  2020 ind      Dual Eligible Ratio 0.261
#> # ℹ 22 more rows
```
