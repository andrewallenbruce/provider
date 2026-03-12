# Linking Providers

> NPIs, PACs, ENIDs, CCNs, CLIAs and Many More

#### Individual Provider

``` r
pac <- affiliations(pac = 7810891009)
```

    #> ✔ Query returned 5 results.

``` r
list(
  individual = as.data.frame(t(unique(pac[1:6]))),
  organization = pac[7:9])
```

    #> $individual
    #>                V1
    #> first        MARK
    #> last         FUNG
    #> middle          K
    #> suffix       <NA>
    #> npi    1043245657
    #> pac    7810891009
    #> 
    #> $organization
    #> # A tibble: 5 × 3
    #>   facility_type facility_ccn parent_ccn
    #>   <chr>         <chr>        <chr>     
    #> 1 Hospital      470003       NA        
    #> 2 Hospital      330250       NA        
    #> 3 Hospital      331321       NA        
    #> 4 Hospital      470001       NA        
    #> 5 Hospital      471307       NA

``` r
ccn <- hospitals(ccn = pac$facility_ccn)
```

    #> ✔ Query returned 5 results.

``` r
ccn |> str()
```

    #> tibble [5 × 39] (S3: tbl_df/tbl/data.frame)
    #>  $ org_name      : chr [1:5] "CHAMPLAIN VALLEY PHYSICIANS HOSPITAL MEDICAL CENTER" "ALICE HYDE MEDICAL CENTER" "CENTRAL VERMONT MEDICAL CENTER INC" "UNIVERSITY OF VERMONT MEDICAL CENTER INC" ...
    #>  $ dba_name      : chr [1:5] "THE UNIVERSITY OF VT HEALTH NETWORK - CHAMPLAIN VALLEY PHYSICIANS HOSP" "THE UNIVERSITY OF VERMONT HEALTH NETWORK-ALICE HYDE MEDICAL CENTER" NA "UNIVERSITY OF VERMONT MEDICAL CENTER" ...
    #>  $ enid          : chr [1:5] "O20120110000201" "O20230512000344" "O20050809000650" "O20021111000009" ...
    #>  $ enid_state    : chr [1:5] "NY" "NY" "VT" "VT" ...
    #>  $ spec          : chr [1:5] "00-09" "00-85" "00-09" "00-09" ...
    #>  $ specialty     : chr [1:5] "PART A PROVIDER - HOSPITAL" "PART A PROVIDER - CRITICAL ACCESS HOSPITAL" "PART A PROVIDER - HOSPITAL" "PART A PROVIDER - HOSPITAL" ...
    #>  $ npi           : chr [1:5] "1033270699" "1114954682" "1508845637" "1568419976" ...
    #>  $ multi         : chr [1:5] "N" "N" "N" "N" ...
    #>  $ ccn           : chr [1:5] "330250" "331321" "470001" "470003" ...
    #>  $ ccn_2         : chr [1:5] NA NA NA NA ...
    #>  $ pac           : chr [1:5] "2769396878" "4082525837" "9335138817" "3779491071" ...
    #>  $ inc_date      : chr [1:5] "1926-01-01" "1905-04-13" "1984-03-01" "1995-01-01" ...
    #>  $ inc_state     : chr [1:5] "NY" "NY" "VT" "VT" ...
    #>  $ org_type      : chr [1:5] "CORPORATION" "CORPORATION" "CORPORATION" "CORPORATION" ...
    #>  $ org_text      : chr [1:5] NA NA NA NA ...
    #>  $ designation   : chr [1:5] "N" "N" "N" "N" ...
    #>  $ add_1         : chr [1:5] "75 BEEKMAN ST" "133 PARK ST" "130 FISHER RD" "111 COLCHESTER AVE" ...
    #>  $ add_2         : chr [1:5] NA NA NA NA ...
    #>  $ city          : chr [1:5] "PLATTSBURGH" "MALONE" "BERLIN" "BURLINGTON" ...
    #>  $ state         : chr [1:5] "NY" "NY" "VT" "VT" ...
    #>  $ zip           : chr [1:5] "129011438" "129531244" "56029516" "54011473" ...
    #>  $ location_type : chr [1:5] "MAIN/PRIMARY HOSPITAL LOCATION" "MAIN/PRIMARY HOSPITAL LOCATION" "MAIN/PRIMARY HOSPITAL LOCATION" "OTHER HOSPITAL PRACTICE LOCATION" ...
    #>  $ location_text : chr [1:5] NA NA NA "HOSPITAL - GENERAL PRACTICE AND CLINICS" ...
    #>  $ reh_ind       : chr [1:5] "N" "N" "N" "N" ...
    #>  $ reh_date      : chr [1:5] NA NA NA NA ...
    #>  $ sub_general   : chr [1:5] "N" "N" "N" "N" ...
    #>  $ sub_acute     : chr [1:5] "Y" "N" "Y" "Y" ...
    #>  $ sub_drug      : chr [1:5] "N" "N" "N" "N" ...
    #>  $ sub_child     : chr [1:5] "N" "N" "N" "N" ...
    #>  $ sub_long      : chr [1:5] "N" "N" "N" "N" ...
    #>  $ sub_psych     : chr [1:5] "N" "N" "N" "N" ...
    #>  $ sub_rehab     : chr [1:5] "N" "N" "N" "N" ...
    #>  $ sub_short     : chr [1:5] "N" "N" "N" "N" ...
    #>  $ sub_swing     : chr [1:5] "N" "N" "N" "N" ...
    #>  $ sub_psych_unit: chr [1:5] "N" "N" "N" "N" ...
    #>  $ sub_rehab_unit: chr [1:5] "N" "N" "N" "N" ...
    #>  $ sub_specialty : chr [1:5] "N" "N" "N" "N" ...
    #>  $ sub_other     : chr [1:5] "N" "N" "N" "Y" ...
    #>  $ sub_otext     : chr [1:5] NA NA NA "ORGAN TRANSPLANT PROGRAM" ...

  

