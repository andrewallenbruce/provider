# NPPES: National Registry of Health Care Providers

Search the National Plan and Provider Enumeration System (NPPES) NPI
Registry, a free directory of all active NPI records.

## Usage

``` r
nppes(npi)
```

## Source

- [NPPES NPI Registry API](https://npiregistry.cms.hhs.gov/api-page)

## Arguments

- npi:

  `<int>` vector of National Provider Identifiers

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
containing the search results.

## National Provider Identifier (NPI)

Healthcare providers acquire their unique 10-digit NPIs to identify
themselves in a standard way throughout their industry. Once CMS
supplies an NPI, they publish the parts of the NPI record that have
public relevance, including the provider’s name, taxonomy and practice
address.

### Entity Type

Two categories of health care providers exist for NPI enumeration
purposes.

**Individual** providers may get an NPI as *Entity Type 1*.

- *Sole Proprietorship* A sole proprietor is one who does not conduct
  business as a corporation and, thus, **is not** an incorporated
  individual.

- An **incorporated individual** is an individual provider who forms and
  conducts business under a corporation. This provider may have a Type 1
  NPI while the corporation has its own Type 2 NPI.

- A solo practitioner is not necessarily a sole proprietor, and
  vice-versa. The following factors do not affect whether a sole
  proprietor is a Type 1 entity:

1.  Multiple office locations

2.  Having employees

3.  Having an EIN

**Organizational** providers are eligible for an *Entity Type 2* NPI.

- Organizational or Group providers may have a single employee or
  thousands of employees. An example is an **incorporated individual**
  who is an organization's only employee.

- Some organization health care providers are made up of parts that work
  somewhat independently from their parent organization. These parts may
  offer different types of health care or offer health care in separate
  physical locations. These parts and their physical locations aren't
  themselves legal entities but are part of the organization health care
  provider (which is a legal entity).

- The NPI Final Rule refers to the parts and locations as sub-parts. An
  organization health care provider can get its sub-parts their own
  NPIs. If a sub-part conducts any HIPAA standard transactions on its
  own (separately from its parent), it must get its own NPI. Sub-part
  determination makes sure that entities within a covered organization
  are uniquely identified in HIPAA standard transactions they conduct
  with Medicare and other covered entities.

- For example, a hospital offers acute care, laboratory, pharmacy, and
  rehabilitation services. Each of these sub-parts may need its own NPI
  because each sends its own standard transactions to one or more health
  plans. Sub-part delegation doesn't affect Entity Type 1 health care
  providers. As individuals, these health care providers can't choose
  sub-parts and are not sub-parts.

**Authorized Official**: An appointed official (e.g., chief executive
officer, chief financial officer, general partner, chairman of the
board, or direct owner) to whom the organization has granted the legal
authority to enroll it in the Medicare program, to make changes or
updates to the organization's status in the Medicare program, and to
commit the organization to fully abide by the statutes, regulations, and
program instructions of the Medicare program.

## Examples

``` r
x = c(
  1003826272, 1013647569, 1023473279, 1083295638,
  1174270805, 1225701881, 1235702796, 1255782751,
  1255877502, 1275117269, 1306500665, 1548743511,
  1588817837, 1689182859, 1841008505, 1841967825,
  1851713903, 1861857013, 1891355863, 1891390084,
  1962116806, 1982059275, 1982296737, 1992338701
)

nppes(x)
#> ✔ nppes searching 24 NPIs
#> ✔ nppes returned 24 results
#> $ind
#> $ind$basic
#> # A tibble: 6 × 10
#>          npi entity cred    first last  sex    sole other enum_date  last_update
#>        <int>  <int> <chr>   <chr> <chr> <chr> <int> <chr> <date>     <date>     
#> 1 1003826272      1 MD      JO    DEAL  F         0 JO P… 2006-08-09 2024-05-07 
#> 2 1255782751      1 MD      JOSE… DAVIS F         0 JOSE… 2016-06-26 2019-10-31 
#> 3 1255877502      1 M.A. B… JOSE… DE L… F         0 NA    2017-01-10 2018-03-27 
#> 4 1588817837      1 RN      JOSE… DAPA… F         0 NA    2008-10-30 2008-10-30 
#> 5 1841008505      1 ALC, N… JOSIE DAVI… F         1 JOSI… 2024-12-26 2024-12-26 
#> 6 1851713903      1 MSW     JOSE… DANW… F         1 NA    2014-01-08 2014-01-16 
#> 
#> $ind$taxonomy
#> # A tibble: 7 × 3
#>          npi order code      
#> *      <int> <int> <chr>     
#> 1 1851713903     1 225400000X
#> 2 1841008505     0 193400000X
#> 3 1841008505     1 101YM0800X
#> 4 1588817837     1 163W00000X
#> 5 1255877502     1 103K00000X
#> 6 1255782751     1 207Q00000X
#> 7 1003826272     1 207RI0200X
#> 
#> $ind$location
#> # A tibble: 10 × 6
#>           npi   loc city        state address                     zip      
#>  *      <int> <int> <chr>       <chr> <chr>                       <chr>    
#>  1 1003826272     1 JACKSON     MS    766 LAKELAND DR # A         392164610
#>  2 1003826272     3 LOS ANGELES CA    6255 W SUNSET BLVD FL 21    900287422
#>  3 1255782751     1 STURGIS     SD    2140 JUNCTION AVE           577852358
#>  4 1255782751     2 OMAHA       NE    983075 NEBRASKA MEDICAL CTR 681983075
#>  5 1255877502     1 WILMINGTON  CA    1233 N NEPTUNE AVE          907443134
#>  6 1255877502     3 LONG BEACH  CA    3752 ATLANTIC AVE           908076667
#>  7 1588817837     1 BRONX       NY    2160 BOLTON ST              104621364
#>  8 1841008505     1 MOBILE      AL    574 AZALEA RD STE 105       366091517
#>  9 1841008505     3 MOBILE      AL    6517 BUGGY WHIP CT          366953100
#> 10 1851713903     1 HESPERIA    CA    18302 WESTLAWN ST           923456923
#> 
#> 
#> $org
#> $org$basic
#> # A tibble: 18 × 11
#>           npi entity cred  first last  title org_name org_par org_dba enum_date 
#>         <int>  <int> <chr> <chr> <chr> <chr> <chr>    <chr>   <chr>   <date>    
#>  1 1013647569      2 DO    FAHI… SASAN Foun… PEACH S… NA      KINDBO… 2022-06-15
#>  2 1023473279      2 MD    JULIE RHEE  Medi… VIOS FE… NA      NA      2015-12-15
#>  3 1083295638      2 DO    FAHI… SASAN Foun… PEACH S… NA      KINDBO… 2021-04-15
#>  4 1174270805      2 DO    FAHI… SASAN Foun… PEACH S… NA      KINDBO… 2022-03-02
#>  5 1225701881      2 NA    KATR… MARS… Dir … VIOS FE… NA      NA      2021-07-29
#>  6 1235702796      2 NA    MARI… DEBE… SVP,… VIOS FE… NA      NA      2021-07-22
#>  7 1275117269      2 DO    FAHI… SASAN Foun… PEACH S… NA      KINDBO… 2021-05-06
#>  8 1306500665      2 DO    FAHI… SASAN Foun… PEACH S… NA      KINDBO… 2021-10-23
#>  9 1548743511      2 DO    FAHI… SASAN Owne… EMPIRE … NA      NA      2018-09-14
#> 10 1689182859      2 RMC   KATR… MARS… Dire… VIOS FE… VIOS F… VIOS F… 2018-01-22
#> 11 1841967825      2 DO    FAHI… SASAN Foun… PEACH S… NA      KINDBO… 2021-08-26
#> 12 1861857013      2 MD    AMBER COOP… Medi… CENTERS… NA      NA      2015-12-15
#> 13 1891355863      2 NA    SHIL… PATEL Chie… FAHIMEH… KBI SE… KINDBO… 2019-06-20
#> 14 1891390084      2 DO    FAHI… SASAN Foun… PEACH S… KBI SE… KINDBO… 2020-12-03
#> 15 1962116806      2 DO    FAHI… SASAN Foun… PEACH S… PEACH … KINDBO… 2023-01-05
#> 16 1982059275      2 NA    HANN… JOHN… Dire… VIOS FE… NA      NA      2016-04-25
#> 17 1982296737      2 DO    FAHI… SASAN Foun… KINDBOD… NA      NA      2021-02-03
#> 18 1992338701      2 NA    SHIL… PATEL Chie… GARDEN … KBI SE… KINDBO… 2020-02-20
#> # ℹ 1 more variable: last_update <date>
#> 
#> $org$taxonomy
#> # A tibble: 46 × 3
#>           npi order code      
#>         <int> <int> <chr>     
#>  1 1992338701     0 193200000X
#>  2 1992338701     1 207VE0102X
#>  3 1992338701     2 207V00000X
#>  4 1982296737     0 193200000X
#>  5 1982296737     1 207V00000X
#>  6 1982296737     2 207VE0102X
#>  7 1982059275     0 193400000X
#>  8 1982059275     1 207VE0102X
#>  9 1962116806     0 193200000X
#> 10 1962116806     1 207VE0102X
#> # ℹ 36 more rows
#> 
#> $org$location
#> # A tibble: 37 × 6
#>           npi   loc city         state address                        zip      
#>  *      <int> <int> <chr>        <chr> <chr>                          <chr>    
#>  1 1013647569     1 ROGERS       AR    2203 S PROMENADE BLVD STE 5185 727588722
#>  2 1013647569     3 CHICAGO      IL    333 S DESPLAINES ST STE 201    606615514
#>  3 1023473279     1 CREVE COEUR  MO    347 N LINDBERGH BLVD           631417811
#>  4 1023473279     3 SAINT LOUIS  MO    621 S NEW BALLAS RD            631418232
#>  5 1083295638     1 AUSTIN       TX    100 COLORADO ST                787014147
#>  6 1083295638     2 HOUSTON      TX    1111 UPTOWN PARK BLVD STE 2    770563224
#>  7 1083295638     2 DALLAS       TX    8041 WALNUT HILL LN STE 870    752310954
#>  8 1083295638     3 CHICAGO      IL    333 S DESPLAINES ST STE 201    606615514
#>  9 1174270805     1 PHILADELPHIA PA    1414 WALNUT ST                 191023824
#> 10 1174270805     3 CHICAGO      IL    333 S DESPLAINES ST STE 201    606615514
#> # ℹ 27 more rows
#> 
#> 
#> attr(,"class")
#> [1] "nppes" "list" 

nppes(npi = order_refer(first = "Jennifer", last = "Smith")$npi)
#> ✔ order_refer returned 135 results
#> ✔ Retrieving 1 page
#> ✔ nppes searching 135 NPIs
#> ✔ nppes returned 134 results
#> $ind
#> $ind$basic
#> # A tibble: 134 × 10
#>           npi entity first  last  sex    sole cred  other enum_date  last_update
#>         <int>  <int> <chr>  <chr> <chr> <int> <chr> <chr> <date>     <date>     
#>  1 1013227818      1 JENNI… SMITH F         0 LCSW  JENN… 2010-10-14 2023-09-26 
#>  2 1013239268      1 JENNI… SMITH F         1 LMFT  JENN… 2010-02-15 2023-11-22 
#>  3 1013467240      1 JENNI… SMITH F         0 PA-C  NA    2016-10-12 2016-10-12 
#>  4 1013988013      1 JENNI… SMITH F         0 DO    NA    2006-01-28 2021-05-12 
#>  5 1023408291      1 JENNI… SMITH F         0 NA    NA    2015-01-27 2026-01-20 
#>  6 1033486725      1 JENNI… SMITH F         0 NA    NA    2011-11-22 2025-09-17 
#>  7 1033553219      1 JENNI… SMITH F         1 M.S.  NA    2013-04-18 2013-04-18 
#>  8 1053340471      1 JENNI… SMITH F         0 PA    NA    2006-06-30 2013-09-30 
#>  9 1053842450      1 JENNI… SMITH F         0 D.O.  NA    2017-03-27 2022-07-27 
#> 10 1063080125      1 JENNI… SMITH F         0 NP    NA    2021-06-15 2021-06-15 
#> # ℹ 124 more rows
#> 
#> $ind$taxonomy
#> # A tibble: 174 × 3
#>           npi order code      
#>         <int> <int> <chr>     
#>  1 1992396162     1 103TC0700X
#>  2 1992162556     1 101YP2500X
#>  3 1982792206     1 363L00000X
#>  4 1982656898     1 2085P0229X
#>  5 1982656898     2 2085R0202X
#>  6 1982026100     1 103TC0700X
#>  7 1972574770     1 207R00000X
#>  8 1972332542     1 363LF0000X
#>  9 1962707042     1 363L00000X
#> 10 1952775413     1 363LF0000X
#> # ℹ 164 more rows
#> 
#> $ind$location
#> # A tibble: 229 × 6
#>           npi   loc city         state address                     zip      
#>  *      <int> <int> <chr>        <chr> <chr>                       <chr>    
#>  1 1013227818     1 COTTONTOWN   TN    250 OLD HIGHWAY 31 W        370484639
#>  2 1013239268     1 POST FALLS   ID    601 E SELTICE WAY STE 203   838547638
#>  3 1013467240     1 LOVELAND     CO    302 3RD ST SE               805376419
#>  4 1013467240     3 EVANS        CO    2930 11TH AVE               806201011
#>  5 1013988013     1 NORTH CONWAY NH    3073 WHITE MOUNTAIN HWY     038607101
#>  6 1023408291     1 BYRON        GA    110 JAILHOUSE ALY           310083200
#>  7 1023408291     3 ALPHARETTA   GA    4300 N POINT PKWY STE 300   300224102
#>  8 1033486725     1 NASHVILLE    TN    3601 THE VANDERBILT CLINIC  372320001
#>  9 1033486725     2 ALAMOGORDO   NM    2539 MEDICAL DR STE 104     883108720
#> 10 1033486725     3 NASHVILLE    TN    3841 GREEN HILLS VILLAGE DR 372152691
#> # ℹ 219 more rows
#> 
#> 
#> attr(,"class")
#> [1] "nppes" "list" 

nppes(uq(providers(pac = uq(clinicians(first = "Etan")$org_pac))$npi))
#> ✔ clinicians returned 12 results
#> ✔ Retrieving 1 page
#> ✔ providers returned 29 results
#> ✔ Retrieving 1 page
#> ✔ nppes searching 26 NPIs
#> ✔ nppes returned 26 results
#> ✔ nppes searching 26 NPIs
#> ✔ nppes returned 26 results
#> $org
#> $org$basic
#> # A tibble: 26 × 11
#>           npi entity first last  title org_name org_par cred  org_dba enum_date 
#>         <int>  <int> <chr> <chr> <chr> <chr>    <chr>   <chr> <chr>   <date>    
#>  1 1013967827      2 CESIA SANC… Prov… UNIVERS… NA      NA    UMIAMI… 2006-05-11
#>  2 1033578364      2 COLL… SWIN… Dire… KAISER … KAISER… NA    WOODLA… 2016-02-15
#>  3 1043378656      2 COLL… SWIN… Dire… KAISER … KAISER… NA    KAISER… 2006-12-05
#>  4 1073678637      2 COLL… SWIN… Dire… KAISER … KAISER… NA    TYSONS… 2006-12-26
#>  5 1083872535      2 AMY   DECL… Dire… LEAVITT… LEAVIT… NA    ADVANC… 2008-05-30
#>  6 1104876622      2 CESIA SANC… Prov… UNIVERS… NA      NA    UMIAMI… 2006-05-12
#>  7 1114677572      2 COLL… SWIN… Dire… KAISER … KAISER… NA    KAISER… 2022-03-28
#>  8 1285101808      2 BENJ… DOMB  Pres… AMERICA… NA      MD    NA      2018-11-01
#>  9 1295279586      2 CESIA SANC… Prov… UNIVERS… NA      NA    UMIAMI… 2016-12-06
#> 10 1306596770      2 COLL… SWIN… Dire… KAISER … KAISER… NA    KAISER… 2022-03-28
#> # ℹ 16 more rows
#> # ℹ 1 more variable: last_update <date>
#> 
#> $org$taxonomy
#> # A tibble: 64 × 3
#>           npi order code      
#>  *      <int> <int> <chr>     
#>  1 1962108753     1 261QE0700X
#>  2 1952461816     0 193200000X
#>  3 1952461816     1 302R00000X
#>  4 1952461816     2 207RG0100X
#>  5 1952461816     2 207K00000X
#>  6 1952461816     2 2085R0202X
#>  7 1952461816     2 207Q00000X
#>  8 1952461816     2 207RS0012X
#>  9 1952461816     2 133N00000X
#> 10 1952461816     2 207X00000X
#> # ℹ 54 more rows
#> 
#> $org$location
#> # A tibble: 47 × 6
#>           npi   loc city        state address                           zip     
#>  *      <int> <int> <chr>       <chr> <chr>                             <chr>   
#>  1 1013967827     1 MIAMI       FL    1611 NW 12TH AVE                  3313610…
#>  2 1033578364     1 BALTIMORE   MD    7141 SECURITY BLVD                2124418…
#>  3 1033578364     3 HYATTSVILLE MD    4000 GARDEN CITY DR               2078524…
#>  4 1043378656     1 HALETHORPE  MD    KAISER PERMANENTE-SOUTH BALTIMORE 2122735…
#>  5 1043378656     3 HYATTSVILLE MD    4000 GARDEN CITY DRIVE            2078524…
#>  6 1073678637     1 MC LEAN     VA    8008 WESTPARK DR                  2210231…
#>  7 1073678637     3 HYATTSVILLE MD    4000 GARDEN CITY DR               2078524…
#>  8 1083872535     1 SEBASTIAN   FL    484 US HIGHWAY 1                  3295884…
#>  9 1083872535     3 MAITLAND    FL    151 SOUTHHALL LN                  3275171…
#> 10 1104876622     1 MIAMI       FL    1611 NW 12TH AVE                  3313610…
#> # ℹ 37 more rows
#> 
#> 
#> attr(,"class")
#> [1] "nppes" "list" 
```
