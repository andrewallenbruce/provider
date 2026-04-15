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
  org_state = NULL,
  count = FALSE,
  set = FALSE
)
```

## Arguments

- npi:

  `<int>` 10-digit National Provider Identifier

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

- count:

  `<lgl>` Return the dataset's total row count

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
#> ℹ reassignments has 3,511,984 rows.
reassignments(org_enid = "I20070209000135")
#> ✔ reassignments returned 6 results.
#> # A tibble: 6 × 14
#>   first   last   state specialty employers    npi pac   enid  org_name employees
#> * <chr>   <chr>  <chr> <chr>         <int>  <int> <chr> <chr> <chr>        <int>
#> 1 Joah    Alian… FL    Ophthalm…         2 1.08e9 9830… I202… NA               6
#> 2 Kyle    Bettis FL    Optometry         2 1.87e9 1850… I201… NA               6
#> 3 Craig   Cole   FL    Ophthalm…         2 1.85e9 6305… I201… NA               6
#> 4 Richard Jablo… FL    Ophthalm…         1 1.76e9 3577… I201… NA               6
#> 5 Asyvia  Powel… FL    Ophthalm…         1 1.68e9 4385… I202… NA               6
#> 6 Ashley  Royce  FL    Optometry         2 1.44e9 8224… I201… NA               6
#> # ℹ 4 more variables: org_pac <chr>, org_enid <chr>, org_state <chr>,
#> #   rec_type <chr>
reassignments(pac = 9830437441)
#> ✔ reassignments returned 2 results.
#> # A tibble: 2 × 14
#>   first last    state specialty  employers    npi pac   enid  org_name employees
#> * <chr> <chr>   <chr> <chr>          <int>  <int> <chr> <chr> <chr>        <int>
#> 1 Joah  Aliancy FL    Ophthalmo…         2 1.08e9 9830… I202… NA               6
#> 2 Joah  Aliancy FL    Ophthalmo…         2 1.08e9 9830… I202… Clermon…         1
#> # ℹ 4 more variables: org_pac <chr>, org_enid <chr>, org_state <chr>,
#> #   rec_type <chr>
reassignments(org_pac = 3173525888)
#> ✔ reassignments returned 6 results.
#> # A tibble: 6 × 14
#>   first   last   state specialty employers    npi pac   enid  org_name employees
#> * <chr>   <chr>  <chr> <chr>         <int>  <int> <chr> <chr> <chr>        <int>
#> 1 Joah    Alian… FL    Ophthalm…         2 1.08e9 9830… I202… NA               6
#> 2 Kyle    Bettis FL    Optometry         2 1.87e9 1850… I201… NA               6
#> 3 Craig   Cole   FL    Ophthalm…         2 1.85e9 6305… I201… NA               6
#> 4 Richard Jablo… FL    Ophthalm…         1 1.76e9 3577… I201… NA               6
#> 5 Asyvia  Powel… FL    Ophthalm…         1 1.68e9 4385… I202… NA               6
#> 6 Ashley  Royce  FL    Optometry         2 1.44e9 8224… I201… NA               6
#> # ℹ 4 more variables: org_pac <chr>, org_enid <chr>, org_state <chr>,
#> #   rec_type <chr>
```
