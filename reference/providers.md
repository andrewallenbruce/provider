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
  last = NULL,
  prov_type = NULL,
  prov_desc = NULL,
  state = NULL,
  org_name = NULL,
  multi = NULL,
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

  `<chr>` Individual provider's name

- prov_type, prov_desc:

  `<chr>` Enrollment specialty code/description

- state:

  `<chr>` Enrollment state, full or abbreviation

- org_name:

  `<chr>` Organizational provider's name

- multi:

  `<lgl>` Provider has multiple NPIs

- count:

  `<lgl>` Return the total row count

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
containing the search results.

## References

- [API: Medicare Provider Supplier
  Enrollment](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/medicare-fee-for-service-public-provider-enrollment)

- [Provider Enrollment Data
  Dictionary](https://data.cms.gov/resources/medicare-fee-for-service-public-provider-enrollment-data-dictionary)

## Examples

``` r
providers(count = TRUE)
#> ◼ providers | 2,981,799 rows | 597 pages

providers(count = TRUE, org_name = not_blank())
#> ✔ providers returned 433,496 results

providers(org_name = starts("AB"), state = c("TX", "CA"))
#> ✔ providers returned 231 results
#> ✔ Retrieving 1 page
#> ✔ nppes searching 219 NPIs
#> ✔ nppes returned 219 results
#> # A tibble: 231 × 11
#>          npi pac   enid  prov_type taxonomy prov_desc org_name first last  state
#>  *     <int> <chr> <chr> <chr>     <chr>    <chr>     <chr>    <chr> <chr> <chr>
#>  1    1.00e9 0941… O200… 12-70     2084P08… PART B S… ABUL H … NA    NA    CA   
#>  2    1.01e9 4486… O200… 12-70     207N000… PART B S… ABC MED… NA    NA    CA   
#>  3    1.02e9 8921… O201… 12-A5     3336C00… PART B S… ABC MED… NA    NA    CA   
#>  4    1.02e9 8921… O201… 30-A5     3336C00… DME SUPP… ABC MED… NA    NA    CA   
#>  5    1.02e9 1557… O202… 12-A5     3336C00… PART B S… ABRX PH… NA    NA    CA   
#>  6    1.03e9 4082… O202… 12-70     208D000… PART B S… ABRI MD… NA    NA    CA   
#>  7    1.06e9 9830… O200… 12-70     207YX09… PART B S… ABBAS K… NA    NA    CA   
#>  8    1.06e9 7416… O201… 00-08     251G000… PART A P… ABSOLUT… NA    NA    CA   
#>  9    1.07e9 8820… O202… 12-70     2084N04… PART B S… ABDULLA… NA    NA    CA   
#> 10    1.08e9 5496… O201… 00-06     251E000… PART A P… ABSOLUT… NA    NA    CA   
#> # ℹ 221 more rows
#> # ℹ 1 more variable: multi <int>
```
