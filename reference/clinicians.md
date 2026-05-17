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
clinicians(count = TRUE)
#> clinicians Totals
#> • Rows  : 3,378,753
#> • Pages : 2,253    
#> 
clinicians(org_name = not_blank(), count = TRUE)
#> ✔ clinicians returned 3,030,173 results.

clinicians(enid = "I20081002000549") |> str()
#> ✔ clinicians returned 1 result.
#> clinicns [1 × 18] (S3: clinicians/tbl_df/tbl/data.frame)
#>  $ first    : chr "DOROTHY"
#>  $ middle   : chr "E"
#>  $ last     : chr "MCCURLEY"
#>  $ gender   : chr "F"
#>  $ cred     : chr "AU"
#>  $ school   : chr "OTHER"
#>  $ grad_year: int 2008
#>  $ specialty: chr "QUALIFIED AUDIOLOGIST"
#>  $ npi      : int 1407031495
#>  $ pac      : chr "8022186162"
#>  $ enid     : chr "I20081002000549"
#>  $ org_name : chr NA
#>  $ org_pac  : chr NA
#>  $ members  : int NA
#>  $ address  : chr "457 WASHINGTON ST SE, SUITE D"
#>  $ city     : chr "ALBUQUERQUE"
#>  $ state    : chr "NM"
#>  $ zip      : chr "871082713"

clinicians(first = "Etan")
#> ✔ clinicians returned 12 results.
#> # A tibble: 12 × 18
#>    first middle last  gender cred  school grad_year specialty    npi pac   enid 
#>    <chr> <chr>  <chr> <chr>  <chr> <chr>      <int> <chr>      <int> <chr> <chr>
#>  1 ETAN  NA     SPIRA M      MD    NEW Y…      2007 GASTROEN… 1.00e9 4587… I201…
#>  2 ETAN  NA     SPIRA M      MD    NEW Y…      2007 GASTROEN… 1.00e9 4587… I201…
#>  3 ETAN  NA     SUGA… M      NA    ALBER…      2011 ORTHOPED… 1.24e9 0244… I202…
#>  4 ETAN  NA     SUGA… M      NA    ALBER…      2011 ORTHOPED… 1.24e9 0244… I202…
#>  5 ETAN  NA     SUGA… M      NA    ALBER…      2011 ORTHOPED… 1.24e9 0244… I202…
#>  6 ETAN  NA     EITC… M      MD    COLUM…      2010 EMERGENC… 1.41e9 9638… I202…
#>  7 ETAN  NA     EITC… M      MD    COLUM…      2010 EMERGENC… 1.41e9 9638… I202…
#>  8 ETAN  NA     EITC… M      MD    COLUM…      2010 EMERGENC… 1.41e9 9638… I202…
#>  9 ETAN  ARIEL  MARKS M      DO    NOVA …      2013 PATHOLOGY 1.53e9 7113… I202…
#> 10 ETAN  ARIEL  MARKS M      DO    NOVA …      2013 PATHOLOGY 1.53e9 7113… I201…
#> 11 ETAN  NA     DAYAN M      MD    STATE…      2012 DIAGNOST… 1.70e9 7618… I202…
#> 12 ETAN  NA     ABER  M      MD    COLUM…      2019 HEMATOLO… 1.84e9 5092… I202…
#> # ℹ 7 more variables: org_name <chr>, org_pac <chr>, members <int>,
#> #   address <chr>, city <chr>, state <chr>, zip <chr>

clinicians(members = not_blank(), count = TRUE)
#> ✔ clinicians returned 3,030,172 results.
clinicians(members = is_blank(), count = TRUE)
#> ✔ clinicians returned 348,581 results.
clinicians(members = 100, count = TRUE)
#> ✔ clinicians returned 3,884 results.
```
