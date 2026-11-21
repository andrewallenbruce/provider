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
#> ◼ pending | 11,768 rows | 3 pages

pending(first = starts("V"))
#> ✔ pending returned 159 results
#> # A tibble: 159 × 4
#>    prov_type        npi first   last          
#>    <chr>          <int> <chr>   <chr>         
#>  1 Physician 1144512724 VADIN   LALL DASS     
#>  2 Physician 1316700214 VALERIA MIDGETTE      
#>  3 Physician 1649776824 VALERIE LUKS          
#>  4 Physician 1134880628 VALERIE MARQUEZ RIVERA
#>  5 Physician 1619545423 VALERIE REEVE         
#>  6 Physician 1043012446 VALERIE SHAY          
#>  7 Physician 1215825310 VALERIE SOTO          
#>  8 Physician 1174214688 VANESSA MAHROU        
#>  9 Physician 1700645272 VANESSA MILAN         
#> 10 Physician 1588552053 VANESSA PAQUETTE      
#> # ℹ 149 more rows
```
