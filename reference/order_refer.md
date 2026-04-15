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
#> ℹ order_refer has 2,005,720 rows.

order_refer(npi = 1003026055)
#> ✔ order_refer returned 1 result.
#> # A tibble: 1 × 8
#>   first   last          npi part_b   dme   hha   pmd hospice
#> * <chr>   <chr>       <int>  <int> <int> <int> <int>   <int>
#> 1 RADHIKA PHADKE 1003026055      1     1     1     1       1

order_refer(first = "Jennifer", last = "Smith")
#> ✔ order_refer returned 135 results.
#> # A tibble: 135 × 8
#>    first    last         npi part_b   dme   hha   pmd hospice
#>  * <chr>    <chr>      <int>  <int> <int> <int> <int>   <int>
#>  1 JENNIFER SMITH 1386871028      1     1     1     1       1
#>  2 JENNIFER SMITH 1922290519      1     1     1     1       1
#>  3 JENNIFER SMITH 1881115061      1     1     0     0       0
#>  4 JENNIFER SMITH 1700809498      1     1     1     1       0
#>  5 JENNIFER SMITH 1215919170      1     1     1     1       1
#>  6 JENNIFER SMITH 1275917817      1     1     1     1       0
#>  7 JENNIFER SMITH 1588849350      1     1     1     1       0
#>  8 JENNIFER SMITH 1497270268      1     1     1     1       0
#>  9 JENNIFER SMITH 1497230395      1     1     1     1       0
#> 10 JENNIFER SMITH 1033486725      1     1     1     1       0
#> # ℹ 125 more rows

order_refer(ptb = TRUE, dme = TRUE, hha = FALSE, pmd = TRUE, hospice = FALSE)
#> ✔ order_refer returned 51 results.
#> # A tibble: 51 × 8
#>    first    last               npi part_b   dme   hha   pmd hospice
#>  * <chr>    <chr>            <int>  <int> <int> <int> <int>   <int>
#>  1 ROBYN    AYER        1659094290      1     1     0     1       0
#>  2 MEGAN    BAUMGARDNER 1023796711      1     1     0     1       0
#>  3 KRISTINA BERRY       1295461192      1     1     0     1       0
#>  4 BONNIE   BETTS       1306821129      1     1     0     1       0
#>  5 LAURA    BOBROWSKI   1013297019      1     1     0     1       0
#>  6 LISA     CHRISTIAN   1235636697      1     1     0     1       0
#>  7 TRAVIS   DANIEL      1134813934      1     1     0     1       0
#>  8 LYNELL   DAWSON      1962852533      1     1     0     1       0
#>  9 BETH     DETRICH     1124364203      1     1     0     1       0
#> 10 BRIDGET  DIETZ       1720522592      1     1     0     1       0
#> # ℹ 41 more rows
```
