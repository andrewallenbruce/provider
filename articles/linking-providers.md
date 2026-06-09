# Linking Providers

``` r

library(provider)
```

#### Individual Provider

``` r

pac <- affiliations(pac = 7810891009)
#> ✔ affiliations returned 5 results.
pac <- list(
  individual = as.data.frame(t(unique(pac[1:4]))),
  organization = pac[5:6])
pac
#> $individual
#>               V1
#> first       MARK
#> last        FUNG
#> npi   1043245657
#> pac   7810891009
#> 
#> $organization
#> # A tibble: 5 × 2
#>   prov_type prov_ccn
#>   <chr>     <chr>   
#> 1 Hospital  470003  
#> 2 Hospital  330250  
#> 3 Hospital  470001  
#> 4 Hospital  331321  
#> 5 Hospital  471307

ccn <- hospitals(ccn = pac$prov_ccn)
#> ✔ Returning first 10 rows
pac$organization <- ccn
pac |> str()
#> List of 2
#>  $ individual  :'data.frame':    4 obs. of  1 variable:
#>   ..$ V1: chr [1:4] "MARK" "FUNG" "1043245657" "7810891009"
#>  $ organization: hospitls [10 × 18] (S3: hospitals/tbl_df/tbl/data.frame)
#>   ..$ org_name : chr [1:10] "SOUTHERN TENNESSEE MEDICAL CENTER LLC" "CENTRAL MAINE MEDICAL CENTER" "ADCARE HOSPITAL OF WORCESTER, INC" "CAPE COD HOSPITAL INC" ...
#>   ..$ org_dba  : chr [1:10] "HIGHPOINT HEALTH - WINCHESTER WITH ASCENSION SAINT THOMAS" NA "ADCARE HOSPITAL OF WORCESTER" "CAPE COD HOSPITAL" ...
#>   ..$ enid     : chr [1:10] "O20020812000015" "O20020814000009" "O20020815000027" "O20020821000019" ...
#>   ..$ npi      : int [1:10] 1467408781 1689653487 1134281280 1114984671 1205807013 1588664007 1942392600 1164481529 1083609150 1396745832
#>   ..$ multi    : int [1:10] 0 0 0 0 0 0 0 0 0 0
#>   ..$ ccn      : chr [1:10] "440058" "200024" "220062" "220012" ...
#>   ..$ pac      : chr [1:10] "5193632180" "2567379563" "8325955347" "8921915950" ...
#>   ..$ inc_date : Date[1:10], format: "1998-11-09" "1888-01-01" ...
#>   ..$ org_type : chr [1:10] "LLC" "CORPORATION" "CORPORATION" "CORPORATION" ...
#>   ..$ status   : chr [1:10] "For-Profit" "Non-Profit" "For-Profit" "Non-Profit" ...
#>   ..$ address  : chr [1:10] "185 HOSPITAL RD" "300 MAIN ST" "107 LINCOLN ST" "27 PARK STREET, CAPE COD HOSPITAL" ...
#>   ..$ city     : chr [1:10] "WINCHESTER" "LEWISTON" "WORCESTER" "HYANNIS" ...
#>   ..$ state    : chr [1:10] "TN" "ME" "MA" "MA" ...
#>   ..$ zip      : chr [1:10] "373982404" "42407027" "16052401" "26015230" ...
#>   ..$ loc_type : chr [1:10] "Primary" "Other" "Primary" "Other" ...
#>   ..$ reh_date : Date[1:10], format: NA NA ...
#>   ..$ prov_type: chr [1:10] NA NA NA NA ...
#>   ..$ sub_group: chr [1:10] "Acute, General, IRF" "General" "Acute, General" "General, Psych" ...
```

#### Organizational Provider

