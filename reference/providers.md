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

  `<int>` 10-digit Individual National Provider Identifier

- pac:

  `<chr>` 10-digit PECOS Associate Control ID

- enid:

  `<chr>` 15-digit Medicare Enrollment ID

- first, middle, last:

  `<chr>` Individual provider's name

- prov_type:

  `<chr>` Enrollment specialty code

- prov_desc:

  `<chr>` Enrollment specialty description

- state:

  `<chr>` Enrollment state, full or abbreviation

- org_name:

  `<chr>` Organization name

- multi:

  `<lgl>` Provider has multiple NPIs

- count:

  `<lgl>` Return the dataset's total row count

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
#> ℹ providers has 2,957,262 rows.
providers(enid = "I20040309000221")
#> ✔ providers returned 1 result.
#> # A data frame: 1 × 11
#>   org_name first  middle last  state prov_type prov_desc npi   multi pac   enid 
#> * <chr>    <chr>  <chr>  <chr> <chr> <chr>     <chr>     <chr> <chr> <chr> <chr>
#> 1 NA       STEVEN D      SHEI… FL    14-41     PRACTITI… 1417… N     3870… I200…
providers(npi = 1417918293)
#> ✔ providers returned 1 result.
#> # A data frame: 1 × 11
#>   org_name first  middle last  state prov_type prov_desc npi   multi pac   enid 
#> * <chr>    <chr>  <chr>  <chr> <chr> <chr>     <chr>     <chr> <chr> <chr> <chr>
#> 1 NA       STEVEN D      SHEI… FL    14-41     PRACTITI… 1417… N     3870… I200…
providers(pac = 2860305554)
#> ✔ providers returned 1 result.
#> # A data frame: 1 × 11
#>   org_name first  middle last  state prov_type prov_desc npi   multi pac   enid 
#> * <chr>    <chr>  <chr>  <chr> <chr> <chr>     <chr>     <chr> <chr> <chr> <chr>
#> 1 NA       ROBERT NA     YEAM… TX    14-41     PRACTITI… 1134… N     2860… I200…
```
