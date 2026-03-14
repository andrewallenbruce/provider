# Pending Medicare Enrollments

Providers with pending Medicare enrollment applications.

## Usage

``` r
pending(npi = NULL, first = NULL, last = NULL, count = FALSE)
```

## Arguments

- npi:

  `<int>` National Provider Identifier

- first, last:

  `<chr>` Provider's name

- count:

  `<lgl>` Return the dataset's total row count

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)

## References

- [Medicare Pending Initial Logging and Tracking Physicians
  API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/pending-initial-logging-and-tracking-physicians)

- [Medicare Pending Initial Logging and Tracking Non-Physicians
  API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/pending-initial-logging-and-tracking-non-physicians)

## Examples

``` r
pending(count = TRUE)
#> ✔ `pending()` returned 9,899 results.
pending(first = "John")
#> ✔ `pending()` returned 66 results.
#> # A tibble: 66 × 4
#>    prov_type first last    npi       
#>    <fct>     <chr> <chr>   <chr>     
#>  1 Physician JOHN  ADAMS   1881791739
#>  2 Physician JOHN  BAUMANN 1255696514
#>  3 Physician JOHN  BIGBEE  1841280963
#>  4 Physician JOHN  BODDEN  1619996378
#>  5 Physician JOHN  BRET    1902873300
#>  6 Physician JOHN  BRUNO   1588744569
#>  7 Physician JOHN  BURKE   1861142556
#>  8 Physician JOHN  COMBS   1306817531
#>  9 Physician JOHN  FLYNN   1376571554
#> 10 Physician JOHN  FREEMAN 1689774804
#> # ℹ 56 more rows
pending(first = starts_with("J"))
#> ✔ `pending()` returned 1,052 results.
#> # A tibble: 1,052 × 4
#>    prov_type first     last     npi       
#>    <fct>     <chr>     <chr>    <chr>     
#>  1 Physician J. ROBERT MILES    1619975190
#>  2 Physician JABEEN    KHAN     1679770663
#>  3 Physician JACE      FOSS     1306268586
#>  4 Physician JACINTA   MOORE    1922894955
#>  5 Physician JACK      GREIDER  1316038615
#>  6 Physician JACK      SHUMATE  1558366955
#>  7 Physician JACKIE    KOTECKI  1851128441
#>  8 Physician JACKIE    MULLINS  1972535805
#>  9 Physician JACKLEEN  GLODENER 1780266270
#> 10 Physician JACOB     ARNAUD   1952824120
#> # ℹ 1,042 more rows
```
