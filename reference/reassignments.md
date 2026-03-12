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
#> ✔ Query returned 3,493,831 results.
reassignments(org_enid = "I20070209000135")
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
