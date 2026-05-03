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
  org_city = NULL,
  org_state = NULL,
  org_zip = NULL,
  org_name = NULL,
  org_pac = NULL,
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

- org_city, org_state, org_zip:

  `<chr>` Facility's city, state, zip

- org_name:

  `<chr>` Facility associated with Provider

- org_pac:

  `<chr>` Facility's PECOS Associate Control ID

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
#> # A tibble: 1 × 26
#>          npi pac   enid  last  first middle suffix gender cred  school grad_year
#> *      <int> <chr> <chr> <chr> <chr> <chr>  <chr>  <chr>  <chr> <chr>      <int>
#> 1 1407031495 8022… I200… MCCU… DORO… E      NA     F      AU    OTHER       2008
#> # ℹ 15 more variables: specialty <chr>, telehlth <chr>, org_name <chr>,
#> #   org_pac <chr>, org_mem <int>, ln_2_sprs <chr>, org_city <chr>,
#> #   org_state <chr>, org_zip <chr>, org_phone <chr>, ind_assgn <chr>,
#> #   grp_assgn <chr>, adrs_id <chr>, org_add <chr>, specialty <chr>

clinicians(first = "Etan")
#> ✔ clinicians returned 11 results.
#> # A tibble: 11 × 26
#>          npi pac   enid  last  first middle suffix gender cred  school grad_year
#>  *     <int> <chr> <chr> <chr> <chr> <chr>  <chr>  <chr>  <chr> <chr>      <int>
#>  1    1.53e9 7113… I202… MARKS ETAN  ARIEL  NA     M      DO    NOVA …      2013
#>  2    1.41e9 9638… I202… EITC… ETAN  NA     NA     M      MD    COLUM…      2010
#>  3    1.53e9 7113… I201… MARKS ETAN  ARIEL  NA     M      DO    NOVA …      2013
#>  4    1.70e9 7618… I202… DAYAN ETAN  NA     NA     M      MD    STATE…      2012
#>  5    1.00e9 4587… I201… SPIRA ETAN  NA     NA     M      MD    NEW Y…      2007
#>  6    1.41e9 9638… I202… EITC… ETAN  NA     NA     M      MD    COLUM…      2010
#>  7    1.00e9 4587… I201… SPIRA ETAN  NA     NA     M      MD    NEW Y…      2007
#>  8    1.41e9 9638… I202… EITC… ETAN  NA     NA     M      MD    COLUM…      2010
#>  9    1.24e9 0244… I202… SUGA… ETAN  NA     NA     M      NA    ALBER…      2011
#> 10    1.24e9 0244… I202… SUGA… ETAN  NA     NA     M      NA    ALBER…      2011
#> 11    1.24e9 0244… I202… SUGA… ETAN  NA     NA     M      NA    ALBER…      2011
#> # ℹ 15 more variables: specialty <chr>, telehlth <chr>, org_name <chr>,
#> #   org_pac <chr>, org_mem <int>, ln_2_sprs <chr>, org_city <chr>,
#> #   org_state <chr>, org_zip <chr>, org_phone <chr>, ind_assgn <chr>,
#> #   grp_assgn <chr>, adrs_id <chr>, org_add <chr>, specialty <chr>
```
