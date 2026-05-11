# Linking Providers

``` r

library(provider)
```

> NPIs, PACs, ENIDs, CCNs, CLIAs and Many More

#### Individual Provider

``` r

pac <- affiliations(pac = 7810891009)
#> ✔ affiliations returned 5 results.
list(
  individual = as.data.frame(t(unique(pac[1:6]))),
  organization = pac[7:9])
#> Error in `pac[7:9]`:
#> ! Can't subset columns past the end.
#> ℹ Location 9 doesn't exist.
#> ℹ There are only 8 columns.
```

``` r

ccn <- hospitals(ccn = pac$facility_ccn)
#> Warning: Unknown or uninitialised column: `facility_ccn`.
#> hospitals Totals
#> • Rows  : 9,182
#> • Pages : 2
#> 
#> ! No Query ❯ Returning first 10 rows.
#> 
ccn |> str()
#> hospitls [10 × 17] (S3: hospitals/tbl_df/tbl/data.frame)
#>  $ org_name: chr [1:10] "SOUTHERN TENNESSEE MEDICAL CENTER LLC" "CENTRAL MAINE MEDICAL CENTER" "ADCARE HOSPITAL OF WORCESTER, INC" "CAPE COD HOSPITAL INC" ...
#>  $ org_dba : chr [1:10] "HIGHPOINT HEALTH - WINCHESTER WITH ASCENSION SAINT THOMAS" NA "ADCARE HOSPITAL OF WORCESTER" "CAPE COD HOSPITAL" ...
#>  $ enid    : chr [1:10] "O20020812000015" "O20020814000009" "O20020815000027" "O20020821000019" ...
#>  $ npi     : int [1:10] 1467408781 1689653487 1134281280 1114984671 1205807013 1588664007 1942392600 1164481529 1083609150 1396745832
#>  $ multi   : int [1:10] 0 0 0 0 0 0 0 0 0 0
#>  $ ccn     : chr [1:10] "440058" "200024" "220062" "220012" ...
#>  $ pac     : chr [1:10] "5193632180" "2567379563" "8325955347" "8921915950" ...
#>  $ inc_date: Date[1:10], format: "1998-11-09" "1888-01-01" ...
#>  $ org_type: chr [1:10] "LLC" "CORPORATION" "CORPORATION" "CORPORATION" ...
#>  $ status  : chr [1:10] "P" "N" "P" "N" ...
#>  $ address : chr [1:10] "185 HOSPITAL RD" "300 MAIN ST" "107 LINCOLN ST" "CAPE COD HOSPITAL" ...
#>  $ city    : chr [1:10] "WINCHESTER" "LEWISTON" "WORCESTER" "HYANNIS" ...
#>  $ state   : chr [1:10] "TN" "ME" "MA" "MA" ...
#>  $ zip     : chr [1:10] "373982404" "42407027" "16052401" "26015230" ...
#>  $ loc_type: chr [1:10] "MAIN/PRIMARY HOSPITAL LOCATION" "OTHER HOSPITAL PRACTICE LOCATION" "MAIN/PRIMARY HOSPITAL LOCATION" "OTHER HOSPITAL PRACTICE LOCATION" ...
#>  $ reh_date: Date[1:10], format: NA NA ...
#>  $ subgroup: chr [1:10] "Acute, General, IRF" "General" "Acute, General" "General, Psych" ...
```

#### Organizational Provider

Exploring links between providers can lead to many interesting insights.
For example, there is a hospital in New York named **Elizabethtown
Community Hospital**.

