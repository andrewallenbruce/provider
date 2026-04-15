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
clinicians(count = TRUE, org_name = not_na())
#> ✔ clinicians returned 2,586,064 results.

clinicians(enid = "I20081002000549")
#> ✔ clinicians returned 1 result.
#> # A tibble: 1 × 20
#>   first middle last  suffix gender cred  school grad_year specialty    npi pac  
#> * <chr> <chr>  <chr> <chr>  <chr>  <chr> <chr>      <int> <chr>      <int> <chr>
#> 1 DORO… E      MCCU… NA     F      AU    OTHER       2008 QUALIFIE… 1.41e9 8022…
#> # ℹ 9 more variables: enid <chr>, org_name <chr>, org_pac <chr>, org_mem <chr>,
#> #   org_city <chr>, org_state <chr>, org_zip <chr>, org_phone <chr>,
#> #   org_add <chr>

clinicians(first = "Etan")
#> ✔ clinicians returned 11 results.
#> # A tibble: 11 × 20
#>    first middle last     suffix gender cred  school   grad_year specialty    npi
#>  * <chr> <chr>  <chr>    <chr>  <chr>  <chr> <chr>        <int> <chr>      <int>
#>  1 ETAN  ARIEL  MARKS    NA     M      DO    NOVA SO…      2013 PATHOLOGY 1.53e9
#>  2 ETAN  NA     EITCHES  NA     M      MD    COLUMBI…      2010 EMERGENC… 1.41e9
#>  3 ETAN  ARIEL  MARKS    NA     M      DO    NOVA SO…      2013 PATHOLOGY 1.53e9
#>  4 ETAN  NA     DAYAN    NA     M      MD    STATE U…      2012 DIAGNOST… 1.70e9
#>  5 ETAN  NA     SPIRA    NA     M      MD    NEW YOR…      2007 GASTROEN… 1.00e9
#>  6 ETAN  NA     EITCHES  NA     M      MD    COLUMBI…      2010 EMERGENC… 1.41e9
#>  7 ETAN  NA     SPIRA    NA     M      MD    NEW YOR…      2007 GASTROEN… 1.00e9
#>  8 ETAN  NA     EITCHES  NA     M      MD    COLUMBI…      2010 EMERGENC… 1.41e9
#>  9 ETAN  NA     SUGARMAN NA     M      NA    ALBERT …      2011 ORTHOPED… 1.24e9
#> 10 ETAN  NA     SUGARMAN NA     M      NA    ALBERT …      2011 ORTHOPED… 1.24e9
#> 11 ETAN  NA     SUGARMAN NA     M      NA    ALBERT …      2011 ORTHOPED… 1.24e9
#> # ℹ 10 more variables: pac <chr>, enid <chr>, org_name <chr>, org_pac <chr>,
#> #   org_mem <chr>, org_city <chr>, org_state <chr>, org_zip <chr>,
#> #   org_phone <chr>, org_add <chr>
```
