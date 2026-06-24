# Linking Providers

``` r

library(provider)
```

#### Individual Provider

``` r

x <- affiliations(pac = 7810891009)
#> ✔ affiliations returned 5 results
#> ✔ Retrieving 1 page
x <- list(
  individual = as.data.frame(t(unique(x[1:4]))),
  organization = hospitals(ccn = x$fac_ccn))
#> Warning: Unknown or uninitialised column: `fac_ccn`.
#> ✔ Returning first 10 rows
#> ✔ hospitals2 returned 9 results
#> ✔ Retrieving 1 page
x
#> $individual
#>               V1
#> first       MARK
#> last        FUNG
#> npi   1043245657
#> pac   7810891009
#> 
#> $organization
#> # A tibble: 10 × 18
#>    org_name    org_dba enid     npi multi ccn   pac   inc_date   org_type status
#>    <chr>       <chr>   <chr>  <int> <int> <chr> <chr> <date>     <chr>    <chr> 
#>  1 SOUTHERN T… HIGHPO… O200… 1.47e9     0 4400… 5193… 1998-11-09 LLC      Propr…
#>  2 CENTRAL MA… NA      O200… 1.69e9     0 2000… 2567… 1888-01-01 Corpora… Volun…
#>  3 ADCARE HOS… ADCARE… O200… 1.13e9     0 2200… 8325… NA         Corpora… Propr…
#>  4 CAPE COD H… CAPE C… O200… 1.11e9     0 2200… 8921… 1919-08-22 Corpora… Volun…
#>  5 CARRINGTON… CHI ST… O200… 1.21e9     0 3513… 0547… 1986-06-30 Corpora… Volun…
#>  6 SELECT SPE… SELECT… O200… 1.59e9     0 1120… 6002… 2001-12-05 Corpora… For-P…
#>  7 THE FINLEY… FINLEY… O200… 1.94e9     0 1601… 5092… NA         Corpora… Volun…
#>  8 ST CHARLES… NA      O200… 1.16e9     0 3302… 6103… 1958-09-30 Corpora… Volun…
#>  9 WASHINGTON… NA      O200… 1.08e9     0 0400… 7214… NA         Other: … Volun…
#> 10 ARIZONA SP… NA      O200… 1.40e9     0 0301… 4486… 2000-10-26 LLC      Physi…
#> # ℹ 8 more variables: address <chr>, city <chr>, state <chr>, zip <chr>,
#> #   loc_type <chr>, sub_group <chr>, rating <int>, county <chr>

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
#> ✔ clinicians returned 1 result
#> ✔ Retrieving 1 page
#> clinicns [1 × 17] (S3: clinicians/tbl_df/tbl/data.frame)
#>  $ first    : chr "MARK"
#>  $ last     : chr "FUNG"
#>  $ gender   : chr "M"
#>  $ cred     : chr "MD"
#>  $ school   : chr "UNIVERSITY OF ALABAMA SCHOOL OF MEDICINE"
#>  $ year     : int 1999
#>  $ specialty: chr "PATHOLOGY"
#>  $ npi      : int 1043245657
#>  $ pac      : chr "7810891009"
#>  $ enid     : chr "I20031120000251"
#>  $ org_name : chr "UNIVERSITY OF VERMONT MEDICAL CENTER INC"
#>  $ org_pac  : chr "3779491071"
#>  $ members  : int 1194
#>  $ address  : chr "111 COLCHESTER AVE"
#>  $ city     : chr "BURLINGTON"
#>  $ state    : chr "VT"
#>  $ zip      : chr "054011473"
```

#### Organizational Provider

