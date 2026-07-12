# Veterans Health Administration Hospitals

A list of all VHA hospitals. The list includes addresses and phone
numbers.

## Usage

``` r
veteran(
  ccn = NULL,
  name = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  county = NULL,
  rating = NULL,
  count = FALSE
)
```

## Source

- [API: Veterans Health Administration Provider Level
  Data](https://data.cms.gov/provider-data/dataset/uyx4-5s7f)

## Arguments

- ccn:

  `<chr>` desc

- name:

  `<chr>` desc

- city, state, zip, county:

  `<chr>` desc

- rating:

  `<int>` desc

- count:

  `<lgl>` Return the total row count

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
containing the search results.

## Examples

``` r
veteran(count = TRUE)
#> ◼ veteran | 132 rows | 1 pages
veteran(state = "GA")
#> ✔ veteran returned 3 results
#> ✔ Retrieving 1 page
#> # A tibble: 3 × 11
#>   ccn    name      address city  state zip   county prov_type own_type emergency
#>   <chr>  <chr>     <chr>   <chr> <chr> <chr> <chr>  <chr>     <chr>        <int>
#> 1 11029F DECATUR … 1670 C… DECA… GA    30033 DE KA… Acute Ca… Veteran…         1
#> 2 11030F AUGUSTA … 1 FREE… AUGU… GA    30904 RICHM… Acute Ca… Veteran…         1
#> 3 11031F DUBLIN V… 1826 V… DUBL… GA    31021 LAURE… Acute Ca… Veteran…         1
#> # ℹ 1 more variable: rating <int>
```
