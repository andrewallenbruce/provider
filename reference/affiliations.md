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
  parent_ccn = NULL
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

  `<chr>` facility type abbreviation:

  |          |                                   |
  |----------|-----------------------------------|
  | **ABBR** | **FULL**                          |
  | `hp`     | Hospital                          |
  | `lt`     | Long-term care hospital           |
  | `nh`     | Nursing home                      |
  | `irf`    | Inpatient rehabilitation facility |
  | `hha`    | Home health agency                |
  | `snf`    | Skilled nursing facility          |
  | `hs`     | Hospice                           |
  | `df`     | Dialysis facility                 |

- facility_ccn:

  `<chr>` CCN of `facility_type` column's facility **or** of a **unit**
  within the hospital where the individual provider provides services.

- parent_ccn:

  `<chr>` CCN of the **primary** hospital containing the unit where the
  individual provider provides services.

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)

## References

- [Physician Facility
  Affiliations](https://data.cms.gov/provider-data/dataset/27ea-46a8)

- [Certification Number (CCN) State
  Codes](https://www.cms.gov/Medicare/Provider-Enrollment-and-Certification/SurveyCertificationGenInfo/Downloads/Survey-and-Cert-Letter-16-09.pdf)

## Examples

``` r
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

affiliations(pac = 7810891009)
#> ✔ Query returned 5 results.
#> # A tibble: 5 × 9
#>   first last  middle suffix npi      pac   facility_type facility_ccn parent_ccn
#>   <chr> <chr> <chr>  <chr>  <chr>    <chr> <chr>         <chr>        <chr>     
#> 1 MARK  FUNG  K      NA     1043245… 7810… Hospital      470003       NA        
#> 2 MARK  FUNG  K      NA     1043245… 7810… Hospital      330250       NA        
#> 3 MARK  FUNG  K      NA     1043245… 7810… Hospital      331321       NA        
#> 4 MARK  FUNG  K      NA     1043245… 7810… Hospital      470001       NA        
#> 5 MARK  FUNG  K      NA     1043245… 7810… Hospital      471307       NA        

affiliations(npi = 1003026055)
#> ✔ Query returned 1 result.
#> # A tibble: 1 × 9
#>   first   last   middle suffix npi   pac   facility_type facility_ccn parent_ccn
#>   <chr>   <chr>  <chr>  <chr>  <chr> <chr> <chr>         <chr>        <chr>     
#> 1 RADHIKA PHADKE PUSHK… NA     1003… 4486… Hospital      100168       NA        

affiliations(first = "KIM")
#> ✔ Query returned 710 results.
#> # A tibble: 710 × 9
#>    first last    middle suffix npi   pac   facility_type facility_ccn parent_ccn
#>    <chr> <chr>   <chr>  <chr>  <chr> <chr> <chr>         <chr>        <chr>     
#>  1 KIM   FRENCH  M      NA     1003… 0941… Hospital      260032       NA        
#>  2 KIM   HARLEY  A      NA     1003… 4880… Hospital      180038       NA        
#>  3 KIM   HARLEY  A      NA     1003… 4880… Hospital      151322       NA        
#>  4 KIM   GORDON  E      NA     1003… 4082… Hospital      310041       NA        
#>  5 KIM   VU      HOANG  NA     1003… 9335… Hospital      050231       NA        
#>  6 KIM   FREDER… S      NA     1003… 0244… Hospital      050131       NA        
#>  7 KIM   FALLON  M      NA     1013… 6002… Hospital      310041       NA        
#>  8 KIM   FALLON  M      NA     1013… 6002… Hospital      310084       NA        
#>  9 KIM   WRIGLEY C      NA     1013… 0547… Hospital      140185       NA        
#> 10 KIM   CARLTON M      NA     1013… 1254… Hospital      030007       NA        
#> # ℹ 700 more rows

affiliations(facility_ccn = c("33Z302", 331302))
#> ✔ Query returned 210 results.
#> # A tibble: 210 × 9
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
#> # ℹ 200 more rows
```
