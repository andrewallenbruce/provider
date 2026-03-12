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

  `<int>` PECOS Associate Control ID

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

  `<int>` Facility's PECOS Associate Control ID

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
#> ✔ Query returned 2,843,790 results.
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
clinicians(city = starts_with("At"), state = "GA", year = 2020, count = TRUE)
#> ✔ Query returned 651 results.
clinicians(city = starts_with("Atl"), state = "GA", year = 2025, count = TRUE)
#> ✔ Query returned 351 results.
```
