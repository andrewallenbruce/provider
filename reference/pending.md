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
#> ◼ pending | 14,171 rows | 4 pages

pending(first = starts("V"))
#> ✔ pending returned 191 results
#> # A tibble: 191 × 4
#>    prov_type        npi first     last     
#>    <chr>          <int> <chr>     <chr>    
#>  1 Physician 1932839230 VA        SI       
#>  2 Physician 1740082726 VAANI     SHAH     
#>  3 Physician 1144512724 VADIN     LALL DASS
#>  4 Physician 1194614206 VAHID     HARBI    
#>  5 Physician 1104512912 VAISHNAVI PARCHURI 
#>  6 Physician 1205765161 VALANDRA  SIERRA   
#>  7 Physician 1770420010 VALBERTO  SANHA    
#>  8 Physician 1245899301 VALEDA    YONG     
#>  9 Physician 1154292712 VALERIA   SILVA    
#> 10 Physician 1629728308 VALERIE   HARDOON  
#> # ℹ 181 more rows
```
