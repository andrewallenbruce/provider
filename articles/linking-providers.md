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
#>                V1
#> npi    1043245657
#> pac    7810891009
#> last         FUNG
#> first        MARK
#> middle          K
#> suffix       <NA>
#> 
#> $organization
#> # A tibble: 5 × 3
#>   facility_type facility_ccn parent_ccn
#>   <chr>         <chr>        <chr>     
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
#> tibble [5 × 38] (S3: tbl_df/tbl/data.frame)
#>  $ enid               : chr [1:5] "O20120110000201" "O20050809000650" "O20021111000009" "O20040812001170" ...
#>  $ enid_state         : chr [1:5] "NY" "VT" "VT" "VT" ...
#>  $ prov_type          : chr [1:5] "00-09" "00-09" "00-09" "00-09" ...
#>  $ prov_desc          : chr [1:5] "PART A PROVIDER - HOSPITAL" "PART A PROVIDER - HOSPITAL" "PART A PROVIDER - HOSPITAL" "PART A PROVIDER - HOSPITAL" ...
#>  $ npi                : int [1:5] 1033270699 1508845637 1568419976 1306849708 1740291400
#>  $ multi              : int [1:5] 0 0 0 0 1
#>  $ ccn                : chr [1:5] "330250" "470001" "470003" "470011" ...
#>  $ pac                : chr [1:5] "2769396878" "9335138817" "3779491071" "9335112929" ...
#>  $ org_name           : chr [1:5] "CHAMPLAIN VALLEY PHYSICIANS HOSPITAL MEDICAL CENTER" "CENTRAL VERMONT MEDICAL CENTER INC" "UNIVERSITY OF VERMONT MEDICAL CENTER INC" "BRATTLEBORO MEMORIAL HOSPITAL" ...
#>  $ org_dba            : chr [1:5] "THE UNIVERSITY OF VT HEALTH NETWORK - CHAMPLAIN VALLEY PHYSICIANS HOSP" NA "UNIVERSITY OF VERMONT MEDICAL CENTER" NA ...
#>  $ inc_date           : Date[1:5], format: "1926-01-01" "1984-03-01" ...
#>  $ inc_state          : chr [1:5] "NY" "VT" "VT" "VT" ...
#>  $ org_type           : chr [1:5] "CORPORATION" "CORPORATION" "CORPORATION" "CORPORATION" ...
#>  $ org_otxt           : chr [1:5] NA NA NA NA ...
#>  $ status             : chr [1:5] "N" "N" "N" "N" ...
#>  $ city               : chr [1:5] "PLATTSBURGH" "BERLIN" "BURLINGTON" "BRATTLEBORO" ...
#>  $ state              : chr [1:5] "NY" "VT" "VT" "VT" ...
#>  $ zip                : chr [1:5] "129011438" "56029516" "54011473" "53017601" ...
#>  $ loc_type           : chr [1:5] "MAIN/PRIMARY HOSPITAL LOCATION" "MAIN/PRIMARY HOSPITAL LOCATION" "OTHER HOSPITAL PRACTICE LOCATION" "OTHER HOSPITAL PRACTICE LOCATION" ...
#>  $ loc_otxt           : chr [1:5] NA NA "HOSPITAL - GENERAL PRACTICE AND CLINICS" NA ...
#>  $ sub_gen            : int [1:5] 0 0 0 1 0
#>  $ sub_acute          : int [1:5] 1 1 1 0 0
#>  $ sub_adu            : int [1:5] 0 0 0 0 0
#>  $ sub_child          : int [1:5] 0 0 0 0 0
#>  $ sub_ltc            : int [1:5] 0 0 0 0 0
#>  $ sub_psy            : int [1:5] 0 0 0 0 0
#>  $ sub_irf            : int [1:5] 0 0 0 0 0
#>  $ sub_stc            : int [1:5] 0 0 0 0 0
#>  $ sub_sba            : int [1:5] 0 0 0 0 0
#>  $ sub_psu            : int [1:5] 0 0 0 0 0
#>  $ sub_iru            : int [1:5] 0 0 0 0 0
#>  $ sub_spec           : int [1:5] 0 0 0 0 0
#>  $ sub_oth            : int [1:5] 0 0 1 0 0
#>  $ sub_otxt           : int [1:5] NA NA NA NA NA
#>  $ REH CONVERSION FLAG: chr [1:5] "N" "N" "N" "N" ...
#>  $ reh_date           : Date[1:5], format: NA NA ...
#>  $ reh_ccn            : chr [1:5] NA NA NA NA ...
#>  $ address            : chr [1:5] "75 BEEKMAN ST" "130 FISHER RD" "111 COLCHESTER AVE" "17 BELMONT AVE" ...
```

#### Organizational Provider

Exploring links between providers can lead to many interesting insights.
For example, there is a hospital in New York named **Elizabethtown
Community Hospital**.

``` r

