# Order and Refer Eligibility

Eligibility to order and refer within Medicare

## Usage

``` r
order_refer(
  npi = NULL,
  first = NULL,
  last = NULL,
  part_b = NULL,
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

- part_b, dme, hha, pmd, hospice:

  `<lgl>` Eligibility for:

  - `part_b`: Medicare Part B

  - `dme`: Durable Medical Equipment

  - `hha`: Home Health Agency

  - `pmd`: Power Mobility Devices

  - `hospice`: Hospice

- count:

  `<lgl>` Return the dataset's total row count

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
#> ✔ `order_refer` returned 1,998,262 results.
order_refer(npi = 1003026055)
#> ✔ `order_refer` returned 1 result.
#> # A tibble: 1 × 8
#>   first   last   npi        part_b dme   hha   pmd   hospice
#>   <chr>   <chr>  <chr>      <chr>  <chr> <chr> <chr> <chr>  
#> 1 RADHIKA PHADKE 1003026055 Y      Y     Y     Y     Y      
order_refer(first = "Jennifer", last = "Smith")
#> ✔ `order_refer` returned 135 results.
#> # A tibble: 135 × 8
#>    first    last  npi        part_b dme   hha   pmd   hospice
#>    <chr>    <chr> <chr>      <chr>  <chr> <chr> <chr> <chr>  
#>  1 JENNIFER SMITH 1588849350 Y      Y     Y     Y     N      
#>  2 JENNIFER SMITH 1952073652 Y      Y     Y     Y     N      
#>  3 JENNIFER SMITH 1265005615 Y      Y     Y     Y     N      
#>  4 JENNIFER SMITH 1790243723 Y      Y     Y     Y     N      
#>  5 JENNIFER SMITH 1881004869 Y      Y     Y     Y     Y      
#>  6 JENNIFER SMITH 1255333522 Y      Y     Y     Y     Y      
#>  7 JENNIFER SMITH 1700323680 Y      Y     Y     Y     N      
#>  8 JENNIFER SMITH 1265417687 N      Y     N     Y     N      
#>  9 JENNIFER SMITH 1063436590 Y      Y     Y     Y     Y      
#> 10 JENNIFER SMITH 1609018068 Y      Y     Y     Y     N      
#> # ℹ 125 more rows
order_refer(
  part_b = TRUE,
  dme = TRUE,
  hha = FALSE,
  pmd = TRUE,
  hospice = FALSE)
#> ✔ `order_refer` returned 49 results.
#> # A tibble: 49 × 8
#>    first    last        npi        part_b dme   hha   pmd   hospice
#>    <chr>    <chr>       <chr>      <chr>  <chr> <chr> <chr> <chr>  
#>  1 ROBYN    AYER        1659094290 Y      Y     N     Y     N      
#>  2 MEGAN    BAUMGARDNER 1023796711 Y      Y     N     Y     N      
#>  3 KRISTINA BERRY       1295461192 Y      Y     N     Y     N      
#>  4 BONNIE   BETTS       1306821129 Y      Y     N     Y     N      
#>  5 LAURA    BOBROWSKI   1013297019 Y      Y     N     Y     N      
#>  6 LISA     CHRISTIAN   1235636697 Y      Y     N     Y     N      
#>  7 TRAVIS   DANIEL      1134813934 Y      Y     N     Y     N      
#>  8 LYNELL   DAWSON      1962852533 Y      Y     N     Y     N      
#>  9 BETH     DETRICH     1124364203 Y      Y     N     Y     N      
#> 10 BRIDGET  DIETZ       1720522592 Y      Y     N     Y     N      
#> # ℹ 39 more rows
```
