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
  individual = as.data.frame(t(unique(pac[1:5]))),
  organization = pac[6:8])
#> $individual
#>                V1
#> first        MARK
#> middle          K
#> last         FUNG
#> npi    1043245657
#> pac    7810891009
#> 
#> $organization
#> # A tibble: 5 × 3
#>   prov_type prov_ccn parent_ccn
#>   <chr>     <chr>    <chr>     
#> 1 Hospital  470003   NA        
#> 2 Hospital  330250   NA        
#> 3 Hospital  470001   NA        
#> 4 Hospital  331321   NA        
#> 5 Hospital  471307   NA
```

``` r

ccn <- hospitals(ccn = pac$prov_ccn)
#> ✔ hospitals returned 5 results.
ccn |> str()
#> hospitls [5 × 18] (S3: hospitals/tbl_df/tbl/data.frame)
#>  $ org_name : chr [1:5] "CHAMPLAIN VALLEY PHYSICIANS HOSPITAL MEDICAL CENTER" "ALICE HYDE MEDICAL CENTER" "CENTRAL VERMONT MEDICAL CENTER INC" "UNIVERSITY OF VERMONT MEDICAL CENTER INC" ...
#>  $ org_dba  : chr [1:5] "THE UNIVERSITY OF VT HEALTH NETWORK - CHAMPLAIN VALLEY PHYSICIANS HOSP" "THE UNIVERSITY OF VERMONT HEALTH NETWORK-ALICE HYDE MEDICAL CENTER" NA "UNIVERSITY OF VERMONT MEDICAL CENTER" ...
#>  $ enid     : chr [1:5] "O20120110000201" "O20230512000344" "O20050809000650" "O20021111000009" ...
#>  $ npi      : int [1:5] 1033270699 1114954682 1508845637 1568419976 1740291400
#>  $ multi    : int [1:5] 0 0 0 0 1
#>  $ ccn      : chr [1:5] "330250" "331321" "470001" "470003" ...
#>  $ pac      : chr [1:5] "2769396878" "4082525837" "9335138817" "3779491071" ...
#>  $ inc_date : Date[1:5], format: "1926-01-01" "1905-04-13" ...
#>  $ org_type : chr [1:5] "CORPORATION" "CORPORATION" "CORPORATION" "CORPORATION" ...
#>  $ status   : chr [1:5] "Non-Profit" "Non-Profit" "Non-Profit" "Non-Profit" ...
#>  $ address  : chr [1:5] "75 BEEKMAN ST" "133 PARK ST" "130 FISHER RD" "111 COLCHESTER AVE" ...
#>  $ city     : chr [1:5] "PLATTSBURGH" "MALONE" "BERLIN" "BURLINGTON" ...
#>  $ state    : chr [1:5] "NY" "NY" "VT" "VT" ...
#>  $ zip      : chr [1:5] "129011438" "129531244" "56029516" "54011473" ...
#>  $ loc_type : chr [1:5] "Primary" "Primary" "Primary" "Other: HOSPITAL - GENERAL PRACTICE AND CLINICS" ...
#>  $ reh_date : Date[1:5], format: NA NA ...
#>  $ prov_type: chr [1:5] NA "CAH" NA NA ...
#>  $ sub_group: chr [1:5] "Acute" NA "Acute" "Other: ORGAN TRANSPLANT PROGRAM" ...
```

#### Organizational Provider

Exploring links between providers can lead to many interesting insights.
For example, there is a hospital in New York named **Elizabethtown
Community Hospital**.

``` r

