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
#> $individual
#>                 1
#> first        MARK
#> last         FUNG
#> middle          K
#> suffix       <NA>
#> npi    1043245657
#> pac    7810891009
#> 
#> $organization
#> # A data frame: 5 × 3
#>   facility_type facility_ccn parent_ccn
#> * <chr>         <chr>        <chr>     
#> 1 Hospital      470003       NA        
#> 2 Hospital      330250       NA        
#> 3 Hospital      470001       NA        
#> 4 Hospital      471307       NA        
#> 5 Hospital      470011       NA
```

``` r
ccn <- hospitals(ccn = pac$facility_ccn)
#> ✔ hospitals returned 5 results.
ccn |> str()
#> Classes 'tbl' and 'data.frame':  5 obs. of  39 variables:
#>  $ org_name      : chr  "CHAMPLAIN VALLEY PHYSICIANS HOSPITAL MEDICAL CENTER" "CENTRAL VERMONT MEDICAL CENTER INC" "UNIVERSITY OF VERMONT MEDICAL CENTER INC" "BRATTLEBORO MEMORIAL HOSPITAL" ...
#>  $ org_dba       : chr  "THE UNIVERSITY OF VT HEALTH NETWORK - CHAMPLAIN VALLEY PHYSICIANS HOSP" NA "UNIVERSITY OF VERMONT MEDICAL CENTER" NA ...
#>  $ enid          : chr  "O20120110000201" "O20050809000650" "O20021111000009" "O20040812001170" ...
#>  $ enid_state    : chr  "NY" "VT" "VT" "VT" ...
#>  $ spec          : chr  "00-09" "00-09" "00-09" "00-09" ...
#>  $ specialty     : chr  "PART A PROVIDER - HOSPITAL" "PART A PROVIDER - HOSPITAL" "PART A PROVIDER - HOSPITAL" "PART A PROVIDER - HOSPITAL" ...
#>  $ npi           : chr  "1033270699" "1508845637" "1568419976" "1306849708" ...
#>  $ multi         : chr  "N" "N" "N" "N" ...
#>  $ ccn           : chr  "330250" "470001" "470003" "470011" ...
#>  $ ccn_2         : chr  NA NA NA NA ...
#>  $ pac           : chr  "2769396878" "9335138817" "3779491071" "9335112929" ...
#>  $ inc_date      : chr  "1926-01-01" "1984-03-01" "1995-01-01" "1904-10-26" ...
#>  $ inc_state     : chr  "NY" "VT" "VT" "VT" ...
#>  $ org_type      : chr  "CORPORATION" "CORPORATION" "CORPORATION" "CORPORATION" ...
#>  $ org_otxt      : chr  NA NA NA NA ...
#>  $ org_status    : chr  "N" "N" "N" "N" ...
#>  $ add_1         : chr  "75 BEEKMAN ST" "130 FISHER RD" "111 COLCHESTER AVE" "17 BELMONT AVE" ...
#>  $ add_2         : chr  NA NA NA NA ...
#>  $ city          : chr  "PLATTSBURGH" "BERLIN" "BURLINGTON" "BRATTLEBORO" ...
#>  $ state         : chr  "NY" "VT" "VT" "VT" ...
#>  $ zip           : chr  "129011438" "56029516" "54011473" "53017601" ...
#>  $ loc_type      : chr  "MAIN/PRIMARY HOSPITAL LOCATION" "MAIN/PRIMARY HOSPITAL LOCATION" "OTHER HOSPITAL PRACTICE LOCATION" "OTHER HOSPITAL PRACTICE LOCATION" ...
#>  $ loc_otxt      : chr  NA NA "HOSPITAL - GENERAL PRACTICE AND CLINICS" NA ...
#>  $ reh_ind       : chr  "N" "N" "N" "N" ...
#>  $ reh_date      : chr  NA NA NA NA ...
#>  $ sub_general   : chr  "N" "N" "N" "Y" ...
#>  $ sub_acute     : chr  "Y" "Y" "Y" "N" ...
#>  $ sub_drug      : chr  "N" "N" "N" "N" ...
#>  $ sub_child     : chr  "N" "N" "N" "N" ...
#>  $ sub_long      : chr  "N" "N" "N" "N" ...
#>  $ sub_psych     : chr  "N" "N" "N" "N" ...
#>  $ sub_rehab     : chr  "N" "N" "N" "N" ...
#>  $ sub_short     : chr  "N" "N" "N" "N" ...
#>  $ sub_swing     : chr  "N" "N" "N" "N" ...
#>  $ sub_psych_unit: chr  "N" "N" "N" "N" ...
#>  $ sub_rehab_unit: chr  "N" "N" "N" "N" ...
#>  $ sub_specialty : chr  "N" "N" "N" "N" ...
#>  $ sub_other     : chr  "N" "N" "Y" "N" ...
#>  $ sub_otxt      : chr  NA NA "ORGAN TRANSPLANT PROGRAM" NA ...
```

  

#### Organizational Provider

Exploring links between providers can lead to many interesting insights.
For example, there is a hospital in New York named **Elizabethtown
Community Hospital**.

``` r
providers(org_name = "Elizabethtown Community Hospital")
#> ✔ providers returned 9 results.
#> # A data frame: 9 × 11
#>   org_name      first middle last  state spec  specialty npi   multi pac   enid 
#> * <chr>         <chr> <chr>  <chr> <chr> <chr> <chr>     <chr> <chr> <chr> <chr>
#> 1 ELIZABETHTOW… NA    NA     NA    NY    12-70 PART B S… 1053… Y     3577… O200…
#> 2 ELIZABETHTOW… NA    NA     NA    NY    00-85 PART A P… 1891… Y     3577… O201…
#> 3 ELIZABETHTOW… NA    NA     NA    NY    12-59 PART B S… 1487… N     3577… O201…
#> 4 ELIZABETHTOW… NA    NA     NA    NY    00-85 PART A P… 1407… N     3577… O202…
#> 5 ELIZABETHTOW… NA    NA     NA    CT    12-70 PART B S… 1053… N     3577… O202…
#> 6 ELIZABETHTOW… NA    NA     NA    FL    12-70 PART B S… 1053… N     3577… O202…
#> 7 ELIZABETHTOW… NA    NA     NA    VT    12-70 PART B S… 1053… N     3577… O202…
#> 8 ELIZABETHTOW… NA    NA     NA    NH    12-70 PART B S… 1053… N     3577… O202…
#> 9 ELIZABETHTOW… NA    NA     NA    CO    12-70 PART B S… 1053… N     3577… O202…
```

``` r
hospitals(org_name = "Elizabethtown Community Hospital")
#> ✔ hospitals returned 2 results.
#> # A data frame: 2 × 39
#>   org_name      org_dba enid  enid_state spec  specialty npi   multi ccn   ccn_2
#> * <chr>         <chr>   <chr> <chr>      <chr> <chr>     <chr> <chr> <chr> <chr>
#> 1 ELIZABETHTOW… NA      O201… NY         00-85 PART A P… 1891… Y     3313… NA   
#> 2 ELIZABETHTOW… NA      O202… NY         00-85 PART A P… 1407… N     33Z3… NA   
#> # ℹ 29 more variables: pac <chr>, inc_date <chr>, inc_state <chr>,
#> #   org_type <chr>, org_otxt <chr>, org_status <chr>, add_1 <chr>, add_2 <chr>,
#> #   city <chr>, state <chr>, zip <chr>, loc_type <chr>, loc_otxt <chr>,
#> #   reh_ind <chr>, reh_date <chr>, sub_general <chr>, sub_acute <chr>,
#> #   sub_drug <chr>, sub_child <chr>, sub_long <chr>, sub_psych <chr>,
#> #   sub_rehab <chr>, sub_short <chr>, sub_swing <chr>, sub_psych_unit <chr>,
#> #   sub_rehab_unit <chr>, sub_specialty <chr>, sub_other <chr>, …
```

``` r
clinicians(facility_name = "Elizabethtown Community Hospital")
#> Error in `clinicians()`:
#> ! unused argument (facility_name = "Elizabethtown Community Hospital")
```

``` r
reassignments(org_name = "Elizabethtown Community Hospital")
#> ✔ reassignments returned 370 results.
#> # A data frame: 370 × 14
#>    first   last  state specialty ind_assoc npi   pac   enid  org_name org_assign
#>  * <chr>   <chr> <chr> <chr>     <chr>     <chr> <chr> <chr> <chr>    <chr>     
#>  1 Nathal… Abis… NY    Family P… 1         1336… 5294… I202… Elizabe… 193       
#>  2 Jose    Acos… NY    Medical … 5         1013… 5890… I201… Elizabe… 193       
#>  3 Jose    Acos… NY    Medical … 5         1013… 5890… I201… Elizabe… 121       
#>  4 Dmitriy Akse… NY    Diagnost… 4         1629… 4385… I202… Elizabe… 193       
#>  5 Dmitriy Akse… VT    Diagnost… 6         1629… 4385… I201… Elizabe… 33        
#>  6 Vlada   Alex… NY    Pathology 3         1952… 5092… I201… Elizabe… 193       
#>  7 Anel    Alex… NY    Emergenc… 6         1720… 3678… I201… Elizabe… 193       
#>  8 Anel    Alex… NY    Emergenc… 6         1720… 3678… I201… Elizabe… 121       
#>  9 Loren   Allen NY    Nurse Pr… 2         1770… 1658… I201… Elizabe… 193       
#> 10 Nichol… Also… NY    Emergenc… 5         1235… 8628… I202… Elizabe… 193       
#> # ℹ 360 more rows
#> # ℹ 4 more variables: org_pac <chr>, org_enid <chr>, org_state <chr>,
#> #   type <chr>
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
  individual = unique(ccn[1:6])
  )
