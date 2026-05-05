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
#> ═ affiliations Totals
#> • Rows  : 1,638,995
#> • Pages : 1,093    
#> 

affiliations(count = TRUE, facility_ccn = 331302)
#> ✔ affiliations returned 206 results.

affiliations()
#> ═ affiliations Totals
#> • Rows  : 1,638,995
#> • Pages : 1,093    
#> 
#> ! No Query ❯ Returning first 10 rows...
#> 
#> # A tibble: 10 × 9
#>        npi pac   last  first middle suffix facility_type facility_ccn parent_ccn
#>  *   <int> <chr> <chr> <chr> <chr>  <chr>  <chr>         <chr>        <chr>     
#>  1  1.00e9 7517… ENKE… ARDA… NA     NA     Hospital      090012       NA        
#>  2  1.00e9 9931… KHAL… RASH… NA     NA     Hospital      360112       NA        
#>  3  1.00e9 9133… VELO… JENN… A      NA     Hospital      360098       NA        
#>  4  1.00e9 0446… ROTH… KEVIN B      NA     Hospital      060024       NA        
#>  5  1.00e9 2163… SEMO… AMAN… M      NA     Hospital      390035       NA        
#>  6  1.00e9 2163… SEMO… AMAN… M      NA     Hospital      390057       NA        
#>  7  1.00e9 2163… SEMO… AMAN… M      NA     Hospital      390049       NA        
#>  8  1.00e9 4082… KIM   DAE   NA     NA     Hospital      370001       NA        
#>  9  1.00e9 4082… KIM   DAE   NA     NA     Hospital      370202       NA        
#> 10  1.00e9 4082… KIM   DAE   NA     NA     Hospital      370057       NA        

affiliations(parent_ccn = 331302)
#> ✔ affiliations returned 4 results.
#> # A tibble: 4 × 9
#>        npi pac   last  first middle suffix facility_type facility_ccn parent_ccn
#> *    <int> <chr> <chr> <chr> <chr>  <chr>  <chr>         <chr>        <chr>     
#> 1   1.07e9 3870… KLOTZ JEFF… NA     NA     Nursing home  33Z302       331302    
#> 2   1.40e9 8921… HALL… MARY  K      NA     Nursing home  33Z302       331302    
#> 3   1.54e9 0547… CHON  IL    JUN    NA     Nursing home  33Z302       331302    
#> 4   1.56e9 6709… BANU  DRAG… NA     NA     Nursing home  33Z302       331302    

affiliations(facility_ccn = 331302)
#> ✔ affiliations returned 206 results.
#> # A tibble: 206 × 9
#>        npi pac   last  first middle suffix facility_type facility_ccn parent_ccn
#>  *   <int> <chr> <chr> <chr> <chr>  <chr>  <chr>         <chr>        <chr>     
#>  1  1.00e9 1759… GREE… LAURA A      NA     Hospital      331302       NA        
#>  2  1.01e9 9133… VASS… NAROD NA     NA     Hospital      331302       NA        
#>  3  1.01e9 3375… TRIP… EMILY NA     NA     Hospital      331302       NA        
#>  4  1.01e9 5890… ACOS… JOSE  M      NA     Hospital      331302       NA        
#>  5  1.02e9 6901… WILH… LIND… B      NA     Hospital      331302       NA        
#>  6  1.04e9 4183… TRAM… ANTH… F      NA     Hospital      331302       NA        
#>  7  1.04e9 7214… FIOR… VANE… NA     NA     Hospital      331302       NA        
#>  8  1.05e9 9234… O'NE… CONOR NA     NA     Hospital      331302       NA        
#>  9  1.06e9 9436… YOUNG JOHN  NA     NA     Hospital      331302       NA        
#> 10  1.06e9 3476… BENAK ROBE… L      NA     Hospital      331302       NA        
#> # ℹ 196 more rows

affiliations(first = "Andrew", last = contains("B"), facility_type = "hospital")
#> ✔ affiliations returned 1,601 results.
#> ℹ Retrieving 2 pages...
#> # A tibble: 1,601 × 9
#>        npi pac   last  first middle suffix facility_type facility_ccn parent_ccn
#>  *   <int> <chr> <chr> <chr> <chr>  <chr>  <chr>         <chr>        <chr>     
#>  1  1.00e9 8628… RODE… ANDR… LEWIS  NA     Hospital      350002       NA        
#>  2  1.00e9 8729… BELL… ANDR… NA     NA     Hospital      330234       NA        
#>  3  1.00e9 9032… KUBI… ANDR… J      NA     Hospital      520045       NA        
#>  4  1.00e9 4082… BERN… ANDR… NA     NA     Hospital      390133       NA        
#>  5  1.01e9 9739… BOMB… ANDR… S      NA     Hospital      330101       NA        
#>  6  1.01e9 4587… BARB… ANDR… NA     NA     Hospital      340030       NA        
#>  7  1.01e9 8628… BUCK… ANDR… D      NA     Hospital      180002       NA        
#>  8  1.01e9 8628… BUCK… ANDR… D      NA     Hospital      180020       NA        
#>  9  1.01e9 2466… BARE… ANDR… NA     NA     Hospital      450039       NA        
#> 10  1.01e9 5294… BOUW… ANDR… ROBERT NA     Hospital      180130       NA        
#> # ℹ 1,591 more rows
```