#### Organizational Provider

Exploring links between providers can lead to many interesting insights.
For example, there is a hospital in New York named **Elizabethtown
Community Hospital**.

``` r
providers(org_name = "Elizabethtown Community Hospital")
```

    #> ✔ Query returned 9 results.

    #> # A tibble: 9 × 11
    #>   first middle last  org_name      state spec  specialty npi   multi pac   enid 
    #>   <chr> <chr>  <chr> <chr>         <chr> <chr> <chr>     <chr> <chr> <chr> <chr>
    #> 1 NA    NA     NA    ELIZABETHTOW… NY    12-70 PART B S… 1053… Y     3577… O200…
    #> 2 NA    NA     NA    ELIZABETHTOW… NY    00-85 PART A P… 1891… Y     3577… O201…
    #> 3 NA    NA     NA    ELIZABETHTOW… NY    12-59 PART B S… 1487… N     3577… O201…
    #> 4 NA    NA     NA    ELIZABETHTOW… NY    00-85 PART A P… 1407… N     3577… O202…
    #> 5 NA    NA     NA    ELIZABETHTOW… CT    12-70 PART B S… 1053… N     3577… O202…
    #> 6 NA    NA     NA    ELIZABETHTOW… FL    12-70 PART B S… 1053… N     3577… O202…
    #> 7 NA    NA     NA    ELIZABETHTOW… VT    12-70 PART B S… 1053… N     3577… O202…
    #> 8 NA    NA     NA    ELIZABETHTOW… NH    12-70 PART B S… 1053… N     3577… O202…
    #> 9 NA    NA     NA    ELIZABETHTOW… CO    12-70 PART B S… 1053… N     3577… O202…

