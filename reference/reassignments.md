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
#> reassignments Totals
#> • Rows  : 3,521,074
#> • Pages : 705      
#> 

reassignments(count = TRUE, employers = greater(50, equal = TRUE))
#> ✔ reassignments returned 1,292 results.

reassignments(org_enid = "I20070209000135")
#> ✔ reassignments returned 6 results.
#> # A tibble: 6 × 13
#>   org_pac   org_enid org_name org_state employees pac   enid     npi first last 
#> * <chr>     <chr>    <chr>    <chr>         <int> <chr> <chr>  <int> <chr> <chr>
#> 1 31735258… I200702… NA       FL                6 9830… I202… 1.08e9 Joah  Alia…
#> 2 31735258… I200702… NA       FL                6 1850… I201… 1.87e9 Kyle  Bett…
#> 3 31735258… I200702… NA       FL                6 6305… I201… 1.85e9 Craig Cole 
#> 4 31735258… I200702… NA       FL                6 3577… I201… 1.76e9 Rich… Jabl…
#> 5 31735258… I200702… NA       FL                6 4385… I202… 1.68e9 Asyv… Powe…
#> 6 31735258… I200702… NA       FL                6 8224… I201… 1.44e9 Ashl… Royce
#> # ℹ 3 more variables: state <chr>, specialty <chr>, employers <int>

reassignments(pac = 9830437441)
#> ✔ reassignments returned 2 results.
#> # A tibble: 2 × 13
#>   org_pac   org_enid org_name org_state employees pac   enid     npi first last 
#> * <chr>     <chr>    <chr>    <chr>         <int> <chr> <chr>  <int> <chr> <chr>
#> 1 31735258… I200702… ""       FL                6 9830… I202… 1.08e9 Joah  Alia…
#> 2 57992955… O202506… "Clermo… FL                1 9830… I202… 1.08e9 Joah  Alia…
#> # ℹ 3 more variables: state <chr>, specialty <chr>, employers <int>

reassignments(org_pac = 3173525888)
#> ✔ reassignments returned 6 results.
#> # A tibble: 6 × 13
#>   org_pac   org_enid org_name org_state employees pac   enid     npi first last 
#> * <chr>     <chr>    <chr>    <chr>         <int> <chr> <chr>  <int> <chr> <chr>
#> 1 31735258… I200702… NA       FL                6 9830… I202… 1.08e9 Joah  Alia…
#> 2 31735258… I200702… NA       FL                6 1850… I201… 1.87e9 Kyle  Bett…
#> 3 31735258… I200702… NA       FL                6 6305… I201… 1.85e9 Craig Cole 
#> 4 31735258… I200702… NA       FL                6 3577… I201… 1.76e9 Rich… Jabl…
#> 5 31735258… I200702… NA       FL                6 4385… I202… 1.68e9 Asyv… Powe…
#> 6 31735258… I200702… NA       FL                6 8224… I201… 1.44e9 Ashl… Royce
#> # ℹ 3 more variables: state <chr>, specialty <chr>, employers <int>
```
