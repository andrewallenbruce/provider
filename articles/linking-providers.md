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
#> ✔ hospitals returned 5 results
#> ✔ Retrieving 1 page
#> Error in `collapse::recode_char()`:
#> ! X needs to be character or a list
x
#> # A tibble: 5 × 7
#>   first last         npi pac        fac_type fac_ccn parent_ccn
#>   <chr> <chr>      <int> <chr>      <chr>    <chr>   <chr>     
#> 1 MARK  FUNG  1043245657 7810891009 Hospital 470003  NA        
#> 2 MARK  FUNG  1043245657 7810891009 Hospital 330250  NA        
#> 3 MARK  FUNG  1043245657 7810891009 Hospital 470001  NA        
#> 4 MARK  FUNG  1043245657 7810891009 Hospital 471307  NA        
#> 5 MARK  FUNG  1043245657 7810891009 Hospital 331321  NA

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
#>  $ grad_year: int 1999
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
#> hospitls [2 × 16] (S3: hospitals/tbl_df/tbl/data.frame)
#>  $ org_name : chr [1:2] "ELIZABETHTOWN COMMUNITY HOSPITAL" "ELIZABETHTOWN COMMUNITY HOSPITAL"
#>  $ org_dba  : chr [1:2] NA NA
#>  $ enid     : chr [1:2] "O20101110000259" "O20220827000145"
#>  $ npi      : chr [1:2] "1891785184" "1407061591"
#>  $ multi    : int [1:2] 1 0
#>  $ ccn      : chr [1:2] "331302" "33Z302"
#>  $ pac      : chr [1:2] "3577554138" "3577554138"
#>  $ inc_date : Date[1:2], format: "1926-05-08" "1926-05-08"
#>  $ org_type : chr [1:2] "Corporation" "Corporation"
#>  $ status   : chr [1:2] "Non-Profit" "Non-Profit"
#>  $ address  : chr [1:2] "75 PARK ST" "75 PARK ST"
#>  $ city     : chr [1:2] "ELIZABETHTOWN" "ELIZABETHTOWN"
#>  $ state    : chr [1:2] "NY" "NY"
#>  $ zip      : chr [1:2] "129322300" "129322300"
#>  $ loc_type : chr [1:2] "Other" "Other"
#>  $ sub_group: chr [1:2] "CAH" "CAH"

clinicians(org_name = x) |> str()
#> ✔ clinicians returned 78 results
#> ✔ Retrieving 1 page
#> clinicns [78 × 17] (S3: clinicians/tbl_df/tbl/data.frame)
#>  $ first    : chr [1:78] "GAVIN" "JOSEPH" "BENJAMIN" "DMITRIY" ...
#>  $ last     : chr [1:78] "NOBLE" "PEKALA" "SAWATZKY" "AKSELROD" ...
#>  $ gender   : chr [1:78] "M" "M" "M" "M" ...
#>  $ cred     : chr [1:78] "MD" "MD" "MD" "MD" ...
#>  $ school   : chr [1:78] "STATE UNIVERSITY OF NY UPSTATE MEDICAL UNIVERSITY" "OTHER" "TEMPLE UNIVERSITY SCHOOL OF MEDICINE" "STATE UNIVERSITY OF NY UPSTATE MEDICAL UNIVERSITY" ...
#>  $ grad_year: int [1:78] 1999 1999 2014 2007 2009 2009 1992 2023 2014 1996 ...
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
#> ✔ affiliations returned 329 results
#> ✔ Retrieving 1 page

list(
  organization = as.data.frame(t(unique(x[5:7]))),
  individual = unique(x[1:4]))
#> $organization
#>                  V1
#> fac_type   Hospital
#> fac_ccn      331302
#> parent_ccn     <NA>
#> 
#> $individual
#> # A tibble: 329 × 4
#>    first   last                  npi pac       
#>    <chr>   <chr>               <int> <chr>     
#>  1 STACI   CARTER-KELLY   1003029125 6204824378
#>  2 DYLAN   ESTES          1003278144 6608167523
#>  3 ARMIN   AFSAR KESHMIRI 1003815184 4082693676
#>  4 LAURA   GREENE         1003845272 1759384035
#>  5 DEBORAH KAMPSCHROR     1013141860 8022069558
#>  6 NAROD   VASSILIAN      1013539584 9133544109
#>  7 EMILY   TRIPLETT       1013595560 3375947401
#>  8 BARDIA  BARIMANI       1013793736 9436503646
#>  9 JOSE    ACOSTAMADIEDO  1013910256 5890719371
#> 10 LINDSEY WILHELM        1023377843 6901115278
#> # ℹ 319 more rows
```

That returns individual providers affiliated with the hospital. Now to
search the alphanumeric CCN (`33Z302`):

``` r

x <- affiliations(fac_ccn = "33Z302")
#> ✔ affiliations returned 6 results
#> ✔ Retrieving 1 page

list(
  organization = as.data.frame(t(unique(x[5:7]))), 
  individual = unique(x[1:4]))
#> $organization
#>                      V1
#> fac_type   Nursing home
#> fac_ccn          33Z302
#> parent_ccn       331302
#> 
#> $individual
#> # A tibble: 6 × 4
#>   first   last            npi pac       
#>   <chr>   <chr>         <int> <chr>     
#> 1 JEFFREY KLOTZ    1073258398 3870095805
#> 2 CARLOS  MARTINEZ 1154332062 5890739734
#> 3 MARY    HALLORAN 1396989059 8921259557
#> 4 IL      CHON     1538173869 0547299091
#> 5 DRAGOS  BANU     1558659367 6709004682
#> 6 JOSHUA  WARNER   1760167712 8123473469
```

That returns more affiliated individual providers that practice in the
Hospital’s nursing home.

> An *alphanumeric* CCN represents a `sub-unit` of the hospital, here a
> nursing home. We would get the same result if we’d set the
> `parent_ccn` argument to the numeric CCN,
> i.e. `affiliations(parent_ccn = 331302)`
