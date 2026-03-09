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
  org_name = NULL,
  org_pac = NULL,
  org_enid = NULL,
  org_state = NULL
)
```

## Arguments

- npi:

  `<chr>` 10-digit National Provider Identifier

- pac:

  `<chr>` 10-digit PECOS Associate Control ID

- enid:

  `<chr>` 15-digit Medicare Enrollment ID

- first, last:

  `<chr>` Provider's name

- state:

  `<chr>` Enrollment state abbreviation

- specialty:

  `<chr>` Enrollment specialty

- org_name:

  `<chr>` Legal business name

- org_pac:

  `<chr>` 10-digit PECOS Associate Control ID

- org_enid:

  `<chr>` 15-digit Medicare Enrollment ID

- org_state:

  `<chr>` Enrollment state abbreviation

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

## References

- [Medicare Revalidation Reassignment List
  API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-reassignment-list)

## Examples

``` r
reassignments()
#> ! No Query → Returning first 10 rows.
#> # A tibble: 10 × 14
#>    npi    pac   enid  first last  state specialty reassignments org_name org_pac
#>    <chr>  <chr> <chr> <chr> <chr> <chr> <chr>     <chr>         <chr>    <chr>  
#>  1 10437… 4880… I201… Syeda Abbas NY    Optometry 1             NA       347660…
#>  2 18718… 9335… I201… Amir  Abba… VA    Podiatry  5             NA       903214…
#>  3 15982… 8224… I201… Kell… Abe   HI    Optometry 1             NA       165840…
#>  4 15685… 2769… I200… Ther… Abed  MI    Clinical… 15            NA       246673…
#>  5 14371… 6305… I200… Mich… Abis  NY    Internal… 1             NA       670906…
#>  6 10536… 5092… I201… Lori  Abney KY    Nurse Pr… 2             NA       771995…
#>  7 19321… 5472… I200… Lour… Abri… NY    Anesthes… 2             NA       549688…
#>  8 15184… 6507… I201… Cath… Acad… CA    Optometry 3             NA       701292…
#>  9 13164… 4385… I201… Megan Acke… CA    Chiropra… 2             NA       680087…
#> 10 13669… 7495… I202… Domi… Acqu… IN    Family P… 1             NA       670982…
#> # ℹ 4 more variables: org_enid <chr>, org_state <chr>, associations <chr>,
#> #   type <chr>

reassignments(enid = "I20200929003184")
#> ✖ Query returned 0 results.

reassignments(pac = 9830437441)
#> ✔ Query returned 2 results.
#> # A tibble: 2 × 14
#>   npi     pac   enid  first last  state specialty reassignments org_name org_pac
#>   <chr>   <chr> <chr> <chr> <chr> <chr> <chr>     <chr>         <chr>    <chr>  
#> 1 108315… 9830… I202… Joah  Alia… FL    Ophthalm… 5             NA       317352…
#> 2 108315… 9830… I202… Joah  Alia… FL    Ophthalm… 1             Clermon… 579929…
#> # ℹ 4 more variables: org_enid <chr>, org_state <chr>, associations <chr>,
#> #   type <chr>

reassignments(org_pac = 3173525888)
#> ✔ Query returned 5 results.
#> # A tibble: 5 × 14
#>   npi     pac   enid  first last  state specialty reassignments org_name org_pac
#>   <chr>   <chr> <chr> <chr> <chr> <chr> <chr>     <chr>         <chr>    <chr>  
#> 1 108315… 9830… I202… Joah  Alia… FL    Ophthalm… 5             NA       317352…
#> 2 187104… 1850… I201… Kyle  Bett… FL    Optometry 5             NA       317352…
#> 3 185133… 6305… I201… Craig Cole  FL    Ophthalm… 5             NA       317352…
#> 4 176047… 3577… I201… Rich… Jabl… FL    Ophthalm… 5             NA       317352…
#> 5 143733… 8224… I201… Ashl… Royce FL    Optometry 5             NA       317352…
#> # ℹ 4 more variables: org_enid <chr>, org_state <chr>, associations <chr>,
#> #   type <chr>
```
