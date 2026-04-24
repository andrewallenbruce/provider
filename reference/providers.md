# Provider Enrollment in Medicare

Enrollment data on individual and organizational providers that are
actively approved to bill Medicare.

## Usage

``` r
providers(
  npi = NULL,
  pac = NULL,
  enid = NULL,
  first = NULL,
  middle = NULL,
  last = NULL,
  prov_type = NULL,
  prov_desc = NULL,
  state = NULL,
  org_name = NULL,
  multi = NULL,
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

- first, middle, last:

  `<chr>` Individual provider's name

- prov_type:

  `<chr>` Enrollment specialty code

- prov_desc:

  `<chr>` Enrollment specialty description

- state:

  `<chr>` Enrollment state, full or abbreviation

- org_name:

  `<chr>` Organizational provider's name

- multi:

  `<lgl>` Provider has multiple NPIs

- count:

  `<lgl>` Return the total row count

- set:

  `<lgl>` Return the entire dataset

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)

## References

- [API: Medicare Provider Supplier
  Enrollment](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/medicare-fee-for-service-public-provider-enrollment)

- [Provider Enrollment Data
  Dictionary](https://data.cms.gov/resources/medicare-fee-for-service-public-provider-enrollment-data-dictionary)

## Examples

``` r
providers(count = TRUE)
#> ℹ providers has 2,981,799 rows.

providers(count = TRUE, org_name = not_blank())
#> ✔ providers returned 433,496 results.

providers(org_name = starts_with("Z"))
#> ✔ providers returned 884 results.
#> # A tibble: 884 × 11
#>    org_name      first middle last  state prov_type prov_desc    npi multi pac  
#>  * <chr>         <chr> <chr>  <chr> <chr> <chr>     <chr>      <int> <int> <chr>
#>  1 Z & B HEALTH… NA    NA     NA    TX    00-08     PART A P… 1.53e9     0 1254…
#>  2 Z & C MEDICA… NA    NA     NA    CA    12-70     PART B S… 1.30e9     0 2567…
#>  3 Z & E DYNAST… NA    NA     NA    DC    12-70     PART B S… 1.95e9     0 1850…
#>  4 Z & Z MEDICA… NA    NA     NA    TX    12-70     PART B S… 1.62e9     0 8224…
#>  5 Z AFFORDABLE… NA    NA     NA    TX    12-70     PART B S… 1.31e9     0 1355…
#>  6 Z AND Z PODI… NA    NA     NA    NV    12-70     PART B S… 1.98e9     0 8224…
#>  7 Z AND Z PODI… NA    NA     NA    AZ    12-70     PART B S… 1.98e9     0 8224…
#>  8 Z AND Z PODI… NA    NA     NA    CA    12-70     PART B S… 1.98e9     0 8224…
#>  9 Z AND Z PODI… NA    NA     NA    NV    30-48     DME SUPP… 1.98e9     0 8224…
#> 10 Z AUDIOLOGY … NA    NA     NA    FL    12-70     PART B S… 1.35e9     0 9436…
#> # ℹ 874 more rows
#> # ℹ 1 more variable: enid <chr>
```
