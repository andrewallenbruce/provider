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
reassigned(
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
  count = FALSE
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

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
containing the search results.

## References

- [API: Medicare Revalidation Reassignment
  List](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-reassignment-list)

## Examples

``` r
reassigned(count = TRUE)
#> ◼ reassigned | 3,567,599 rows | 714 pages
reassigned(org_enid = starts("I"), members = greater(50, equal = TRUE))
#> ✔ reassigned returned 51 results
#> # A tibble: 51 × 13
#>         npi pac   enid  first last  state specialty memberships org_pac org_enid
#>       <int> <chr> <chr> <chr> <chr> <chr> <chr>           <int> <chr>   <chr>   
#>  1   1.83e9 6103… I201… Hila… Alva… TX    Family P…           2 175932… I201208…
#>  2   1.92e9 9638… I200… James Bagg… TX    Emergenc…           2 175932… I201208…
#>  3   1.37e9 5799… I200… Todd  Baker TX    Family P…           2 175932… I201208…
#>  4   1.84e9 5193… I200… Ami   Besh… TX    Family P…           2 175932… I201208…
#>  5   1.86e9 2567… I201… Denn… Bish… TX    Emergenc…           6 175932… I201208…
#>  6   1.32e9 3452… I201… Cris… Blej… TX    Family P…           2 175932… I201208…
#>  7   1.84e9 3274… I201… James Bugg  TX    Family P…           2 175932… I201208…
#>  8   1.89e9 5092… I200… Rich… Camp… TX    Emergenc…           2 175932… I201208…
#>  9   1.01e9 8820… I200… John  Cantu TX    Family P…           2 175932… I201208…
#> 10   1.82e9 7416… I201… David Cart… TX    Family P…           5 175932… I201208…
#> # ℹ 41 more rows
#> # ℹ 3 more variables: org_name <chr>, members <int>, org_state <chr>
```
