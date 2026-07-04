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
  last_org = NULL,
  cred = NULL,
  entity = NULL,
  specialty = NULL,
  par = NULL,
  hcpcs = NULL,
  patients = NULL,
  services = NULL,
  charges = NULL,
  allowed = NULL,
  payment = NULL,
  avg_age = NULL,
  avg_risk = NULL,
  dual = NULL,
  ndual = NULL,
  address = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  count = FALSE
)

services(
  year = NULL,
  npi = NULL,
  entity = NULL,
  first = NULL,
  last_org = NULL,
  cred = NULL,
  specialty = NULL,
  par = NULL,
  hcpcs_code = NULL,
  hcpcs_desc = NULL,
  hcpcs_drug = NULL,
  pos = NULL,
  patients = NULL,
  services = NULL,
  avg_charge = NULL,
  avg_allowed = NULL,
  avg_payment = NULL,
  count = FALSE
)
```

## Arguments

- year:

  `<int>` Year data was reported

- npi:

  `<int>` 10-digit national provider identifier

- first, last_org:

  `<chr>` Individual/Organizational provider's name

- cred:

  `<chr>` Individual provider's credentials

- entity:

  `<chr>` Type of entity reported in NPPES. An entity code of `I`
  identifies providers registered as individuals and an entity type code
  of `O` identifies providers registered as organizations.

- specialty:

  `<chr>` Provider specialty reported on the largest number of claims
  submitted

- par:

  `<lgl>` Identifies whether the provider participates in Medicare
  and/or accepts assignment of Medicare allowed amounts. The value will
  be `Y` for any provider that had at least one claim identifying the
  provider as participating in Medicare or accepting assignment of
  Medicare allowed amounts within HCPCS code and place of service. A
  non-participating provider may elect to accept Medicare allowed
  amounts for some services and not accept Medicare allowed amounts for
  other services.

- hcpcs:

  `<int>` Total number of unique HCPCS codes

- patients:

  `<int>` Total Medicare beneficiaries receiving services from the
  provider

- services:

  `<int>` Total provider services

- charges:

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

- address, city, state, zip:

  The provider's street address, city, state and zip code, as reported
  in NPPES.

- count:

  `<lgl>` Return the total row count

- hcpcs_code:

  `<chr>` Total number of unique HCPCS codes

- hcpcs_desc:

  `<chr>` Total number of unique HCPCS codes

- hcpcs_drug:

  `<lgl>` Total number of unique HCPCS codes

- pos:

  `<chr>` Total number of unique HCPCS codes

- avg_charge:

  `<int>` The total charges that the provider submitted for all services

- avg_allowed:

  `<dbl>` The Medicare allowed amount for all provider services. This
  figure is the sum of the amount Medicare pays, the deductible and
  coinsurance amounts that the beneficiary is responsible for paying,
  and any amounts that a third party is responsible for paying.

- avg_payment:

  `<dbl>` Total amount that Medicare paid after deductible and
  coinsurance amounts have been deducted for all the provider's line
  item services.

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
```
