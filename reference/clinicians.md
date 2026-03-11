# Clinician Demographics

Demographics of doctors and clinicians listed in the Provider Data
Catalog (PDC)

The Doctors and Clinicians national downloadable file is organized such
that each line is unique at the clinician/enrollment
record/group/address level. Clinicians with multiple Medicare enrollment
records and/or single enrollments linking to multiple practice locations
are listed on multiple lines.

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
  facility_pac = NULL
)
```

## Arguments

- npi:

  `<int>` Individual National Provider Identifier

- pac:

  `<int>` Individual PECOS Associate Control ID

- enid:

  `<chr>` Individual Medicare Enrollment ID

- first, middle, last, suffix:

  `<chr>` Individual provider's name

- gender:

  `<chr>` Individual provider's gender; `"F"` (Female), `"M"` (Male), or
  `"U"` (Unknown)

- credential:

  `<chr>` Individual provider's credential, i.e. `"MD"`, `"OD"`

- specialty:

  `<chr>` Individual provider’s primary medical specialty

- school:

  `<chr>` Individual provider’s medical school

- year:

  `<int>` Individual provider’s graduation year

- city, state, zip:

  `<chr>` Facility's city, state, zip

- facility_name:

  `<chr>` Facility associated with Provider

- facility_pac:

  `<int>` Facility's PECOS Associate Control ID

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)

## References

- [National Downloadable
  File](https://data.cms.gov/provider-data/dataset/mj5m-pzi6)

- [Provider Data Catalog (PDC) Data
  Dictionary](https://data.cms.gov/provider-data/sites/default/files/data_dictionaries/physician/DOC_Data_Dictionary.pdf)

## Examples

``` r
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
#> # ℹ 15 more variables: facility_name <chr>, npi <chr>, pac <chr>, enid <chr>,
#> #   org_pac <chr>, org_mems <chr>, add_1 <chr>, add_2 <chr>, city <chr>,
#> #   state <chr>, zip <chr>, phone <chr>, ind <chr>, grp <chr>, tele <chr>

clinicians(enid = "I20081002000549")
#> ✔ Query returned 1 result.
#> # A tibble: 1 × 25
#>   first   middle last     suffix gender cred  school year  specialty  spec_other
#>   <chr>   <chr>  <chr>    <chr>  <chr>  <chr> <chr>  <chr> <chr>      <chr>     
#> 1 DOROTHY E      MCCURLEY NA     F      AU    OTHER  2008  QUALIFIED… NA        
#> # ℹ 15 more variables: facility_name <chr>, npi <chr>, pac <chr>, enid <chr>,
#> #   org_pac <chr>, org_mems <chr>, add_1 <chr>, add_2 <chr>, city <chr>,
#> #   state <chr>, zip <chr>, phone <chr>, ind <chr>, grp <chr>, tele <chr>

clinicians(first = "ETAN")
#> ✔ Query returned 11 results.
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
#> # ℹ 15 more variables: facility_name <chr>, npi <chr>, pac <chr>, enid <chr>,
#> #   org_pac <chr>, org_mems <chr>, add_1 <chr>, add_2 <chr>, city <chr>,
#> #   state <chr>, zip <chr>, phone <chr>, ind <chr>, grp <chr>, tele <chr>

clinicians(city = starts_with("At"), state = "GA", year = 2020)
#> ✔ Query returned 651 results.
#> # A tibble: 651 × 25
#>    first    middle   last  suffix gender cred  school year  specialty spec_other
#>    <chr>    <chr>    <chr> <chr>  <chr>  <chr> <chr>  <chr> <chr>     <chr>     
#>  1 ABBY     A        BROWN NA     F      NP    OTHER  2020  NURSE PR… NA        
#>  2 JAMES    QUINTEN  TUCK… NA     M      NA    KANSA… 2020  OPHTHALM… NA        
#>  3 SARAH    ELIZABE… DUNS… NA     F      MD    UNIVE… 2020  ANESTHES… NA        
#>  4 ANNA     NA       WISE  NA     F      NA    OTHER  2020  PSYCHIAT… NA        
#>  5 SANTORIA GIBBS    HAMB… NA     F      NA    OTHER  2020  NURSE PR… NA        
#>  6 SANDRA   NA       ST L… NA     F      NA    OTHER  2020  NURSE PR… NA        
#>  7 JACKSON  J        CERVI NA     M      NA    OTHER  2020  PHYSICAL… NA        
#>  8 SHAMEELA NA       KHIM… NA     F      NA    OTHER  2020  ALLERGY/… NA        
#>  9 TYREL    NA       FOST… NA     M      MD    UNIVE… 2020  NUCLEAR … NA        
#> 10 KARTHIK  NA       BHAT  NA     M      MD    EASTE… 2020  VASCULAR… NA        
#> # ℹ 641 more rows
#> # ℹ 15 more variables: facility_name <chr>, npi <chr>, pac <chr>, enid <chr>,
#> #   org_pac <chr>, org_mems <chr>, add_1 <chr>, add_2 <chr>, city <chr>,
#> #   state <chr>, zip <chr>, phone <chr>, ind <chr>, grp <chr>, tele <chr>
```
