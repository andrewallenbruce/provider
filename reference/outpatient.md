# Outpatient Hospitals

Outpatient Hospitals

## Usage

``` r
outpatient(
  year = NULL,
  ccn = NULL,
  org_name = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  patients = NULL,
  services = NULL,
  charge = NULL,
  allowed = NULL,
  payment = NULL,
  outliers = NULL,
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

- services:

  `<int>` Total provider services

- charge:

  `<int>` The total charges that the provider submitted for all services

- allowed:

  `<dbl>` The Medicare allowed amount for all provider services. This
  figure is the sum of the amount Medicare pays, the deductible and
  coinsurance amounts that the beneficiary is responsible for paying,
  and any amounts that a third party is responsible for paying.

- payment:

  `<dbl>` Total amount that Medicare paid after deductible and
  coinsurance amounts have been deducted for all the provider's line
  item services.

- outliers:

  description

- count:

  `<lgl>` Return the total row count

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
containing the search results.

## Examples

``` r
outpatient(count = TRUE)
#> ◼ outpatient | 1,008,975 rows | 208 pages
outpatient(state = "GA", city = "Valdosta")
#> ✔ outpatient returned 442 results
#> ✔ Retrieving 10 pages
#> # A tibble: 442 × 16
#>     year ccn    org_name address city  state zip   apc   desc  patients services
#>    <int> <chr>  <chr>    <chr>   <chr> <chr> <chr> <chr> <chr>    <int>    <int>
#>  1  2015 110122 South G… 2501 N… Vald… GA    31603 0039  Leve…       11       12
#>  2  2015 110122 South G… 2501 N… Vald… GA    31603 0061  Leve…       NA       NA
#>  3  2015 110122 South G… 2501 N… Vald… GA    31603 0083  Leve…      102      150
#>  4  2015 110122 South G… 2501 N… Vald… GA    31603 0089  Leve…       72       72
#>  5  2015 110122 South G… 2501 N… Vald… GA    31603 0090  Leve…       17       17
#>  6  2015 110122 South G… 2501 N… Vald… GA    31603 0107  Leve…       NA       NA
#>  7  2015 110122 South G… 2501 N… Vald… GA    31603 0108  Leve…       14       14
#>  8  2015 110122 South G… 2501 N… Vald… GA    31603 0202  Leve…       NA       NA
#>  9  2015 110122 South G… 2501 N… Vald… GA    31603 0229  Leve…      125      131
#> 10  2015 110122 South G… 2501 N… Vald… GA    31603 0318  Leve…       32       32
#> # ℹ 432 more rows
#> # ℹ 5 more variables: outliers <int>, charge <dbl>, allowed <dbl>,
#> #   payment <dbl>, outpay <dbl>
```
