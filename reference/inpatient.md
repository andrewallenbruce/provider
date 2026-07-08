# Inpatient Hospitals

Inpatient Hospitals

## Usage

``` r
inpatient(
  year = NULL,
  ccn = NULL,
  org_name = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  patients = NULL,
  discharges = NULL,
  charge = NULL,
  payment = NULL,
  avg_age = NULL,
  avg_risk = NULL,
  dual = NULL,
  ndual = NULL,
  count = FALSE
)
```

## Arguments

- year:

  `<int>` Year data was reported

- ccn:

  `<int>` 10-digit national provider identifier

- org_name:

  `<chr>` Individual/Organizational provider's name

- city, state, zip:

  `<chr>` The provider's city and state, as reported in NPPES.

- patients:

  `<int>` Total Medicare beneficiaries receiving services from the
  provider

- discharges:

  description

- charge:

  `<int>` The total charges that the provider submitted for all services

- payment:

  `<dbl>` Total amount that Medicare paid after deductible and
  coinsurance amounts have been deducted for all the provider's line
  item services.

- avg_age:

  `<dbl>` Average age of beneficiaries. Beneficiary age is calculated at
  the end of the calendar year or at the time of death

- avg_risk:

  `<dbl>` Average Hierarchical Condition Category (HCC) risk score of
  beneficiaries

- dual:

  `<int>` Number of Medicare beneficiaries qualified to receive Medicare
  and Medicaid benefits. Beneficiaries are classified as Medicare and
  Medicaid entitlement if in any month in the given calendar year they
  were receiving full or partial Medicaid benefits.

- ndual:

  `<int>` Number of Medicare beneficiaries qualified to receive Medicare
  only benefits. Beneficiaries are classified as Medicare only
  entitlement if they received zero months of any Medicaid benefits
  (full or partial) in the given calendar year.

- count:

  `<lgl>` Return the total row count

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
containing the search results.

## Examples

``` r
inpatient(count = TRUE)
#> ◼ inpatient | 38,594 rows | 12 pages
inpatient(state = "GA", city = "Valdosta")
#> ✔ inpatient returned 12 results
#> ✔ Retrieving 12 pages
#> # A tibble: 12 × 18
#>     year ccn    org_name       address city  zip   state patients charge payment
#>    <int> <chr>  <chr>          <chr>   <chr> <chr> <chr>    <int>  <dbl>   <dbl>
#>  1  2013 110122 SOUTH GEORGIA… 2501 N… VALD… 31603 GA        3564 1.63e8  4.99e7
#>  2  2014 110122 SOUTH GEORGIA… 2501 N… VALD… 31603 GA        3249 1.67e8  4.65e7
#>  3  2015 110122 SOUTH GEORGIA… 2501 N… VALD… 31603 GA        3139 1.83e8  4.79e7
#>  4  2016 110122 SOUTH GEORGIA… 2501 N… VALD… 31603 GA        3061 1.86e8  4.83e7
#>  5  2017 110122 SOUTH GEORGIA… 2501 N… VALD… 31602 GA        3105 1.80e8  4.68e7
#>  6  2018 110122 SOUTH GEORGIA… 2501 N… VALD… 31602 GA        3162 1.96e8  5.29e7
#>  7  2019 110122 SOUTH GEORGIA… 2501 N… VALD… 31602 GA        3010 1.89e8  5.40e7
#>  8  2020 110122 SOUTH GEORGIA… 2501 N… VALD… 31602 GA        2696 1.70e8  5.35e7
#>  9  2021 110122 SOUTH GEORGIA… 2501 N… VALD… 31602 GA        2648 1.75e8  5.36e7
#> 10  2022 110122 South Georgia… 2501 N… Vald… 31602 GA        2276 1.49e8  4.41e7
#> 11  2023 110122 Sgmc Health    2501 N… Vald… 31602 GA        2297 1.46e8  4.17e7
#> 12  2024 110122 Sgmc Health    2501 N… Vald… 31602 GA        2229 1.53e8  4.33e7
#> # ℹ 8 more variables: medicare <dbl>, discharges <int>, covered <int>,
#> #   days <int>, dual <int>, ndual <int>, avg_age <dbl>, avg_risk <dbl>
```
