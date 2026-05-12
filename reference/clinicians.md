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
  members = NULL,
  count = FALSE,
  set = FALSE
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

- first, middle, last:

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

- members:

  `<int>` Number of members in Organization

- count:

  `<lgl>` Return the total row count

- set:

  `<lgl>` Return the entire dataset

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
clinicians(count = TRUE, org_name = not_blank())
#> ✔ clinicians returned 2,586,064 results.

clinicians(enid = "I20081002000549")
#> ✔ clinicians returned 1 result.
#> # A tibble: 1 × 18
#>   first  middle last  gender cred  school grad_year specialty    npi pac   enid 
#>   <chr>  <chr>  <chr> <chr>  <chr> <chr>      <int> <chr>      <int> <chr> <chr>
#> 1 DOROT… E      MCCU… F      AU    OTHER       2008 QUALIFIE… 1.41e9 8022… I200…
#> # ℹ 7 more variables: org_name <chr>, org_pac <chr>, members <int>,
#> #   address <chr>, city <chr>, state <chr>, zip <chr>

clinicians(first = "Etan")
#> ✔ clinicians returned 11 results.
#> # A tibble: 11 × 18
#>    first middle last  gender cred  school grad_year specialty    npi pac   enid 
#>    <chr> <chr>  <chr> <chr>  <chr> <chr>      <int> <chr>      <int> <chr> <chr>
#>  1 ETAN  ARIEL  MARKS M      DO    NOVA …      2013 PATHOLOGY 1.53e9 7113… I202…
#>  2 ETAN  NA     EITC… M      MD    COLUM…      2010 EMERGENC… 1.41e9 9638… I202…
#>  3 ETAN  ARIEL  MARKS M      DO    NOVA …      2013 PATHOLOGY 1.53e9 7113… I201…
#>  4 ETAN  NA     DAYAN M      MD    STATE…      2012 DIAGNOST… 1.70e9 7618… I202…
#>  5 ETAN  NA     SPIRA M      MD    NEW Y…      2007 INTERNAL… 1.00e9 4587… I201…
#>  6 ETAN  NA     EITC… M      MD    COLUM…      2010 EMERGENC… 1.41e9 9638… I202…
#>  7 ETAN  NA     SPIRA M      MD    NEW Y…      2007 INTERNAL… 1.00e9 4587… I201…
#>  8 ETAN  NA     EITC… M      MD    COLUM…      2010 EMERGENC… 1.41e9 9638… I202…
#>  9 ETAN  NA     SUGA… M      NA    ALBER…      2011 ORTHOPED… 1.24e9 0244… I202…
#> 10 ETAN  NA     SUGA… M      NA    ALBER…      2011 ORTHOPED… 1.24e9 0244… I202…
#> 11 ETAN  NA     SUGA… M      NA    ALBER…      2011 ORTHOPED… 1.24e9 0244… I202…
#> # ℹ 7 more variables: org_name <chr>, org_pac <chr>, members <int>,
#> #   address <chr>, city <chr>, state <chr>, zip <chr>

clinicians(members = 100, count = TRUE)
#> ✔ clinicians returned 3,411 results.
# clinicians(members = less(100), count = TRUE)
# clinicians(members = greater(100), count = TRUE)
# clinicians(members = greater(1000), count = TRUE)
```
