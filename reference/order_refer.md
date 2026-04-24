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

  `<lgl>` Return the dataset's total row count

- set:

  `<lgl>` Return the entire dataset

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)

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
#> ℹ order_refer has 1,994,820 rows.

order_refer(npi = 1003026055)
#> ✔ order_refer returned 1 result.
#> # A tibble: 1 × 8
#>   first   last          npi   ptb   dme   hha   pmd hospice
#> * <chr>   <chr>       <int> <int> <int> <int> <int>   <int>
#> 1 RADHIKA PHADKE 1003026055     0     1     0     1       0

order_refer(first = "Jennifer", last = "Smith")
#> ✔ order_refer returned 135 results.
#> # A tibble: 135 × 8
#>    first    last         npi   ptb   dme   hha   pmd hospice
#>  * <chr>    <chr>      <int> <int> <int> <int> <int>   <int>
#>  1 JENNIFER SMITH 1881004869     1     1     1     1       1
#>  2 JENNIFER SMITH 1265005615     1     1     1     1       0
#>  3 JENNIFER SMITH 1790243723     1     1     1     1       0
#>  4 JENNIFER SMITH 1255333522     1     1     1     1       1
#>  5 JENNIFER SMITH 1700323680     1     1     1     1       0
#>  6 JENNIFER SMITH 1265417687     0     1     0     1       0
#>  7 JENNIFER SMITH 1063436590     1     1     1     1       1
#>  8 JENNIFER SMITH 1861169211     1     1     1     1       0
#>  9 JENNIFER SMITH 1588849350     1     1     1     1       0
#> 10 JENNIFER SMITH 1922290519     1     1     1     1       1
#> # ℹ 125 more rows

order_refer(ptb = TRUE, dme = TRUE, hha = FALSE, pmd = TRUE, hospice = FALSE)
#> ✔ order_refer returned 45 results.
#> # A tibble: 45 × 8
#>    first    last               npi   ptb   dme   hha   pmd hospice
#>  * <chr>    <chr>            <int> <int> <int> <int> <int>   <int>
#>  1 ROBYN    AYER        1659094290     1     1     0     1       0
#>  2 MEGAN    BAUMGARDNER 1023796711     1     1     0     1       0
#>  3 KRISTINA BERRY       1295461192     1     1     0     1       0
#>  4 BONNIE   BETTS       1306821129     1     1     0     1       0
#>  5 LAURA    BOBROWSKI   1013297019     1     1     0     1       0
#>  6 BRIDGET  DIETZ       1720522592     1     1     0     1       0
#>  7 JAMIE    DUBOSE      1720506520     1     1     0     1       0
#>  8 ANNA     DYKSTRA     1174278626     1     1     0     1       0
#>  9 SUSAN    ENGLEBERT   1487145967     1     1     0     1       0
#> 10 RONALD   FANCHER     1598744989     1     1     0     1       0
#> # ℹ 35 more rows
```
