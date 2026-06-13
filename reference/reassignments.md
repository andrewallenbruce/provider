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
  memberships = NULL,
  members = NULL,
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

- memberships, members:

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
#> ◼ reassignments | 3,527,875 rows | 706 pages
reassignments(org_enid = starts("I"), members = greater(50, equal = TRUE))
#> ✔ reassignments returned 52 results
#> ✔ Retrieving 1 page
#> # A tibble: 52 × 13
#>    first   last  state specialty memberships    npi pac   enid  org_name members
#>    <chr>   <chr> <chr> <chr>           <int>  <int> <chr> <chr> <chr>      <int>
#>  1 Hilario Alva… TX    Family P…           2 1.83e9 6103… I201… NA            52
#>  2 James   Bagg… TX    Emergenc…           2 1.92e9 9638… I200… NA            52
#>  3 Todd    Baker TX    Family P…           2 1.37e9 5799… I200… NA            52
#>  4 Ami     Besh… TX    Family P…           2 1.84e9 5193… I200… NA            52
#>  5 Dennis  Bish… TX    Emergenc…           7 1.86e9 2567… I201… NA            52
#>  6 Cristi… Blej… TX    Family P…           2 1.32e9 3452… I201… NA            52
#>  7 James   Bugg  TX    Family P…           2 1.84e9 3274… I201… NA            52
#>  8 Richard Camp… TX    Emergenc…           2 1.89e9 5092… I200… NA            52
#>  9 John    Cantu TX    Family P…           2 1.01e9 8820… I200… NA            52
#> 10 David   Cart… TX    Family P…           5 1.82e9 7416… I201… NA            52
#> # ℹ 42 more rows
#> # ℹ 3 more variables: org_pac <chr>, org_enid <chr>, org_state <chr>
```
