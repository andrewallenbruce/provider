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
services(count = TRUE)
#> ◼ services | 116,297,407 rows | 23,267 pages
geography(count = TRUE)
#> ◼ geography | 3,228,031 rows | 650 pages

utilization(npi = 1003000423)
#> ✔ utilization returned 12 results
#> ✔ Retrieving 12 pages
#> # A tibble: 12 × 22
#>     year        npi entity   par hcpcs patients services charges allowed payment
#>    <int>      <int> <chr>  <int> <int>    <int>    <int>   <int>   <dbl>   <dbl>
#>  1  2013 1003000423 I          1    33       63      320   31637  13176.  10320.
#>  2  2014 1003000423 I          1    29       57      293   24148  12029.   9492.
#>  3  2015 1003000423 I          1    31       56      117   20414  10542.   8558.
#>  4  2016 1003000423 I          1    26       82      163   25862  12894.  10519.
#>  5  2017 1003000423 I          1    29       71      155   33700  14115.  11245.
#>  6  2018 1003000423 I          1    20       73      283   16773   8496.   6857.
#>  7  2019 1003000423 I          1    24       74      897   23150  11090.   9007.
#>  8  2020 1003000423 I          1    21       56      571   23680   9012.   7224.
#>  9  2021 1003000423 I          1    19       69      738   21300   8018.   6736.
#> 10  2022 1003000423 I          1    16       59      111    9918   5136.   4335.
#> 11  2023 1003000423 I          1    16       63      119   13785   6388.   5231.
#> 12  2024 1003000423 I          1    18       75      140   22015   8709.   7134.
#> # ℹ 12 more variables: avg_age <int>, avg_risk <dbl>, dual <int>, ndual <int>,
#> #   first <chr>, last <chr>, cred <chr>, specialty <chr>, address <chr>,
#> #   city <chr>, state <chr>, zip <chr>

services(npi = 1003000423)
#> ✔ services returned 41 results
#> ✔ Retrieving 12 pages
#> # A tibble: 41 × 11
#>     year    npi hcpcs desc   drug pos   patients services charge allowed payment
#>    <int>  <int> <chr> <chr> <int> <chr>    <int>    <int>  <int>   <dbl>   <dbl>
#>  1  2013 1.00e9 Q0091 Scre…     0 O           20       20     40    39.6    39.6
#>  2  2014 1.00e9 Q0091 Scre…     0 O           13       13     40    39.2    39.2
#>  3  2015 1.00e9 Q0091 Scre…     0 O           14       14     40    39.2    39.2
#>  4  2016 1.00e9 Q0091 Scre…     0 O           20       20     40    39.2    39.2
#>  5  2017 1.00e9 Q0091 Scre…     0 O           20       20     41    38.9    38.9
#>  6  2018 1.00e9 Q0091 Scre…     0 O           18       18     50    41.6    41.6
#>  7  2019 1.00e9 Q0091 Scre…     0 O           16       16     50    41.0    41.0
#>  8  2020 1.00e9 Q0091 Scre…     0 O           15       15     51    41.0    41.0
#>  9  2021 1.00e9 Q0091 Scre…     0 O           20       20     60    41.5    41.5
#> 10  2022 1.00e9 Q0091 Scre…     0 O           15       15     60    40.9    40.9
#> # ℹ 31 more rows

geography(
  hcpcs = c("Q0091", "G0101", "99213", "99212", "99203", "81002", "76830"),
  pos = "O",
  state = c("National", "Ohio"))
#> ✔ geography returned 168 results
#> ✔ Retrieving 12 pages
#> # A tibble: 168 × 12
#>     year state    hcpcs desc       drug pos   providers patients services charge
#>    <int> <chr>    <chr> <chr>     <int> <chr>     <int>    <int>    <int>  <dbl>
#>  1  2024 National 76830 Ultrasou…     0 O         26009   224170   269595  349. 
#>  2  2024 Ohio     76830 Ultrasou…     0 O           837     5548     6201  274. 
#>  3  2024 National 81002 Urinalys…     0 O         94006  1459105  2205580   15.0
#>  4  2024 Ohio     81002 Urinalys…     0 O          5041    60373    88101   14.6
#>  5  2024 National 99203 New pati…     0 O        388139  6537424  8070604  267. 
#>  6  2024 Ohio     99203 New pati…     0 O         15545   229830   268676  238. 
#>  7  2024 National 99212 Establis…     0 O        319826  3989238  6241712  118. 
#>  8  2024 Ohio     99212 Establis…     0 O         13534   145434   203859  107. 
#>  9  2024 National 99213 Establis…     0 O        631995 18637816 64778139  189. 
#> 10  2024 Ohio     99213 Establis…     0 O         25987   750987  2223611  177. 
#> # ℹ 158 more rows
#> # ℹ 2 more variables: allowed <dbl>, payment <dbl>
```
