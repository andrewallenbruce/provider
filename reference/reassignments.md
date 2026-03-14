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
  count = FALSE
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

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)

## References

- [API: Medicare Revalidation Reassignment
  List](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-reassignment-list)

## Examples

``` r
reassignments(count = TRUE)
#> ✔ `reassignments()` returned 3,493,831 results.
reassignments(org_enid = "I20070209000135")
#> ✔ `reassignments()` returned 5 results.
#> # A tibble: 5 × 14
#>   first   last   state specialty ind_assoc npi   pac   enid  org_name org_assign
#>   <chr>   <chr>  <chr> <chr>     <chr>     <chr> <chr> <chr> <chr>    <chr>     
#> 1 Joah    Alian… FL    Ophthalm… 2         1083… 9830… I202… NA       5         
#> 2 Kyle    Bettis FL    Optometry 2         1871… 1850… I201… NA       5         
#> 3 Craig   Cole   FL    Ophthalm… 2         1851… 6305… I201… NA       5         
#> 4 Richard Jablo… FL    Ophthalm… 2         1760… 3577… I201… NA       5         
#> 5 Ashley  Royce  FL    Optometry 2         1437… 8224… I201… NA       5         
#> # ℹ 4 more variables: org_pac <chr>, org_enid <chr>, org_state <chr>,
#> #   type <chr>
reassignments(pac = 9830437441)
#> ✔ `reassignments()` returned 2 results.
#> # A tibble: 2 × 14
#>   first last    state specialty  ind_assoc npi   pac   enid  org_name org_assign
#>   <chr> <chr>   <chr> <chr>      <chr>     <chr> <chr> <chr> <chr>    <chr>     
#> 1 Joah  Aliancy FL    Ophthalmo… 2         1083… 9830… I202… NA       5         
#> 2 Joah  Aliancy FL    Ophthalmo… 2         1083… 9830… I202… Clermon… 1         
#> # ℹ 4 more variables: org_pac <chr>, org_enid <chr>, org_state <chr>,
#> #   type <chr>
reassignments(org_pac = 3173525888)
#> ✔ `reassignments()` returned 5 results.
#> # A tibble: 5 × 14
#>   first   last   state specialty ind_assoc npi   pac   enid  org_name org_assign
#>   <chr>   <chr>  <chr> <chr>     <chr>     <chr> <chr> <chr> <chr>    <chr>     
#> 1 Joah    Alian… FL    Ophthalm… 2         1083… 9830… I202… NA       5         
#> 2 Kyle    Bettis FL    Optometry 2         1871… 1850… I201… NA       5         
#> 3 Craig   Cole   FL    Ophthalm… 2         1851… 6305… I201… NA       5         
#> 4 Richard Jablo… FL    Ophthalm… 2         1760… 3577… I201… NA       5         
#> 5 Ashley  Royce  FL    Optometry 2         1437… 8224… I201… NA       5         
#> # ℹ 4 more variables: org_pac <chr>, org_enid <chr>, org_state <chr>,
#> #   type <chr>
```