``` r

x <- "Elizabethtown Community Hospital"

providers(org_name = x)
#> ✔ providers returned 8 results.
#> # A tibble: 8 × 10
#>   org_name        first last  state prov_type prov_desc    npi multi pac   enid 
#>   <chr>           <chr> <chr> <chr> <chr>     <chr>      <int> <int> <chr> <chr>
#> 1 ELIZABETHTOWN … NA    NA    CT    12-70     PART B S… 1.05e9     0 3577… O202…
#> 2 ELIZABETHTOWN … NA    NA    FL    12-70     PART B S… 1.05e9     0 3577… O202…
#> 3 ELIZABETHTOWN … NA    NA    VT    12-70     PART B S… 1.05e9     0 3577… O202…
#> 4 ELIZABETHTOWN … NA    NA    NH    12-70     PART B S… 1.05e9     0 3577… O202…
#> 5 ELIZABETHTOWN … NA    NA    CO    12-70     PART B S… 1.05e9     0 3577… O202…
#> 6 ELIZABETHTOWN … NA    NA    NY    12-70     PART B S… 1.05e9     1 3577… O200…
#> 7 ELIZABETHTOWN … NA    NA    NY    00-85     PART A P… 1.41e9     0 3577… O202…
#> 8 ELIZABETHTOWN … NA    NA    NY    00-85     PART A P… 1.89e9     1 3577… O201…

hospitals(org_name = x) |> str()
#> ✔ hospitals returned 2 results.
#> hospitls [2 × 18] (S3: hospitals/tbl_df/tbl/data.frame)
#>  $ org_name : chr [1:2] "ELIZABETHTOWN COMMUNITY HOSPITAL" "ELIZABETHTOWN COMMUNITY HOSPITAL"
#>  $ org_dba  : chr [1:2] NA NA
#>  $ enid     : chr [1:2] "O20101110000259" "O20220827000145"
#>  $ npi      : int [1:2] 1891785184 1407061591
#>  $ multi    : int [1:2] 1 0
#>  $ ccn      : chr [1:2] "331302" "33Z302"
#>  $ pac      : chr [1:2] "3577554138" "3577554138"
#>  $ inc_date : Date[1:2], format: "1926-05-08" "1926-05-08"
#>  $ org_type : chr [1:2] "CORPORATION" "CORPORATION"
#>  $ status   : chr [1:2] "Non-Profit" "Non-Profit"
#>  $ address  : chr [1:2] "75 PARK ST" "75 PARK ST"
#>  $ city     : chr [1:2] "ELIZABETHTOWN" "ELIZABETHTOWN"
#>  $ state    : chr [1:2] "NY" "NY"
#>  $ zip      : chr [1:2] "129322300" "129322300"
#>  $ loc_type : chr [1:2] "Other" "Other"
#>  $ reh_date : Date[1:2], format: NA NA
#>  $ prov_type: chr [1:2] "CAH" "CAH"
#>  $ sub_group: chr [1:2] NA NA

clinicians(org_name = x) |> str()
#> ✔ clinicians returned 77 results.
#> clinicns [77 × 17] (S3: clinicians/tbl_df/tbl/data.frame)
#>  $ first    : chr [1:77] "GAVIN" "JOSEPH" "DMITRIY" "ROBERT" ...
#>  $ last     : chr [1:77] "NOBLE" "PEKALA" "AKSELROD" "PERCARPIO" ...
#>  $ gender   : chr [1:77] "M" "M" "M" "M" ...
#>  $ cred     : chr [1:77] "MD" "MD" "MD" "MD" ...
#>  $ school   : chr [1:77] "STATE UNIVERSITY OF NY UPSTATE MEDICAL UNIVERSITY" "GEISEL SCHOOL OF MEDICINE AT DARTMOUTH" "STATE UNIVERSITY OF NY UPSTATE MEDICAL UNIVERSITY" "NEW YORK MEDICAL COLLEGE" ...
#>  $ grad_year: int [1:77] 1999 1999 2007 2009 2009 1992 2023 2014 1996 2012 ...
#>  $ specialty: chr [1:77] "CARDIOVASCULAR DISEASE (CARDIOLOGY), INTERNAL MEDICINE" "DIAGNOSTIC RADIOLOGY" "DIAGNOSTIC RADIOLOGY" "INTERVENTIONAL RADIOLOGY" ...
#>  $ npi      : int [1:77] 1750335014 1366468951 1629241336 1356579171 1770725467 1154411882 1760167712 1922491349 1871698019 1033478565 ...
#>  $ pac      : chr [1:77] "6002861804" "3274579073" "4385805696" "5991948382" ...
#>  $ enid     : chr [1:77] "I20200824000234" "I20050701000411" "I20170524000768" "I20230928000333" ...
#>  $ org_name : chr [1:77] "ELIZABETHTOWN COMMUNITY HOSPITAL" "ELIZABETHTOWN COMMUNITY HOSPITAL" "ELIZABETHTOWN COMMUNITY HOSPITAL" "ELIZABETHTOWN COMMUNITY HOSPITAL" ...
#>  $ org_pac  : chr [1:77] "3577554138" "3577554138" "3577554138" "3577554138" ...
#>  $ members  : int [1:77] 54 54 54 54 54 54 54 54 54 54 ...
#>  $ address  : chr [1:77] "101 ADIRONDACK DR, SUITE 1" "108 PRESTON RD" "1355 CHURCH HILL RD" "1437 N RD" ...
#>  $ city     : chr [1:77] "TICONDEROGA" "LYME" "CHARLOTTE" "HINESBURG" ...
#>  $ state    : chr [1:77] "NY" "NH" "VT" "VT" ...
#>  $ zip      : chr [1:77] "128839334" "037683508" "054459594" "054619697" ...

reassignments(org_name = x)
#> ✔ reassignments returned 398 results.
#> # A tibble: 398 × 13
#>    first   last  state specialty employers    npi pac   enid  org_name employees
#>    <chr>   <chr> <chr> <chr>         <int>  <int> <chr> <chr> <chr>        <int>
#>  1 Nathal… Abis… NY    Family P…         1 1.34e9 5294… I202… Elizabe…       202
#>  2 Jose    Acos… NY    Medical …         5 1.01e9 5890… I201… Elizabe…       202
#>  3 Jose    Acos… NY    Medical …         5 1.01e9 5890… I201… Elizabe…       141
#>  4 Dmitriy Akse… NY    Diagnost…         4 1.63e9 4385… I202… Elizabe…       202
#>  5 Dmitriy Akse… VT    Diagnost…         6 1.63e9 4385… I201… Elizabe…        33
#>  6 Vlada   Alex… NY    Pathology         3 1.95e9 5092… I201… Elizabe…       202
#>  7 Anel    Alex… NY    Emergenc…         6 1.72e9 3678… I201… Elizabe…       202
#>  8 Anel    Alex… NY    Emergenc…         6 1.72e9 3678… I201… Elizabe…       141
#>  9 Loren   Allen NY    Nurse Pr…         2 1.77e9 1658… I201… Elizabe…       202
#> 10 Nichol… Also… NY    Emergenc…         5 1.24e9 8628… I202… Elizabe…       202
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

ccn <- affiliations(facility_ccn = 331302)
#> ✔ affiliations returned 334 results.

list(
  organization = as.data.frame(t(unique(ccn[5:7]))),
  individual = unique(ccn[1:4]))
#> $organization
#>                  V1
#> prov_type  Hospital
#> prov_ccn     331302
#> parent_ccn     <NA>
#> 
#> $individual
#> # A tibble: 334 × 4
#>    first   last                  npi pac       
#>    <chr>   <chr>               <int> <chr>     
#>  1 STACI   CARTER-KELLY   1003029125 6204824378
#>  2 DYLAN   ESTES          1003278144 6608167523
#>  3 ANA     MORALES MEJIA  1003421496 6103287404
#>  4 ARMIN   AFSAR KESHMIRI 1003815184 4082693676
#>  5 LAURA   GREENE         1003845272 1759384035
#>  6 DEBORAH KAMPSCHROR     1013141860 8022069558
#>  7 NAROD   VASSILIAN      1013539584 9133544109
#>  8 EMILY   TRIPLETT       1013595560 3375947401
#>  9 BARDIA  BARIMANI       1013793736 9436503646
#> 10 JOSE    ACOSTAMADIEDO  1013910256 5890719371
#> # ℹ 324 more rows
```

That returns individual providers affiliated with the hospital. Now to
search the alphanumeric CCN (`33Z302`):

``` r

ccn2 <- affiliations(facility_ccn = "33Z302")
#> ✔ affiliations returned 6 results.

list(
  organization = as.data.frame(t(unique(ccn2[5:7]))), 
  individual = unique(ccn2[1:4]))
#> $organization
#>                      V1
#> prov_type  Nursing home
#> prov_ccn         33Z302
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
