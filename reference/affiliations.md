# Provider-Facility Affiliations

Access information concerning individual providers' affiliations with
organizations/facilities.

## Usage

``` r
affiliations(
  npi = NULL,
  pac = NULL,
  first = NULL,
  last = NULL,
  fac_type = NULL,
  ccn = NULL,
  parent_ccn = NULL,
  count = FALSE
)
```

## Source

- [API: Physician Facility
  Affiliations](https://data.cms.gov/provider-data/dataset/27ea-46a8)

## Arguments

- npi:

  `<int>` Individual National Provider Identifier

- pac:

  `<chr>` Individual PECOS Associate Control ID

- first, last:

  `<chr>` Individual provider's name

- fac_type:

  `<enum>` facility type:

  - `esrd` = Dialysis facility

  - `hha` = Home health agency

  - `hospice` = Hospice

  - `hospital` = Hospital

  - `irf` = Inpatient rehabilitation facility

  - `ltch` = Long-term care hospital

  - `nurse` = Nursing home

  - `snf` = Skilled nursing facility

- ccn:

  `<chr>` CCN of `fac_type` column's facility **or** of a **unit**
  within the hospital where the individual provider provides services.

- parent_ccn:

  `<int>` CCN of the **primary** hospital containing the unit where the
  individual provider provides services.

- count:

  `<lgl>` Return the total row count

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
containing the search results.

## Examples

``` r
affiliations(count = TRUE)
#> ◼ affiliations | 2,260,193 rows | 1,507 pages
affiliations(ccn = 331302)
#> ✔ affiliations returned 340 results
#> # A tibble: 340 × 7
#>    first   last                  npi pac        fac_type ccn    parent_ccn
#>    <chr>   <chr>               <int> <chr>      <chr>    <chr>  <chr>     
#>  1 STACI   CARTER-KELLY   1003029125 6204824378 Hospital 331302 NA        
#>  2 DYLAN   ESTES          1003278144 6608167523 Hospital 331302 NA        
#>  3 ARMIN   AFSAR KESHMIRI 1003815184 4082693676 Hospital 331302 NA        
#>  4 LAURA   GREENE         1003845272 1759384035 Hospital 331302 NA        
#>  5 DEBORAH KAMPSCHROR     1013141860 8022069558 Hospital 331302 NA        
#>  6 NAROD   VASSILIAN      1013539584 9133544109 Hospital 331302 NA        
#>  7 EMILY   TRIPLETT       1013595560 3375947401 Hospital 331302 NA        
#>  8 BARDIA  BARIMANI       1013793736 9436503646 Hospital 331302 NA        
#>  9 JOSE    ACOSTAMADIEDO  1013910256 5890719371 Hospital 331302 NA        
#> 10 LINDSEY WILHELM        1023377843 6901115278 Hospital 331302 NA        
#> # ℹ 330 more rows
affiliations(parent_ccn = 331302)
#> ✔ affiliations returned 7 results
#> # A tibble: 7 × 7
#>   first   last                 npi pac        fac_type     ccn    parent_ccn
#>   <chr>   <chr>              <int> <chr>      <chr>        <chr>  <chr>     
#> 1 JEFFREY KLOTZ         1073258398 3870095805 Nursing Home 33Z302 331302    
#> 2 CARLOS  MARTINEZ      1154332062 5890739734 Nursing Home 33Z302 331302    
#> 3 GABRIEL CREVIER-SORBO 1154946978 2264892017 Nursing Home 33Z302 331302    
#> 4 MARY    HALLORAN      1396989059 8921259557 Nursing Home 33Z302 331302    
#> 5 IL      CHON          1538173869 0547299091 Nursing Home 33Z302 331302    
#> 6 DRAGOS  BANU          1558659367 6709004682 Nursing Home 33Z302 331302    
#> 7 JOSHUA  WARNER        1760167712 8123473469 Nursing Home 33Z302 331302    
```
