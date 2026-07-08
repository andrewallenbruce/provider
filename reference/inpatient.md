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
#>     year ccn    org_name     address city  state zip   patients discharges  days
#>    <int> <chr>  <chr>        <chr>   <chr> <chr> <chr>    <int>      <int> <int>
#>  1  2013 110122 SOUTH GEORG… 2501 N… VALD… GA    31603     3564       5172 27467
#>  2  2014 110122 SOUTH GEORG… 2501 N… VALD… GA    31603     3249       4685 23852
#>  3  2015 110122 SOUTH GEORG… 2501 N… VALD… GA    31603     3139       4493 23808
#>  4  2016 110122 SOUTH GEORG… 2501 N… VALD… GA    31603     3061       4385 23621
#>  5  2017 110122 SOUTH GEORG… 2501 N… VALD… GA    31602     3105       4236 22772
#>  6  2018 110122 SOUTH GEORG… 2501 N… VALD… GA    31602     3162       4552 26145
#>  7  2019 110122 SOUTH GEORG… 2501 N… VALD… GA    31602     3010       4452 23835
#>  8  2020 110122 SOUTH GEORG… 2501 N… VALD… GA    31602     2696       3851 21038
#>  9  2021 110122 SOUTH GEORG… 2501 N… VALD… GA    31602     2648       3754 21481
#> 10  2022 110122 South Georg… 2501 N… Vald… GA    31602     2276       3204 18019
#> 11  2023 110122 Sgmc Health  2501 N… Vald… GA    31602     2297       3355 16328
#> 12  2024 110122 Sgmc Health  2501 N… Vald… GA    31602     2229       3339 16160
#> # ℹ 8 more variables: covered <int>, charge <dbl>, payment <dbl>, mdcpay <dbl>,
#> #   avg_age <dbl>, avg_risk <dbl>, dual <int>, ndual <int>
```
