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
#> hospitls [5 × 18] (S3: hospitals/provider/tbl_df/tbl/data.frame)
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
#>  1 LUCY  NA     LANE  F      MD    OTHER       2012 DIAGNOST… 1.03e9 7911… I201…
#>  2 LUCY  NA     LANE  F      MD    OTHER       2012 DIAGNOST… 1.03e9 7911… I202…
#>  3 VANE… NA     FIOR… F      MD    OTHER       2013 MEDICAL … 1.04e9 7214… I202…
#>  4 JEFF… NA     KLOTZ M      MD    OTHER       2022 FAMILY P… 1.07e9 3870… I202…
#>  5 CARL  NA     COBB  M      MD    UNIVE…      1990 DIAGNOST… 1.08e9 0840… I202…
#>  6 CARL  NA     COBB  M      MD    UNIVE…      1990 DIAGNOST… 1.08e9 0840… I200…
#>  7 CARL  NA     COBB  M      MD    UNIVE…      1990 DIAGNOST… 1.08e9 0840… I202…
#>  8 RYAN  NA     WALSH M      MD    OTHER       2007 DIAGNOST… 1.08e9 8921… I202…
#>  9 RYAN  NA     WALSH M      MD    OTHER       2007 DIAGNOST… 1.08e9 8921… I201…
#> 10 RUSS… NA     MEYER M      MD    UNIVE…      2009 DIAGNOST… 1.12e9 4082… I201…
#> # ℹ 67 more rows
#> # ℹ 7 more variables: org_name <chr>, org_pac <chr>, members <int>,
#> #   address <chr>, city <chr>, state <chr>, zip <chr>
reassignments(org_name = "Elizabethtown Community Hospital")
#> ✔ reassignments returned 398 results.
#> # A tibble: 398 × 13
#>    first   last  state specialty employers    npi pac   enid  org_name employees
#>    <chr>   <chr> <chr> <chr>         <int>  <int> <chr> <chr> <chr>        <int>
#>  1 Jose    Acos… NY    Medical …         5 1.01e9 5890… I201… Elizabe…       202
#>  2 Jose    Acos… NY    Medical …         5 1.01e9 5890… I201… Elizabe…       141
#>  3 Lindsey Wilh… NY    Family P…         3 1.02e9 6901… I201… Elizabe…       202
#>  4 Lindsey Wilh… NY    Family P…         3 1.02e9 6901… I201… Elizabe…       141
#>  5 Lucy    Lane  NY    Diagnost…         5 1.03e9 7911… I202… Elizabe…       202
#>  6 Lucy    Lane  NY    Diagnost…         5 1.03e9 7911… I202… Elizabe…       141
#>  7 Lucy    Lane  VT    Diagnost…        14 1.03e9 7911… I201… Elizabe…        33
#>  8 Vanessa Fior… NY    Medical …         3 1.04e9 7214… I202… Elizabe…       202
#>  9 Vanessa Fior… NY    Medical …         3 1.04e9 7214… I202… Elizabe…        15
#> 10 Janusz  Kikut NY    Diagnost…         5 1.05e9 1658… I202… Elizabe…       202
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
