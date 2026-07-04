# Provider Utilization by Year

Access information on services and procedures provided to Original
Medicare (fee-for-service) Part B beneficiaries by physicians and other
healthcare professionals; aggregated by provider, service and geography.

The **Provider** dataset allows the user access to data such as services
and procedures performed; charges submitted and payment received; and
beneficiary demographic and health characteristics for providers
treating Original Medicare (fee-for-service) Part B beneficiaries,
aggregated by year.

## Usage

``` r
utilization(
  year = NULL,
  npi = NULL,
  first = NULL,
  last = NULL,
  cred = NULL,
  entity = NULL,
  specialty = NULL,
  par = NULL,
  hcpcs = NULL,
  patients = NULL,
  services = NULL,
  charge = NULL,
  allowed = NULL,
  payment = NULL,
  avg_age = NULL,
  avg_risk = NULL,
  dual = NULL,
  ndual = NULL,
  city = NULL,
  state = NULL,
  count = FALSE
)

services(
  year = NULL,
  npi = NULL,
  entity = NULL,
  first = NULL,
  last = NULL,
  cred = NULL,
  specialty = NULL,
  par = NULL,
  hcpcs = NULL,
  drug = NULL,
  pos = NULL,
  patients = NULL,
  services = NULL,
  charge = NULL,
  allowed = NULL,
  payment = NULL,
  count = FALSE
)

geography(
  year = NULL,
  level = NULL,
  hcpcs = NULL,
  drug = NULL,
  pos = NULL,
  providers = NULL,
  patients = NULL,
  services = NULL,
  charge = NULL,
  allowed = NULL,
  payment = NULL,
  count = FALSE
)
```

## Arguments

- year:

  `<int>` Year data was reported

- npi:

  `<int>` 10-digit national provider identifier

- first, last:

  `<chr>` Individual/Organizational provider's name

- cred:

  `<chr>` Individual provider's credentials

- entity:

  `<chr>` Type of entity reported in NPPES. `I` identifies individual
  providers and `O` identifies those registered as organizations.

- specialty:

  `<chr>` Provider specialty reported on the largest number of claims
  submitted

- par:

  `<lgl>` Identifies a provider *with at least one claim* identifying
  them as *participating* in Medicare or accepting assignment of
  Medicare allowed amounts within HCPCS code and place of service. A
  *non-participating* provider is one that may elect to accept Medicare
  allowed amounts for some services and not accept Medicare allowed
  amounts for other services.

- hcpcs:

  `<int/chr>` Total number of unique HCPCS codes

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

- city, state:

  `<chr>` The provider's city and state, as reported in NPPES.

- count:

  `<lgl>` Return the total row count

- drug:

  `<lgl>` Total number of unique HCPCS codes

- pos:

  `<chr>` Total number of unique HCPCS codes

- level:

  `<chr>` National or State

- providers:

  `<int>` Total

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
containing the search results.

## Links

- [Medicare Physician & Other Practitioners: by Provider
  API](https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-provider)

- [Medicare Physician & Other Practitioners: by Provider and Service
  API](https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-provider-and-service)

- [Medicare Physician & Other Practitioners: by Geography and Service
  API](https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-geography-and-service)

## Examples

