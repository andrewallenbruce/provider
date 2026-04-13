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
providers(count = TRUE, org_name = not(""))
#> ✔ providers returned 433,293 results.
providers(org_name = starts_with("Z"), multi = TRUE)
#> ✔ providers returned 10 results.
#> # A data frame: 10 × 11
#>    org_name first middle last  state prov_type prov_desc npi   multi pac   enid 
#>  * <chr>    <chr> <chr>  <chr> <chr> <chr>     <chr>     <chr> <chr> <chr> <chr>
#>  1 ZEPF CE… NA    NA     NA    OH    12-70     PART B S… 1215… Y     5395… O200…
#>  2 ZOLLING… NA    NA     NA    CA    12-65     PART B S… 1861… Y     3577… O200…
#>  3 ZEITER … NA    NA     NA    CA    12-70     PART B S… 1730… Y     8527… O200…
#>  4 ZACOALC… NA    NA     NA    CA    12-70     PART B S… 1679… Y     4183… O200…
#>  5 ZEPHYRH… NA    NA     NA    FL    12-70     PART B S… 1902… Y     8628… O200…
#>  6 ZOOM RE… NA    NA     NA    TX    00-14     PART A P… 1861… Y     9133… O201…
#>  7 ZANESVI… NA    NA     NA    OH    12-70     PART B S… 1891… Y     4082… O201…
#>  8 ZYMEK C… NA    NA     NA    AZ    12-70     PART B S… 1225… Y     4082… O201…
#>  9 ZION HE… NA    NA     NA    FL    12-70     PART B S… 1023… Y     8224… O201…
#> 10 ZOHAS P… NA    NA     NA    CA    12-73     PART B S… 1811… Y     9436… O202…
```
