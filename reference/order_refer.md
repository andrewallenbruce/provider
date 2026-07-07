# Order and Refer Eligibility

Eligibility to order and refer within Medicare

## Usage

``` r
order_refer(
  npi = NULL,
  first = NULL,
  last = NULL,
  ptb = NULL,
  dme = NULL,
  hha = NULL,
  pmd = NULL,
  hospice = NULL,
  count = FALSE
)
```

## Arguments

- npi:

  `<int>` National Provider Identifier

- first, last:

  `<chr>` Individual provider's first/last name

- ptb, dme, hha, pmd, hospice:

  `<lgl>` Eligibility for:

  - `ptb`: Medicare Part B

  - `dme`: Durable Medical Equipment

  - `hha`: Home Health Agency

  - `pmd`: Power Mobility Devices

  - `hospice`: Hospice

- count:

  `<lgl>` Return the total row count

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
containing the search results.

## Criteria

- *Individual* NPI

- Medicare enrollment with *Approved* or *Opt-Out* status

- Eligible *specialty* type

## Types

- *Ordering*: can order non-physician services for patients.

- *Referring/Certifying*: can request items/services Medicare may
  reimburse.

- *Opt-Out*: can enroll solely to order and refer.

## Services

- *Medicare Part B*: Clinical Labs, Imaging

- *Medicare Part A*: Home Health

- *DMEPOS*: Durable medical equipment, prosthetics, orthotics, &
  supplies

## References

- [API: Medicare Order and
  Referring](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/order-and-referring)

- [CMS: Ordering &
  Certifying](https://www.cms.gov/medicare/enrollment-renewal/providers-suppliers/chain-ownership-system-pecos/ordering-certifying)

## Examples

``` r
order_refer(count = TRUE)
#> ◼ order_refer | 2,014,707 rows | 403 pages

order_refer(first = "Jennifer", last = "Smith")
#> ✔ order_refer returned 135 results
#> ✔ Retrieving 1 page
#> # A tibble: 135 × 8
#>           npi first    last  ptb_ind dme_ind hha_ind pmd_ind hsp_ind
#>         <int> <chr>    <chr>   <int>   <int>   <int>   <int>   <int>
#>  1 1083750079 JENNIFER SMITH       1       1       0       0       0
#>  2 1013239268 JENNIFER SMITH       1       1       0       0       0
#>  3 1457578197 JENNIFER SMITH       1       1       0       0       0
#>  4 1861169211 JENNIFER SMITH       1       1       1       1       0
#>  5 1225032758 JENNIFER SMITH       1       1       1       1       1
#>  6 1134468614 JENNIFER SMITH       1       1       1       1       0
#>  7 1992396162 JENNIFER SMITH       1       1       0       0       0
#>  8 1013227818 JENNIFER SMITH       1       1       0       0       0
#>  9 1982656898 JENNIFER SMITH       1       1       1       1       1
#> 10 1811620370 JENNIFER SMITH       1       1       1       1       0
#> # ℹ 125 more rows
```
