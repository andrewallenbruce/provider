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
#> order_refer Totals
#> • Rows  : 1,998,241
#> • Pages : 400      
#> 

order_refer(npi = 1003026055)
#> ✔ order_refer returned 1 result.
#> # A tibble: 1 × 8
#>          npi last   first     ptb   dme   hha   pmd hospice
#> *      <int> <chr>  <chr>   <int> <int> <int> <int>   <int>
#> 1 1003026055 PHADKE RADHIKA     0     1     0     1       0

order_refer(first = "Jennifer", last = "Smith")
#> ✔ order_refer returned 136 results.
#> # A tibble: 136 × 8
#>           npi last  first      ptb   dme   hha   pmd hospice
#>  *      <int> <chr> <chr>    <int> <int> <int> <int>   <int>
#>  1 1699184895 SMITH JENNIFER     1     1     1     1       0
#>  2 1215919170 SMITH JENNIFER     1     1     1     1       1
#>  3 1053842450 SMITH JENNIFER     1     1     1     1       1
#>  4 1063180420 SMITH JENNIFER     1     1     1     1       0
#>  5 1952073652 SMITH JENNIFER     1     1     1     1       0
#>  6 1285898619 SMITH JENNIFER     1     1     1     0       1
#>  7 1861988990 SMITH JENNIFER     1     1     1     0       1
#>  8 1821069931 SMITH JENNIFER     1     1     1     1       0
#>  9 1790063832 SMITH JENNIFER     1     1     1     1       1
#> 10 1184142903 SMITH JENNIFER     1     1     1     1       0
#> # ℹ 126 more rows

order_refer(ptb = TRUE, dme = TRUE, hha = FALSE, pmd = TRUE, hospice = FALSE)
#> ✔ order_refer returned 47 results.
#> # A tibble: 47 × 8
#>           npi last        first       ptb   dme   hha   pmd hospice
#>  *      <int> <chr>       <chr>     <int> <int> <int> <int>   <int>
#>  1 1659094290 AYER        ROBYN         1     1     0     1       0
#>  2 1023796711 BAUMGARDNER MEGAN         1     1     0     1       0
#>  3 1295461192 BERRY       KRISTINA      1     1     0     1       0
#>  4 1306821129 BETTS       BONNIE        1     1     0     1       0
#>  5 1013297019 BOBROWSKI   LAURA         1     1     0     1       0
#>  6 1508691460 BRAGGS      PRINCESS      1     1     0     1       0
#>  7 1649046129 BROWN       ALEXANDRA     1     1     0     1       0
#>  8 1003706912 CARROLL     KAELYN        1     1     0     1       0
#>  9 1720522592 DIETZ       BRIDGET       1     1     0     1       0
#> 10 1720506520 DUBOSE      JAMIE         1     1     0     1       0
#> # ℹ 37 more rows
```
