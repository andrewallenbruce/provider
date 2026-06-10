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
  address = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  specialty = NULL,
  participating = NULL,
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

  `<chr>` Type of entity reported in NPPES. An entity code of `I`
  identifies providers registered as individuals and an entity type code
  of `O` identifies providers registered as organizations.

- address, city, state, zip:

  The provider's street address, city, state and zip code, as reported
  in NPPES.

- specialty:

  `<chr>` Provider specialty reported on the largest number of claims
  submitted

- participating:

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

- count:

  `<lgl>` Return the total row count

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)

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
#> utilization Totals
#> • Rows  : 13,528,933
#> • Pages : 2,712     

utilization(npi = 1003000423)
#> ✔ utilization returned 12 results
#> ✔ Retrieving 12 pages
#> # A tibble: 12 × 22
#>     year        npi first last  cred  entity address city  state zip   specialty
#>    <int>      <int> <chr> <chr> <chr> <chr>  <chr>   <chr> <chr> <chr> <chr>    
#>  1  2013 1003000423 JENN… VELO… M.D.  I      11100 … CLEV… OH    44106 Obstetri…
#>  2  2014 1003000423 JENN… VELO… M.D.  I      11100 … CLEV… OH    44106 Obstetri…
#>  3  2015 1003000423 JENN… VELO… M.D.  I      11100 … CLEV… OH    44106 Obstetri…
#>  4  2016 1003000423 JENN… VELO… M.D.  I      11100 … CLEV… OH    44106 Obstetri…
#>  5  2017 1003000423 JENN… VELO… M.D.  I      11100 … CLEV… OH    44106 Obstetri…
#>  6  2018 1003000423 JENN… VELO… M.D.  I      11100 … CLEV… OH    44106 Obstetri…
#>  7  2019 1003000423 JENN… VELO… M.D.  I      11100 … CLEV… OH    44106 Obstetri…
#>  8  2020 1003000423 Jenn… Velo… M.D.  I      11100 … Clev… OH    44106 Obstetri…
#>  9  2021 1003000423 Jenn… Velo… M.D.  I      11100 … Clev… OH    44106 Obstetri…
#> 10  2022 1003000423 Jenn… Velo… M.D.  I      11100 … Clev… OH    44106 Obstetri…
#> 11  2023 1003000423 Jenn… Velo… M.D.  I      11100 … Clev… OH    44106 Obstetri…
#> 12  2024 1003000423 Jenn… Velo… M.D.  I      8300 T… Ment… OH    44060 Obstetri…
#> # ℹ 11 more variables: participating <int>, hcpcs <int>, patients <int>,
#> #   services <int>, charges <int>, allowed <dbl>, payment <dbl>, avg_age <int>,
#> #   avg_risk <dbl>, dual <int>, ndual <int>
```
