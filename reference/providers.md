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
#>    org_name    first last  state prov_type taxonomy prov_desc    npi multi pac  
#>  * <chr>       <chr> <chr> <chr> <chr>     <chr>    <chr>      <int> <int> <chr>
#>  1 ABUL H SHI… NA    NA    CA    12-70     2084P08… PART B S… 1.00e9     0 0941…
#>  2 ABC MEDICA… NA    NA    CA    12-70     207N000… PART B S… 1.01e9     0 4486…
#>  3 ABC MEDICI… NA    NA    CA    12-A5     3336C00… PART B S… 1.02e9     0 8921…
#>  4 ABC MEDICI… NA    NA    CA    30-A5     3336C00… DME SUPP… 1.02e9     0 8921…
#>  5 ABRX PHARM… NA    NA    CA    12-A5     3336C00… PART B S… 1.02e9     0 1557…
#>  6 ABRI MD GR… NA    NA    CA    12-70     208D000… PART B S… 1.03e9     0 4082…
#>  7 ABBAS KASH… NA    NA    CA    12-70     207YX09… PART B S… 1.06e9     0 9830…
#>  8 ABSOLUTE C… NA    NA    CA    00-08     251G000… PART A P… 1.06e9     0 7416…
#>  9 ABDULLAH I… NA    NA    CA    12-70     2084N04… PART B S… 1.07e9     0 8820…
#> 10 ABSOLUTE C… NA    NA    CA    00-06     251E000… PART A P… 1.08e9     0 5496…
#> # ℹ 221 more rows
#> # ℹ 1 more variable: enid <chr>
```