``` r

providers(org_name = "Elizabethtown Community Hospital")
#> ✔ providers returned 8 results.
#> # A tibble: 8 × 11
#>   org_name first middle last  state prov_type prov_desc    npi multi pac   enid 
#>   <chr>    <chr> <chr>  <chr> <chr> <chr>     <chr>      <int> <int> <chr> <chr>
#> 1 ELIZABE… NA    NA     NA    CT    12-70     PART B S… 1.05e9     0 3577… O202…
#> 2 ELIZABE… NA    NA     NA    FL    12-70     PART B S… 1.05e9     0 3577… O202…
#> 3 ELIZABE… NA    NA     NA    VT    12-70     PART B S… 1.05e9     0 3577… O202…
#> 4 ELIZABE… NA    NA     NA    NH    12-70     PART B S… 1.05e9     0 3577… O202…
#> 5 ELIZABE… NA    NA     NA    CO    12-70     PART B S… 1.05e9     0 3577… O202…
#> 6 ELIZABE… NA    NA     NA    NY    12-70     PART B S… 1.05e9     1 3577… O200…
#> 7 ELIZABE… NA    NA     NA    NY    00-85     PART A P… 1.41e9     0 3577… O202…
#> 8 ELIZABE… NA    NA     NA    NY    00-85     PART A P… 1.89e9     1 3577… O201…
hospitals(org_name = "Elizabethtown Community Hospital")
#> ✔ hospitals returned 2 results.
#> # A tibble: 2 × 17
#>   org_name     org_dba enid     npi multi ccn   pac   inc_date   org_type status
#> * <chr>        <chr>   <chr>  <int> <int> <chr> <chr> <date>     <chr>    <chr> 
#> 1 ELIZABETHTO… NA      O201… 1.89e9     1 3313… 3577… 1926-05-08 CORPORA… N     
#> 2 ELIZABETHTO… NA      O202… 1.41e9     0 33Z3… 3577… 1926-05-08 CORPORA… N     
#> # ℹ 7 more variables: address <chr>, city <chr>, state <chr>, zip <chr>,
#> #   loc_type <chr>, reh_date <date>, subgroup <chr>
clinicians(org_name = "Elizabethtown Community Hospital")
#> ✔ clinicians returned 58 results.
#> # A tibble: 58 × 18
#>    first middle last  gender cred  school grad_year specialty    npi pac   enid 
#>    <chr> <chr>  <chr> <chr>  <chr> <chr>      <int> <chr>      <int> <chr> <chr>
#>  1 GAVIN L      NOBLE M      MD    STATE…      1999 INTERNAL… 1.75e9 6002… I202…
#>  2 DMIT… G      AKSE… M      MD    STATE…      2007 DIAGNOST… 1.63e9 4385… I201…
#>  3 ROBE… NA     PERC… M      MD    NEW Y…      2009 INTERVEN… 1.36e9 5991… I202…
#>  4 BENJ… NA     LANGE M      MD    HARVA…      2009 INTERVEN… 1.77e9 2365… I201…
#>  5 BENJ… NA     BAMF… M      MD    UNIVE…      1992 DIAGNOST… 1.15e9 9638… I201…
#>  6 JOSH… NA     WARN… F      NP    OTHER       2023 NURSE PR… 1.76e9 8123… I202…
#>  7 DAGM… NA     HOEG… F      MD    OTHER       1996 DIAGNOST… 1.87e9 4880… I200…
#>  8 CARLY J      SLEE… F      NA    ALBAN…      2012 PHYSICIA… 1.66e9 8921… I201…
#>  9 ROB   L      DEMU… M      MD    STATE…      1996 INTERNAL… 1.80e9 3577… I200…
#> 10 JAMES E      EAST  M      MD    OTHER       2016 DIAGNOST… 1.95e9 2961… I202…
#> # ℹ 48 more rows
#> # ℹ 7 more variables: org_name <chr>, org_pac <chr>, members <int>,
#> #   address <chr>, city <chr>, state <chr>, zip <chr>
reassignments(org_name = "Elizabethtown Community Hospital")
#> ✔ reassignments returned 380 results.
#> # A tibble: 380 × 13
#>    first   last  state specialty employers    npi pac   enid  org_name employees
#>    <chr>   <chr> <chr> <chr>         <int>  <int> <chr> <chr> <chr>        <int>
#>  1 Nathal… Abis… NY    Family P…         1 1.34e9 5294… I202… Elizabe…       196
#>  2 Jose    Acos… NY    Medical …         5 1.01e9 5890… I201… Elizabe…       196
#>  3 Jose    Acos… NY    Medical …         5 1.01e9 5890… I201… Elizabe…       129
#>  4 Dmitriy Akse… NY    Diagnost…         4 1.63e9 4385… I202… Elizabe…       196
#>  5 Dmitriy Akse… VT    Diagnost…         6 1.63e9 4385… I201… Elizabe…        33
#>  6 Vlada   Alex… NY    Pathology         3 1.95e9 5092… I201… Elizabe…       196
#>  7 Anel    Alex… NY    Emergenc…         6 1.72e9 3678… I201… Elizabe…       196
#>  8 Anel    Alex… NY    Emergenc…         6 1.72e9 3678… I201… Elizabe…       129
#>  9 Loren   Allen NY    Nurse Pr…         2 1.77e9 1658… I201… Elizabe…       196
#> 10 Nichol… Also… NY    Emergenc…         5 1.24e9 8628… I202… Elizabe…       196
#> # ℹ 370 more rows
#> # ℹ 3 more variables: org_pac <chr>, org_enid <chr>, org_state <chr>
```

The **Hospital Enrollment** API includes only Medicare Part A (hospital)
providers, so we only get two rows back, but those include a new data
point: two facility CCNs. Plugging those into the **Facility
Affiliations** API, we can retrieve information on the individual
providers practicing at this hospital. First, the all-numeric CCN
(`331302`):

``` r

ccn <- affiliations(facility_ccn = 331302)
#> ✔ affiliations returned 206 results.
list(
  organization = as.data.frame(t(unique(ccn[7:9]))),
  individual = unique(ccn[1:6]))
#> Error in `ccn[7:9]`:
#> ! Can't subset columns past the end.
#> ℹ Location 9 doesn't exist.
#> ℹ There are only 8 columns.
```

That returns individual providers affiliated with the hospital. Now to
search the alphanumeric CCN (`33Z302`):

``` r

ccn2 <- affiliations(facility_ccn = "33Z302")
#> ✔ affiliations returned 4 results.
list(
  organization = as.data.frame(t(unique(ccn2[7:9]))), 
  individual = unique(ccn2[1:6]))
#> Error in `ccn2[7:9]`:
#> ! Can't subset columns past the end.
#> ℹ Location 9 doesn't exist.
#> ℹ There are only 8 columns.
```

That returns more affiliated individual providers that practice in the
Hospital’s nursing home.

> An *alphanumeric* CCN represents a `sub-unit` of the hospital, here a
> nursing home. We would get the same result if we’d set the
> `parent_ccn` argument to the numeric CCN,
> i.e. `affiliations(parent_ccn = 331302)`
