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
  organization = NULL,
  pac_org = NULL,
  enid_org = NULL,
  state_org = NULL,
  entry = NULL,
  tidy = TRUE,
  na.rm = TRUE,
  ...
)
```

## Arguments

- npi:

  `<chr>` **Individual** 10-digit National Provider Identifier

- pac:

  `<chr>` **Individual** 10-digit PECOS Associate Control ID

- enid:

  `<chr>` **Individual** 15-digit Medicare Enrollment ID

- first, last:

  `<chr>` **Individual** Provider's name

- state:

  `<chr>` **Individual** Enrollment state abbreviation

- specialty:

  `<chr>` **Individual** Enrollment specialty

- organization:

  `<chr>` **Organizational** Legal business name

- pac_org:

  `<chr>` **Organizational** 10-digit PECOS Associate Control ID

- enid_org:

  `<chr>` **Organizational** 15-digit Medicare Enrollment ID

- state_org:

  `<chr>` **Organizational** Enrollment state abbreviation

- entry:

  `<chr>` Entry type, reassignment (`"R"`) or employment (`"E"`)

- tidy:

  `<lgl>` // **default:** `TRUE` Tidy output

- na.rm:

  `<chr>` // **default:** `TRUE` Remove empty rows and columns

- ...:

  Empty

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
with the columns:

|                 |                                                                    |
|-----------------|--------------------------------------------------------------------|
| **Field**       | **Description**                                                    |
| `npi`           | *Individual* National Provider Identifier                          |
| `pac`           | *Individual* PECOS Associate Control ID                            |
| `enid`          | *Individual* Medicare Enrollment ID                                |
| `first`         | *Individual* Provider's First Name                                 |
| `last`          | *Individual* Provider's Last Name                                  |
| `associations`  | Number of Organizations *Individual* Reassigns Benefits To         |
| `pac_org`       | *Organization's* PECOS Associate Control ID                        |
| `enid_org`      | *Organization's* Medicare Enrollment ID                            |
| `state_org`     | State *Organization* Enrolled in Medicare                          |
| `reassignments` | Number of Individuals the *Organization* Accepts Reassignment From |
| `entry`         | Whether Entry is for *Reassignment* or *Employment*                |

## Links

- [Medicare Revalidation Reassignment List
  API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-reassignment-list)

*Update Frequency:* **Monthly**

## Examples

``` r
if (FALSE) { # interactive()
reassignments(enid = "I20200929003184")

reassignments(pac = 9830437441)

reassignments(pac_org = 3173525888)
}
```
