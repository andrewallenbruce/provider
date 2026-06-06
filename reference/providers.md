# Provider Enrollment in Medicare

Enrollment data on individual and organizational providers that are
actively approved to bill Medicare.

## Usage

``` r
providers(
  npi = NULL,
  pac = NULL,
  enid = NULL,
  first = NULL,
  middle = NULL,
  last = NULL,
  prov_type = NULL,
  prov_desc = NULL,
  state = NULL,
  org_name = NULL,
  multi = NULL,
  count = FALSE,
  set = FALSE
)
```

## Arguments

- npi:

  `<int>` National Provider Identifier

- pac:

  `<chr>` PECOS Associate Control ID

- enid:

  `<chr>` Medicare Enrollment ID

- first, middle, last:

  `<chr>` Individual provider's name

- prov_type:

  `<chr>` Enrollment specialty code

- prov_desc:

  `<chr>` Enrollment specialty description

- state:

  `<chr>` Enrollment state, full or abbreviation

- org_name:

  `<chr>` Organizational provider's name

- multi:

  `<lgl>` Provider has multiple NPIs

- count:

  `<lgl>` Return the total row count

- set:

  `<lgl>` Return the entire dataset

## References

- [API: Medicare Provider Supplier
  Enrollment](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/medicare-fee-for-service-public-provider-enrollment)

- [Provider Enrollment Data
  Dictionary](https://data.cms.gov/resources/medicare-fee-for-service-public-provider-enrollment-data-dictionary)

## Examples

``` r
providers(count = TRUE)
#> providers Totals
#> Error in httr2::req_perform(httr2::req_retry(httr2::request(url), retry_on_failure = TRUE,     max_tries = 2)): HTTP 429 Too Many Requests.

providers(count = TRUE, org_name = not_blank())
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■                 
#> Waiting 2s for retry backoff ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  
#> Error in httr2::req_perform(httr2::req_retry(httr2::request(url), retry_on_failure = TRUE,     max_tries = 2)): HTTP 429 Too Many Requests.

providers()
#> providers Totals
#> Error in httr2::req_perform(httr2::req_retry(httr2::request(url), retry_on_failure = TRUE,     max_tries = 2)): HTTP 429 Too Many Requests.

providers(org_name = starts("AB"), state = c("TX", "CA"))
#> Error in httr2::req_perform(httr2::req_retry(httr2::request(url), retry_on_failure = TRUE,     max_tries = 2)): HTTP 429 Too Many Requests.

providers(org_name = starts("U"), count = TRUE)
#> Error in httr2::req_perform(httr2::req_retry(httr2::request(url), retry_on_failure = TRUE,     max_tries = 2)): HTTP 429 Too Many Requests.
```
