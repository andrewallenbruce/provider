# Provider Facility Affiliations

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

  `<int>` Unique clinician ID assigned by NPPES

- pac:

  `<chr>` Unique individual clinician ID assigned by PECOS

- first, middle, last, suffix:

  `<chr>` Clinician name

- facility_type:

  `<chr>` type of facility:

  - `"hp"` Hospital

  - `"lt"` Long-Term Care Hospital

  - `"nh"` Nursing Home

  - `"irf"` Inpatient Rehabilitation Facility

  - `"hha"` Home Health Agency

  - `"snf"` Skilled Nursing Facility

  - `"hs"` Hospice

  - `"df"` Dialysis Facility

- facility_ccn:

  `<chr>` CCN of `facility_type` or unit within hospital where an
  individual clinician provides service

- parent_ccn:

  `<chr>` CCN of the primary hospital where individual clinician
  provides service, should the clinician provide services in a unit
  within the hospital

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
# affiliations(facility_type = c("lt", "irf")) 15,105 results

affiliations(facility_ccn = "33Z302")
#> ✔ Query returning 5 results.
#> # A tibble: 5 × 9
#>   npi      pac   first middle last  suffix facility_type parent_ccn facility_ccn
#>   <chr>    <chr> <chr> <chr>  <chr> <chr>  <chr>         <chr>      <chr>       
#> 1 1073258… 3870… KLOTZ JEFFR… ""    ""     Nursing home  33Z302     331302      
#> 2 1396989… 8921… HALL… MARY   "K"   ""     Nursing home  33Z302     331302      
#> 3 1538173… 0547… CHON  IL     "JUN" ""     Nursing home  33Z302     331302      
#> 4 1558659… 6709… BANU  DRAGOS ""    ""     Nursing home  33Z302     331302      
#> 5 1760167… 8123… WARN… JOSHUA ""    ""     Nursing home  33Z302     331302      

affiliations(parent_ccn = 331302)
#> ✔ Query returning 5 results.
#> # A tibble: 5 × 9
#>   npi      pac   first middle last  suffix facility_type parent_ccn facility_ccn
#>   <chr>    <chr> <chr> <chr>  <chr> <chr>  <chr>         <chr>      <chr>       
#> 1 1073258… 3870… KLOTZ JEFFR… ""    ""     Nursing home  33Z302     331302      
#> 2 1396989… 8921… HALL… MARY   "K"   ""     Nursing home  33Z302     331302      
#> 3 1538173… 0547… CHON  IL     "JUN" ""     Nursing home  33Z302     331302      
#> 4 1558659… 6709… BANU  DRAGOS ""    ""     Nursing home  33Z302     331302      
#> 5 1760167… 8123… WARN… JOSHUA ""    ""     Nursing home  33Z302     331302      

affiliations(pac = 7810891009)
#> ✔ Query returning 5 results.
#> # A tibble: 5 × 9
#>   npi      pac   first middle last  suffix facility_type parent_ccn facility_ccn
#>   <chr>    <chr> <chr> <chr>  <chr> <chr>  <chr>         <chr>      <chr>       
#> 1 1043245… 7810… FUNG  MARK   K     ""     Hospital      470003     ""          
#> 2 1043245… 7810… FUNG  MARK   K     ""     Hospital      330250     ""          
#> 3 1043245… 7810… FUNG  MARK   K     ""     Hospital      331321     ""          
#> 4 1043245… 7810… FUNG  MARK   K     ""     Hospital      470001     ""          
#> 5 1043245… 7810… FUNG  MARK   K     ""     Hospital      471307     ""          

affiliations(npi = 1003026055)
#> ✔ Query returning 1 results.
#> # A tibble: 1 × 9
#>   npi      pac   first middle last  suffix facility_type parent_ccn facility_ccn
#>   <chr>    <chr> <chr> <chr>  <chr> <chr>  <chr>         <chr>      <chr>       
#> 1 1003026… 4486… PHAD… RADHI… PUSH… ""     Hospital      100168     ""          

affiliations(first = "KIM")
#> ✔ Query returning 703 results.
#> # A tibble: 703 × 9
#>    npi     pac   first middle last  suffix facility_type parent_ccn facility_ccn
#>    <chr>   <chr> <chr> <chr>  <chr> <chr>  <chr>         <chr>      <chr>       
#>  1 100311… 0941… FREN… KIM    M     ""     Hospital      260032     ""          
#>  2 100315… 4880… HARL… KIM    A     ""     Hospital      180038     ""          
#>  3 100315… 4880… HARL… KIM    A     ""     Hospital      151322     ""          
#>  4 100326… 4082… GORD… KIM    E     ""     Hospital      310041     ""          
#>  5 100344… 9335… VU    KIM    HOANG ""     Hospital      050231     ""          
#>  6 100399… 0244… FRED… KIM    S     ""     Hospital      050131     ""          
#>  7 101300… 6002… FALL… KIM    M     ""     Hospital      310041     ""          
#>  8 101300… 6002… FALL… KIM    M     ""     Hospital      310084     ""          
#>  9 101307… 0547… WRIG… KIM    C     ""     Hospital      140185     ""          
#> 10 101309… 1254… CARL… KIM    M     ""     Hospital      030007     ""          
#> # ℹ 693 more rows
```
