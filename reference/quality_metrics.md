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

quality()
#> quality Totals
#> • Rows  : 6,154,354
#> • Pages : 1,233    
#> 
#> ! No Query ❯ Returning first 10 rows.
#> 
#> # A tibble: 80 × 22
#>     year        npi state  size specialty        years patients charges services
#>  * <int>      <int> <chr> <int> <chr>            <int>    <int>   <int>    <int>
#>  1  2021 1487963492 WI     3985 Internal Medici…    10   105665  1.12e8  1253108
#>  2  2021 1417413022 VA       13 Physician Assis…     3     1148  1.76e5     1468
#>  3  2021 1598059354 WI        1 Podiatry            10      384  2.01e5     2412
#>  4  2021 1609097500 GA        4 Physical Therap…    15      126  1.50e5     4810
#>  5  2021 1780868182 TX     1678 Hospitalist         11    27358  3.32e7   303940
#>  6  2021 1932201423 MS      216 Interventional …    18    23182  1.19e7   125172
#>  7  2021 1932495876 NY      371 Nurse Practitio…    11    40417  4.69e6    73230
#>  8  2021 1619234945 LA      568 Family Practice      8    17508  1.49e7   154328
#>  9  2021 1699154567 AR      374 Physician Assis…     6    19603  1.55e7   164262
#> 10  2021 1649275769 KY      337 Physician Assis…    18    23432  1.61e7   166671
#> # ℹ 70 more rows
#> # ℹ 13 more variables: final_score <dbl>, adjustment <dbl>,
#> #   complex_bonus <dbl>, qa_score <dbl>, pi_score <dbl>, part_option <chr>,
#> #   qi_bonus <dbl>, ia_score <dbl>, cost_score <dbl>, cred <chr>,
#> #   dual_ratio <dbl>, small_bonus <dbl>, flag <chr>


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
