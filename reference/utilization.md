# Provider Utilization & Demographics by Year

Access information on services and procedures provided to Original
Medicare (fee-for-service) Part B beneficiaries by physicians and other
healthcare professionals; aggregated by provider, service and geography.

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
  risk_score = NULL,
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

  `<chr>` Provider entity type; `"I"` (Individual), `"O"` (Organization)

- address, city, state, zip:

  description

- specialty:

  `<chr>` Provider specialty reported on the largest number of claims
  submitted

- participating:

  `<lgl>` Identifies whether the provider participates in Medicare
  and/or accepts assignment of Medicare allowed amounts

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

  `<int>` Average age of beneficiaries. Beneficiary age is calculated at
  the end of the calendar year or at the time of death

- risk_score:

  `<dbl>` Average Hierarchical Condition Category (HCC) risk score of
  beneficiaries

- count:

  `<lgl>` Return the total row count

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)

## By Provider

**type =**`"Provider"`:

The **Provider** dataset allows the user access to data such as services
and procedures performed; charges submitted and payment received; and
beneficiary demographic and health characteristics for providers
treating Original Medicare (fee-for-service) Part B beneficiaries,
aggregated by year.

## By Provider and Service

**type =**`"Service"`:

The **Provider and Service** dataset is aggregated by:

1.  Rendering provider's NPI

2.  Healthcare Common Procedure Coding System (HCPCS) code

3.  Place of Service (Facility or Non-facility)

There can be multiple records for a given NPI based on the number of
distinct HCPCS codes that were billed and where the services were
provided. Data have been aggregated based on the place of service
because separate fee schedules apply depending on whether the place of
service submitted on the claim is facility or non-facility.

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
#> 

utilization(npi = 1003000423)
#> ✔ utilization returned 12 results.
#> • 2024 : 1
#> • 2023 : 1
#> • 2022 : 1
#> • 2021 : 1
#> • 2020 : 1
#> • 2019 : 1
#> • 2018 : 1
#> • 2017 : 1
#> • 2016 : 1
#> • 2015 : 1
#> • 2014 : 1
#> • 2013 : 1
#> ✔ Retrieving 12 pages
#> # A tibble: 12 × 24
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
#> # ℹ 13 more variables: participating <int>, hcpcs <int>, patients <int>,
#> #   services <int>, charges <int>, allowed <dbl>, payment <dbl>, avg_age <int>,
#> #   avg_risk <dbl>, female <int>, male <int>, dual <int>, ndual <int>

utilization(npi = 1003000126)
#> Error in "cli::cli_alert_success(msg)": ! Could not evaluate cli `{}` expression: `mark(sum2(x@count))`.
#> Caused by error in `purrr::map_int(url, base_request, query = query)`:
#> ! ℹ In index: 8.
#> Caused by error in `httr2::req_perform()`:
#> ! HTTP 429 Too Many Requests.

utilization(npi = 1043477615)
#> Error in purrr::map_int(url, base_request, query = query): ℹ In index: 1.
#> Caused by error in `httr2::req_perform()`:
#> ! HTTP 429 Too Many Requests.
```
