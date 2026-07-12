# Inpatient Hospitals

### Outlier Payments

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

## Source

- [API: Medicare Inpatient Hospitals - by
  Provider](https://data.cms.gov/provider-data/dataset/uyx4-5s7f)

&nbsp;

- [API: Medicare Outpatient Hospitals - by Provider and
  Service](https://data.cms.gov/provider-data/dataset/uyx4-5s7f)

## Arguments

- year:

  `<int>` Year data was reported

- ccn:

  `<int>` The CMS Certification Number (CCN) of the provider billing for
  outpatient hospital services.

- org_name:

  `<chr>` Organizational provider's name

- city, state, zip:

  `<chr>` The provider's city and state, as reported in NPPES.

- patients:

  `<int>` The number of Medicare fee-for-service beneficiaries receiving
  outpatient hospital services.

- discharges:

  `<int>` The number of discharges billed by the provider for inpatient
  hospital services.

- charge:

  `<int>` The provider's average estimated submitted charge for services
  covered by Medicare for the Ambulatory Payment Classification (APC).

- payment:

  `<dbl>` The average of total regular payments the provider receives
  directly from Medicare. It excludes special outlier payments which is
  reported in a separate column.

- avg_age:

  `<dbl>` The average age of Medicare enrollees who used a covered
  health care or medical service from the provider.

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

- services:

  `<int>` The number of primary HCPCS services billed by the provider
  for outpatient hospital services.

- allowed:

  `<dbl>` The average of total regular payments the provider receives
  for the APC. It includes both Medicare direct provider payments as
  well as beneficiaries’ co-payment and deductible payments. It excludes
  special outlier payments which is reported in a separate column.

- outliers:

  `<int>` The number of comprehensive APC services with outlier
  payments.

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
containing the search results.

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
containing the search results.

## Details

OPPS APC payment amounts are based on the average costs for a set of
services. In the event that a hospital’s costs for these services exceed
a given threshold tied to the average APC payment, CMS must issue an
outlier payment to the hospital to that service to compensate for the
costly provision of service.

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
