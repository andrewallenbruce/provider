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
#> # A tibble: 231 × 10
#>    org_name       first last  state prov_type prov_desc    npi multi pac   enid 
#>    <chr>          <chr> <chr> <chr> <chr>     <chr>      <int> <int> <chr> <chr>
#>  1 ABUL H SHIRAZ… NA    NA    CA    12-70     PART B S… 1.00e9     0 0941… O200…
#>  2 ABC MEDICAL C… NA    NA    CA    12-70     PART B S… 1.01e9     0 4486… O200…
#>  3 ABC MEDICINE … NA    NA    CA    12-A5     PART B S… 1.02e9     0 8921… O201…
#>  4 ABC MEDICINE … NA    NA    CA    30-A5     DME SUPP… 1.02e9     0 8921… O201…
#>  5 ABRX PHARMACY… NA    NA    CA    12-A5     PART B S… 1.02e9     0 1557… O202…
#>  6 ABRI MD GROUP… NA    NA    CA    12-70     PART B S… 1.03e9     0 4082… O202…
#>  7 ABBAS KASHANI… NA    NA    CA    12-70     PART B S… 1.06e9     0 9830… O200…
#>  8 ABSOLUTE COMP… NA    NA    CA    00-08     PART A P… 1.06e9     0 7416… O201…
#>  9 ABDULLAH IBIS… NA    NA    CA    12-70     PART B S… 1.07e9     0 8820… O202…
#> 10 ABSOLUTE CARE… NA    NA    CA    00-06     PART A P… 1.08e9     0 5496… O201…
#> # ℹ 221 more rows
```
