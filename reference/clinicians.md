# Clinician Demographics

Demographics of clinicians listed in the Provider Data Catalog (PDC)

## Usage

``` r
clinicians(
  npi = NULL,
  pac = NULL,
  enid = NULL,
  first = NULL,
  last = NULL,
  gender = NULL,
  cred = NULL,
  specialty = NULL,
  school = NULL,
  year = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  org_name = NULL,
  org_pac = NULL,
  members = NULL,
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

- first, last:

  `<chr>` Individual provider's name

- gender:

  `<enum>` Provider's gender; `"F"` (Female), `"M"` (Male), or `"U"`
  (Unknown)

- cred:

  `<chr>` Provider's credential, i.e. `"MD"`, `"OD"`

- specialty:

  `<chr>` Provider’s primary medical specialty

- school:

  `<chr>` Provider's medical school

- year:

  `<int>` Provider's graduation year

- city, state, zip:

  `<chr>` Facility's city, state, zip

- org_name:

  `<chr>` Name of facility associated with Provider

- org_pac:

  `<chr>` Facility's PECOS Associate Control ID

- members:

  `<int>` Number of members in facility's organization

- count:

  `<lgl>` Return the total row count

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
containing the search results.

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
#> ◼ clinicians | 3,364,553 rows | 2,244 pages
clinicians(first = "Etan")
#> ✔ clinicians returned 12 results
#> ✔ Retrieving 1 page
#> # A tibble: 12 × 17
#>    first last    gender cred  school  year specialty    npi pac   enid  org_name
#>    <chr> <chr>   <chr>  <chr> <chr>  <int> <chr>      <int> <chr> <chr> <chr>   
#>  1 ETAN  MARKS   M      DO    NOVA …  2013 PATHOLOGY 1.53e9 7113… I202… ADVANCE…
#>  2 ETAN  EITCHES M      MD    COLUM…  2010 EMERGENC… 1.41e9 9638… I202… KAISER …
#>  3 ETAN  MARKS   M      DO    NOVA …  2013 PATHOLOGY 1.53e9 7113… I201… LEAVITT…
#>  4 ETAN  DAYAN   M      MD    STATE…  2012 DIAGNOST… 1.70e9 7618… I202… UNIVERS…
#>  5 ETAN  SPIRA   M      MD    NEW Y…  2007 GASTROEN… 1.00e9 4587… I201… HUDSON …
#>  6 ETAN  EITCHES M      MD    COLUM…  2010 EMERGENC… 1.41e9 9638… I202… KAISER …
#>  7 ETAN  ABER    M      MD    COLUM…  2019 HEMATOLO… 1.84e9 5092… I202… NA      
#>  8 ETAN  SPIRA   M      MD    NEW Y…  2007 GASTROEN… 1.00e9 4587… I201… HUDSON …
#>  9 ETAN  EITCHES M      MD    COLUM…  2010 EMERGENC… 1.41e9 9638… I202… KAISER …
#> 10 ETAN  SUGARM… M      NA    ALBER…  2011 ORTHOPED… 1.24e9 0244… I202… AMERICA…
#> 11 ETAN  SUGARM… M      NA    ALBER…  2011 ORTHOPED… 1.24e9 0244… I202… AMERICA…
#> 12 ETAN  SUGARM… M      NA    ALBER…  2011 ORTHOPED… 1.24e9 0244… I202… AMERICA…
#> # ℹ 6 more variables: org_pac <chr>, members <int>, address <chr>, city <chr>,
#> #   state <chr>, zip <chr>
clinicians(year = greater(2030))
#> ✔ clinicians returned 10 results
#> ✔ Retrieving 1 page
#> # A tibble: 10 × 17
#>    first   last  gender cred  school  year specialty    npi pac   enid  org_name
#>    <chr>   <chr> <chr>  <chr> <chr>  <int> <chr>      <int> <chr> <chr> <chr>   
#>  1 ANTHONY HAGE  M      MD    OTHER   2031 INTERVEN… 1.92e9 8527… I202… COOPER …
#>  2 ANTHONY HAGE  M      MD    OTHER   2031 INTERVEN… 1.92e9 8527… I202… COOPER …
#>  3 MOLLY   MILLS F      CNA   OTHER   2032 CERTIFIE… 1.95e9 0840… I202… LIFELIN…
#>  4 ANTHONY HAGE  M      MD    OTHER   2031 INTERVEN… 1.92e9 8527… I202… COOPER …
#>  5 TONYA   REAG… F      NA    OTHER   2035 HOSPICE/… 1.09e9 0840… I202… NA      
#>  6 TONYA   REAG… F      NA    OTHER   2035 HOSPICE/… 1.09e9 0840… I202… NA      
#>  7 ANTHONY HAGE  M      MD    OTHER   2031 INTERVEN… 1.92e9 8527… I202… COOPER …
#>  8 ANTHONY HAGE  M      MD    OTHER   2031 INTERVEN… 1.92e9 8527… I202… COOPER …
#>  9 ANTHONY HAGE  M      MD    OTHER   2031 INTERVEN… 1.92e9 8527… I202… COOPER …
#> 10 ANTHONY HAGE  M      MD    OTHER   2031 INTERVEN… 1.92e9 8527… I202… COOPER …
#> # ℹ 6 more variables: org_pac <chr>, members <int>, address <chr>, city <chr>,
#> #   state <chr>, zip <chr>
```
