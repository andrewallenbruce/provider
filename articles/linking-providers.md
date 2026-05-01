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
#> 3 Hospital      470001       NA        
#> 4 Hospital      471307       NA        
#> 5 Hospital      470011       NA
```

``` r

ccn <- hospitals(ccn = pac$facility_ccn)
#> ✔ hospitals returned 5 results.
ccn |> str()
#> 'data.frame':    5 obs. of  39 variables:
#>  $ ENROLLMENT ID                 : chr  "O20120110000201" "O20050809000650" "O20021111000009" "O20040812001170" ...
#>  $ ENROLLMENT STATE              : chr  "NY" "VT" "VT" "VT" ...
#>  $ PROVIDER TYPE CODE            : chr  "00-09" "00-09" "00-09" "00-09" ...
#>  $ PROVIDER TYPE TEXT            : chr  "PART A PROVIDER - HOSPITAL" "PART A PROVIDER - HOSPITAL" "PART A PROVIDER - HOSPITAL" "PART A PROVIDER - HOSPITAL" ...
#>  $ NPI                           : chr  "1033270699" "1508845637" "1568419976" "1306849708" ...
#>  $ MULTIPLE NPI FLAG             : chr  "N" "N" "N" "N" ...
#>  $ CCN                           : chr  "330250" "470001" "470003" "470011" ...
#>  $ ASSOCIATE ID                  : chr  "2769396878" "9335138817" "3779491071" "9335112929" ...
#>  $ ORGANIZATION NAME             : chr  "CHAMPLAIN VALLEY PHYSICIANS HOSPITAL MEDICAL CENTER" "CENTRAL VERMONT MEDICAL CENTER INC" "UNIVERSITY OF VERMONT MEDICAL CENTER INC" "BRATTLEBORO MEMORIAL HOSPITAL" ...
#>  $ DOING BUSINESS AS NAME        : chr  "THE UNIVERSITY OF VT HEALTH NETWORK - CHAMPLAIN VALLEY PHYSICIANS HOSP" "" "UNIVERSITY OF VERMONT MEDICAL CENTER" "" ...
#>  $ INCORPORATION DATE            : chr  "1926-01-01" "1984-03-01" "1995-01-01" "1904-10-26" ...
#>  $ INCORPORATION STATE           : chr  "NY" "VT" "VT" "VT" ...
#>  $ ORGANIZATION TYPE STRUCTURE   : chr  "CORPORATION" "CORPORATION" "CORPORATION" "CORPORATION" ...
#>  $ ORGANIZATION OTHER TYPE TEXT  : chr  "" "" "" "" ...
#>  $ PROPRIETARY NONPROFIT         : chr  "N" "N" "N" "N" ...
#>  $ ADDRESS LINE 1                : chr  "75 BEEKMAN ST" "130 FISHER RD" "111 COLCHESTER AVE" "17 BELMONT AVE" ...
#>  $ ADDRESS LINE 2                : chr  "" "" "" "" ...
#>  $ CITY                          : chr  "PLATTSBURGH" "BERLIN" "BURLINGTON" "BRATTLEBORO" ...
#>  $ STATE                         : chr  "NY" "VT" "VT" "VT" ...
#>  $ ZIP CODE                      : chr  "129011438" "56029516" "54011473" "53017601" ...
#>  $ PRACTICE LOCATION TYPE        : chr  "MAIN/PRIMARY HOSPITAL LOCATION" "MAIN/PRIMARY HOSPITAL LOCATION" "OTHER HOSPITAL PRACTICE LOCATION" "OTHER HOSPITAL PRACTICE LOCATION" ...
#>  $ LOCATION OTHER TYPE TEXT      : chr  "" "" "HOSPITAL - GENERAL PRACTICE AND CLINICS" "" ...
#>  $ SUBGROUP - GENERAL            : chr  "N" "N" "N" "Y" ...
#>  $ SUBGROUP - ACUTE CARE         : chr  "Y" "Y" "Y" "N" ...
#>  $ SUBGROUP - ALCOHOL DRUG       : chr  "N" "N" "N" "N" ...
#>  $ SUBGROUP - CHILDRENS          : chr  "N" "N" "N" "N" ...
#>  $ SUBGROUP - LONG-TERM          : chr  "N" "N" "N" "N" ...
#>  $ SUBGROUP - PSYCHIATRIC        : chr  "N" "N" "N" "N" ...
#>  $ SUBGROUP - REHABILITATION     : chr  "N" "N" "N" "N" ...
#>  $ SUBGROUP - SHORT-TERM         : chr  "N" "N" "N" "N" ...
#>  $ SUBGROUP - SWING-BED APPROVED : chr  "N" "N" "N" "N" ...
#>  $ SUBGROUP - PSYCHIATRIC UNIT   : chr  "N" "N" "N" "N" ...
#>  $ SUBGROUP - REHABILITATION UNIT: chr  "N" "N" "N" "N" ...
#>  $ SUBGROUP - SPECIALTY HOSPITAL : chr  "N" "N" "N" "N" ...
#>  $ SUBGROUP - OTHER              : chr  "N" "N" "Y" "N" ...
#>  $ SUBGROUP - OTHER TEXT         : chr  "" "" "ORGAN TRANSPLANT PROGRAM" "" ...
#>  $ REH CONVERSION FLAG           : chr  "N" "N" "N" "N" ...
#>  $ REH CONVERSION DATE           : chr  "" "" "" "" ...
#>  $ CAH OR HOSPITAL CCN           : chr  "" "" "" "" ...
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
#> * <chr>    <chr> <chr>  <chr> <chr> <chr>     <chr>      <int> <int> <chr> <chr>
#> 1 ELIZABE… NA    NA     NA    NY    12-70     PART B S… 1.05e9     1 3577… O200…
#> 2 ELIZABE… NA    NA     NA    NY    00-85     PART A P… 1.89e9     1 3577… O201…
#> 3 ELIZABE… NA    NA     NA    NY    00-85     PART A P… 1.41e9     0 3577… O202…
#> 4 ELIZABE… NA    NA     NA    CT    12-70     PART B S… 1.05e9     0 3577… O202…
#> 5 ELIZABE… NA    NA     NA    FL    12-70     PART B S… 1.05e9     0 3577… O202…
#> 6 ELIZABE… NA    NA     NA    VT    12-70     PART B S… 1.05e9     0 3577… O202…
#> 7 ELIZABE… NA    NA     NA    NH    12-70     PART B S… 1.05e9     0 3577… O202…
#> 8 ELIZABE… NA    NA     NA    CO    12-70     PART B S… 1.05e9     0 3577… O202…
hospitals(org_name = "Elizabethtown Community Hospital")
#> ✔ hospitals returned 2 results.
clinicians(org_name = "Elizabethtown Community Hospital")
#> ✔ clinicians returned 58 results.
#> # A tibble: 58 × 21
#>    first    middle last    suffix gender cred  school grad_year specialty    npi
#>  * <chr>    <chr>  <chr>   <chr>  <chr>  <chr> <chr>      <int> <chr>      <int>
#>  1 GAVIN    L      NOBLE   NA     M      MD    STATE…      1999 CARDIOVA… 1.75e9
#>  2 DMITRIY  G      AKSELR… NA     M      MD    STATE…      2007 DIAGNOST… 1.63e9
#>  3 ROBERT   NA     PERCAR… NA     M      MD    NEW Y…      2009 INTERVEN… 1.36e9
#>  4 BENJAMIN NA     LANGE   NA     M      MD    HARVA…      2009 DIAGNOST… 1.77e9
#>  5 BENJAMIN NA     BAMFORD NA     M      MD    UNIVE…      1992 DIAGNOST… 1.15e9
#>  6 JOSHUA   NA     WARNER  NA     F      NP    OTHER       2023 NURSE PR… 1.76e9
#>  7 DAGMAR   NA     HOEGEM… NA     F      MD    OTHER       1996 DIAGNOST… 1.87e9
#>  8 CARLY    J      SLEEPER NA     F      NA    ALBAN…      2012 PHYSICIA… 1.66e9
#>  9 ROB      L      DEMURO  NA     M      MD    STATE…      1996 INTERNAL… 1.80e9
#> 10 JAMES    E      EAST    NA     M      MD    OTHER       2016 DIAGNOST… 1.95e9
#> # ℹ 48 more rows
#> # ℹ 11 more variables: pac <chr>, enid <chr>, org_name <chr>, org_pac <chr>,
#> #   org_mem <int>, org_city <chr>, org_state <chr>, org_zip <chr>,
#> #   org_phone <chr>, org_add <chr>, specialty <chr>
reassignments(org_name = "Elizabethtown Community Hospital")
#> ✔ reassignments returned 370 results.
#> # A tibble: 370 × 14
#>    first   last  state specialty employers    npi pac   enid  org_name employees
#>  * <chr>   <chr> <chr> <chr>         <int>  <int> <chr> <chr> <chr>        <int>
#>  1 Nathal… Abis… NY    Family P…         1 1.34e9 5294… I202… Elizabe…       193
#>  2 Jose    Acos… NY    Medical …         5 1.01e9 5890… I201… Elizabe…       193
#>  3 Jose    Acos… NY    Medical …         5 1.01e9 5890… I201… Elizabe…       121
#>  4 Dmitriy Akse… NY    Diagnost…         4 1.63e9 4385… I202… Elizabe…       193
#>  5 Dmitriy Akse… VT    Diagnost…         6 1.63e9 4385… I201… Elizabe…        33
#>  6 Vlada   Alex… NY    Pathology         3 1.95e9 5092… I201… Elizabe…       193
#>  7 Anel    Alex… NY    Emergenc…         6 1.72e9 3678… I201… Elizabe…       193
#>  8 Anel    Alex… NY    Emergenc…         6 1.72e9 3678… I201… Elizabe…       121
#>  9 Loren   Allen NY    Nurse Pr…         2 1.77e9 1658… I201… Elizabe…       193
#> 10 Nichol… Also… NY    Emergenc…         5 1.24e9 8628… I202… Elizabe…       193
#> # ℹ 360 more rows
#> # ℹ 4 more variables: org_pac <chr>, org_enid <chr>, org_state <chr>,
#> #   rec_type <chr>
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
#>    first   last            middle suffix        npi pac       
#>    <chr>   <chr>           <chr>  <chr>       <int> <chr>     
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
  individual = unique(ccn2[1:6]))
#> $organization
#>                         V1
#> facility_type Nursing home
#> facility_ccn        33Z302
#> parent_ccn          331302
#> 
#> $individual
#> # A tibble: 4 × 6
#>   first   last     middle suffix        npi pac       
#>   <chr>   <chr>    <chr>  <chr>       <int> <chr>     
#> 1 JEFFREY KLOTZ    NA     NA     1073258398 3870095805
#> 2 MARY    HALLORAN K      NA     1396989059 8921259557
#> 3 IL      CHON     JUN    NA     1538173869 0547299091
#> 4 DRAGOS  BANU     NA     NA     1558659367 6709004682
```

That returns more affiliated individual providers that practice in the
Hospital’s nursing home.

> An *alphanumeric* CCN represents a `sub-unit` of the hospital, here a
> nursing home. We would get the same result if we’d set the
> `parent_ccn` argument to the numeric CCN,
> i.e. `affiliations(parent_ccn = 331302)`
