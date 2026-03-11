# Linking Providers

## NPIs, PACs, ENIDs, CCNs, CLIAs and Many More

``` r
pac <- affiliations(pac = 7810891009)
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
ccn <- hospitals(ccn = unique(pac$facility_ccn))
ccn
```

    #> # A tibble: 5 × 39
    #>   org_name     dba_name enid  enid_state spec  specialty npi   multi ccn   ccn_2
    #>   <chr>        <chr>    <chr> <chr>      <chr> <chr>     <chr> <chr> <chr> <chr>
    #> 1 CHAMPLAIN V… THE UNI… O201… NY         00-09 PART A P… 1033… N     3302… NA   
    #> 2 ALICE HYDE … THE UNI… O202… NY         00-85 PART A P… 1114… N     3313… NA   
    #> 3 CENTRAL VER… NA       O200… VT         00-09 PART A P… 1508… N     4700… NA   
    #> 4 UNIVERSITY … UNIVERS… O200… VT         00-09 PART A P… 1568… N     4700… NA   
    #> 5 PORTER HOSP… NA       O200… VT         00-85 PART A P… 1740… Y     4713… NA   
    #> # ℹ 29 more variables: pac <chr>, inc_date <chr>, inc_state <chr>,
    #> #   org_type <chr>, org_text <chr>, designation <chr>, add_1 <chr>,
    #> #   add_2 <chr>, city <chr>, state <chr>, zip <chr>, location_type <chr>,
    #> #   location_text <chr>, reh_ind <chr>, reh_date <chr>, sub_general <chr>,
    #> #   sub_acute <chr>, sub_drug <chr>, sub_child <chr>, sub_long <chr>,
    #> #   sub_psych <chr>, sub_rehab <chr>, sub_short <chr>, sub_swing <chr>,
    #> #   sub_psych_unit <chr>, sub_rehab_unit <chr>, sub_specialty <chr>, …

  

Exploring links between providers can lead to many interesting insights.
For example, there is a hospital in New York named **Elizabethtown
Community Hospital**.

``` r
providers(org_name = "Elizabethtown Community Hospital")
```

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

  

The **Hospital Enrollment** API includes only Medicare Part A (hospital)
providers, so we only get two rows back, but those include a new data
point: two facility CCNs. Plugging those into the **Facility
Affiliations** API, we can retrieve information on the individual
providers practicing at this hospital. First, the all-numeric CCN
(`331302`):

  

``` r
ccn <- affiliations(facility_ccn = 331302)
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
