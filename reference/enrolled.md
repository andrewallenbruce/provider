# Enrollment in Medicare

Enrollment data on individual and organizational providers that are
actively approved to bill Medicare.

## Usage

``` r
enrolled(
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
enrolled(count = TRUE)
#> ℹ providers has 2,981,799 rows.
enrolled(count = TRUE, org_name = not_blank())
#> ✔ providers returned 433,496 results.
enrolled()
#> ! providers ❯ No Query
#> ℹ Returning first 10 rows...
#> # A tibble: 10 × 11
#>    org_name first      middle last  state prov_type prov_desc    npi multi pac  
#>  * <chr>    <chr>      <chr>  <chr> <chr> <chr>     <chr>      <int> <int> <chr>
#>  1 NA       ANTONIO    NA     ALVA… PR    14-16     PRACTITI… 1.00e9     0 8022…
#>  2 NA       CHRISTOPH… J      ZIEG… PA    14-68     PRACTITI… 1.00e9     0 7113…
#>  3 NA       KADISHA    B      RAPP  PA    14-93     PRACTITI… 1.41e9     0 8022…
#>  4 NA       JORGE      A      OSTO… PR    14-16     PRACTITI… 1.83e9     0 5193…
#>  5 NA       RHONDA     G      GRIS… KY    14-30     PRACTITI… 1.85e9     0 2466…
#>  6 NA       TIMOTHY    J      DIEC… NJ    14-35     PRACTITI… 1.08e9     0 5092…
#>  7 NA       ANNA       NA     MOY   NJ    14-41     PRACTITI… 1.08e9     0 5991…
#>  8 NA       DAMON      D      DELS… NJ    14-26     PRACTITI… 1.72e9     0 7618…
#>  9 NA       ELVIA      ARELIS AYALA PR    14-01     PRACTITI… 1.50e9     0 1254…
#> 10 NA       ARNOLD     NA     WEIN… MI    14-68     PRACTITI… 1.44e9     0 9234…
#> # ℹ 1 more variable: enid <chr>
enrolled(org_name = starts_with("AB"), state = c("TX", "CA"))
#> ✔ providers returned 231 results.
#> # A tibble: 231 × 11
#>    org_name      first middle last  state prov_type prov_desc    npi multi pac  
#>  * <chr>         <chr> <chr>  <chr> <chr> <chr>     <chr>      <int> <int> <chr>
#>  1 ABSOLUTE HOM… NA    NA     NA    CA    00-06     PART A P… 1.70e9     0 5890…
#>  2 ABILITY HOME… NA    NA     NA    CA    00-18     PART A P… 1.32e9     0 0042…
#>  3 ABM MEDICAL … NA    NA     NA    CA    12-70     PART B S… 1.50e9     0 6901…
#>  4 ABACUS BUSIN… NA    NA     NA    CA    12-69     PART B S… 1.82e9     0 9436…
#>  5 ABJELINA MEN… NA    NA     NA    CA    12-70     PART B S… 1.29e9     0 5193…
#>  6 ABRAHAM ISHA… NA    NA     NA    CA    12-70     PART B S… 1.84e9     0 2264…
#>  7 ABLE HANDS I… NA    NA     NA    CA    00-06     PART A P… 1.78e9     0 7911…
#>  8 ABC MEDICAL … NA    NA     NA    CA    12-70     PART B S… 1.01e9     0 4486…
#>  9 ABRHAM TEKOL… NA    NA     NA    CA    12-70     PART B S… 1.33e9     0 5597…
#> 10 ABHAY PARIKH… NA    NA     NA    CA    12-70     PART B S… 1.44e9     0 4587…
#> # ℹ 221 more rows
#> # ℹ 1 more variable: enid <chr>
# enrolled(org_name = starts_with("U"))
```
