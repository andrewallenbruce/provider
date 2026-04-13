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
  count = FALSE,
  set = FALSE
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
#> ℹ order_refer has 2,004,978 rows.
order_refer(npi = 1003026055)
#> ✔ order_refer returned 1 result.
#> # A data frame: 1 × 8
#>   first   last   npi        part_b dme   hha   pmd   hospice
#> * <chr>   <chr>  <chr>      <chr>  <chr> <chr> <chr> <chr>  
#> 1 RADHIKA PHADKE 1003026055 Y      Y     Y     Y     Y      
order_refer(first = "Jennifer", last = "Smith")
#> ✔ order_refer returned 135 results.
#> # A data frame: 135 × 8
#>    first    last  npi        part_b dme   hha   pmd   hospice
#>  * <chr>    <chr> <chr>      <chr>  <chr> <chr> <chr> <chr>  
#>  1 JENNIFER SMITH 1255983557 Y      Y     Y     N     Y      
#>  2 JENNIFER SMITH 1063260172 Y      Y     Y     Y     N      
#>  3 JENNIFER SMITH 1972332542 Y      Y     Y     Y     N      
#>  4 JENNIFER SMITH 1588617773 Y      Y     Y     Y     N      
#>  5 JENNIFER SMITH 1023408291 Y      Y     Y     Y     N      
#>  6 JENNIFER SMITH 1336652726 Y      Y     Y     Y     N      
#>  7 JENNIFER SMITH 1528351160 Y      Y     Y     Y     Y      
#>  8 JENNIFER SMITH 1992396162 Y      Y     N     N     N      
#>  9 JENNIFER SMITH 1942592324 Y      Y     Y     Y     N      
#> 10 JENNIFER SMITH 1134237498 Y      Y     Y     Y     Y      
#> # ℹ 125 more rows
order_refer(
  part_b = TRUE,
  dme = TRUE,
  hha = FALSE,
  pmd = TRUE,
  hospice = FALSE)
#> ✔ order_refer returned 51 results.
#> # A data frame: 51 × 8
#>    first    last        npi        part_b dme   hha   pmd   hospice
#>  * <chr>    <chr>       <chr>      <chr>  <chr> <chr> <chr> <chr>  
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
#> # ℹ 41 more rows
```
