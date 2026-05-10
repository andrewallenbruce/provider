# Pending Medicare Enrollments

Providers with pending Medicare enrollment applications.

The *Pending Initial Logging and Tracking (L & T)* dataset provides a
list of pending applications for both Physicians and Non-Physicians that
have not been processed by CMS contractors.

## Usage

``` r
pending(npi = NULL, first = NULL, last = NULL, count = FALSE, set = FALSE)
```

## Source

Medicare Pending Initial Logging and Tracking:

- [API:
  Physicians](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/pending-initial-logging-and-tracking-physicians)

- [API:
  Non-Physicians](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/pending-initial-logging-and-tracking-non-physicians)

## Arguments

- npi:

  `<int>` National Provider Identifier

- first, last:

  `<chr>` Provider's name

- count:

  `<lgl>` Return the total row count

- set:

  `<lgl>` Return the entire dataset

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)

## Examples

``` r
pending(count = TRUE)
#> pending Totals
#> • Rows  : 10,579
#> • Pages : 3     
#> 

pending(first = "Victor", count = TRUE)
#> ✔ pending returned 7 results.
#> • Physician     : 6
#> • Non-Physician : 1

pending(first = starts("V"))
#> ✔ pending returned 141 results.
#> • Physician     : 61
#> • Non-Physician : 80
#> # A tibble: 141 × 4
#>    prov_type        npi last             first        
#>  * <chr>          <int> <chr>            <chr>        
#>  1 Physician 1144512724 LALL DASS        VADIN        
#>  2 Physician 1689304545 TURBAY CABALLERO VALENTINA    
#>  3 Physician 1265373518 GRAVES           VALERIE      
#>  4 Physician 1215825310 SOTO             VALERIE      
#>  5 Physician 1407597651 BACOT-DAVIS      VALJEAN      
#>  6 Physician 1407534472 LAVU             VAMSI KRISHNA
#>  7 Physician 1437094257 CARRENO          VANESA       
#>  8 Physician 1861237943 DONALDSON        VANESSA      
#>  9 Physician 1518545672 PAHALYANTS       VARTAN       
#> 10 Physician 1972442267 SHAH             VARUNIL      
#> # ℹ 131 more rows
```
