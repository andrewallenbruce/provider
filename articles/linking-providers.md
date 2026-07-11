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
  organization = hospital(ccn = x$ccn))
#> ✔ hospital returned 5 results
#> ✔ Retrieving 1 page
#> ✔ hospital2 returned 5 results
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
#> # A tibble: 5 × 18
#>   org_name     org_dba ccn      npi pac   enid  multi inc_date   org_type status
#>   <chr>        <chr>   <chr>  <int> <chr> <chr> <int> <date>     <chr>    <chr> 
#> 1 CHAMPLAIN V… THE UN… 3302… 1.03e9 2769… O201…     0 1926-01-01 Corpora… Volun…
#> 2 ALICE HYDE … THE UN… 3313… 1.11e9 4082… O202…     0 1905-04-13 Corpora… Volun…
#> 3 CENTRAL VER… NA      4700… 1.51e9 9335… O200…     0 1984-03-01 Corpora… Volun…
#> 4 UNIVERSITY … UNIVER… 4700… 1.57e9 3779… O200…     0 1995-01-01 Corpora… Volun…
#> 5 PORTER HOSP… NA      4713… 1.74e9 1850… O200…     1 1986-11-14 Corpora… Volun…
#> # ℹ 8 more variables: address <chr>, city <chr>, state <chr>, zip <chr>,
#> #   loc_type <chr>, sub_group <chr>, rating <int>, county <chr>

reassigned(pac = 7810891009) |> str()
#> ✔ reassigned returned 1 result
#> ✔ Retrieving 1 page
#> reassgnd [1 × 13] (S3: reassigned/tbl_df/tbl/data.frame)
#>  $ npi        : int 1043245657
#>  $ pac        : chr "7810891009"
#>  $ enid       : chr "I20031120000251"
#>  $ first      : chr "Mark"
#>  $ last       : chr "Fung"
#>  $ state      : chr "VT"
#>  $ specialty  : chr "Pathology"
#>  $ memberships: int 1
#>  $ org_pac    : chr "3779491071"
#>  $ org_enid   : chr "O20040406001047"
#>  $ org_name   : chr "University Of Vermont Medical Center Inc"
#>  $ members    : int 1585
#>  $ org_state  : chr "VT"

clinician(pac = 7810891009) |> str()
#> ✔ clinician returned 1 result
#> ✔ Retrieving 1 page
#> clinicin [1 × 17] (S3: clinician/tbl_df/tbl/data.frame)
#>  $ npi      : int 1043245657
#>  $ pac      : chr "7810891009"
#>  $ enid     : chr "I20031120000251"
#>  $ first    : chr "MARK"
#>  $ last     : chr "FUNG"
#>  $ gender   : chr "M"
#>  $ cred     : chr "MD"
#>  $ school   : chr "UNIVERSITY OF ALABAMA SCHOOL OF MEDICINE"
#>  $ year     : int 1999
#>  $ specialty: chr "PATHOLOGY"
#>  $ org_name : chr "UNIVERSITY OF VERMONT MEDICAL CENTER INC"
#>  $ org_pac  : chr "3779491071"
#>  $ members  : int 1197
#>  $ address  : chr "111 COLCHESTER AVE"
#>  $ city     : chr "BURLINGTON"
#>  $ state    : chr "VT"
#>  $ zip      : chr "054011473"
```

#### Organizational Provider

``` r

x <- "Elizabethtown Community Hospital"

hospital(org_name = x) |> str()
#> ✔ hospital returned 2 results
#> ✔ Retrieving 1 page
#> ✔ hospital2 returned 1 result
#> ✔ Retrieving 1 page
#> hospital [2 × 18] (S3: hospital/tbl_df/tbl/data.frame)
#>  $ org_name : chr [1:2] "ELIZABETHTOWN COMMUNITY HOSPITAL" "ELIZABETHTOWN COMMUNITY HOSPITAL"
#>  $ org_dba  : chr [1:2] NA NA
#>  $ ccn      : chr [1:2] "331302" "33Z302"
#>  $ npi      : int [1:2] 1891785184 1407061591
#>  $ pac      : chr [1:2] "3577554138" "3577554138"
#>  $ enid     : chr [1:2] "O20101110000259" "O20220827000145"
#>  $ multi    : int [1:2] 1 0
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