``` r
hospitals(org_name = "Elizabethtown Community Hospital")
```

    #> ✔ Query returned 2 results.

    #> # A tibble: 2 × 39
    #>   org_name     dba_name enid  enid_state spec  specialty npi   multi ccn   ccn_2
    #>   <chr>        <chr>    <chr> <chr>      <chr> <chr>     <chr> <chr> <chr> <chr>
    #> 1 ELIZABETHTO… NA       O201… NY         00-85 PART A P… 1891… Y     3313… NA   
    #> 2 ELIZABETHTO… NA       O202… NY         00-85 PART A P… 1407… N     33Z3… NA   
    #> # ℹ 29 more variables: pac <chr>, inc_date <chr>, inc_state <chr>,
    #> #   org_type <chr>, org_text <chr>, designation <chr>, add_1 <chr>,
    #> #   add_2 <chr>, city <chr>, state <chr>, zip <chr>, location_type <chr>,
    #> #   location_text <chr>, reh_ind <chr>, reh_date <chr>, sub_general <chr>,
    #> #   sub_acute <chr>, sub_drug <chr>, sub_child <chr>, sub_long <chr>,
    #> #   sub_psych <chr>, sub_rehab <chr>, sub_short <chr>, sub_swing <chr>,
    #> #   sub_psych_unit <chr>, sub_rehab_unit <chr>, sub_specialty <chr>, …

``` r
clinicians(facility_name = "Elizabethtown Community Hospital")
```

    #> ✔ Query returned 60 results.

    #> # A tibble: 60 × 25
    #>    first    middle last    suffix gender cred  school year  specialty spec_other
    #>    <chr>    <chr>  <chr>   <chr>  <chr>  <chr> <chr>  <chr> <chr>     <chr>     
    #>  1 JEFFREY  NA     KLOTZ   NA     M      MD    OTHER  2022  FAMILY P… NA        
    #>  2 RYAN     NA     WALSH   NA     M      MD    OTHER  2007  DIAGNOST… NA        
    #>  3 RYAN     NA     WALSH   NA     M      MD    OTHER  2007  DIAGNOST… NA        
    #>  4 RUSSELL  NA     MEYER   NA     M      MD    UNIVE… 2009  DIAGNOST… NA        
    #>  5 RUSSELL  NA     MEYER   NA     M      MD    UNIVE… 2009  DIAGNOST… NA        
    #>  6 JAMES    NA     KENNEY  NA     M      MD    UNIVE… 1992  DIAGNOST… NA        
    #>  7 BENJAMIN NA     BAMFORD NA     M      MD    UNIVE… 1992  DIAGNOST… NA        
    #>  8 BENJAMIN NA     BAMFORD NA     M      MD    UNIVE… 1992  DIAGNOST… NA        
    #>  9 STEVEN   E      DESO    NA     M      MD    BOSTO… 2010  DIAGNOST… INTERVENT…
    #> 10 LAURENT  NA     GILLOT… NA     M      MD    OTHER  1998  DIAGNOST… NA        
    #> # ℹ 50 more rows
    #> # ℹ 15 more variables: facility_name <chr>, npi <chr>, pac <chr>, enid <chr>,
    #> #   org_pac <chr>, org_mems <chr>, add_1 <chr>, add_2 <chr>, city <chr>,
    #> #   state <chr>, zip <chr>, phone <chr>, ind <chr>, grp <chr>, tele <chr>

``` r
reassignments(org_name = "Elizabethtown Community Hospital")
```

    #> ✔ Query returned 356 results.

    #> # A tibble: 356 × 14
    #>    first   last  state specialty ind_assoc npi   pac   enid  org_name org_assign
    #>    <chr>   <chr> <chr> <chr>     <chr>     <chr> <chr> <chr> <chr>    <chr>     
    #>  1 Nathal… Abis… NY    Family P… 1         1336… 5294… I202… Elizabe… 186       
    #>  2 Jose    Acos… NY    Medical … 5         1013… 5890… I201… Elizabe… 186       
    #>  3 Jose    Acos… NY    Medical … 5         1013… 5890… I201… Elizabe… 114       
    #>  4 Aderon… Aden… NY    Cardiova… 3         1407… 8820… I201… Elizabe… 186       
    #>  5 Dmitriy Akse… NY    Diagnost… 4         1629… 4385… I202… Elizabe… 186       
    #>  6 Dmitriy Akse… VT    Diagnost… 6         1629… 4385… I201… Elizabe… 33        
    #>  7 Vlada   Alex… NY    Pathology 3         1952… 5092… I201… Elizabe… 186       
    #>  8 Anel    Alex… NY    Emergenc… 6         1720… 3678… I201… Elizabe… 186       
    #>  9 Anel    Alex… NY    Emergenc… 6         1720… 3678… I201… Elizabe… 114       
    #> 10 Loren   Allen NY    Nurse Pr… 2         1770… 1658… I201… Elizabe… 186       
    #> # ℹ 346 more rows
    #> # ℹ 4 more variables: org_pac <chr>, org_enid <chr>, org_state <chr>,
    #> #   type <chr>

  

