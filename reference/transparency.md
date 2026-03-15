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
transparency(count = TRUE)
#> ✔ `transparency()` returned 10,726 results.
transparency(state = "GA")
#> ✔ `transparency()` returned 259 results.
#> # A tibble: 259 × 7
#>    id    name                             address city  state action action_date
#>    <chr> <chr>                            <chr>   <chr> <chr> <chr>  <chr>      
#>  1 42    Northside Hospital Atlanta       1000 J… Atla… GA    Warni… 2021-04-19 
#>  2 68    Wellstar Kennestone Regional Me… 677 Ch… Mari… GA    Warni… 2021-04-19 
#>  3 75    Northeast Georgia Medical Cente… 743 Sp… Gain… GA    Warni… 2021-04-19 
#>  4 99    Northside Hospital - Cherokee    450 No… Cant… GA    Warni… 2021-05-18 
#>  5 116   Wellstar Atlanta Medical Center  303 Pa… Atla… GA    Warni… 2021-04-19 
#>  6 117   Tift Regional Medical Center     901 Ea… Tift… GA    Warni… 2023-03-01 
#>  7 136   Piedmont Columbus Regional Midt… 710 Ce… Colu… GA    Warni… 2021-04-19 
#>  8 163   Emory Johns Creek Hospital       6325 H… John… GA    Warni… 2021-06-23 
#>  9 248   Ridgeview Institute Smyrna       3995 S… Smyr… GA    Warni… 2024-02-02 
#> 10 265   Archbold Memorial                915 Go… Thom… GA    Warni… 2022-12-22 
#> # ℹ 249 more rows
```
