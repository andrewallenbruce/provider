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

- first, middle, last:

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
#> affiliations Totals
#> • Rows  : 1,638,995
#> • Pages : 1,093    
#> 

affiliations(count = TRUE, facility_ccn = 331302)
#> ✔ affiliations returned 206 results.

affiliations()
#> affiliations Totals
#> • Rows  : 1,638,995
#> • Pages : 1,093    
#> 
#> ! No Query ❯ Returning first 10 rows.
#> 
#> # A tibble: 10 × 8
#>    first    last      middle     npi pac   facility_type facility_ccn parent_ccn
#>    <chr>    <chr>     <chr>    <int> <chr> <chr>         <chr>        <chr>     
#>  1 ARDALAN  ENKESHAFI NA      1.00e9 7517… Hospital      090012       NA        
#>  2 RASHID   KHALIL    NA      1.00e9 9931… Hospital      360112       NA        
#>  3 JENNIFER VELOTTA   A       1.00e9 9133… Hospital      360098       NA        
#>  4 KEVIN    ROTHCHILD B       1.00e9 0446… Hospital      060024       NA        
#>  5 AMANDA   SEMONCHE  M       1.00e9 2163… Hospital      390035       NA        
#>  6 AMANDA   SEMONCHE  M       1.00e9 2163… Hospital      390057       NA        
#>  7 AMANDA   SEMONCHE  M       1.00e9 2163… Hospital      390049       NA        
#>  8 DAE      KIM       NA      1.00e9 4082… Hospital      370001       NA        
#>  9 DAE      KIM       NA      1.00e9 4082… Hospital      370202       NA        
#> 10 DAE      KIM       NA      1.00e9 4082… Hospital      370057       NA        

affiliations(parent_ccn = 331302)
#> ✔ affiliations returned 4 results.
#> # A tibble: 4 × 8
#>   first   last     middle        npi pac   facility_type facility_ccn parent_ccn
#>   <chr>   <chr>    <chr>       <int> <chr> <chr>         <chr>        <chr>     
#> 1 JEFFREY KLOTZ    NA     1073258398 3870… Nursing home  33Z302       331302    
#> 2 MARY    HALLORAN K      1396989059 8921… Nursing home  33Z302       331302    
#> 3 IL      CHON     JUN    1538173869 0547… Nursing home  33Z302       331302    
#> 4 DRAGOS  BANU     NA     1558659367 6709… Nursing home  33Z302       331302    

affiliations(facility_ccn = 331302)
#> ✔ affiliations returned 206 results.
#> # A tibble: 206 × 8
#>    first   last        middle    npi pac   facility_type facility_ccn parent_ccn
#>    <chr>   <chr>       <chr>   <int> <chr> <chr>         <chr>        <chr>     
#>  1 LAURA   GREENE      A      1.00e9 1759… Hospital      331302       NA        
#>  2 NAROD   VASSILIAN   NA     1.01e9 9133… Hospital      331302       NA        
#>  3 EMILY   TRIPLETT    NA     1.01e9 3375… Hospital      331302       NA        
#>  4 JOSE    ACOSTAMADI… M      1.01e9 5890… Hospital      331302       NA        
#>  5 LINDSEY WILHELM     B      1.02e9 6901… Hospital      331302       NA        
#>  6 ANTHONY TRAMONTANO  F      1.04e9 4183… Hospital      331302       NA        
#>  7 VANESSA FIORINI FU… NA     1.04e9 7214… Hospital      331302       NA        
#>  8 CONOR   O'NEILL     NA     1.05e9 9234… Hospital      331302       NA        
#>  9 JOHN    YOUNG       NA     1.06e9 9436… Hospital      331302       NA        
#> 10 ROBERT  BENAK       L      1.06e9 3476… Hospital      331302       NA        
#> # ℹ 196 more rows

affiliations(first = "Andrew", last = contains("B"), facility_type = "hospital")
#> ✔ affiliations returned 1,601 results.
#> ℹ Retrieving 2 pages...
#> [working] (0 + 0) -> 1 -> 1 | ■■■■■■■■■■■■■■■■                  50%
#> [working] (0 + 0) -> 0 -> 2 | ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  100%
#> # A tibble: 1,601 × 8
#>    first  last       middle      npi pac   facility_type facility_ccn parent_ccn
#>    <chr>  <chr>      <chr>     <int> <chr> <chr>         <chr>        <chr>     
#>  1 ANDREW RODENBURG  LEWIS    1.00e9 8628… Hospital      350002       NA        
#>  2 ANDREW BELLANTONI NA       1.00e9 8729… Hospital      330234       NA        
#>  3 ANDREW KUBISCH    J        1.00e9 9032… Hospital      520045       NA        
#>  4 ANDREW BERNER     NA       1.00e9 4082… Hospital      390133       NA        
#>  5 ANDREW BOMBACK    S        1.01e9 9739… Hospital      330101       NA        
#>  6 ANDREW BARBAS     NA       1.01e9 4587… Hospital      340030       NA        
#>  7 ANDREW BUCKLEY    D        1.01e9 8628… Hospital      180002       NA        
#>  8 ANDREW BUCKLEY    D        1.01e9 8628… Hospital      180020       NA        
#>  9 ANDREW BAREFOOT   NA       1.01e9 2466… Hospital      450039       NA        
#> 10 ANDREW BOUWKAMP   ROBERT   1.01e9 5294… Hospital      180130       NA        
#> # ℹ 1,591 more rows
```