clinician(org_name = x) |> str()
#> ✔ clinician returned 85 results
#> ✔ Retrieving 1 page
#> clinicin [85 × 17] (S3: clinician/tbl_df/tbl/data.frame)
#>  $ npi      : int [1:85] 1750335014 1366468951 1235549247 1629241336 1356579171 1770725467 1154411882 1275762551 1760167712 1922491349 ...
#>  $ pac      : chr [1:85] "6002861804" "3274579073" "0345559357" "4385805696" ...
#>  $ enid     : chr [1:85] "I20200824000234" "I20050701000411" "I20200715002569" "I20170524000768" ...
#>  $ first    : chr [1:85] "GAVIN" "JOSEPH" "BENJAMIN" "DMITRIY" ...
#>  $ last     : chr [1:85] "NOBLE" "PEKALA" "SAWATZKY" "AKSELROD" ...
#>  $ gender   : chr [1:85] "M" "M" "M" "M" ...
#>  $ cred     : chr [1:85] "MD" "MD" "MD" "MD" ...
#>  $ school   : chr [1:85] "STATE UNIVERSITY OF NY UPSTATE MEDICAL UNIVERSITY" "OTHER" "TEMPLE UNIVERSITY SCHOOL OF MEDICINE" "STATE UNIVERSITY OF NY UPSTATE MEDICAL UNIVERSITY" ...
#>  $ year     : int [1:85] 1999 1999 2014 2007 2009 2009 1992 2009 2023 2014 ...
#>  $ specialty: chr [1:85] "CARDIOVASCULAR DISEASE (CARDIOLOGY), INTERNAL MEDICINE" "DIAGNOSTIC RADIOLOGY" "DIAGNOSTIC RADIOLOGY" "DIAGNOSTIC RADIOLOGY" ...
#>  $ org_name : chr [1:85] "ELIZABETHTOWN COMMUNITY HOSPITAL" "ELIZABETHTOWN COMMUNITY HOSPITAL" "ELIZABETHTOWN COMMUNITY HOSPITAL" "ELIZABETHTOWN COMMUNITY HOSPITAL" ...
#>  $ org_pac  : chr [1:85] "3577554138" "3577554138" "3577554138" "3577554138" ...
#>  $ members  : int [1:85] 59 59 59 59 59 59 59 59 59 59 ...
#>  $ address  : chr [1:85] "101 ADIRONDACK DR, SUITE 1" "108 PRESTON RD" "119 BRADLEY LN" "1355 CHURCH HILL RD" ...
#>  $ city     : chr [1:85] "TICONDEROGA" "LYME" "WILLISTON" "CHARLOTTE" ...
#>  $ state    : chr [1:85] "NY" "NH" "VT" "VT" ...
#>  $ zip      : chr [1:85] "128839334" "037683508" "054957007" "054459594" ...

reassigned(org_name = x)
#> ✔ reassigned returned 398 results
#> ✔ Retrieving 1 page
#> # A tibble: 398 × 13
#>         npi pac   enid  first last  state specialty memberships org_pac org_enid
#>       <int> <chr> <chr> <chr> <chr> <chr> <chr>           <int> <chr>   <chr>   
#>  1   1.34e9 5294… I202… Nath… Abis… NY    Family P…           1 357755… O200405…
#>  2   1.01e9 5890… I201… Jose  Acos… NY    Medical …           5 357755… O200405…
#>  3   1.01e9 5890… I201… Jose  Acos… NY    Medical …           5 357755… O201011…
#>  4   1.63e9 4385… I202… Dmit… Akse… NY    Diagnost…           4 357755… O200405…
#>  5   1.63e9 4385… I201… Dmit… Akse… VT    Diagnost…           6 357755… O202405…
#>  6   1.95e9 5092… I201… Vlada Alex… NY    Pathology           3 357755… O200405…
#>  7   1.72e9 3678… I201… Anel  Alex… NY    Emergenc…           6 357755… O200405…
#>  8   1.72e9 3678… I201… Anel  Alex… NY    Emergenc…           6 357755… O201011…
#>  9   1.77e9 1658… I201… Loren Allen NY    Nurse Pr…           2 357755… O200405…
#> 10   1.24e9 8628… I202… Nich… Also… NY    Emergenc…           5 357755… O200405…
#> # ℹ 388 more rows
#> # ℹ 3 more variables: org_name <chr>, members <int>, org_state <chr>
```

The **Hospital Enrollment** API includes only Medicare Part A (hospital)
providers, so we only get two rows back, but those include a new data
point: two facility CCNs. Plugging those into the **Facility
Affiliations** API, we can retrieve information on the individual
providers practicing at this hospital. First, the all-numeric CCN
(`331302`):

``` r

x <- affiliations(ccn = 331302)
#> ✔ affiliations returned 340 results
#> ✔ Retrieving 1 page

list(
  organization = as.data.frame(t(unique(x[5:7]))),
  individual = unique(x[1:4]))
#> $organization
#>                  V1
#> fac_type   Hospital
#> ccn          331302
#> parent_ccn     <NA>
#> 
#> $individual
#> # A tibble: 340 × 4
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
#> # ℹ 330 more rows
```

That returns individual providers affiliated with the hospital. Now to
search the alphanumeric CCN (`33Z302`):

``` r

x <- affiliations(ccn = "33Z302")
#> ✔ affiliations returned 7 results
#> ✔ Retrieving 1 page

list(
  organization = as.data.frame(t(unique(x[5:7]))), 
  individual = unique(x[1:4]))
#> $organization
#>                V1
#> fac_type       NH
#> ccn        33Z302
#> parent_ccn 331302
#> 
#> $individual
#> # A tibble: 7 × 4
#>   first   last                 npi pac       
#>   <chr>   <chr>              <int> <chr>     
#> 1 JEFFREY KLOTZ         1073258398 3870095805
#> 2 CARLOS  MARTINEZ      1154332062 5890739734
#> 3 GABRIEL CREVIER-SORBO 1154946978 2264892017
#> 4 MARY    HALLORAN      1396989059 8921259557
#> 5 IL      CHON          1538173869 0547299091
#> 6 DRAGOS  BANU          1558659367 6709004682
#> 7 JOSHUA  WARNER        1760167712 8123473469
```

That returns more affiliated individual providers that practice in the
Hospital’s nursing home.

> An *alphanumeric* CCN represents a `sub-unit` of the hospital, here a
> nursing home. We would get the same result if we’d set the
> `parent_ccn` argument to the numeric CCN,
> i.e. `affiliations(parent_ccn = 331302)`
