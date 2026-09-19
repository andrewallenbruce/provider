# Pending Medicare Enrollments

Providers with pending Medicare enrollment applications.

The *Pending Initial Logging and Tracking (L & T)* dataset provides a
list of pending applications for both Physicians and Non-Physicians that
have not been processed by CMS contractors.

## Usage

``` r
pending(prov_type = NULL, npi = NULL, first = NULL, last = NULL, count = FALSE)
```

## Source

Medicare Pending Initial Logging and Tracking:

- [API:
  Physicians](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/pending-initial-logging-and-tracking-physicians)

- [API:
  Non-Physicians](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/pending-initial-logging-and-tracking-non-physicians)

## Arguments

- prov_type:

  `<chr>` `"Physician"` or `"Non-Physician"`

- npi:

  `<int>` National Provider Identifier

- first, last:

  `<chr>` Provider's name

- count:

  `<lgl>` Return the total row count

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
containing the search results.

## Examples

``` r
pending(count = TRUE)
#> ◼ pending | 12,555 rows | 4 pages

pending(first = starts("V"))
#> ✔ pending returned 184 results
#> # A tibble: 184 × 4
#>    prov_type        npi first     last        
#>    <chr>          <int> <chr>     <chr>       
#>  1 Physician 1144512724 VADIN     LALL DASS   
#>  2 Physician 1972125656 VALENCIA  GARCIA      
#>  3 Physician 1871429951 VALENTINA VARGAS MARIN
#>  4 Physician 1891445540 VALERIE   CHEN        
#>  5 Physician 1174183800 VALERIE   CRONEY      
#>  6 Physician 1790435469 VALERIE   MENDEZ      
#>  7 Physician 1619545423 VALERIE   REEVE       
#>  8 Physician 1326735036 VALESCHIA ALEXANDER   
#>  9 Physician 1467078212 VANDAN    SHAH        
#> 10 Physician 1912587676 VANDANA   DODA        
#> # ℹ 174 more rows
```