``` r
utilization(count = TRUE)
#> ◼ utilization | 13,528,933 rows | 2,712 pages
utilization(npi = 1003000423)
#> ✔ utilization returned 12 results
#> ✔ Retrieving 12 pages
#> # A tibble: 12 × 22
#>     year    npi first last  cred  entity specialty   par hcpcs patients services
#>    <int>  <int> <chr> <chr> <chr> <chr>  <chr>     <int> <int>    <int>    <int>
#>  1  2013 1.00e9 JENN… VELO… M.D.  I      Obstetri…     1    33       63      320
#>  2  2014 1.00e9 JENN… VELO… M.D.  I      Obstetri…     1    29       57      293
#>  3  2015 1.00e9 JENN… VELO… M.D.  I      Obstetri…     1    31       56      117
#>  4  2016 1.00e9 JENN… VELO… M.D.  I      Obstetri…     1    26       82      163
#>  5  2017 1.00e9 JENN… VELO… M.D.  I      Obstetri…     1    29       71      155
#>  6  2018 1.00e9 JENN… VELO… M.D.  I      Obstetri…     1    20       73      283
#>  7  2019 1.00e9 JENN… VELO… M.D.  I      Obstetri…     1    24       74      897
#>  8  2020 1.00e9 Jenn… Velo… M.D.  I      Obstetri…     1    21       56      571
#>  9  2021 1.00e9 Jenn… Velo… M.D.  I      Obstetri…     1    19       69      738
#> 10  2022 1.00e9 Jenn… Velo… M.D.  I      Obstetri…     1    16       59      111
#> 11  2023 1.00e9 Jenn… Velo… M.D.  I      Obstetri…     1    16       63      119
#> 12  2024 1.00e9 Jenn… Velo… M.D.  I      Obstetri…     1    18       75      140
#> # ℹ 11 more variables: charges <int>, allowed <dbl>, payment <dbl>,
#> #   avg_age <int>, avg_risk <dbl>, dual <int>, ndual <int>, address <chr>,
#> #   city <chr>, state <chr>, zip <chr>

services(count = TRUE)
#> ◼ services | 116,297,407 rows | 23,267 pages
services(npi = c(1003000423, 1003826272))
#> ✔ services returned 209 results
#> ✔ Retrieving 12 pages
#> # A tibble: 209 × 11
#>     year      npi hcpcs description  drug pos   patients services charge allowed
#>    <int>    <int> <chr> <chr>       <int> <chr>    <int>    <int>  <int>   <dbl>
#>  1  2013   1.00e9 Q2038 Influenza …     1 O           32       32     16  11.8  
#>  2  2014   1.00e9 Q2038 Influenza …     1 O           26       26     16  11.3  
#>  3  2015   1.00e9 Q2038 Influenza …     1 O           40       42     16  11.8  
#>  4  2017   1.00e9 Q2035 Influenza …     1 O           22       22     20  17.3  
#>  5  2023   1.00e9 Q0138 Injection,…     1 O           66    55080      4   0.495
#>  6  2024   1.00e9 Q0138 Injection,…     1 O           28    24481      4   0.350
#>  7  2013   1.00e9 Q0091 Screening …     0 O           20       20     40  39.6  
#>  8  2014   1.00e9 Q0091 Screening …     0 O           13       13     40  39.2  
#>  9  2015   1.00e9 Q0091 Screening …     0 O           14       14     40  39.2  
#> 10  2016   1.00e9 Q0091 Screening …     0 O           20       20     40  39.2  
#> # ℹ 199 more rows
#> # ℹ 1 more variable: payment <dbl>

geography(count = TRUE)
#> ◼ geography | 3,228,031 rows | 650 pages
geography(hcpcs = 99215)
#> ✔ geography returned 1,378 results
#> ✔ Retrieving 12 pages
#> # A tibble: 1,378 × 13
#>     year level   state hcpcs description  drug pos   providers patients services
#>    <int> <chr>   <chr> <chr> <chr>       <int> <chr>     <int>    <int>    <int>
#>  1  2024 Nation… NA    99215 Establishe…     0 F        101163  1259226  2595818
#>  2  2024 Nation… NA    99215 Establishe…     0 O        340863  5280156 10326407
#>  3  2023 Nation… NA    99215 Establishe…     0 F         97208  1186849  2432569
#>  4  2023 Nation… NA    99215 Establishe…     0 O        320488  5098798  9710835
#>  5  2022 Nation… NA    99215 Establishe…     0 F        101817  1133234  2249809
#>  6  2022 Nation… NA    99215 Establishe…     0 O        306692  4914072  9078994
#>  7  2021 Nation… NA    99215 Establishe…     0 F         98767  1089127  2132747
#>  8  2021 Nation… NA    99215 Establishe…     0 O        300443  4848612  8763759
#>  9  2020 Nation… NA    99215 Establishe…     0 F         89793   873298  1582440
#> 10  2020 Nation… NA    99215 Establishe…     0 O        259521  4150032  7103762
#> # ℹ 1,368 more rows
#> # ℹ 3 more variables: charge <dbl>, allowed <dbl>, payment <dbl>
```
