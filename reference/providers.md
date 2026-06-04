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
#> • Rows  : 2,981,799
#> • Pages : 597      
#> 

providers(count = TRUE, org_name = not_blank())
#> ✔ providers returned 433,496 results.

providers()
#> providers Totals
#> • Rows  : 2,981,799
#> • Pages : 597      
#> 
#> ! No Query ❯ Returning first 10 rows.
#> 
#> # A tibble: 10 × 11
#>    org_name      first middle last  state prov_type prov_desc    npi multi pac  
#>    <chr>         <chr> <chr>  <chr> <chr> <chr>     <chr>      <int> <int> <chr>
#>  1 NA            ARDA… NA     ENKE… MD    14-11     PRACTITI… 1.00e9     0 7517…
#>  2 NA            ARDA… NA     ENKE… DC    14-C6     PRACTITI… 1.00e9     0 7517…
#>  3 NA            ARDA… NA     ENKE… VA    14-11     PRACTITI… 1.00e9     0 7517…
#>  4 NA            ARDA… NA     ENKE… PA    14-11     PRACTITI… 1.00e9     0 7517…
#>  5 NA            THOM… L      CIBU… IL    14-22     PRACTITI… 1.00e9     0 4284…
#>  6 NA            RASH… NA     KHAL… OH    14-05     PRACTITI… 1.00e9     0 9931…
#>  7 NA            RASH… NA     KHAL… MI    14-05     PRACTITI… 1.00e9     0 9931…
#>  8 NA            RASH… NA     KHAL… TX    14-05     PRACTITI… 1.00e9     0 9931…
#>  9 KOPELMAN FAM… NA    NA     NA    MA    12-70     PART B S… 1.00e9     0 8224…
#> 10 TRI-STATE EY… NA    NA     NA    WV    12-70     PART B S… 1.00e9     0 1850…
#> # ℹ 1 more variable: enid <chr>

providers(org_name = starts("AB"), state = c("TX", "CA"))
#> Error in "cli::cli_alert_success(msg)": ! Could not evaluate cli `{}` expression: `mark(x@count)`.
#> Caused by error in `httr2::req_perform(httr2::req_error(httr2::req_retry(httr2::request(url), …`:
#> ! Failed to parse error body with method defined in `req_error()`.
#> Caused by error in `httr2::resp_body_json()`:
#> ! Unexpected content type "text/html".
#> • Expecting type "application/json" or suffix "json".

providers(org_name = starts("U"), count = TRUE)
#> Error in httr2::req_perform(httr2::req_error(httr2::req_retry(httr2::request(url),     retry_on_failure = TRUE, max_tries = 2), body = function(resp) httr2::resp_body_json(resp)$message)): Failed to parse error body with method defined in `req_error()`.
#> Caused by error in `httr2::resp_body_json()`:
#> ! Unexpected content type "text/html".
#> • Expecting type "application/json" or suffix "json".
```