``` r

x <- "Elizabethtown Community Hospital"

hospitals(org_name = x) |> str()
#> ✔ hospitals returned 2 results
#> ✔ Retrieving 1 page
#> ✔ hospitals2 returned 1 result
#> ✔ Retrieving 1 page
#> hospitls [2 × 18] (S3: hospitals/tbl_df/tbl/data.frame)
#>  $ org_name : chr [1:2] "ELIZABETHTOWN COMMUNITY HOSPITAL" "ELIZABETHTOWN COMMUNITY HOSPITAL"
#>  $ org_dba  : chr [1:2] NA NA
#>  $ enid     : chr [1:2] "O20101110000259" "O20220827000145"
#>  $ npi      : int [1:2] 1891785184 1407061591
#>  $ multi    : int [1:2] 1 0
#>  $ ccn      : chr [1:2] "331302" "33Z302"
#>  $ pac      : chr [1:2] "3577554138" "3577554138"
#>  $ inc_date : Date[1:2], format: "1926-05-08" "1926-05-08"
#>  $ org_type : chr [1:2] "Corporation" "Corporation"
#>  $ status   : chr [1:2] "Voluntary non-profit - Private" "Non-Profit"
#>  $ address  : chr [1:2] "75 PARK ST" "75 PARK ST"
#>  $ city     : chr [1:2] "ELIZABETHTOWN" "ELIZABETHTOWN"
#>  $ state    : chr [1:2] "NY" "NY"
#>  $ zip      : chr [1:2] "129322300" "129322300"
#>  $ loc_type : chr [1:2] "Other" "Other"
#>  $ sub_group: chr [1:2] "CAH" "CAH"
#>  $ rating   : int [1:2] 4 NA
#>  $ county   : chr [1:2] "ESSEX" NA

clinicians(org_name = x) |> str()
#> ✔ clinicians returned 78 results
#> ✔ Retrieving 1 page
#> clinicns [78 × 17] (S3: clinicians/tbl_df/tbl/data.frame)
#>  $ first    : chr [1:78] "GAVIN" "JOSEPH" "BENJAMIN" "DMITRIY" ...
#>  $ last     : chr [1:78] "NOBLE" "PEKALA" "SAWATZKY" "AKSELROD" ...
#>  $ gender   : chr [1:78] "M" "M" "M" "M" ...
#>  $ cred     : chr [1:78] "MD" "MD" "MD" "MD" ...
#>  $ school   : chr [1:78] "STATE UNIVERSITY OF NY UPSTATE MEDICAL UNIVERSITY" "OTHER" "TEMPLE UNIVERSITY SCHOOL OF MEDICINE" "STATE UNIVERSITY OF NY UPSTATE MEDICAL UNIVERSITY" ...
#>  $ year     : int [1:78] 1999 1999 2014 2007 2009 2009 1992 2023 2014 1996 ...
#>  $ specialty: chr [1:78] "CARDIOVASCULAR DISEASE (CARDIOLOGY), INTERNAL MEDICINE" "DIAGNOSTIC RADIOLOGY" "DIAGNOSTIC RADIOLOGY" "DIAGNOSTIC RADIOLOGY" ...
#>  $ npi      : int [1:78] 1750335014 1366468951 1235549247 1629241336 1356579171 1770725467 1154411882 1760167712 1922491349 1871698019 ...
#>  $ pac      : chr [1:78] "6002861804" "3274579073" "0345559357" "4385805696" ...
#>  $ enid     : chr [1:78] "I20200824000234" "I20050701000411" "I20200715002569" "I20170524000768" ...
#>  $ org_name : chr [1:78] "ELIZABETHTOWN COMMUNITY HOSPITAL" "ELIZABETHTOWN COMMUNITY HOSPITAL" "ELIZABETHTOWN COMMUNITY HOSPITAL" "ELIZABETHTOWN COMMUNITY HOSPITAL" ...
#>  $ org_pac  : chr [1:78] "3577554138" "3577554138" "3577554138" "3577554138" ...
#>  $ members  : int [1:78] 54 54 54 54 54 54 54 54 54 54 ...
#>  $ address  : chr [1:78] "101 ADIRONDACK DR, SUITE 1" "108 PRESTON RD" "119 BRADLEY LN" "1355 CHURCH HILL RD" ...
#>  $ city     : chr [1:78] "TICONDEROGA" "LYME" "WILLISTON" "CHARLOTTE" ...
#>  $ state    : chr [1:78] "NY" "NH" "VT" "VT" ...
#>  $ zip      : chr [1:78] "128839334" "037683508" "054957007" "054459594" ...

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

x <- affiliations(fac_ccn = 331302)
#> Error in `affiliations()`:
#> ! unused argument (fac_ccn = 331302)

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

x <- affiliations(fac_ccn = "33Z302")
#> Error in `affiliations()`:
#> ! unused argument (fac_ccn = "33Z302")

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
