# Linking Providers

``` r

library(provider)
```

#### Individual Provider

``` r

x <- affiliations(pac = 7810891009)
#> Error in `httr2::req_perform()`:
#> ! HTTP 503 Service Unavailable.
x <- list(
  individual = as.data.frame(t(unique(x[1:4]))),
  organization = hospitals(ccn = x$ccn))
#> Error:
#> ! object 'x' not found
x
#> Error:
#> ! object 'x' not found

reassignments(pac = 7810891009) |> str()
#> ✔ reassignments returned 1 result
#> ✔ Retrieving 1 page
#> rssgnmnt [1 × 13] (S3: reassignments/tbl_df/tbl/data.frame)
#>  $ first      : chr "Mark"
#>  $ last       : chr "Fung"
#>  $ state      : chr "VT"
#>  $ specialty  : chr "Pathology"
#>  $ memberships: int 1
#>  $ npi        : int 1043245657
#>  $ pac        : chr "7810891009"
#>  $ enid       : chr "I20031120000251"
#>  $ org_name   : chr "University Of Vermont Medical Center Inc"
#>  $ members    : int 1585
#>  $ org_pac    : chr "3779491071"
#>  $ org_enid   : chr "O20040406001047"
#>  $ org_state  : chr "VT"

clinicians(pac = 7810891009) |> str()
#> Error in `httr2::req_perform()`:
#> ! HTTP 503 Service Unavailable.
```

#### Organizational Provider

``` r

x <- "Elizabethtown Community Hospital"

hospitals(org_name = x) |> str()
#> ✔ hospitals returned 2 results
#> ✔ Retrieving 1 page
#> ✔ hospitals2 returned 1 result
#> ✔ Retrieving 1 page
#> Error in `httr2::req_perform()`:
#> ! HTTP 503 Service Unavailable.

clinicians(org_name = x) |> str()
#> Error in `httr2::req_perform()`:
#> ! HTTP 503 Service Unavailable.

reassignments(org_name = x)
#> ✔ reassignments returned 398 results
#> ✔ Retrieving 1 page
#> # A tibble: 398 × 13
#>    first   last  state specialty memberships    npi pac   enid  org_name members
#>    <chr>   <chr> <chr> <chr>           <int>  <int> <chr> <chr> <chr>      <int>
#>  1 Nathal… Abis… NY    Family P…           1 1.34e9 5294… I202… Elizabe…     202
#>  2 Jose    Acos… NY    Medical …           5 1.01e9 5890… I201… Elizabe…     202
#>  3 Jose    Acos… NY    Medical …           5 1.01e9 5890… I201… Elizabe…     141
#>  4 Dmitriy Akse… NY    Diagnost…           4 1.63e9 4385… I202… Elizabe…     202
#>  5 Dmitriy Akse… VT    Diagnost…           6 1.63e9 4385… I201… Elizabe…      33
#>  6 Vlada   Alex… NY    Pathology           3 1.95e9 5092… I201… Elizabe…     202
#>  7 Anel    Alex… NY    Emergenc…           6 1.72e9 3678… I201… Elizabe…     202
#>  8 Anel    Alex… NY    Emergenc…           6 1.72e9 3678… I201… Elizabe…     141
#>  9 Loren   Allen NY    Nurse Pr…           2 1.77e9 1658… I201… Elizabe…     202
#> 10 Nichol… Also… NY    Emergenc…           5 1.24e9 8628… I202… Elizabe…     202
#> # ℹ 388 more rows
#> # ℹ 3 more variables: org_pac <chr>, org_enid <chr>, org_state <chr>
```

The **Hospital Enrollment** API includes only Medicare Part A (hospital)
providers, so we only get two rows back, but those include a new data
point: two facility CCNs. Plugging those into the **Facility
Affiliations** API, we can retrieve information on the individual
providers practicing at this hospital. First, the all-numeric CCN
(`331302`):

``` r

x <- affiliations(ccn = 331302)
#> ✔ affiliations returned 329 results
#> ✔ Retrieving 1 page
#> Error in `httr2::req_perform()`:
#> ! HTTP 503 Service Unavailable.

list(
  organization = as.data.frame(t(unique(x[5:7]))),
  individual = unique(x[1:4]))
#> $organization
#>     V1
#> 1 <NA>
#> 
#> $individual
#> [1] "Elizabethtown Community Hospital" NA
```

That returns individual providers affiliated with the hospital. Now to
search the alphanumeric CCN (`33Z302`):

``` r

x <- affiliations(ccn = "33Z302")
#> Error in `httr2::req_perform()`:
#> ! HTTP 503 Service Unavailable.

list(
  organization = as.data.frame(t(unique(x[5:7]))), 
  individual = unique(x[1:4]))
#> $organization
#>     V1
#> 1 <NA>
#> 
#> $individual
#> [1] "Elizabethtown Community Hospital" NA
```

That returns more affiliated individual providers that practice in the
Hospital’s nursing home.

> An *alphanumeric* CCN represents a `sub-unit` of the hospital, here a
> nursing home. We would get the same result if we’d set the
> `parent_ccn` argument to the numeric CCN,
> i.e. `affiliations(parent_ccn = 331302)`
