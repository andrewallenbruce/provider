# Clinician Demographics

Demographics of clinicians listed in the Provider Data Catalog (PDC)

## Usage

``` r
clinicians(
  npi = NULL,
  pac = NULL,
  enid = NULL,
  first = NULL,
  middle = NULL,
  last = NULL,
  suffix = NULL,
  gender = NULL,
  credential = NULL,
  specialty = NULL,
  school = NULL,
  year = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  facility_name = NULL,
  facility_pac = NULL,
  count = FALSE
)
```

## Arguments

- npi:

  `<int>` National Provider Identifier

- pac:

  `<chr>` PECOS Associate Control ID

- enid:

  `<chr>` Medicare Enrollment ID

- first, middle, last, suffix:

  `<chr>` Individual provider's name

- gender:

  `<chr>` Provider's gender; `"F"` (Female), `"M"` (Male), or `"U"`
  (Unknown)

- credential:

  `<chr>` Provider's credential, i.e. `"MD"`, `"OD"`

- specialty:

  `<chr>` Provider’s primary medical specialty

- school:

  `<chr>` Provider’s medical school

- year:

  `<int>` Provider’s graduation year

- city, state, zip:

  `<chr>` Facility's city, state, zip

- facility_name:

  `<chr>` Facility associated with Provider

- facility_pac:

  `<chr>` Facility's PECOS Associate Control ID

- count:

  `<lgl>` Return the dataset's total row count

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)

## Data Source

The Doctors and Clinicians National Downloadable File is organized such
that each line is unique at the clinician/enrollment
record/group/address level.

Clinicians with multiple Medicare enrollment records and/or single
enrollments linking to multiple practice locations are listed on
multiple lines.

### Inclusion Criteria

A Clinician or Group must have:

- Current and approved Medicare enrollment record in PECOS

- Valid physical practice location or address

- Valid specialty

- National Provider Identifier

- One Medicare FFS claim within the last six months

- Two approved clinicians reassigning their benefits to the group

## References

- [API: National Downloadable
  File](https://data.cms.gov/provider-data/dataset/mj5m-pzi6)

- [Dictionary: Provider Data Catalog
  (PDC)](https://data.cms.gov/provider-data/sites/default/files/data_dictionaries/physician/DOC_Data_Dictionary.pdf)

- [Source
  Information](https://data.cms.gov/provider-data/topics/doctors-clinicians/data-sources)

## Examples

``` r
clinicians(count = TRUE)
#> ✔ `clinicians` returned 2,819,129 results.
clinicians(enid = "I20081002000549")
#> ✔ `clinicians` returned 1 result.
#> # A data frame: 1 × 25
#>   first middle last  suffix gender cred  school year  specialty spec_other npi  
#> * <chr> <chr>  <chr> <chr>  <chr>  <chr> <chr>  <chr> <chr>     <chr>      <chr>
#> 1 DORO… E      MCCU… NA     F      AU    OTHER  2008  QUALIFIE… NA         1407…
#> # ℹ 14 more variables: pac <chr>, enid <chr>, org_name <chr>, org_pac <chr>,
#> #   org_mem <chr>, add_1 <chr>, add_2 <chr>, org_city <chr>, org_state <chr>,
#> #   org_zip <chr>, org_phone <chr>, ind <chr>, org <chr>, tlh <chr>
clinicians(first = "ETAN")
#> ✔ `clinicians` returned 11 results.
#> # A data frame: 11 × 25
#>    first middle last     suffix gender cred  school   year  specialty spec_other
#>  * <chr> <chr>  <chr>    <chr>  <chr>  <chr> <chr>    <chr> <chr>     <chr>     
#>  1 ETAN  NA     SPIRA    NA     M      MD    NEW YOR… 2007  GASTROEN… INTERNAL …
#>  2 ETAN  NA     SPIRA    NA     M      MD    NEW YOR… 2007  GASTROEN… INTERNAL …
#>  3 ETAN  NA     SUGARMAN NA     M      NA    ALBERT … 2011  ORTHOPED… NA        
#>  4 ETAN  NA     SUGARMAN NA     M      NA    ALBERT … 2011  ORTHOPED… NA        
#>  5 ETAN  NA     SUGARMAN NA     M      NA    ALBERT … 2011  ORTHOPED… NA        
#>  6 ETAN  NA     EITCHES  NA     M      MD    COLUMBI… 2010  EMERGENC… NA        
#>  7 ETAN  NA     EITCHES  NA     M      MD    COLUMBI… 2010  EMERGENC… NA        
#>  8 ETAN  NA     EITCHES  NA     M      MD    COLUMBI… 2010  EMERGENC… NA        
#>  9 ETAN  ARIEL  MARKS    NA     M      DO    NOVA SO… 2013  PATHOLOGY NA        
#> 10 ETAN  ARIEL  MARKS    NA     M      DO    NOVA SO… 2013  PATHOLOGY NA        
#> 11 ETAN  NA     DAYAN    NA     M      MD    STATE U… 2012  DIAGNOST… NA        
#> # ℹ 15 more variables: npi <chr>, pac <chr>, enid <chr>, org_name <chr>,
#> #   org_pac <chr>, org_mem <chr>, add_1 <chr>, add_2 <chr>, org_city <chr>,
#> #   org_state <chr>, org_zip <chr>, org_phone <chr>, ind <chr>, org <chr>,
#> #   tlh <chr>
clinicians(city = starts_with("Atl"), state = "GA", year = 2025, count = TRUE)
#> ✔ `clinicians` returned 362 results.
clinicians(city = "Atlanta", state = "GA", year = 2025)
#> ✔ `clinicians` returned 362 results.
#> # A data frame: 362 × 25
#>    first      middle last  suffix gender cred  school year  specialty spec_other
#>  * <chr>      <chr>  <chr> <chr>  <chr>  <chr> <chr>  <chr> <chr>     <chr>     
#>  1 THAO       NA     HOANG NA     F      PA    OTHER  2025  PHYSICIA… NA        
#>  2 RYAN       NA     FERL… NA     M      NA    OTHER  2025  PHYSICIA… NA        
#>  3 SYDNEY     CLAIRE ZARS… NA     F      NA    OTHER  2025  PHYSICIA… NA        
#>  4 CATHERINE  NA     GENER NA     F      NP    OTHER  2025  NURSE PR… NA        
#>  5 MADISON    NA     THUR… NA     F      OD    ILLIN… 2025  OPHTHALM… NA        
#>  6 MADISON    NA     THUR… NA     F      OD    ILLIN… 2025  OPHTHALM… NA        
#>  7 KERRINGTON NA     PUGH  NA     F      NA    OTHER  2025  PHYSICIA… NA        
#>  8 ELIOT      NA     KIM   NA     M      PT    OTHER  2025  PHYSICAL… NA        
#>  9 NATHANIEL  NA     TREES NA     M      NA    OTHER  2025  PHYSICAL… NA        
#> 10 MARA       S.     DETR… NA     F      NA    MERCE… 2025  PHYSICIA… NA        
#> # ℹ 352 more rows
#> # ℹ 15 more variables: npi <chr>, pac <chr>, enid <chr>, org_name <chr>,
#> #   org_pac <chr>, org_mem <chr>, add_1 <chr>, add_2 <chr>, org_city <chr>,
#> #   org_state <chr>, org_zip <chr>, org_phone <chr>, ind <chr>, org <chr>,
#> #   tlh <chr>
```
