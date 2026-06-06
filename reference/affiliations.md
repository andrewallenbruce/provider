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

## Examples

``` r
affiliations(count = TRUE)
#> affiliations Totals
#> • Rows  : 2,247,604
#> • Pages : 1,499    
#> 

affiliations(count = TRUE, facility_ccn = 331302)
#> ✔ affiliations returned 334 results.

affiliations()
#> affiliations Totals
#> • Rows  : 2,247,604
#> • Pages : 1,499    
#> 
#> ✔ Returning first 10 rows
#> # A tibble: 10 × 8
#>    first    middle last             npi pac        prov_type prov_ccn parent_ccn
#>    <chr>    <chr>  <chr>          <int> <chr>      <chr>     <chr>    <chr>     
#>  1 ARDALAN  NA     ENKESHAFI 1003000126 7517003643 Hospital  090012   NA        
#>  2 RASHID   NA     KHALIL    1003000142 9931380672 Hospital  360112   NA        
#>  3 JENNIFER A      VELOTTA   1003000423 9133397268 Hospital  360098   NA        
#>  4 KEVIN    B      ROTHCHILD 1003000480 0446348254 Hospital  060024   NA        
#>  5 AMANDA   M      SEMONCHE  1003000530 2163575663 Home hea… 397791   NA        
#>  6 AMANDA   M      SEMONCHE  1003000530 2163575663 Hospital  390035   NA        
#>  7 AMANDA   M      SEMONCHE  1003000530 2163575663 Hospital  390049   NA        
#>  8 AMANDA   M      SEMONCHE  1003000530 2163575663 Hospital  390057   NA        
#>  9 DAE      NA     KIM       1003000597 4082848189 Hospital  370001   NA        
#> 10 DAE      NA     KIM       1003000597 4082848189 Hospital  370202   NA        

affiliations(parent_ccn = 331302)
#> ✔ affiliations returned 6 results.
#> # A tibble: 6 × 8
#>   first   middle last            npi pac        prov_type    prov_ccn parent_ccn
#>   <chr>   <chr>  <chr>         <int> <chr>      <chr>        <chr>    <chr>     
#> 1 JEFFREY NA     KLOTZ    1073258398 3870095805 Nursing home 33Z302   331302    
#> 2 CARLOS  E      MARTINEZ 1154332062 5890739734 Nursing home 33Z302   331302    
#> 3 MARY    K      HALLORAN 1396989059 8921259557 Nursing home 33Z302   331302    
#> 4 IL      JUN    CHON     1538173869 0547299091 Nursing home 33Z302   331302    
#> 5 DRAGOS  NA     BANU     1558659367 6709004682 Nursing home 33Z302   331302    
#> 6 JOSHUA  NA     WARNER   1760167712 8123473469 Nursing home 33Z302   331302    

affiliations(facility_ccn = 331302)
#> ✔ affiliations returned 334 results.
#> # A tibble: 334 × 8
#>    first   middle  last                  npi pac   prov_type prov_ccn parent_ccn
#>    <chr>   <chr>   <chr>               <int> <chr> <chr>     <chr>    <chr>     
#>  1 STACI   L       CARTER-KELLY   1003029125 6204… Hospital  331302   NA        
#>  2 DYLAN   A       ESTES          1003278144 6608… Hospital  331302   NA        
#>  3 ANA     MARIELA MORALES MEJIA  1003421496 6103… Hospital  331302   NA        
#>  4 ARMIN   NA      AFSAR KESHMIRI 1003815184 4082… Hospital  331302   NA        
#>  5 LAURA   A       GREENE         1003845272 1759… Hospital  331302   NA        
#>  6 DEBORAH M       KAMPSCHROR     1013141860 8022… Hospital  331302   NA        
#>  7 NAROD   NA      VASSILIAN      1013539584 9133… Hospital  331302   NA        
#>  8 EMILY   NA      TRIPLETT       1013595560 3375… Hospital  331302   NA        
#>  9 BARDIA  NA      BARIMANI       1013793736 9436… Hospital  331302   NA        
#> 10 JOSE    M       ACOSTAMADIEDO  1013910256 5890… Hospital  331302   NA        
#> # ℹ 324 more rows

affiliations(first = "Andrew", last = contains("B"), facility_type = "hospital")
#> ✔ affiliations returned 2,093 results.
#> ✔ Retrieving 2 pages
#> # A tibble: 2,093 × 8
#>    first  middle last              npi pac        prov_type prov_ccn parent_ccn
#>    <chr>  <chr>  <chr>           <int> <chr>      <chr>     <chr>    <chr>     
#>  1 ANDREW LEWIS  RODENBURG  1003253634 8628345642 Hospital  350002   NA        
#>  2 ANDREW NA     BELLANTONI 1003278680 8729327556 Hospital  330234   NA        
#>  3 ANDREW J      KUBISCH    1003479494 9032446414 Hospital  520045   NA        
#>  4 ANDREW NA     BERNER     1003530478 4082081914 Hospital  390133   NA        
#>  5 ANDREW S      BOMBACK    1013129816 9739239856 Hospital  330101   NA        
#>  6 ANDREW NA     BARBAS     1013174275 4587951728 Hospital  340030   NA        
#>  7 ANDREW D      BUCKLEY    1013273853 8628222783 Hospital  180020   NA        
#>  8 ANDREW D      BUCKLEY    1013273853 8628222783 Hospital  180002   NA        
#>  9 ANDREW D      BUCKLEY    1013273853 8628222783 Hospital  180127   NA        
#> 10 ANDREW NA     BAREFOOT   1013438274 2466725031 Hospital  450039   NA        
#> # ℹ 2,083 more rows
```
