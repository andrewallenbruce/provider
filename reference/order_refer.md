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
#> ✔ Query returned 1,996,162 results.

order_refer(npi = 1003026055)
#> ✔ Query returned 1 result.
#> # A tibble: 1 × 8
#>   npi        first   last   part_b dme   hha   pmd   hospice
#>   <chr>      <chr>   <chr>  <chr>  <chr> <chr> <chr> <chr>  
#> 1 1003026055 RADHIKA PHADKE Y      Y     Y     Y     Y      

order_refer(first = "Jennifer", last = "Smith")
#> ✔ Query returned 134 results.
#> # A tibble: 134 × 8
#>    npi        first    last  part_b dme   hha   pmd   hospice
#>    <chr>      <chr>    <chr> <chr>  <chr> <chr> <chr> <chr>  
#>  1 1134237498 JENNIFER SMITH Y      Y     Y     Y     Y      
#>  2 1336652726 JENNIFER SMITH Y      Y     Y     Y     N      
#>  3 1811518566 JENNIFER SMITH Y      Y     N     N     N      
#>  4 1992162556 JENNIFER SMITH Y      Y     N     N     N      
#>  5 1396151817 JENNIFER SMITH Y      Y     Y     N     Y      
#>  6 1427168814 JENNIFER SMITH Y      Y     Y     Y     N      
#>  7 1588291215 JENNIFER SMITH Y      Y     Y     Y     Y      
#>  8 1841730512 JENNIFER SMITH Y      Y     Y     Y     N      
#>  9 1053842450 JENNIFER SMITH Y      Y     Y     Y     Y      
#> 10 1063080125 JENNIFER SMITH Y      Y     Y     Y     N      
#> # ℹ 124 more rows

order_refer(
  part_b = TRUE,
  dme = TRUE,
  hha = FALSE,
  pmd = TRUE,
  hospice = FALSE)
#> ✔ Query returned 50 results.
#> # A tibble: 50 × 8
#>    npi        first    last        part_b dme   hha   pmd   hospice
#>    <chr>      <chr>    <chr>       <chr>  <chr> <chr> <chr> <chr>  
#>  1 1659094290 ROBYN    AYER        Y      Y     N     Y     N      
#>  2 1023796711 MEGAN    BAUMGARDNER Y      Y     N     Y     N      
#>  3 1295461192 KRISTINA BERRY       Y      Y     N     Y     N      
#>  4 1306821129 BONNIE   BETTS       Y      Y     N     Y     N      
#>  5 1073322277 ALYSSA   BLEDSOE     Y      Y     N     Y     N      
#>  6 1013297019 LAURA    BOBROWSKI   Y      Y     N     Y     N      
#>  7 1235636697 LISA     CHRISTIAN   Y      Y     N     Y     N      
#>  8 1134813934 TRAVIS   DANIEL      Y      Y     N     Y     N      
#>  9 1962852533 LYNELL   DAWSON      Y      Y     N     Y     N      
#> 10 1124364203 BETH     DETRICH     Y      Y     N     Y     N      
#> # ℹ 40 more rows
```
