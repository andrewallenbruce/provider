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
#> Error in purrr::map_int(url, base_request, query = query): ℹ In index: 1.
#> Caused by error in `httr2::req_perform()`:
#> ! Failed to parse error body with method defined in `req_error()`.
#> Caused by error in `httr2::resp_body_json()`:
#> ! Unexpected content type "text/html".
#> • Expecting type "application/json" or suffix "json".

quality(count = TRUE, state = "GA")
#> Error in purrr::map_int(url, base_request, query = query): ℹ In index: 1.
#> Caused by error in `httr2::req_perform()`:
#> ! Failed to parse error body with method defined in `req_error()`.
#> Caused by error in `httr2::resp_body_json()`:
#> ! Unexpected content type "text/html".
#> • Expecting type "application/json" or suffix "json".

quality() |> str()
#> quality Totals
#> Error in purrr::map_int(url, base_request, query = query): ℹ In index: 1.
#> Caused by error in `httr2::req_perform()`:
#> ! Failed to parse error body with method defined in `req_error()`.
#> Caused by error in `httr2::resp_body_json()`:
#> ! Unexpected content type "text/html".
#> • Expecting type "application/json" or suffix "json".

quality(npi = 1316939655)
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■                 
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Error in purrr::map_int(url, base_request, query = query): ℹ In index: 1.
#> Caused by error in `httr2::req_perform()`:
#> ! Failed to parse error body with method defined in `req_error()`.
#> Caused by error in `httr2::resp_body_json()`:
#> ! Unexpected content type "text/html".
#> • Expecting type "application/json" or suffix "json".

quality(npi = 1043245657)
#> Error in purrr::map_int(url, base_request, query = query): ℹ In index: 1.
#> Caused by error in `httr2::req_perform()`:
#> ! Failed to parse error body with method defined in `req_error()`.
#> Caused by error in `httr2::resp_body_json()`:
#> ! Unexpected content type "text/html".
#> • Expecting type "application/json" or suffix "json".

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
