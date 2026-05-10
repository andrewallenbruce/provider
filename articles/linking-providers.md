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
#> Error in `pac[7:9]`:
#> ! Can't subset columns past the end.
#> ℹ Location 9 doesn't exist.
#> ℹ There are only 8 columns.
```

``` r

ccn <- hospitals(ccn = pac$facility_ccn)
#> ✔ hospitals returned 5 results.
ccn |> str()
#> tibble [5 × 17] (S3: tbl_df/tbl/data.frame)
#>  $ enid    : chr [1:5] "O20120110000201" "O20050809000650" "O20021111000009" "O20040812001170" ...
#>  $ npi     : int [1:5] 1033270699 1508845637 1568419976 1306849708 1740291400
#>  $ multi   : int [1:5] 0 0 0 0 1
#>  $ ccn     : chr [1:5] "330250" "470001" "470003" "470011" ...
#>  $ pac     : chr [1:5] "2769396878" "9335138817" "3779491071" "9335112929" ...
#>  $ org_name: chr [1:5] "CHAMPLAIN VALLEY PHYSICIANS HOSPITAL MEDICAL CENTER" "CENTRAL VERMONT MEDICAL CENTER INC" "UNIVERSITY OF VERMONT MEDICAL CENTER INC" "BRATTLEBORO MEMORIAL HOSPITAL" ...
#>  $ org_dba : chr [1:5] "THE UNIVERSITY OF VT HEALTH NETWORK - CHAMPLAIN VALLEY PHYSICIANS HOSP" NA "UNIVERSITY OF VERMONT MEDICAL CENTER" NA ...
#>  $ inc_date: Date[1:5], format: "1926-01-01" "1984-03-01" ...
#>  $ org_type: chr [1:5] "CORPORATION" "CORPORATION" "CORPORATION" "CORPORATION" ...
#>  $ status  : chr [1:5] "N" "N" "N" "N" ...
#>  $ address : chr [1:5] "75 BEEKMAN ST" "130 FISHER RD" "111 COLCHESTER AVE" "17 BELMONT AVE" ...
#>  $ city    : chr [1:5] "PLATTSBURGH" "BERLIN" "BURLINGTON" "BRATTLEBORO" ...
#>  $ state   : chr [1:5] "NY" "VT" "VT" "VT" ...
#>  $ zip     : chr [1:5] "129011438" "56029516" "54011473" "53017601" ...
#>  $ loc_type: chr [1:5] "MAIN/PRIMARY HOSPITAL LOCATION" "MAIN/PRIMARY HOSPITAL LOCATION" "OTHER: HOSPITAL - GENERAL PRACTICE AND CLINICS" "OTHER HOSPITAL PRACTICE LOCATION" ...
#>  $ reh_date: Date[1:5], format: NA NA ...
#>  $ subgroup: chr [1:5] "Acute" "Acute" "Acute" "General" ...
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
#>    <int> <int> <chr> <chr> <chr>     <chr>     <chr> <chr> <chr>  <chr> <chr>   
#> 1 1.05e9     1 3577… O200… 12-70     PART B S… NY    NA    NA     NA    ELIZABE…
#> 2 1.05e9     0 3577… O202… 12-70     PART B S… CT    NA    NA     NA    ELIZABE…
#> 3 1.05e9     0 3577… O202… 12-70     PART B S… FL    NA    NA     NA    ELIZABE…
#> 4 1.05e9     0 3577… O202… 12-70     PART B S… VT    NA    NA     NA    ELIZABE…
#> 5 1.05e9     0 3577… O202… 12-70     PART B S… NH    NA    NA     NA    ELIZABE…
#> 6 1.05e9     0 3577… O202… 12-70     PART B S… CO    NA    NA     NA    ELIZABE…
#> 7 1.41e9     0 3577… O202… 00-85     PART A P… NY    NA    NA     NA    ELIZABE…
#> 8 1.89e9     1 3577… O201… 00-85     PART A P… NY    NA    NA     NA    ELIZABE…
hospitals(org_name = "Elizabethtown Community Hospital")
#> ✔ hospitals returned 2 results.
#> # A tibble: 2 × 17
#>   enid         npi multi ccn   pac   org_name org_dba inc_date   org_type status
#> * <chr>      <int> <int> <chr> <chr> <chr>    <chr>   <date>     <chr>    <chr> 
#> 1 O2010111… 1.89e9     1 3313… 3577… ELIZABE… NA      1926-05-08 CORPORA… N     
#> 2 O2022082… 1.41e9     0 33Z3… 3577… ELIZABE… NA      1926-05-08 CORPORA… N     
#> # ℹ 7 more variables: address <chr>, city <chr>, state <chr>, zip <chr>,
#> #   loc_type <chr>, reh_date <date>, subgroup <chr>
clinicians(org_name = "Elizabethtown Community Hospital")
#> ✔ clinicians returned 58 results.
#> # A tibble: 58 × 18
#>       npi pac   enid  last  first middle gender cred  school grad_year specialty
#>     <int> <chr> <chr> <chr> <chr> <chr>  <chr>  <chr> <chr>      <int> <chr>    
#>  1 1.75e9 6002… I202… NOBLE GAVIN L      M      MD    STATE…      1999 INTERNAL…
#>  2 1.63e9 4385… I201… AKSE… DMIT… G      M      MD    STATE…      2007 DIAGNOST…
#>  3 1.36e9 5991… I202… PERC… ROBE… NA     M      MD    NEW Y…      2009 INTERVEN…
#>  4 1.77e9 2365… I201… LANGE BENJ… NA     M      MD    HARVA…      2009 INTERVEN…
#>  5 1.15e9 9638… I201… BAMF… BENJ… NA     M      MD    UNIVE…      1992 DIAGNOST…
#>  6 1.76e9 8123… I202… WARN… JOSH… NA     F      NP    OTHER       2023 NURSE PR…
#>  7 1.87e9 4880… I200… HOEG… DAGM… NA     F      MD    OTHER       1996 DIAGNOST…
#>  8 1.66e9 8921… I201… SLEE… CARLY J      F      NA    ALBAN…      2012 PHYSICIA…
#>  9 1.80e9 3577… I200… DEMU… ROB   L      M      MD    STATE…      1996 INTERNAL…
#> 10 1.95e9 2961… I202… EAST  JAMES E      M      MD    OTHER       2016 DIAGNOST…
#> # ℹ 48 more rows
#> # ℹ 7 more variables: org_name <chr>, org_pac <chr>, members <int>,
#> #   address <chr>, city <chr>, state <chr>, zip <chr>
reassignments(org_name = "Elizabethtown Community Hospital")
#> ✔ reassignments returned 380 results.
#> # A tibble: 380 × 13
#>    org_pac  org_enid org_name org_state employees pac   enid     npi first last 
#>  * <chr>    <chr>    <chr>    <chr>         <int> <chr> <chr>  <int> <chr> <chr>
#>  1 3577554… O200405… Elizabe… NY              196 5294… I202… 1.34e9 Nath… Abis…
#>  2 3577554… O200405… Elizabe… NY              196 5890… I201… 1.01e9 Jose  Acos…
#>  3 3577554… O201011… Elizabe… NY              129 5890… I201… 1.01e9 Jose  Acos…
#>  4 3577554… O200405… Elizabe… NY              196 4385… I202… 1.63e9 Dmit… Akse…
#>  5 3577554… O202405… Elizabe… VT               33 4385… I201… 1.63e9 Dmit… Akse…
#>  6 3577554… O200405… Elizabe… NY              196 5092… I201… 1.95e9 Vlada Alex…
#>  7 3577554… O200405… Elizabe… NY              196 3678… I201… 1.72e9 Anel  Alex…
#>  8 3577554… O201011… Elizabe… NY              129 3678… I201… 1.72e9 Anel  Alex…
#>  9 3577554… O200405… Elizabe… NY              196 1658… I201… 1.77e9 Loren Allen
#> 10 3577554… O200405… Elizabe… NY              196 8628… I202… 1.24e9 Nich… Also…
#> # ℹ 370 more rows
#> # ℹ 3 more variables: state <chr>, specialty <chr>, employers <int>
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
#> Error in `ccn[7:9]`:
#> ! Can't subset columns past the end.
#> ℹ Location 9 doesn't exist.
#> ℹ There are only 8 columns.
```

That returns individual providers affiliated with the hospital. Now to
search the alphanumeric CCN (`33Z302`):

``` r

ccn2 <- affiliations(facility_ccn = "33Z302")
#> ✔ affiliations returned 4 results.
list(
  organization = as.data.frame(t(unique(ccn2[7:9]))), 
  individual = unique(ccn2[1:6]))
#> Error in `ccn2[7:9]`:
#> ! Can't subset columns past the end.
#> ℹ Location 9 doesn't exist.
#> ℹ There are only 8 columns.
```

That returns more affiliated individual providers that practice in the
Hospital’s nursing home.

> An *alphanumeric* CCN represents a `sub-unit` of the hospital, here a
> nursing home. We would get the same result if we’d set the
> `parent_ccn` argument to the numeric CCN,
> i.e. `affiliations(parent_ccn = 331302)`
