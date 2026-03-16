# Hospital Price Transparency

Eligibility to order and refer within Medicare

## Usage

``` r
transparency(
  name = NULL,
  address = NULL,
  city = NULL,
  state = NULL,
  action = NULL,
  count = FALSE
)
```

## Arguments

- name:

  `<chr>` Hospital name

- address:

  `<chr>` Hospital address

- city:

  `<chr>` Hospital city

- state:

  `<chr>` Hospital state

- action:

  `<chr>` Action taken by CMS following a Compliance Review

- count:

  `<lgl>` Return the dataset's total row count

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)

## References

- [API: Medicare Order and
  Referring](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/order-and-referring)

- [CMS: Ordering &
  Certifying](https://www.cms.gov/medicare/enrollment-renewal/providers-suppliers/chain-ownership-system-pecos/ordering-certifying)

## Examples

``` r
transparency(count = TRUE)
#> ✔ `transparency()` returned 10,726 results.
transparency(state = "GA", city = "Valdosta")
#> ✔ `transparency()` returned 1 result.
#> # A tibble: 1 × 7
#>   id    name             address             city     state action   action_date
#>   <chr> <chr>            <chr>               <chr>    <chr> <chr>    <chr>      
#> 1 6131  Greenleaf Center 2209 Pineview Drive Valdosta GA    Met Req… 2025-08-01 
```