providers(org_name = "Elizabethtown Community Hospital")
#> ✔ providers returned 8 results.
#> # A tibble: 8 × 4
#>   prov_type first last         npi
#>   <chr>     <chr> <chr>      <int>
#> 1 12-70     NA    NA    1053656744
#> 2 12-70     NA    NA    1053656744
#> 3 12-70     NA    NA    1053656744
#> 4 12-70     NA    NA    1053656744
#> 5 12-70     NA    NA    1053656744
#> 6 12-70     NA    NA    1053656744
#> 7 00-85     NA    NA    1407061591
#> 8 00-85     NA    NA    1891785184
hospitals(org_name = "Elizabethtown Community Hospital")
#> ✔ hospitals returned 2 results.
#> # A tibble: 2 × 18
#>   org_name     org_dba enid     npi multi ccn   pac   inc_date   org_type status
#> * <chr>        <chr>   <chr>  <int> <int> <chr> <chr> <date>     <chr>    <chr> 
#> 1 ELIZABETHTO… NA      O201… 1.89e9     1 3313… 3577… 1926-05-08 CORPORA… Non-P…
#> 2 ELIZABETHTO… NA      O202… 1.41e9     0 33Z3… 3577… 1926-05-08 CORPORA… Non-P…
#> # ℹ 8 more variables: address <chr>, city <chr>, state <chr>, zip <chr>,
#> #   loc_type <chr>, reh_date <date>, prov_type <chr>, sub_group <chr>
clinicians(org_name = "Elizabethtown Community Hospital")
#> ✔ clinicians returned 77 results.
#> # A tibble: 77 × 18
#>    first middle last  gender cred  school grad_year specialty    npi pac   enid 
#>    <chr> <chr>  <chr> <chr>  <chr> <chr>      <int> <chr>      <int> <chr> <chr>
#>  1 GAVIN L      NOBLE M      MD    STATE…      1999 CARDIOVA… 1.75e9 6002… I202…
#>  2 JOSE… NA     PEKA… M      MD    GEISE…      1999 DIAGNOST… 1.37e9 3274… I200…
#>  3 DMIT… G      AKSE… M      MD    STATE…      2007 DIAGNOST… 1.63e9 4385… I201…
#>  4 ROBE… NA     PERC… M      MD    NEW Y…      2009 INTERVEN… 1.36e9 5991… I202…
#>  5 BENJ… NA     LANGE M      MD    HARVA…      2009 DIAGNOST… 1.77e9 2365… I201…
#>  6 BENJ… NA     BAMF… M      MD    UNIVE…      1992 DIAGNOST… 1.15e9 9638… I201…
#>  7 JOSH… NA     WARN… F      NP    OTHER       2023 NURSE PR… 1.76e9 8123… I202…
#>  8 EMILY NA     POLO… F      NP    OTHER       2014 NURSE PR… 1.92e9 8729… I202…
#>  9 DAGM… NA     HOEG… F      MD    OTHER       1996 DIAGNOST… 1.87e9 4880… I200…
#> 10 LUCY  NA     LANE  F      MD    OTHER       2012 DIAGNOST… 1.03e9 7911… I201…
#> # ℹ 67 more rows
#> # ℹ 7 more variables: org_name <chr>, org_pac <chr>, members <int>,
#> #   address <chr>, city <chr>, state <chr>, zip <chr>
reassignments(org_name = "Elizabethtown Community Hospital")
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
  organization = as.data.frame(t(unique(ccn[6:8]))),
  individual = unique(ccn[1:5]))
#> $organization
#>                  V1
#> prov_type  Hospital
#> prov_ccn     331302
#> parent_ccn     <NA>
#> 
#> $individual
#> # A tibble: 334 × 5
#>    first   middle  last                  npi pac       
#>    <chr>   <chr>   <chr>               <int> <chr>     
#>  1 STACI   L       CARTER-KELLY   1003029125 6204824378
#>  2 DYLAN   A       ESTES          1003278144 6608167523
#>  3 ANA     MARIELA MORALES MEJIA  1003421496 6103287404
#>  4 ARMIN   NA      AFSAR KESHMIRI 1003815184 4082693676
#>  5 LAURA   A       GREENE         1003845272 1759384035
#>  6 DEBORAH M       KAMPSCHROR     1013141860 8022069558
#>  7 NAROD   NA      VASSILIAN      1013539584 9133544109
#>  8 EMILY   NA      TRIPLETT       1013595560 3375947401
#>  9 BARDIA  NA      BARIMANI       1013793736 9436503646
#> 10 JOSE    M       ACOSTAMADIEDO  1013910256 5890719371
#> # ℹ 324 more rows
```

That returns individual providers affiliated with the hospital. Now to
search the alphanumeric CCN (`33Z302`):

``` r

ccn2 <- affiliations(facility_ccn = "33Z302")
#> ✔ affiliations returned 6 results.
list(
  organization = as.data.frame(t(unique(ccn2[6:8]))), 
  individual = unique(ccn2[1:5]))
#> $organization
#>                      V1
#> prov_type  Nursing home
#> prov_ccn         33Z302
#> parent_ccn       331302
#> 
#> $individual
#> # A tibble: 6 × 5
#>   first   middle last            npi pac       
#>   <chr>   <chr>  <chr>         <int> <chr>     
#> 1 JEFFREY NA     KLOTZ    1073258398 3870095805
#> 2 CARLOS  E      MARTINEZ 1154332062 5890739734
#> 3 MARY    K      HALLORAN 1396989059 8921259557
#> 4 IL      JUN    CHON     1538173869 0547299091
#> 5 DRAGOS  NA     BANU     1558659367 6709004682
#> 6 JOSHUA  NA     WARNER   1760167712 8123473469
```

That returns more affiliated individual providers that practice in the
Hospital’s nursing home.

> An *alphanumeric* CCN represents a `sub-unit` of the hospital, here a
> nursing home. We would get the same result if we’d set the
> `parent_ccn` argument to the numeric CCN,
> i.e. `affiliations(parent_ccn = 331302)`
