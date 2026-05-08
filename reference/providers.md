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
#> providers Totals
#> • Rows  : 2,981,799
#> • Pages : 597      
#> 

providers(count = TRUE, org_name = not_blank())
#> ✔ providers returned 433,496 results.

providers()
#> providers Totals
#> • Rows  : 2,981,799
#> • Pages : 597      
#> 
#> ! No Query ❯ Returning first 10 rows.
#> 
#> # A tibble: 10 × 11
#>    org_name first      middle last  state prov_type prov_desc    npi multi pac  
#>    <chr>    <chr>      <chr>  <chr> <chr> <chr>     <chr>      <int> <int> <chr>
#>  1 NA       ELVIA      ARELIS AYALA PR    14-01     PRACTITI… 1.50e9     0 1254…
#>  2 NA       RHONDA     G      GRIS… KY    14-30     PRACTITI… 1.85e9     0 2466…
#>  3 NA       TIMOTHY    J      DIEC… NJ    14-35     PRACTITI… 1.08e9     0 5092…
#>  4 NA       JORGE      A      OSTO… PR    14-16     PRACTITI… 1.83e9     0 5193…
#>  5 NA       ANNA       NA     MOY   NJ    14-41     PRACTITI… 1.08e9     0 5991…
#>  6 NA       CHRISTOPH… J      ZIEG… PA    14-68     PRACTITI… 1.00e9     0 7113…
#>  7 NA       DAMON      D      DELS… NJ    14-26     PRACTITI… 1.72e9     0 7618…
#>  8 NA       ANTONIO    NA     ALVA… PR    14-16     PRACTITI… 1.00e9     0 8022…
#>  9 NA       KADISHA    B      RAPP  PA    14-93     PRACTITI… 1.41e9     0 8022…
#> 10 NA       ARNOLD     NA     WEIN… MI    14-68     PRACTITI… 1.44e9     0 9234…
#> # ℹ 1 more variable: enid <chr>

providers(org_name = starts("AB"), state = c("TX", "CA"))
#> ✔ providers returned 231 results.
#> # A tibble: 231 × 11
#>    org_name      first middle last  state prov_type prov_desc    npi multi pac  
#>    <chr>         <chr> <chr>  <chr> <chr> <chr>     <chr>      <int> <int> <chr>
#>  1 ABILITY HOME… NA    NA     NA    CA    00-18     PART A P… 1.32e9     0 0042…
#>  2 ABSOLUTE LIF… NA    NA     NA    TX    12-70     PART B S… 1.34e9     0 0042…
#>  3 ABILENE CHIR… NA    NA     NA    TX    12-70     PART B S… 1.54e9     0 0042…
#>  4 ABILENE DERM… NA    NA     NA    TX    12-70     PART B S… 1.96e9     0 0143…
#>  5 ABC HOSPICE,… NA    NA     NA    TX    00-08     PART A P… 1.22e9     0 0244…
#>  6 ABDUL S THAN… NA    NA     NA    TX    12-70     PART B S… 1.79e9     0 0244…
#>  7 ABHISHEK BHA… NA    NA     NA    CA    12-70     PART B S… 1.55e9     0 0244…
#>  8 ABC SLEEP PL… NA    NA     NA    TX    12-70     PART B S… 1.48e9     0 0345…
#>  9 ABOVE AVERAG… NA    NA     NA    TX    12-70     PART B S… 1.76e9     0 0446…
#> 10 ABADA PLLC    NA    NA     NA    TX    12-70     PART B S… 1.26e9     0 0446…
#> # ℹ 221 more rows
#> # ℹ 1 more variable: enid <chr>

providers(org_name = starts("U"), count = TRUE)
#> ✔ providers returned 5,830 results.
```
