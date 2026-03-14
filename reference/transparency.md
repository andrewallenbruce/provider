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

  `<chr>` Action taken by CMS following a Hospital Price Transparency
  Compliance Review

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
if (FALSE) {
transparency(count = TRUE)
transparency(state = "GA")
}
```
