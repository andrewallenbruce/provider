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
#> # A tibble: 10 × 11
#>    org_name      first middle last  state prov_type prov_desc    npi multi pac  
#>  * <chr>         <chr> <chr>  <chr> <chr> <chr>     <chr>      <int> <int> <chr>
#>  1 ZEPF CENTER   NA    NA     NA    OH    12-70     PART B S… 1.22e9     1 5395…
#>  2 ZOLLINGER PH… NA    NA     NA    CA    12-65     PART B S… 1.86e9     1 3577…
#>  3 ZEITER EYE M… NA    NA     NA    CA    12-70     PART B S… 1.73e9     1 8527…
#>  4 ZACOALCO MED… NA    NA     NA    CA    12-70     PART B S… 1.68e9     1 4183…
#>  5 ZEPHYRHILLS … NA    NA     NA    FL    12-70     PART B S… 1.90e9     1 8628…
#>  6 ZOOM REHABIL… NA    NA     NA    TX    00-14     PART A P… 1.86e9     1 9133…
#>  7 ZANESVILLE V… NA    NA     NA    OH    12-70     PART B S… 1.89e9     1 4082…
#>  8 ZYMEK CARDIO… NA    NA     NA    AZ    12-70     PART B S… 1.23e9     1 4082…
#>  9 ZION HEALTH … NA    NA     NA    FL    12-70     PART B S… 1.02e9     1 8224…
#> 10 ZOHAS PHARMA… NA    NA     NA    CA    12-73     PART B S… 1.81e9     1 9436…
#> # ℹ 1 more variable: enid <chr>
```
