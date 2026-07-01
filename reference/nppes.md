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

### Entity Type: Two categories of health care providers exist for NPI

enumeration purposes:

- **Type 1**: **Individual** providers may get an NPI as *Entity Type
  1*.

*Sole Proprietorship* A sole proprietor is one who does not conduct
business as a corporation and, thus, **is not** an incorporated
individual.

An **incorporated individual** is an individual provider who forms and
conducts business under a corporation. This provider may have a Type 1
NPI while the corporation has its own Type 2 NPI.

A solo practitioner is not necessarily a sole proprietor, and
vice-versa. The following factors do not affect whether a sole
proprietor is a Type 1 entity:

- Multiple office locations

- Having employees

- Having an EIN

&nbsp;

- **Type 2**: **Organizational** providers are eligible for an *Entity
  Type 2* NPI.

Organizational or Group providers may have a single employee or
thousands of employees. An example is an **incorporated individual** who
is an organization's only employee.

Some organization health care providers are made up of parts that work
somewhat independently from their parent organization. These parts may
offer different types of health care or offer health care in separate
physical locations. These parts and their physical locations aren't
themselves legal entities but are part of the organization health care
provider (which is a legal entity).

The NPI Final Rule refers to the parts and locations as sub-parts. An
organization health care provider can get its sub-parts their own NPIs.
If a sub-part conducts any HIPAA standard transactions on its own
(separately from its parent), it must get its own NPI. Sub-part
determination makes sure that entities within a covered organization are
uniquely identified in HIPAA standard transactions they conduct with
Medicare and other covered entities.

For example, a hospital offers acute care, laboratory, pharmacy, and
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
  1003826272, 1013647569, 1023473279, 1083295638, 1174270805,
  1225701881, 1235702796, 1255782751, 1255877502, 1275117269,
  1306500665, 1548743511, 1588817837, 1689182859, 1841008505,
  1841967825, 1851713903, 1861857013, 1891355863, 1891390084,
  1962116806, 1982059275, 1982296737, 1992338701
)

nppes(x)
#> $ind
#> $ind$basic
#> # A tibble: 6 × 11
#>          npi entity cred     first last  sex   sole  other cert_date  enum_date 
#>        <int>  <int> <chr>    <chr> <chr> <chr> <chr> <chr> <date>     <date>    
#> 1 1003826272      1 MD       JO    DEAL  F     NO    JO P… 2024-05-07 2006-08-09
#> 2 1255782751      1 MD       JOSE… DAVIS F     NO    JOSE… NA         2016-06-26
#> 3 1255877502      1 M.A. BC… JOSE… DE L… F     NO    NA    NA         2017-01-10
#> 4 1588817837      1 RN       JOSE… DAPA… F     NO    NA    NA         2008-10-30
#> 5 1841008505      1 ALC, NCC JOSIE DAVI… F     YES   JOSI… 2024-12-26 2024-12-26
#> 6 1851713903      1 MSW      JOSE… DANW… F     YES   NA    NA         2014-01-08
#> # ℹ 1 more variable: last_update <date>
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
#> # A tibble: 18 × 12
#>           npi entity cred  first last  title org_name org_par org_dba cert_date 
#>         <int>  <int> <chr> <chr> <chr> <chr> <chr>    <chr>   <chr>   <date>    
#>  1 1013647569      2 DO    FAHI… SASAN Foun… PEACH S… NA      KINDBO… 2024-05-20
#>  2 1023473279      2 MD    JULIE RHEE  Medi… VIOS FE… NA      NA      2024-02-12
#>  3 1083295638      2 DO    FAHI… SASAN Foun… PEACH S… NA      KINDBO… 2024-05-20
#>  4 1174270805      2 DO    FAHI… SASAN Foun… PEACH S… NA      KINDBO… 2024-05-20
#>  5 1225701881      2 NA    KATR… MARS… Dir … VIOS FE… NA      NA      2024-02-12
#>  6 1235702796      2 NA    MARI… DEBE… SVP,… VIOS FE… NA      NA      2025-04-21
#>  7 1275117269      2 DO    FAHI… SASAN Foun… PEACH S… NA      KINDBO… 2024-05-20
#>  8 1306500665      2 DO    FAHI… SASAN Foun… PEACH S… NA      KINDBO… 2024-05-20
#>  9 1548743511      2 DO    FAHI… SASAN Owne… EMPIRE … NA      NA      NA        
#> 10 1689182859      2 RMC   KATR… MARS… Dire… VIOS FE… VIOS F… VIOS F… 2023-05-03
#> 11 1841967825      2 DO    FAHI… SASAN Foun… PEACH S… NA      KINDBO… 2024-05-20
#> 12 1861857013      2 MD    AMBER COOP… Medi… CENTERS… NA      NA      2024-02-12
#> 13 1891355863      2 NA    SHIL… PATEL Chie… FAHIMEH… KBI SE… KINDBO… 2020-02-21
#> 14 1891390084      2 DO    FAHI… SASAN Foun… PEACH S… KBI SE… KINDBO… 2024-05-20
#> 15 1962116806      2 DO    FAHI… SASAN Foun… PEACH S… PEACH … KINDBO… 2024-05-20
#> 16 1982059275      2 NA    HANN… JOHN… Dire… VIOS FE… NA      NA      NA        
#> 17 1982296737      2 DO    FAHI… SASAN Foun… KINDBOD… NA      NA      2021-02-03
#> 18 1992338701      2 NA    SHIL… PATEL Chie… GARDEN … KBI SE… KINDBO… 2020-02-20
#> # ℹ 2 more variables: enum_date <date>, last_update <date>
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
```
