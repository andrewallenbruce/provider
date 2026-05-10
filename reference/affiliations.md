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
#>           npi pac       last  first middle facility_type facility_ccn parent_ccn
#>  *      <int> <chr>     <chr> <chr> <chr>  <chr>         <chr>        <chr>     
#>  1 1003000126 75170036… ENKE… ARDA… NA     Hospital      090012       NA        
#>  2 1003000142 99313806… KHAL… RASH… NA     Hospital      360112       NA        
#>  3 1003000423 91333972… VELO… JENN… A      Hospital      360098       NA        
#>  4 1003000480 04463482… ROTH… KEVIN B      Hospital      060024       NA        
#>  5 1003000530 21635756… SEMO… AMAN… M      Hospital      390035       NA        
#>  6 1003000530 21635756… SEMO… AMAN… M      Hospital      390057       NA        
#>  7 1003000530 21635756… SEMO… AMAN… M      Hospital      390049       NA        
#>  8 1003000597 40828481… KIM   DAE   NA     Hospital      370001       NA        
#>  9 1003000597 40828481… KIM   DAE   NA     Hospital      370202       NA        
#> 10 1003000597 40828481… KIM   DAE   NA     Hospital      370057       NA        

affiliations(parent_ccn = 331302)
#> ✔ affiliations returned 4 results.
#> # A tibble: 4 × 8
#>          npi pac        last  first middle facility_type facility_ccn parent_ccn
#> *      <int> <chr>      <chr> <chr> <chr>  <chr>         <chr>        <chr>     
#> 1 1073258398 3870095805 KLOTZ JEFF… NA     Nursing home  33Z302       331302    
#> 2 1396989059 8921259557 HALL… MARY  K      Nursing home  33Z302       331302    
#> 3 1538173869 0547299091 CHON  IL    JUN    Nursing home  33Z302       331302    
#> 4 1558659367 6709004682 BANU  DRAG… NA     Nursing home  33Z302       331302    

affiliations(facility_ccn = 331302)
#> ✔ affiliations returned 206 results.
#> # A tibble: 206 × 8
#>           npi pac       last  first middle facility_type facility_ccn parent_ccn
#>  *      <int> <chr>     <chr> <chr> <chr>  <chr>         <chr>        <chr>     
#>  1 1003845272 17593840… GREE… LAURA A      Hospital      331302       NA        
#>  2 1013539584 91335441… VASS… NAROD NA     Hospital      331302       NA        
#>  3 1013595560 33759474… TRIP… EMILY NA     Hospital      331302       NA        
#>  4 1013910256 58907193… ACOS… JOSE  M      Hospital      331302       NA        
#>  5 1023377843 69011152… WILH… LIND… B      Hospital      331302       NA        
#>  6 1043397656 41837645… TRAM… ANTH… F      Hospital      331302       NA        
#>  7 1043672140 72142293… FIOR… VANE… NA     Hospital      331302       NA        
#>  8 1053686196 92344325… O'NE… CONOR NA     Hospital      331302       NA        
#>  9 1063420891 94360516… YOUNG JOHN  NA     Hospital      331302       NA        
#> 10 1063423523 34765528… BENAK ROBE… L      Hospital      331302       NA        
#> # ℹ 196 more rows

affiliations(first = "Andrew", last = contains("B"), facility_type = "hospital")
#> ✔ affiliations returned 1,601 results.
#> ℹ Retrieving 2 pages...
#> # A tibble: 1,601 × 8
#>           npi pac       last  first middle facility_type facility_ccn parent_ccn
#>  *      <int> <chr>     <chr> <chr> <chr>  <chr>         <chr>        <chr>     
#>  1 1003253634 86283456… RODE… ANDR… LEWIS  Hospital      350002       NA        
#>  2 1003278680 87293275… BELL… ANDR… NA     Hospital      330234       NA        
#>  3 1003479494 90324464… KUBI… ANDR… J      Hospital      520045       NA        
#>  4 1003530478 40820819… BERN… ANDR… NA     Hospital      390133       NA        
#>  5 1013129816 97392398… BOMB… ANDR… S      Hospital      330101       NA        
#>  6 1013174275 45879517… BARB… ANDR… NA     Hospital      340030       NA        
#>  7 1013273853 86282227… BUCK… ANDR… D      Hospital      180002       NA        
#>  8 1013273853 86282227… BUCK… ANDR… D      Hospital      180020       NA        
#>  9 1013438274 24667250… BARE… ANDR… NA     Hospital      450039       NA        
#> 10 1013438746 52941598… BOUW… ANDR… ROBERT Hospital      180130       NA        
#> # ℹ 1,591 more rows
```
