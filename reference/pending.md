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
#> ◼ pending | 12,214 rows | 3 pages

pending(first = starts("V"))
#> ✔ pending returned 169 results
#> # A tibble: 169 × 4
#>    prov_type        npi first     last          
#>    <chr>          <int> <chr>     <chr>         
#>  1 Physician 1164110664 VADIM     KASHTELYAN    
#>  2 Physician 1144512724 VADIN     LALL DASS     
#>  3 Physician 1104404466 VAISHNAVI ARYAPADI      
#>  4 Physician 1619545423 VALERIE   REEVE         
#>  5 Physician 1578982013 VALERIE   WEISS         
#>  6 Physician 1982509188 VALESHKA  AVILES CANTING
#>  7 Physician 1508396284 VAN       TRUONG        
#>  8 Physician 1912587676 VANDANA   DODA          
#>  9 Physician 1700645272 VANESSA   MILAN         
#> 10 Physician 1558244814 VANESSA   OCON          
#> # ℹ 159 more rows
```
