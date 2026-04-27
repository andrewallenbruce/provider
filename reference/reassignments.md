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

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)

## References

- [API: Medicare Revalidation Reassignment
  List](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-reassignment-list)

## Examples

``` r
reassignments(count = TRUE)
#> Error in c("cli::cli_alert_info(c(\"{.strong {endpoint}} has \", \"{.strong {mark(x)}} \", ", "    \"{cli::qty(x)}row{?s}.\"))"): ! Could not evaluate cli `{}` expression: `mark(x)`.
#> Caused by error in `uuid_cms(self@end)`:
#> ! `endpoint` "eval" is invalid.

reassignments(
  count = TRUE,
  employers = greater(50, equal = TRUE))
#> Error in uuid_cms(self@end): `endpoint` "eval" is invalid.

reassignments(org_enid = "I20070209000135")
#> Error in uuid_cms(self@end): `endpoint` "eval" is invalid.

reassignments(pac = 9830437441)
#> Error in uuid_cms(self@end): `endpoint` "eval" is invalid.

reassignments(org_pac = 3173525888)
#> Error in uuid_cms(self@end): `endpoint` "eval" is invalid.
```
