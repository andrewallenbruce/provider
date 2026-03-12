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
  count = FALSE
)
```

## Arguments

- npi:

  `<int>` Individual National Provider Identifier

- pac:

  `<chr>` Individual PECOS Associate Control ID

- first, middle, last, suffix:

  `<chr>` Individual provider's name

- facility_type:

  `<chr>` facility type abbreviation

- facility_ccn:

  `<chr>` CCN of `facility_type` column's facility **or** of a **unit**
  within the hospital where the individual provider provides services.

- parent_ccn:

  `<chr>` CCN of the **primary** hospital containing the unit where the
  individual provider provides services.

- count:

  `<lgl>` Return the dataset's total row count

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)

## References

- [API: Physician Facility
  Affiliations](https://data.cms.gov/provider-data/dataset/27ea-46a8)

- [Certification Number (CCN) State
  Codes](https://www.cms.gov/Medicare/Provider-Enrollment-and-Certification/SurveyCertificationGenInfo/Downloads/Survey-and-Cert-Letter-16-09.pdf)

## Examples

``` r
affiliations(count = TRUE)
#> ✔ Query returned 1,621,297 results.
affiliations()
#> ! No Query → Returning first 10 rows.
#> # A tibble: 10 × 9
#>    first   last  middle suffix npi   pac   facility_type facility_ccn parent_ccn
#>    <chr>   <chr> <chr>  <chr>  <chr> <chr> <chr>         <chr>        <chr>     
#>  1 ARDALAN ENKE… NA     NA     1003… 7517… Hospital      090012       NA        
#>  2 RASHID  KHAL… NA     NA     1003… 9931… Hospital      360112       NA        
#>  3 KEVIN   ROTH… B      NA     1003… 0446… Hospital      060024       NA        
#>  4 AMANDA  SEMO… M      NA     1003… 2163… Home health … 397791       NA        
#>  5 AMANDA  SEMO… M      NA     1003… 2163… Hospital      390035       NA        
#>  6 AMANDA  SEMO… M      NA     1003… 2163… Hospital      390049       NA        
#>  7 AMANDA  SEMO… M      NA     1003… 2163… Hospital      390057       NA        
#>  8 DAE     KIM   NA     NA     1003… 4082… Hospital      370001       NA        
#>  9 DAE     KIM   NA     NA     1003… 4082… Hospital      370202       NA        
#> 10 DAE     KIM   NA     NA     1003… 4082… Hospital      370057       NA        
affiliations(first = "")
#> ✖ Query returned 0 results.
affiliations(facility_ccn = "33Z302")
#> ✔ Query returned 4 results.
#> # A tibble: 4 × 9
#>   first   last   middle suffix npi   pac   facility_type facility_ccn parent_ccn
#>   <chr>   <chr>  <chr>  <chr>  <chr> <chr> <chr>         <chr>        <chr>     
#> 1 JEFFREY KLOTZ  NA     NA     1073… 3870… Nursing home  33Z302       331302    
#> 2 MARY    HALLO… K      NA     1396… 8921… Nursing home  33Z302       331302    
#> 3 IL      CHON   JUN    NA     1538… 0547… Nursing home  33Z302       331302    
#> 4 DRAGOS  BANU   NA     NA     1558… 6709… Nursing home  33Z302       331302    
affiliations(parent_ccn = 331302)
#> ✔ Query returned 4 results.
#> # A tibble: 4 × 9
#>   first   last   middle suffix npi   pac   facility_type facility_ccn parent_ccn
#>   <chr>   <chr>  <chr>  <chr>  <chr> <chr> <chr>         <chr>        <chr>     
#> 1 JEFFREY KLOTZ  NA     NA     1073… 3870… Nursing home  33Z302       331302    
#> 2 MARY    HALLO… K      NA     1396… 8921… Nursing home  33Z302       331302    
#> 3 IL      CHON   JUN    NA     1538… 0547… Nursing home  33Z302       331302    
#> 4 DRAGOS  BANU   NA     NA     1558… 6709… Nursing home  33Z302       331302    
affiliations(facility_ccn = 331302)
#> ✔ Query returned 206 results.
#> # A tibble: 206 × 9
#>    first   last  middle suffix npi   pac   facility_type facility_ccn parent_ccn
#>    <chr>   <chr> <chr>  <chr>  <chr> <chr> <chr>         <chr>        <chr>     
#>  1 LAURA   GREE… A      NA     1003… 1759… Hospital      331302       NA        
#>  2 DEBORAH KAMP… M      NA     1013… 8022… Hospital      331302       NA        
#>  3 NAROD   VASS… NA     NA     1013… 9133… Hospital      331302       NA        
#>  4 EMILY   TRIP… NA     NA     1013… 3375… Hospital      331302       NA        
#>  5 JOSE    ACOS… M      NA     1013… 5890… Hospital      331302       NA        
#>  6 LINDSEY WILH… B      NA     1023… 6901… Hospital      331302       NA        
#>  7 VANESSA FIOR… NA     NA     1043… 7214… Hospital      331302       NA        
#>  8 JOHN    YOUNG NA     NA     1063… 9436… Hospital      331302       NA        
#>  9 DELANEY OSBO… NA     NA     1073… 0547… Hospital      331302       NA        
#> 10 ANGAD   GILL  NA     NA     1073… 6800… Hospital      331302       NA        
#> # ℹ 196 more rows
```
