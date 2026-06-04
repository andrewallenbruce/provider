# Reassignment of Benefits

Returns information about:

- Individual providers who are reassigning benefits or are an employee
  of

- Organizational/Group providers who are receiving reassignment of
  benefits from or are the employer of the individual provider

It provides information regarding the physician and the group practice
they reassign their billing to, including individual employer
association counts.

## Usage

``` r
reassignments(
  npi = NULL,
  pac = NULL,
  enid = NULL,
  first = NULL,
  last = NULL,
  state = NULL,
  specialty = NULL,
  employers = NULL,
  employees = NULL,
  org_name = NULL,
  org_pac = NULL,
  org_enid = NULL,
  org_state = NULL,
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

- first, last:

  `<chr>` Provider's name

- state:

  `<chr>` Enrollment state abbreviation

- specialty:

  `<chr>` Enrollment specialty

- employers, employees:

  `<int>` Enrollment specialty

- org_name:

  `<chr>` Legal business name

- org_pac:

  `<chr>` PECOS Associate Control ID

- org_enid:

  `<chr>` Medicare Enrollment ID

- org_state:

  `<chr>` Enrollment state abbreviation

- count:

  `<lgl>` Return the total row count

- set:

  `<lgl>` Return the entire dataset

## References

- [API: Medicare Revalidation Reassignment
  List](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-reassignment-list)

## Examples

``` r
reassignments(count = TRUE)
#> reassignments Totals
#> Error in httr2::req_perform(httr2::req_error(httr2::req_retry(httr2::request(url),     retry_on_failure = TRUE, max_tries = 2), body = function(resp) httr2::resp_body_json(resp)$message)): Failed to parse error body with method defined in `req_error()`.
#> Caused by error in `httr2::resp_body_json()`:
#> ! Unexpected content type "text/html".
#> • Expecting type "application/json" or suffix "json".

reassignments(count = TRUE, employers = greater(50, equal = TRUE))
#> Error in httr2::req_perform(httr2::req_error(httr2::req_retry(httr2::request(url),     retry_on_failure = TRUE, max_tries = 2), body = function(resp) httr2::resp_body_json(resp)$message)): Failed to parse error body with method defined in `req_error()`.
#> Caused by error in `httr2::resp_body_json()`:
#> ! Unexpected content type "text/html".
#> • Expecting type "application/json" or suffix "json".

reassignments(org_enid = "I20070209000135")
#> Error in httr2::req_perform(httr2::req_error(httr2::req_retry(httr2::request(url),     retry_on_failure = TRUE, max_tries = 2), body = function(resp) httr2::resp_body_json(resp)$message)): Failed to parse error body with method defined in `req_error()`.
#> Caused by error in `httr2::resp_body_json()`:
#> ! Unexpected content type "text/html".
#> • Expecting type "application/json" or suffix "json".

reassignments(pac = 9830437441)
#> Error in httr2::req_perform(httr2::req_error(httr2::req_retry(httr2::request(url),     retry_on_failure = TRUE, max_tries = 2), body = function(resp) httr2::resp_body_json(resp)$message)): Failed to parse error body with method defined in `req_error()`.
#> Caused by error in `httr2::resp_body_json()`:
#> ! Unexpected content type "text/html".
#> • Expecting type "application/json" or suffix "json".

reassignments(org_pac = 3173525888)
#> Error in httr2::req_perform(httr2::req_error(httr2::req_retry(httr2::request(url),     retry_on_failure = TRUE, max_tries = 2), body = function(resp) httr2::resp_body_json(resp)$message)): Failed to parse error body with method defined in `req_error()`.
#> Caused by error in `httr2::resp_body_json()`:
#> ! Unexpected content type "text/html".
#> • Expecting type "application/json" or suffix "json".
```