#> $organization
#>                      1
#> facility_type Hospital
#> facility_ccn    331302
#> parent_ccn        <NA>
#> 
#> $individual
#> # A data frame: 206 × 6
#>    first   last            middle suffix npi        pac       
#>  * <chr>   <chr>           <chr>  <chr>  <chr>      <chr>     
#>  1 LAURA   GREENE          A      NA     1003845272 1759384035
#>  2 NAROD   VASSILIAN       NA     NA     1013539584 9133544109
#>  3 EMILY   TRIPLETT        NA     NA     1013595560 3375947401
#>  4 JOSE    ACOSTAMADIEDO   M      NA     1013910256 5890719371
#>  5 LINDSEY WILHELM         B      NA     1023377843 6901115278
#>  6 ANTHONY TRAMONTANO      F      NA     1043397656 4183764558
#>  7 VANESSA FIORINI FURTADO NA     NA     1043672140 7214229350
#>  8 CONOR   O'NEILL         NA     NA     1053686196 9234432576
#>  9 JOHN    YOUNG           NA     NA     1063420891 9436051687
#> 10 ROBERT  BENAK           L      NA     1063423523 3476552878
#> # ℹ 196 more rows
```

  

That returns individual providers affiliated with the hospital. Now to
search the alphanumeric CCN (`33Z302`):

``` r
ccn2 <- affiliations(facility_ccn = "33Z302")
#> ✔ affiliations returned 4 results.
list(
  organization = as.data.frame(t(unique(ccn2[7:9]))),
  individual = unique(ccn2[1:6])
  )
#> $organization
#>                          1
#> facility_type Nursing home
#> facility_ccn        33Z302
#> parent_ccn          331302
#> 
#> $individual
#> # A data frame: 4 × 6
#>   first   last     middle suffix npi        pac       
#> * <chr>   <chr>    <chr>  <chr>  <chr>      <chr>     
#> 1 JEFFREY KLOTZ    NA     NA     1073258398 3870095805
#> 2 MARY    HALLORAN K      NA     1396989059 8921259557
#> 3 IL      CHON     JUN    NA     1538173869 0547299091
#> 4 DRAGOS  BANU     NA     NA     1558659367 6709004682
```

  

That returns more affiliated individual providers that practice in the
Hospital’s nursing home..

  

> An *alphanumeric* CCN represents a sub-unit of the hospital, here a
> nursing home. We would get the same result if we’d set the
> `parent_ccn` argument to the numeric CCN,
> i.e. `affiliations(parent_ccn = 331302)`
