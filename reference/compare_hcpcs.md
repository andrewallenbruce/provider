# Compare Provider Performance

`compare_hcpcs()` allows the user to compare a provider's yearly HCPCS
utilization data to state and national averages

## Usage

``` r
compare_hcpcs(df)
```

## Arguments

- df:

  \< *tbl_df* \> // **required**

  [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
  returned from `utilization(type = "Service")`

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)

## Examples

``` r
if (FALSE) { # interactive()
compare_hcpcs(utilization(year = 2018,
                          type = "Service",
                          npi = 1023076643))

map_dfr(util_years(), ~utilization(year = .x,
                                   npi = 1023076643,
                                   type = "Service")) |>
compare_hcpcs()
}
```
