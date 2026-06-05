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
#> ℹ Retrieving 1 page
#> Error in "\"id\" %in% names(args)": ! Could not evaluate cli `{}` expression: `x@pages`.
#> Caused by error in `eval(expr, envir = envir)`:
#> ! object 'x' not found
#> ✖ Retrieving 1 page [1.8s]
#> 

quality(npi = c(1003026055, 1316939655))
#> ✔ quality returned 10 results.
#> • 2022 : 1
#> • 2021 : 2
#> • 2020 : 3
#> • 2019 : 1
#> • 2018 : 1
#> • 2017 : 2
#> ℹ Retrieving 6 pages
#> Error in "\"id\" %in% names(args)": ! Could not evaluate cli `{}` expression: `x@pages`.
#> Caused by error in `eval(expr, envir = envir)`:
#> ! object 'x' not found
#> ✖ Retrieving 6 pages [1.8s]
#> 

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
