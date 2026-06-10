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
  count = FALSE,
  set = FALSE
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

- set:

  `<lgl>` Return the entire dataset

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
#> order_refer summary
#> ◉ Rows  : 2,005,842
#> ◉ Pages : 402      

order_refer(first = "Jennifer", last = "Smith")
#> ✔ order_refer returned 135 results.
#> # A tibble: 135 × 8
#>    first    last         npi ptb_ind dme_ind hha_ind pmd_ind hsp_ind
#>    <chr>    <chr>      <int>   <int>   <int>   <int>   <int>   <int>
#>  1 JENNIFER SMITH 1073921029       1       1       1       1       0
#>  2 JENNIFER SMITH 1427292986       1       1       1       1       1
#>  3 JENNIFER SMITH 1366601932       1       1       1       1       1
#>  4 JENNIFER SMITH 1780354217       1       1       1       1       0
#>  5 JENNIFER SMITH 1750729497       1       1       1       1       0
#>  6 JENNIFER SMITH 1760504674       1       1       1       0       1
#>  7 JENNIFER SMITH 1417514035       1       1       1       1       0
#>  8 JENNIFER SMITH 1972574770       1       1       1       1       1
#>  9 JENNIFER SMITH 1659822211       1       1       1       1       0
#> 10 JENNIFER SMITH 1316939655       1       1       1       1       0
#> # ℹ 125 more rows
```
