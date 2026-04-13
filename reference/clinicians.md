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
  grad_year = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  org_name = NULL,
  org_pac = NULL,
  count = FALSE
)
```

## Source

- [API: National Downloadable
  File](https://data.cms.gov/provider-data/dataset/mj5m-pzi6)

- [Dictionary: Provider Data Catalog
  (PDC)](https://data.cms.gov/provider-data/sites/default/files/data_dictionaries/physician/DOC_Data_Dictionary.pdf)

- [Source
  Information](https://data.cms.gov/provider-data/topics/doctors-clinicians/data-sources)

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

  `<enum>` Provider's gender; `"F"` (Female), `"M"` (Male), or `"U"`
  (Unknown)

- credential:

  `<chr>` Provider's credential, i.e. `"MD"`, `"OD"`

- specialty:

  `<chr>` Provider’s primary medical specialty

- school:

  `<chr>` Provider’s medical school

- grad_year:

  `<int>` Provider’s graduation year

- city, state, zip:

  `<chr>` Facility's city, state, zip

- org_name:

  `<chr>` Facility associated with Provider

- org_pac:

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

## Examples

``` r
clinicians(count = TRUE)
#> ℹ clinicians has 2,857,460 rows.
clinicians(enid = "I20081002000549")
#> ✔ clinicians returned 1 result.
#> # A data frame: 1 × 25
#>   first   middle last  suffix gender cred  school grad_year specialty spec_other
#> * <chr>   <chr>  <chr> <chr>  <chr>  <chr> <chr>  <chr>     <chr>     <chr>     
#> 1 DOROTHY E      MCCU… NA     F      AU    OTHER  2008      QUALIFIE… NA        
#> # ℹ 15 more variables: npi <chr>, pac <chr>, enid <chr>, org_name <chr>,
#> #   org_pac <chr>, org_mem <chr>, add_1 <chr>, add_2 <chr>, org_city <chr>,
#> #   org_state <chr>, org_zip <chr>, org_phone <chr>, ind <chr>, org <chr>,
#> #   tlh <chr>
clinicians(first = "ETAN")
#> ✔ clinicians returned 11 results.
#> # A data frame: 11 × 25
#>    first middle last   suffix gender cred  school grad_year specialty spec_other
#>  * <chr> <chr>  <chr>  <chr>  <chr>  <chr> <chr>  <chr>     <chr>     <chr>     
#>  1 ETAN  ARIEL  MARKS  NA     M      DO    NOVA … 2013      PATHOLOGY NA        
#>  2 ETAN  NA     EITCH… NA     M      MD    COLUM… 2010      EMERGENC… NA        
#>  3 ETAN  ARIEL  MARKS  NA     M      DO    NOVA … 2013      PATHOLOGY NA        
#>  4 ETAN  NA     DAYAN  NA     M      MD    STATE… 2012      DIAGNOST… NA        
#>  5 ETAN  NA     SPIRA  NA     M      MD    NEW Y… 2007      GASTROEN… INTERNAL …
#>  6 ETAN  NA     EITCH… NA     M      MD    COLUM… 2010      EMERGENC… NA        
#>  7 ETAN  NA     SPIRA  NA     M      MD    NEW Y… 2007      GASTROEN… INTERNAL …
#>  8 ETAN  NA     EITCH… NA     M      MD    COLUM… 2010      EMERGENC… NA        
#>  9 ETAN  NA     SUGAR… NA     M      NA    ALBER… 2011      ORTHOPED… NA        
#> 10 ETAN  NA     SUGAR… NA     M      NA    ALBER… 2011      ORTHOPED… NA        
#> 11 ETAN  NA     SUGAR… NA     M      NA    ALBER… 2011      ORTHOPED… NA        
#> # ℹ 15 more variables: npi <chr>, pac <chr>, enid <chr>, org_name <chr>,
#> #   org_pac <chr>, org_mem <chr>, add_1 <chr>, add_2 <chr>, org_city <chr>,
#> #   org_state <chr>, org_zip <chr>, org_phone <chr>, ind <chr>, org <chr>,
#> #   tlh <chr>
clinicians(count = TRUE,
           city = starts_with("Atl"),
           state = "GA",
           grad_year = 2025)
#> ✔ clinicians returned 389 results.
```
