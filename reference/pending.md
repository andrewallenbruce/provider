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
#> ◼ pending | 14,519 rows | 4 pages

pending(first = starts("V"))
#> ✔ pending returned 208 results
#> ✔ Retrieving 2 pages
#> # A tibble: 208 × 4
#>    prov_type        npi first    last       
#>    <chr>          <int> <chr>    <chr>      
#>  1 Physician 1932839230 VA       SI         
#>  2 Physician 1093652463 VADIM    DOLGOV     
#>  3 Physician 1144512724 VADIN    LALL DASS  
#>  4 Physician 1700451846 VAGHARSH ANTANESIAN 
#>  5 Physician 1073202859 VAHE     KHACHATRYAN
#>  6 Physician 1932895539 VAHE     MARTIKIAN  
#>  7 Physician 1194614206 VAHID    HARBI      
#>  8 Physician 1447190517 VAIDEHI  KOTHARI    
#>  9 Physician 1871107623 VAIDEHI  SHAH       
#> 10 Physician 1770420010 VALBERTO SANHA      
#> # ℹ 198 more rows
```
