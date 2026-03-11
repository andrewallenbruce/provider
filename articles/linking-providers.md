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
    #> 3 Hospital      331321       NA        
    #> 4 Hospital      470001       NA        
    #> 5 Hospital      471307       NA

``` r
ccn <- hospitals(ccn = unique(pac$facility_ccn))
ccn
```

    #> # A tibble: 5 × 39
    #>   enid    enid_state spec_cd specialty npi   multi ccn   pac   org_name dba_name
    #>   <chr>   <chr>      <chr>   <chr>     <chr> <chr> <chr> <chr> <chr>    <chr>   
    #> 1 O20120… NY         00-09   PART A P… 1033… N     3302… 2769… CHAMPLA… THE UNI…
    #> 2 O20230… NY         00-85   PART A P… 1114… N     3313… 4082… ALICE H… THE UNI…
    #> 3 O20050… VT         00-09   PART A P… 1508… N     4700… 9335… CENTRAL… NA      
    #> 4 O20021… VT         00-09   PART A P… 1568… N     4700… 3779… UNIVERS… UNIVERS…
    #> 5 O20061… VT         00-85   PART A P… 1740… Y     4713… 1850… PORTER … NA      
    #> # ℹ 29 more variables: inc_date <chr>, inc_state <chr>, org_type <chr>,
    #> #   org_text <chr>, designation <chr>, add_1 <chr>, add_2 <chr>, city <chr>,
    #> #   state <chr>, zip <chr>, location_type <chr>, location_text <chr>,
    #> #   sub_general <chr>, sub_acute <chr>, sub_drug <chr>, sub_child <chr>,
    #> #   sub_long <chr>, sub_psych <chr>, sub_rehab <chr>, sub_short <chr>,
    #> #   sub_swing <chr>, sub_psych_unit <chr>, sub_rehab_unit <chr>,
    #> #   sub_specialty <chr>, sub_other <chr>, sub_otext <chr>, reh_ind <chr>, …

  

Exploring links between providers can lead to many interesting insights.
For example, there is a hospital in New York named **Elizabethtown
Community Hospital**.

``` r
providers(org_name = "Elizabethtown Community Hospital")
```

    #> # A tibble: 9 × 11
    #>   npi        multi pac   enid  spec  specialty state last  first middle org_name
    #>   <chr>      <chr> <chr> <chr> <chr> <chr>     <chr> <chr> <chr> <chr>  <chr>   
    #> 1 1053656744 Y     3577… O200… 12-70 PART B S… NY    NA    NA    NA     ELIZABE…
    #> 2 1891785184 Y     3577… O201… 00-85 PART A P… NY    NA    NA    NA     ELIZABE…
    #> 3 1487923637 N     3577… O201… 12-59 PART B S… NY    NA    NA    NA     ELIZABE…
    #> 4 1407061591 N     3577… O202… 00-85 PART A P… NY    NA    NA    NA     ELIZABE…
    #> 5 1053656744 N     3577… O202… 12-70 PART B S… CT    NA    NA    NA     ELIZABE…
    #> 6 1053656744 N     3577… O202… 12-70 PART B S… FL    NA    NA    NA     ELIZABE…
    #> 7 1053656744 N     3577… O202… 12-70 PART B S… VT    NA    NA    NA     ELIZABE…
    #> 8 1053656744 N     3577… O202… 12-70 PART B S… NH    NA    NA    NA     ELIZABE…
    #> 9 1053656744 N     3577… O202… 12-70 PART B S… CO    NA    NA    NA     ELIZABE…

``` r
hospitals(org_name = "Elizabethtown Community Hospital")
```

    #> # A tibble: 2 × 39
    #>   enid    enid_state spec_cd specialty npi   multi ccn   pac   org_name dba_name
    #>   <chr>   <chr>      <chr>   <chr>     <chr> <chr> <chr> <chr> <chr>    <chr>   
    #> 1 O20101… NY         00-85   PART A P… 1891… Y     3313… 3577… ELIZABE… NA      
    #> 2 O20220… NY         00-85   PART A P… 1407… N     33Z3… 3577… ELIZABE… NA      
    #> # ℹ 29 more variables: inc_date <chr>, inc_state <chr>, org_type <chr>,
    #> #   org_text <chr>, designation <chr>, add_1 <chr>, add_2 <chr>, city <chr>,
    #> #   state <chr>, zip <chr>, location_type <chr>, location_text <chr>,
    #> #   sub_general <chr>, sub_acute <chr>, sub_drug <chr>, sub_child <chr>,
    #> #   sub_long <chr>, sub_psych <chr>, sub_rehab <chr>, sub_short <chr>,
    #> #   sub_swing <chr>, sub_psych_unit <chr>, sub_rehab_unit <chr>,
    #> #   sub_specialty <chr>, sub_other <chr>, sub_otext <chr>, reh_ind <chr>, …

  

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
    #>    npi        pac        last            first   middle suffix
    #>    <chr>      <chr>      <chr>           <chr>   <chr>  <chr> 
    #>  1 1003845272 1759384035 GREENE          LAURA   A      NA    
    #>  2 1013141860 8022069558 KAMPSCHROR      DEBORAH M      NA    
    #>  3 1013539584 9133544109 VASSILIAN       NAROD   NA     NA    
    #>  4 1013595560 3375947401 TRIPLETT        EMILY   NA     NA    
    #>  5 1013910256 5890719371 ACOSTAMADIEDO   JOSE    M      NA    
    #>  6 1023377843 6901115278 WILHELM         LINDSEY B      NA    
    #>  7 1043672140 7214229350 FIORINI FURTADO VANESSA NA     NA    
    #>  8 1063420891 9436051687 YOUNG           JOHN    NA     NA    
    #>  9 1073073177 0547593097 OSBORN          DELANEY NA     NA    
    #> 10 1073133435 6800318452 GILL            ANGAD   NA     NA    
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
    #>   npi        pac        last     first   middle suffix
    #>   <chr>      <chr>      <chr>    <chr>   <chr>  <chr> 
    #> 1 1073258398 3870095805 KLOTZ    JEFFREY NA     NA    
    #> 2 1396989059 8921259557 HALLORAN MARY    K      NA    
    #> 3 1538173869 0547299091 CHON     IL      JUN    NA    
    #> 4 1558659367 6709004682 BANU     DRAGOS  NA     NA

  

That returns more affiliated individual providers that practice in the
Hospital’s nursing home..

  

> An *alphanumeric* CCN represents a sub-unit of the hospital, here a
> nursing home. We would get the same result if we’d set the
> `parent_ccn` argument to the numeric CCN,
> i.e. `affiliations(parent_ccn = 331302)`