The **Hospital Enrollment** API includes only Medicare Part A (hospital)
providers, so we only get two rows back, but those include a new data
point: two facility CCNs. Plugging those into the **Facility
Affiliations** API, we can retrieve information on the individual
providers practicing at this hospital. First, the all-numeric CCN
(`331302`):

  

``` r
ccn <- affiliations(facility_ccn = 331302)
```

    #> ✔ Query returned 206 results.

``` r
list(
  organization = as.data.frame(t(unique(ccn[7:9]))),
  individual = unique(ccn[1:6])
  )
```

    #> $organization
    #>                     V1
    #> facility_type Hospital
    #> facility_ccn    331302
    #> parent_ccn        <NA>
    #> 
    #> $individual
    #> # A tibble: 206 × 6
    #>    first   last            middle suffix npi        pac       
    #>    <chr>   <chr>           <chr>  <chr>  <chr>      <chr>     
    #>  1 LAURA   GREENE          A      NA     1003845272 1759384035
    #>  2 DEBORAH KAMPSCHROR      M      NA     1013141860 8022069558
    #>  3 NAROD   VASSILIAN       NA     NA     1013539584 9133544109
    #>  4 EMILY   TRIPLETT        NA     NA     1013595560 3375947401
    #>  5 JOSE    ACOSTAMADIEDO   M      NA     1013910256 5890719371
    #>  6 LINDSEY WILHELM         B      NA     1023377843 6901115278
    #>  7 VANESSA FIORINI FURTADO NA     NA     1043672140 7214229350
    #>  8 JOHN    YOUNG           NA     NA     1063420891 9436051687
    #>  9 DELANEY OSBORN          NA     NA     1073073177 0547593097
    #> 10 ANGAD   GILL            NA     NA     1073133435 6800318452
    #> # ℹ 196 more rows

  

That returns individual providers affiliated with the hospital. Now to
search the alphanumeric CCN (`33Z302`):

``` r
ccn2 <- affiliations(facility_ccn = "33Z302")
```

    #> ✔ Query returned 4 results.

``` r
list(
  organization = as.data.frame(t(unique(ccn2[7:9]))),
  individual = unique(ccn2[1:6])
  )
```

    #> $organization
    #>                         V1
    #> facility_type Nursing home
    #> facility_ccn        33Z302
    #> parent_ccn          331302
    #> 
    #> $individual
    #> # A tibble: 4 × 6
    #>   first   last     middle suffix npi        pac       
    #>   <chr>   <chr>    <chr>  <chr>  <chr>      <chr>     
    #> 1 JEFFREY KLOTZ    NA     NA     1073258398 3870095805
    #> 2 MARY    HALLORAN K      NA     1396989059 8921259557
    #> 3 IL      CHON     JUN    NA     1538173869 0547299091
    #> 4 DRAGOS  BANU     NA     NA     1558659367 6709004682

  

That returns more affiliated individual providers that practice in the
Hospital’s nursing home..

  

> An *alphanumeric* CCN represents a sub-unit of the hospital, here a
> nursing home. We would get the same result if we’d set the
> `parent_ccn` argument to the numeric CCN,
> i.e. `affiliations(parent_ccn = 331302)`
