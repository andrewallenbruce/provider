# Provider-Facility Affiliations

Access information concerning individual providers' affiliations with
organizations/facilities.

## Usage

``` r
affiliations(
  npi = NULL,
  pac = NULL,
  first = NULL,
  middle = NULL,
  last = NULL,
  suffix = NULL,
  facility_type = NULL,
  facility_ccn = NULL,
  parent_ccn = NULL,
  count = FALSE,
  set = FALSE
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

- first, middle, last, suffix:

  `<chr>` Individual provider's name

- facility_type:

  `<enum>` facility type:

  - `esrd` = Dialysis facility

  - `hha` = Home health agency

  - `hospice` = Hospice

  - `hospital` = Hospital

  - `irf` = Inpatient rehabilitation facility

  - `ltch` = Long-term care hospital

  - `nurse` = Nursing home

  - `snf` = Skilled nursing facility

- facility_ccn:

  `<chr>` CCN of `facility_type` column's facility **or** of a **unit**
  within the hospital where the individual provider provides services.

- parent_ccn:

  `<int>` CCN of the **primary** hospital containing the unit where the
  individual provider provides services.

- count:

  `<lgl>` Return the total row count

- set:

  `<lgl>` Return the entire dataset

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)

## Examples

``` r
affiliations(count = TRUE)
#> ℹ affiliations has 1,638,995 rows.

affiliations(facility_ccn = "33Z302")
#> ✔ affiliations returned 4 results.
#> # A tibble: 4 × 9
#>   first   last  middle suffix    npi pac   facility_type facility_ccn parent_ccn
#> * <chr>   <chr> <chr>  <chr>   <int> <chr> <chr>         <chr>        <chr>     
#> 1 JEFFREY KLOTZ NA     NA     1.07e9 3870… Nursing home  33Z302       331302    
#> 2 MARY    HALL… K      NA     1.40e9 8921… Nursing home  33Z302       331302    
#> 3 IL      CHON  JUN    NA     1.54e9 0547… Nursing home  33Z302       331302    
#> 4 DRAGOS  BANU  NA     NA     1.56e9 6709… Nursing home  33Z302       331302    

affiliations(parent_ccn = 331302)
#> ✔ affiliations returned 4 results.
#> # A tibble: 4 × 9
#>   first   last  middle suffix    npi pac   facility_type facility_ccn parent_ccn
#> * <chr>   <chr> <chr>  <chr>   <int> <chr> <chr>         <chr>        <chr>     
#> 1 JEFFREY KLOTZ NA     NA     1.07e9 3870… Nursing home  33Z302       331302    
#> 2 MARY    HALL… K      NA     1.40e9 8921… Nursing home  33Z302       331302    
#> 3 IL      CHON  JUN    NA     1.54e9 0547… Nursing home  33Z302       331302    
#> 4 DRAGOS  BANU  NA     NA     1.56e9 6709… Nursing home  33Z302       331302    

affiliations(facility_ccn = 331302)
#> ✔ affiliations returned 206 results.
#> # A tibble: 206 × 9
#>    first  last  middle suffix    npi pac   facility_type facility_ccn parent_ccn
#>  * <chr>  <chr> <chr>  <chr>   <int> <chr> <chr>         <chr>        <chr>     
#>  1 LAURA  GREE… A      NA     1.00e9 1759… Hospital      331302       NA        
#>  2 NAROD  VASS… NA     NA     1.01e9 9133… Hospital      331302       NA        
#>  3 EMILY  TRIP… NA     NA     1.01e9 3375… Hospital      331302       NA        
#>  4 JOSE   ACOS… M      NA     1.01e9 5890… Hospital      331302       NA        
#>  5 LINDS… WILH… B      NA     1.02e9 6901… Hospital      331302       NA        
#>  6 ANTHO… TRAM… F      NA     1.04e9 4183… Hospital      331302       NA        
#>  7 VANES… FIOR… NA     NA     1.04e9 7214… Hospital      331302       NA        
#>  8 CONOR  O'NE… NA     NA     1.05e9 9234… Hospital      331302       NA        
#>  9 JOHN   YOUNG NA     NA     1.06e9 9436… Hospital      331302       NA        
#> 10 ROBERT BENAK L      NA     1.06e9 3476… Hospital      331302       NA        
#> # ℹ 196 more rows
```
