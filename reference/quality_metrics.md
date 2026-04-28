# Quality Payment Program

The Quality Payment Program (QPP) Experience dataset provides
participation and performance information in the Merit-based Incentive
Payment System (MIPS) during each performance year. They cover
eligibility and participation, performance categories, and final score
and payment adjustments.

## Usage

``` r
quality_metrics(year)
```

## Arguments

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
