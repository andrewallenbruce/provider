# Order and Referral Eligibility

`order_refer()` returns a provider's eligibility to order and refer
within Medicare to:

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
  hospice = NULL
)
```

## Arguments

- npi:

  `<int>` 10-digit Individual National Provider Identifier

- first, last:

  `<chr>` Individual provider's first/last name

- part_b, dme, hha, pmd, hospice:

  `<lgl>` Whether a provider is eligible to order and refer to:

  - `partb`: Medicare Part B

  - `dme`: Durable Medical Equipment

  - `hha`: Home Health Agency

  - `pmd`: Power Mobility Devices

  - `hospice`: Hospice

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
with the columns:

|            |                                                  |
|------------|--------------------------------------------------|
| **Field**  | **Description**                                  |
| `npi`      | National Provider Identifier                     |
| `first`    | Order and Referring Provider's First Name        |
| `last`     | Order and Referring Provider's Last Name         |
| `eligible` | Services An Eligible Provider Can Order/Refer To |

## Details

- **Part B**: Clinical Laboratory Services, Imaging Services

- **DME**: Durable Medical Equipment, Prosthetics, Orthotics, & Supplies
  (DMEPOS)

- **Part A**: Home Health Services

To be eligible, a provider must:

- have an *Individual* NPI

- be enrolled in Medicare in either an *Approved* or *Opt-Out* status

- be of an *Eligible Specialty* type

**Ordering Providers** can order non-physician services for patients.

**Referring (or Certifying) Providers** can request items or services
that Medicare may reimburse on behalf of its beneficiaries.

**Opt-Out Providers**: Providers who have opted out of Medicare may
still order and refer. They can also enroll solely to order and refer.

## References

links:

- [Medicare Order and Referring
  API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/order-and-referring)

- [CMS.gov: Ordering &
  Certifying](https://www.cms.gov/medicare/enrollment-renewal/providers-suppliers/chain-ownership-system-pecos/ordering-certifying)

## Examples

``` r
order_refer()
#> ! No Query → Returning first 10 rows.
#> # A tibble: 10 × 8
#>    npi        first     last          part_b dme   hha   pmd   hospice
#>    <chr>      <chr>     <chr>         <chr>  <chr> <chr> <chr> <chr>  
#>  1 1417051921 N         A BELLE       Y      Y     Y     Y     N      
#>  2 1972040137 ELIZABETH A NOVOTNY     Y      Y     Y     Y     N      
#>  3 1760465553 MUHAMMAD  A SATTAR      Y      Y     Y     Y     Y      
#>  4 1295400745 BROGAN    A'NEAL        Y      Y     N     N     N      
#>  5 1265446264 CATHERINE A'VANT FOWLER Y      Y     N     N     N      
#>  6 1700562584 BAILEY    AAB           Y      Y     Y     N     Y      
#>  7 1205257284 KATIE     AAB           Y      Y     N     N     N      
#>  8 1245971480 ALEXANDER AABEDI        Y      Y     Y     Y     Y      
#>  9 1164905659 SAMANTHA  AABEL         Y      Y     N     N     N      
#> 10 1881384394 CAROLINE  AABERG        Y      Y     Y     Y     N      

order_refer(npi = 100)
#> ✖ Query returned 0 results.

order_refer(npi = 1003026055)
#> ✔ Query returned 1  result.
#> # A tibble: 1 × 8
#>   npi        first   last   part_b dme   hha   pmd   hospice
#>   <chr>      <chr>   <chr>  <chr>  <chr> <chr> <chr> <chr>  
#> 1 1003026055 RADHIKA PHADKE Y      Y     Y     Y     Y      

order_refer(first = "Jennifer", last = "Smith")
#> ✔ Query returned 133  results.
#> # A tibble: 133 × 8
#>    npi        first    last  part_b dme   hha   pmd   hospice
#>    <chr>      <chr>    <chr> <chr>  <chr> <chr> <chr> <chr>  
#>  1 1982026100 JENNIFER SMITH Y      Y     N     N     N      
#>  2 1861777609 JENNIFER SMITH Y      Y     N     N     N      
#>  3 1295381994 JENNIFER SMITH N      Y     N     N     N      
#>  4 1184142903 JENNIFER SMITH Y      Y     Y     Y     N      
#>  5 1598994923 JENNIFER SMITH Y      Y     Y     Y     N      
#>  6 1811218712 JENNIFER SMITH Y      Y     Y     Y     Y      
#>  7 1750494886 JENNIFER SMITH Y      Y     Y     N     Y      
#>  8 1497230395 JENNIFER SMITH Y      Y     Y     Y     N      
#>  9 1033486725 JENNIFER SMITH Y      Y     Y     Y     N      
#> 10 1952073652 JENNIFER SMITH Y      Y     Y     Y     N      
#> # ℹ 123 more rows

order_refer(
  part_b = TRUE,
  dme = TRUE,
  hha = FALSE,
  pmd = TRUE,
  hospice = FALSE
 )
#> ✔ Query returned 50  results.
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
