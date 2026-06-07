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
#> Warning: downloaded length 0 != reported length 796
#> Warning: cannot open URL 'https://data.cms.gov/data.json': HTTP status was '429 Unknown Error'
#> Error in download.file(url = .url, destfile = .destfile, method = .method,     quiet = !verbose, headers = .headers): cannot open URL 'https://data.cms.gov/data.json'

utilization(npi = 1003000423)
#> Warning: downloaded length 0 != reported length 796
#> Warning: cannot open URL 'https://data.cms.gov/data.json': HTTP status was '429 Unknown Error'
#> Error in download.file(url = .url, destfile = .destfile, method = .method,     quiet = !verbose, headers = .headers): cannot open URL 'https://data.cms.gov/data.json'

utilization(npi = 1003000126)
#> Error in purrr::map_int(url, base_request, query = query): ℹ In index: 1.
#> Caused by error in `httr2::req_perform()`:
#> ! HTTP 429 Too Many Requests.

utilization(npi = 1043477615)
#> Error in purrr::map_int(url, base_request, query = query): ℹ In index: 1.
#> Caused by error in `httr2::req_perform()`:
#> ! HTTP 429 Too Many Requests.
```