providers(org_name = "Elizabethtown Community Hospital")
#> ✔ providers returned 8 results.
#> # A tibble: 8 × 11
#>      npi multi pac   enid  prov_type prov_desc state first middle last  org_name
#> *  <int> <int> <chr> <chr> <chr>     <chr>     <chr> <chr> <chr>  <chr> <chr>   
#> 1 1.05e9     1 3577… O200… 12-70     PART B S… NY    NA    NA     NA    ELIZABE…
#> 2 1.89e9     1 3577… O201… 00-85     PART A P… NY    NA    NA     NA    ELIZABE…
#> 3 1.41e9     0 3577… O202… 00-85     PART A P… NY    NA    NA     NA    ELIZABE…
#> 4 1.05e9     0 3577… O202… 12-70     PART B S… CT    NA    NA     NA    ELIZABE…
#> 5 1.05e9     0 3577… O202… 12-70     PART B S… FL    NA    NA     NA    ELIZABE…
#> 6 1.05e9     0 3577… O202… 12-70     PART B S… VT    NA    NA     NA    ELIZABE…
#> 7 1.05e9     0 3577… O202… 12-70     PART B S… NH    NA    NA     NA    ELIZABE…
#> 8 1.05e9     0 3577… O202… 12-70     PART B S… CO    NA    NA     NA    ELIZABE…
hospitals(org_name = "Elizabethtown Community Hospital")
#> ✔ hospitals returned 2 results.
#> # A tibble: 2 × 38
#>   enid  enid_state prov_type prov_desc    npi multi ccn   pac   org_name org_dba
#> * <chr> <chr>      <chr>     <chr>      <int> <int> <chr> <chr> <chr>    <chr>  
#> 1 O201… NY         00-85     PART A P… 1.89e9     1 3313… 3577… ELIZABE… NA     
#> 2 O202… NY         00-85     PART A P… 1.41e9     0 33Z3… 3577… ELIZABE… NA     
#> # ℹ 28 more variables: inc_date <date>, inc_state <chr>, org_type <chr>,
#> #   org_otxt <chr>, status <chr>, city <chr>, state <chr>, zip <chr>,
#> #   loc_type <chr>, loc_otxt <chr>, sub_gen <int>, sub_acute <int>,
#> #   sub_adu <int>, sub_child <int>, sub_ltc <int>, sub_psy <int>,
#> #   sub_irf <int>, sub_stc <int>, sub_sba <int>, sub_psu <int>, sub_iru <int>,
#> #   sub_spec <int>, sub_oth <int>, sub_otxt <int>, `REH CONVERSION FLAG` <chr>,
#> #   reh_date <date>, reh_ccn <chr>, address <chr>
clinicians(org_name = "Elizabethtown Community Hospital")
#> ✔ clinicians returned 58 results.
#> # A tibble: 58 × 26
#>          npi pac   enid  last  first middle suffix gender cred  school grad_year
#>  *     <int> <chr> <chr> <chr> <chr> <chr>  <chr>  <chr>  <chr> <chr>      <int>
#>  1    1.75e9 6002… I202… NOBLE GAVIN L      NA     M      MD    STATE…      1999
#>  2    1.63e9 4385… I201… AKSE… DMIT… G      NA     M      MD    STATE…      2007
#>  3    1.36e9 5991… I202… PERC… ROBE… NA     NA     M      MD    NEW Y…      2009
#>  4    1.77e9 2365… I201… LANGE BENJ… NA     NA     M      MD    HARVA…      2009
#>  5    1.15e9 9638… I201… BAMF… BENJ… NA     NA     M      MD    UNIVE…      1992
#>  6    1.76e9 8123… I202… WARN… JOSH… NA     NA     F      NP    OTHER       2023
#>  7    1.87e9 4880… I200… HOEG… DAGM… NA     NA     F      MD    OTHER       1996
#>  8    1.66e9 8921… I201… SLEE… CARLY J      NA     F      NA    ALBAN…      2012
#>  9    1.80e9 3577… I200… DEMU… ROB   L      NA     M      MD    STATE…      1996
#> 10    1.95e9 2961… I202… EAST  JAMES E      NA     M      MD    OTHER       2016
#> # ℹ 48 more rows
#> # ℹ 15 more variables: specialty <chr>, telehlth <chr>, org_name <chr>,
#> #   org_pac <chr>, org_mem <int>, ln_2_sprs <chr>, org_city <chr>,
#> #   org_state <chr>, org_zip <chr>, org_phone <chr>, ind_assgn <chr>,
#> #   grp_assgn <chr>, adrs_id <chr>, org_add <chr>, specialty <chr>
reassignments(org_name = "Elizabethtown Community Hospital")
#> ✔ reassignments returned 380 results.
#> # A tibble: 380 × 16
#>    org_pac org_enid org_name org_state `Group Due Date` employees rec_type pac  
#>  * <chr>   <chr>    <chr>    <chr>     <chr>                <int> <chr>    <chr>
#>  1 357755… O200405… Elizabe… NY        TBD                    196 Reassig… 5294…
#>  2 357755… O200405… Elizabe… NY        TBD                    196 Reassig… 5890…
#>  3 357755… O201011… Elizabe… NY        TBD                    129 Reassig… 5890…
#>  4 357755… O200405… Elizabe… NY        TBD                    196 Reassig… 4385…
#>  5 357755… O202405… Elizabe… VT        TBD                     33 Reassig… 4385…
#>  6 357755… O200405… Elizabe… NY        TBD                    196 Reassig… 5092…
#>  7 357755… O200405… Elizabe… NY        TBD                    196 Reassig… 3678…
#>  8 357755… O201011… Elizabe… NY        TBD                    129 Reassig… 3678…
#>  9 357755… O200405… Elizabe… NY        TBD                    196 Reassig… 1658…
#> 10 357755… O200405… Elizabe… NY        TBD                    196 Reassig… 8628…
#> # ℹ 370 more rows
#> # ℹ 8 more variables: enid <chr>, npi <int>, first <chr>, last <chr>,
#> #   state <chr>, specialty <chr>, `Individual Due Date` <chr>, employers <int>
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
#> $organization
#>                     V1
#> facility_type Hospital
#> facility_ccn    331302
#> parent_ccn        <NA>
#> 
#> $individual
#> # A tibble: 206 × 6
#>           npi pac        last            first   middle suffix
#>         <int> <chr>      <chr>           <chr>   <chr>  <chr> 
#>  1 1003845272 1759384035 GREENE          LAURA   A      NA    
#>  2 1013539584 9133544109 VASSILIAN       NAROD   NA     NA    
#>  3 1013595560 3375947401 TRIPLETT        EMILY   NA     NA    
#>  4 1013910256 5890719371 ACOSTAMADIEDO   JOSE    M      NA    
#>  5 1023377843 6901115278 WILHELM         LINDSEY B      NA    
#>  6 1043397656 4183764558 TRAMONTANO      ANTHONY F      NA    
#>  7 1043672140 7214229350 FIORINI FURTADO VANESSA NA     NA    
#>  8 1053686196 9234432576 O'NEILL         CONOR   NA     NA    
#>  9 1063420891 9436051687 YOUNG           JOHN    NA     NA    
#> 10 1063423523 3476552878 BENAK           ROBERT  L      NA    
#> # ℹ 196 more rows
```

That returns individual providers affiliated with the hospital. Now to
search the alphanumeric CCN (`33Z302`):

``` r

ccn2 <- affiliations(facility_ccn = "33Z302")
#> ✔ affiliations returned 4 results.
list(
  organization = as.data.frame(t(unique(ccn2[7:9]))), 
  individual = unique(ccn2[1:6]))
#> $organization
#>                         V1
#> facility_type Nursing home
#> facility_ccn        33Z302
#> parent_ccn          331302
#> 
#> $individual
#> # A tibble: 4 × 6
#>          npi pac        last     first   middle suffix
#>        <int> <chr>      <chr>    <chr>   <chr>  <chr> 
#> 1 1073258398 3870095805 KLOTZ    JEFFREY NA     NA    
#> 2 1396989059 8921259557 HALLORAN MARY    K      NA    
#> 3 1538173869 0547299091 CHON     IL      JUN    NA    
#> 4 1558659367 6709004682 BANU     DRAGOS  NA     NA
```

That returns more affiliated individual providers that practice in the
Hospital’s nursing home.

> An *alphanumeric* CCN represents a `sub-unit` of the hospital, here a
> nursing home. We would get the same result if we’d set the
> `parent_ccn` argument to the numeric CCN,
> i.e. `affiliations(parent_ccn = 331302)`
