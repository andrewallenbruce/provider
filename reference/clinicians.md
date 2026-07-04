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
#>         npi pac   enid  first last  gender cred  school  year specialty org_name
#>       <int> <chr> <chr> <chr> <chr> <chr>  <chr> <chr>  <int> <chr>     <chr>   
#>  1   1.53e9 7113… I202… ETAN  MARKS M      DO    NOVA …  2013 PATHOLOGY ADVANCE…
#>  2   1.41e9 9638… I202… ETAN  EITC… M      MD    COLUM…  2010 EMERGENC… KAISER …
#>  3   1.53e9 7113… I201… ETAN  MARKS M      DO    NOVA …  2013 PATHOLOGY LEAVITT…
#>  4   1.70e9 7618… I202… ETAN  DAYAN M      MD    STATE…  2012 DIAGNOST… UNIVERS…
#>  5   1.00e9 4587… I201… ETAN  SPIRA M      MD    NEW Y…  2007 GASTROEN… HUDSON …
#>  6   1.41e9 9638… I202… ETAN  EITC… M      MD    COLUM…  2010 EMERGENC… KAISER …
#>  7   1.84e9 5092… I202… ETAN  ABER  M      MD    COLUM…  2019 HEMATOLO… NA      
#>  8   1.00e9 4587… I201… ETAN  SPIRA M      MD    NEW Y…  2007 GASTROEN… HUDSON …
#>  9   1.41e9 9638… I202… ETAN  EITC… M      MD    COLUM…  2010 EMERGENC… KAISER …
#> 10   1.24e9 0244… I202… ETAN  SUGA… M      NA    ALBER…  2011 ORTHOPED… AMERICA…
#> 11   1.24e9 0244… I202… ETAN  SUGA… M      NA    ALBER…  2011 ORTHOPED… AMERICA…
#> 12   1.24e9 0244… I202… ETAN  SUGA… M      NA    ALBER…  2011 ORTHOPED… AMERICA…
#> # ℹ 6 more variables: org_pac <chr>, members <int>, address <chr>, city <chr>,
#> #   state <chr>, zip <chr>
clinicians(year = greater(2030))
#> ✔ clinicians returned 10 results
#> ✔ Retrieving 1 page
#> # A tibble: 10 × 17
#>         npi pac   enid  first last  gender cred  school  year specialty org_name
#>       <int> <chr> <chr> <chr> <chr> <chr>  <chr> <chr>  <int> <chr>     <chr>   
#>  1   1.92e9 8527… I202… ANTH… HAGE  M      MD    OTHER   2031 INTERVEN… COOPER …
#>  2   1.92e9 8527… I202… ANTH… HAGE  M      MD    OTHER   2031 INTERVEN… COOPER …
#>  3   1.95e9 0840… I202… MOLLY MILLS F      CNA   OTHER   2032 CERTIFIE… LIFELIN…
#>  4   1.92e9 8527… I202… ANTH… HAGE  M      MD    OTHER   2031 INTERVEN… COOPER …
#>  5   1.09e9 0840… I202… TONYA REAG… F      NA    OTHER   2035 HOSPICE/… NA      
#>  6   1.09e9 0840… I202… TONYA REAG… F      NA    OTHER   2035 HOSPICE/… NA      
#>  7   1.92e9 8527… I202… ANTH… HAGE  M      MD    OTHER   2031 INTERVEN… COOPER …
#>  8   1.92e9 8527… I202… ANTH… HAGE  M      MD    OTHER   2031 INTERVEN… COOPER …
#>  9   1.92e9 8527… I202… ANTH… HAGE  M      MD    OTHER   2031 INTERVEN… COOPER …
#> 10   1.92e9 8527… I202… ANTH… HAGE  M      MD    OTHER   2031 INTERVEN… COOPER …
#> # ℹ 6 more variables: org_pac <chr>, members <int>, address <chr>, city <chr>,
#> #   state <chr>, zip <chr>
```
