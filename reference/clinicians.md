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
#> ✔ `clinicians` returned 2,843,790 results.
clinicians()
#> ! No Query → Returning first 10 rows.
#> # A tibble: 10 × 25
#>    first    middle last    suffix gender cred  school year  specialty spec_other
#>    <chr>    <chr>  <chr>   <chr>  <chr>  <chr> <chr>  <chr> <chr>     <chr>     
#>  1 ARDALAN  NA     ENKESH… NA     M      MD    OTHER  1994  HOSPITAL… INTERNAL …
#>  2 RASHID   NA     KHALIL  NA     M      MD    OTHER  1999  ANESTHES… NA        
#>  3 RASHID   NA     KHALIL  NA     M      MD    OTHER  1999  ANESTHES… NA        
#>  4 RASHID   NA     KHALIL  NA     M      MD    OTHER  1999  ANESTHES… NA        
#>  5 RASHID   NA     KHALIL  NA     M      MD    OTHER  1999  ANESTHES… PAIN MANA…
#>  6 JENNIFER A      VELOTTA NA     F      MD    TOLED… 2007  OBSTETRI… NA        
#>  7 KEVIN    B      ROTHCH… NA     M      MD    OHIO … 1997  GENERAL … NA        
#>  8 KEVIN    B      ROTHCH… NA     M      MD    OHIO … 1997  GENERAL … NA        
#>  9 KEVIN    B      ROTHCH… NA     M      MD    OHIO … 1997  GENERAL … NA        
#> 10 AMANDA   M      SEMONC… NA     F      DO    LAKE … 2006  INTERNAL… NA        
#> # ℹ 15 more variables: npi <chr>, pac <chr>, enid <chr>, org_name <chr>,
#> #   org_pac <chr>, org_mem <chr>, add_1 <chr>, add_2 <chr>, org_city <chr>,
#> #   org_state <chr>, org_zip <chr>, org_phone <chr>, ind <chr>, org <chr>,
#> #   tlh <chr>
clinicians(enid = "I20081002000549")
#> ✔ `clinicians` returned 1 result.
#> # A tibble: 1 × 25
#>   first middle last  suffix gender cred  school year  specialty spec_other npi  
#>   <chr> <chr>  <chr> <chr>  <chr>  <chr> <chr>  <chr> <chr>     <chr>      <chr>
#> 1 DORO… E      MCCU… NA     F      AU    OTHER  2008  QUALIFIE… NA         1407…
#> # ℹ 14 more variables: pac <chr>, enid <chr>, org_name <chr>, org_pac <chr>,
#> #   org_mem <chr>, add_1 <chr>, add_2 <chr>, org_city <chr>, org_state <chr>,
#> #   org_zip <chr>, org_phone <chr>, ind <chr>, org <chr>, tlh <chr>
clinicians(first = "ETAN")
#> ✔ `clinicians` returned 11 results.
#> # A tibble: 11 × 25
#>    first middle last     suffix gender cred  school   year  specialty spec_other
#>    <chr> <chr>  <chr>    <chr>  <chr>  <chr> <chr>    <chr> <chr>     <chr>     
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
#> ✔ `clinicians` returned 351 results.
clinicians(city = "ATLANTA", state = "GA", year = 2025, count = TRUE)
#> ✔ `clinicians` returned 351 results.
clinicians(city = any_of("Atlanta"), state = "GA", year = 2025)
#> ✔ `clinicians` returned 351 results.
#> # A tibble: 351 × 25
#>    first      middle last  suffix gender cred  school year  specialty spec_other
#>    <chr>      <chr>  <chr> <chr>  <chr>  <chr> <chr>  <chr> <chr>     <chr>     
#>  1 THAO       NA     HOANG NA     F      PA    OTHER  2025  PHYSICIA… NA        
#>  2 RYAN       NA     FERL… NA     M      NA    OTHER  2025  PHYSICIA… NA        
#>  3 MADISON    NA     THUR… NA     F      OD    ILLIN… 2025  OPHTHALM… NA        
#>  4 MADISON    NA     THUR… NA     F      OD    ILLIN… 2025  OPHTHALM… NA        
#>  5 KERRINGTON NA     PUGH  NA     F      NA    OTHER  2025  PHYSICIA… NA        
#>  6 ELIOT      NA     KIM   NA     M      PT    OTHER  2025  PHYSICAL… NA        
#>  7 NATHANIEL  NA     TREES NA     M      NA    OTHER  2025  PHYSICAL… NA        
#>  8 MARA       S.     DETR… NA     F      NA    MERCE… 2025  PHYSICIA… NA        
#>  9 KRYSTAL    GAIL   DENN… NA     F      NP    OTHER  2025  NURSE PR… NA        
#> 10 LAUREN     NA     FOX   NA     F      NP    OTHER  2025  NURSE PR… NA        
#> # ℹ 341 more rows
#> # ℹ 15 more variables: npi <chr>, pac <chr>, enid <chr>, org_name <chr>,
#> #   org_pac <chr>, org_mem <chr>, add_1 <chr>, add_2 <chr>, org_city <chr>,
#> #   org_state <chr>, org_zip <chr>, org_phone <chr>, ind <chr>, org <chr>,
#> #   tlh <chr>
```
