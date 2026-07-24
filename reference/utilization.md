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
  entity = NULL,
  first = NULL,
  last = NULL,
  credential = NULL,
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
  credential = NULL,
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
  state = NULL,
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

- entity:

  `<int>` Type of entity reported in NPPES. `1` identifies individual
  providers and `2` identifies those registered as organizations.

- first, last:

  `<chr>` Individual/Organizational provider's name

- credential:

  `<chr>` Individual provider's credentials

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

  `<lgl>` Identifies a HCPCS code that is represents a drug

- pos:

  `<chr>` Place of service; one of `F` (Facility) or `O` (Physician's
  Office)

- level:

  `<chr>` `National` or `State`

- providers:

  `<int>` Total providers

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
services(count = TRUE)
#> ◼ services | 116,297,407 rows | 23,267 pages
geography(count = TRUE)
#> ◼ geography | 3,228,031 rows | 650 pages

utilization(npi = 1003000423)
#> ✔ utilization returned 12 results
#> # A tibble: 12 × 22
#>     year        npi entity   par hcpcs patients services charges allowed payment
#>    <int>      <int>  <int> <int> <int>    <int>    <int>   <int>   <dbl>   <dbl>
#>  1  2013 1003000423      1     1    33       63      320   31637  13176.  10320.
#>  2  2014 1003000423      1     1    29       57      293   24148  12029.   9492.
#>  3  2015 1003000423      1     1    31       56      117   20414  10542.   8558.
#>  4  2016 1003000423      1     1    26       82      163   25862  12894.  10519.
#>  5  2017 1003000423      1     1    29       71      155   33700  14115.  11245.
#>  6  2018 1003000423      1     1    20       73      283   16773   8496.   6857.
#>  7  2019 1003000423      1     1    24       74      897   23150  11090.   9007.
#>  8  2020 1003000423      1     1    21       56      571   23680   9012.   7224.
#>  9  2021 1003000423      1     1    19       69      738   21300   8018.   6736.
#> 10  2022 1003000423      1     1    16       59      111    9918   5136.   4335.
#> 11  2023 1003000423      1     1    16       63      119   13785   6388.   5231.
#> 12  2024 1003000423      1     1    18       75      140   22015   8709.   7134.
#> # ℹ 12 more variables: avg_age <int>, avg_risk <dbl>, dual <int>, ndual <int>,
#> #   first <chr>, last <chr>, cred <chr>, specialty <chr>, address <chr>,
#> #   city <chr>, state <chr>, zip <chr>

services(npi = 1003000423)
#> ✔ services returned 41 results
#> # A tibble: 41 × 21
#>     year       npi entity   par hcpcs desc   drug pos   patients services charge
#>    <int>     <int>  <int> <int> <chr> <chr> <int> <chr>    <int>    <int>  <int>
#>  1  2013    1.00e9      1     1 Q0091 Scre…     0 O           20       20     40
#>  2  2014    1.00e9      1     1 Q0091 Scre…     0 O           13       13     40
#>  3  2015    1.00e9      1     1 Q0091 Scre…     0 O           14       14     40
#>  4  2016    1.00e9      1     1 Q0091 Scre…     0 O           20       20     40
#>  5  2017    1.00e9      1     1 Q0091 Scre…     0 O           20       20     41
#>  6  2018    1.00e9      1     1 Q0091 Scre…     0 O           18       18     50
#>  7  2019    1.00e9      1     1 Q0091 Scre…     0 O           16       16     50
#>  8  2020    1.00e9      1     1 Q0091 Scre…     0 O           15       15     51
#>  9  2021    1.00e9      1     1 Q0091 Scre…     0 O           20       20     60
#> 10  2022    1.00e9      1     1 Q0091 Scre…     0 O           15       15     60
#> # ℹ 31 more rows
#> # ℹ 10 more variables: allowed <dbl>, payment <dbl>, first <chr>, last <chr>,
#> #   cred <chr>, specialty <chr>, address <chr>, city <chr>, state <chr>,
#> #   zip <chr>

geography(
  hcpcs = c("Q0091", "G0101", "99213", "99212", "99203", "81002", "76830"),
  pos = "O",
  state = c("National", "Ohio"))
#> ✔ geography returned 168 results
#> # A tibble: 168 × 13
#>     year level  state hcpcs desc   drug pos   providers patients services charge
#>    <int> <chr>  <chr> <chr> <chr> <int> <chr>     <int>    <int>    <int>  <dbl>
#>  1  2013 Natio… Nati… Q0091 Scre…     0 O         61931   765792   765875   67.2
#>  2  2014 Natio… Nati… Q0091 Scre…     0 O         58311   681376   681445   70.2
#>  3  2015 Natio… Nati… Q0091 Scre…     0 O         54977   635611   635683   72.8
#>  4  2016 Natio… Nati… Q0091 Scre…     0 O         55719   623706   623784   75.6
#>  5  2017 Natio… Nati… Q0091 Scre…     0 O         53929   580115   580185   78.3
#>  6  2018 Natio… Nati… Q0091 Scre…     0 O         51816   545498   545554   80.7
#>  7  2019 Natio… Nati… Q0091 Scre…     0 O         50380   516118   516179   83.9
#>  8  2020 Natio… Nati… Q0091 Scre…     0 O         43181   400534   400557   85.8
#>  9  2021 Natio… Nati… Q0091 Scre…     0 O         44034   451584   451619   90.3
#> 10  2022 Natio… Nati… Q0091 Scre…     0 O         41510   398093   398143   93.5
#> # ℹ 158 more rows
#> # ℹ 2 more variables: allowed <dbl>, payment <dbl>
```
