# Provider-Facility Affiliations

`affiliations()` allows the user access to data concerning providers'
facility affiliations

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
  parent_ccn = NULL
)
```

## Arguments

- npi:

  `<int>` Individual clinician ID, assigned by *NPPES*

- pac:

  `<chr>` Individual clinician ID, assigned by *PECOS*

- first, middle, last, suffix:

  `<chr>` Individual clinician's name

- facility_type:

  `<chr>` Type of facility:

  |          |                                   |
  |----------|-----------------------------------|
  | **abbr** | **full**                          |
  | `hp`     | Hospital                          |
  | `lt`     | Long-term care hospital           |
  | `nh`     | Nursing home                      |
  | `irf`    | Inpatient rehabilitation facility |
  | `hha`    | Home health agency                |
  | `snf`    | Skilled nursing facility          |
  | `hs`     | Hospice                           |
  | `df`     | Dialysis facility                 |

- facility_ccn:

  `<chr>` Medicare CCN of `facility_type` column's facility *or* of a
  *unit* within the hospital where the individual clinician provides
  services.

- parent_ccn:

  `<chr>` Medicare CCN of *primary* hospital where the individual
  clinician provides services in a unit within said hospital.

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
containing the search results.

## Links

- [Physician Facility
  Affiliations](https://data.cms.gov/provider-data/dataset/27ea-46a8)

- [Certification Number (CCN) State
  Codes](https://www.cms.gov/Medicare/Provider-Enrollment-and-Certification/SurveyCertificationGenInfo/Downloads/Survey-and-Cert-Letter-16-09.pdf)

## Examples

``` r
affiliations()
#> ! No arguments provided.
#> ℹ Returning first 10 rows.
#> # A tibble: 10 × 9
#>    npi     pac   last  first middle suffix facility_type facility_ccn parent_ccn
#>    <chr>   <chr> <chr> <chr> <chr>  <chr>  <chr>         <chr>        <chr>     
#>  1 100300… 7517… ENKE… ARDA… NA     NA     Hospital      090012       NA        
#>  2 100300… 9931… KHAL… RASH… NA     NA     Hospital      360112       NA        
#>  3 100300… 0446… ROTH… KEVIN B      NA     Hospital      060024       NA        
#>  4 100300… 2163… SEMO… AMAN… M      NA     Home health … 397791       NA        
#>  5 100300… 2163… SEMO… AMAN… M      NA     Hospital      390035       NA        
#>  6 100300… 2163… SEMO… AMAN… M      NA     Hospital      390049       NA        
#>  7 100300… 2163… SEMO… AMAN… M      NA     Hospital      390057       NA        
#>  8 100300… 4082… KIM   DAE   NA     NA     Hospital      370001       NA        
#>  9 100300… 4082… KIM   DAE   NA     NA     Hospital      370202       NA        
#> 10 100300… 4082… KIM   DAE   NA     NA     Hospital      370057       NA        

affiliations(facility_ccn = "33Z302")
#> ✔ Query returned 4 results.
#> # A tibble: 4 × 9
#>   npi      pac   last  first middle suffix facility_type facility_ccn parent_ccn
#>   <chr>    <chr> <chr> <chr> <chr>  <chr>  <chr>         <chr>        <chr>     
#> 1 1073258… 3870… KLOTZ JEFF… NA     NA     Nursing home  33Z302       331302    
#> 2 1396989… 8921… HALL… MARY  K      NA     Nursing home  33Z302       331302    
#> 3 1538173… 0547… CHON  IL    JUN    NA     Nursing home  33Z302       331302    
#> 4 1558659… 6709… BANU  DRAG… NA     NA     Nursing home  33Z302       331302    

affiliations(parent_ccn = 331302)
#> ✔ Query returned 4 results.
#> # A tibble: 4 × 9
#>   npi      pac   last  first middle suffix facility_type facility_ccn parent_ccn
#>   <chr>    <chr> <chr> <chr> <chr>  <chr>  <chr>         <chr>        <chr>     
#> 1 1073258… 3870… KLOTZ JEFF… NA     NA     Nursing home  33Z302       331302    
#> 2 1396989… 8921… HALL… MARY  K      NA     Nursing home  33Z302       331302    
#> 3 1538173… 0547… CHON  IL    JUN    NA     Nursing home  33Z302       331302    
#> 4 1558659… 6709… BANU  DRAG… NA     NA     Nursing home  33Z302       331302    

affiliations(pac = 7810891009)
#> ✔ Query returned 5 results.
#> # A tibble: 5 × 9
#>   npi      pac   last  first middle suffix facility_type facility_ccn parent_ccn
#>   <chr>    <chr> <chr> <chr> <chr>  <chr>  <chr>         <chr>        <chr>     
#> 1 1043245… 7810… FUNG  MARK  K      NA     Hospital      470003       NA        
#> 2 1043245… 7810… FUNG  MARK  K      NA     Hospital      330250       NA        
#> 3 1043245… 7810… FUNG  MARK  K      NA     Hospital      331321       NA        
#> 4 1043245… 7810… FUNG  MARK  K      NA     Hospital      470001       NA        
#> 5 1043245… 7810… FUNG  MARK  K      NA     Hospital      471307       NA        

affiliations(npi = 1003026055)
#> ✔ Query returned 1 results.
#> # A tibble: 1 × 9
#>   npi      pac   last  first middle suffix facility_type facility_ccn parent_ccn
#>   <chr>    <chr> <chr> <chr> <chr>  <chr>  <chr>         <chr>        <chr>     
#> 1 1003026… 4486… PHAD… RADH… PUSHK… NA     Hospital      100168       NA        

affiliations(first = "KIM")
#> ✔ Query returned 710 results.
#> # A tibble: 710 × 9
#>    npi     pac   last  first middle suffix facility_type facility_ccn parent_ccn
#>    <chr>   <chr> <chr> <chr> <chr>  <chr>  <chr>         <chr>        <chr>     
#>  1 100311… 0941… FREN… KIM   M      NA     Hospital      260032       NA        
#>  2 100315… 4880… HARL… KIM   A      NA     Hospital      180038       NA        
#>  3 100315… 4880… HARL… KIM   A      NA     Hospital      151322       NA        
#>  4 100326… 4082… GORD… KIM   E      NA     Hospital      310041       NA        
#>  5 100344… 9335… VU    KIM   HOANG  NA     Hospital      050231       NA        
#>  6 100399… 0244… FRED… KIM   S      NA     Hospital      050131       NA        
#>  7 101300… 6002… FALL… KIM   M      NA     Hospital      310041       NA        
#>  8 101300… 6002… FALL… KIM   M      NA     Hospital      310084       NA        
#>  9 101307… 0547… WRIG… KIM   C      NA     Hospital      140185       NA        
#> 10 101309… 1254… CARL… KIM   M      NA     Hospital      030007       NA        
#> # ℹ 700 more rows
```
