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
#>       npi entity cred  first last  sex   sole  cert_date  enum_date  last_update
#> *   <int>  <int> <chr> <chr> <chr> <chr> <chr> <date>     <date>     <date>     
#> 1  1.00e9      1 MD    JO    DEAL  F     NO    2024-05-07 2006-08-09 2024-05-07 
#> 2  1.26e9      1 MD    JOSE… DAVIS F     NO    NA         2016-06-26 2019-10-31 
#> 3  1.26e9      1 M.A.… JOSE… DE L… F     NO    NA         2017-01-10 2018-03-27 
#> 4  1.59e9      1 RN    JOSE… DAPA… F     NO    NA         2008-10-30 2008-10-30 
#> 5  1.84e9      1 ALC,… JOSIE DAVI… F     YES   2024-12-26 2024-12-26 2024-12-26 
#> 6  1.85e9      1 MSW   JOSE… DANW… F     YES   NA         2014-01-08 2014-01-16 
#> # ℹ 1 more variable: other <chr>
#> 
#> $ind$taxonomy
#> # A tibble: 6 × 7
#>          npi code       desc                           license  prim state group
#>        <int> <chr>      <chr>                          <chr>   <int> <chr> <chr>
#> 1 1003826272 207RI0200X Internal Medicine, Infectious… 10460       1 MS    NA   
#> 2 1255782751 207Q00000X Family Medicine                7744        1 NE    NA   
#> 3 1255877502 103K00000X Behavior Analyst               1-17-2…     1 CA    NA   
#> 4 1588817837 163W00000X Registered Nurse               552550      1 NY    NA   
#> 5 1841008505 101YM0800X Counselor, Mental Health       ALC045…     1 AL    1934…
#> 6 1851713903 225400000X Rehabilitation Practitioner    NA          1 NA    NA   
#> 
#> $ind$identifier
#> # A tibble: 3 × 4
#>          npi code       issuer               state
#>        <int> <chr>      <chr>                <chr>
#> 1 1003826272 00018389   Medicaid             MS   
#> 2 1003826272 P01065367  Railroad Medicare    MS   
#> 3 1255877502 27-0383738 California Psychcare CA   
#> 
#> $ind$location
#> # A tibble: 10 × 6
#>           npi address                       loc city        zip       state
#>         <int> <chr>                       <int> <chr>       <chr>     <chr>
#>  1 1003826272 766 LAKELAND DR # A             0 JACKSON     392164610 MS   
#>  2 1003826272 6255 W SUNSET BLVD FL 21        9 LOS ANGELES 900287422 CA   
#>  3 1255782751 2140 JUNCTION AVE               0 STURGIS     577852358 SD   
#>  4 1255877502 1233 N NEPTUNE AVE              0 WILMINGTON  907443134 CA   
#>  5 1255877502 3752 ATLANTIC AVE               9 LONG BEACH  908076667 CA   
#>  6 1588817837 2160 BOLTON ST                  0 BRONX       104621364 NY   
#>  7 1841008505 574 AZALEA RD STE 105           0 MOBILE      366091517 AL   
#>  8 1841008505 6517 BUGGY WHIP CT              9 MOBILE      366953100 AL   
#>  9 1851713903 18302 WESTLAWN ST               0 HESPERIA    923456923 CA   
#> 10 1255782751 983075 NEBRASKA MEDICAL CTR     1 OMAHA       681983075 NE   
#> 
#> 
#> $org
#> $org$basic
#> # A tibble: 18 × 12
#>           npi entity cred  first    last    title org_name org_parent cert_date 
#>  *      <int>  <int> <chr> <chr>    <chr>   <chr> <chr>    <chr>      <date>    
#>  1 1013647569      2 DO    FAHIMEH  SASAN   Foun… PEACH S… NA         2024-05-20
#>  2 1023473279      2 MD    JULIE    RHEE    Medi… VIOS FE… NA         2024-02-12
#>  3 1083295638      2 DO    FAHIMEH  SASAN   Foun… PEACH S… NA         2024-05-20
#>  4 1174270805      2 DO    FAHIMEH  SASAN   Foun… PEACH S… NA         2024-05-20
#>  5 1225701881      2 NA    KATRINA  MARSHA… Dir … VIOS FE… NA         2024-02-12
#>  6 1235702796      2 NA    MARIANNE DEBENE… SVP,… VIOS FE… NA         2025-04-21
#>  7 1275117269      2 DO    FAHIMEH  SASAN   Foun… PEACH S… NA         2024-05-20
#>  8 1306500665      2 DO    FAHIMEH  SASAN   Foun… PEACH S… NA         2024-05-20
#>  9 1548743511      2 DO    FAHIMEH  SASAN   Owne… EMPIRE … NA         NA        
#> 10 1689182859      2 RMC   KATRINA  MARSHA… Dire… VIOS FE… VIOS FERT… 2023-05-03
#> 11 1841967825      2 DO    FAHIMEH  SASAN   Foun… PEACH S… NA         2024-05-20
#> 12 1861857013      2 MD    AMBER    COOPER  Medi… CENTERS… NA         2024-02-12
#> 13 1891355863      2 NA    SHILPA   PATEL   Chie… FAHIMEH… KBI SERVI… 2020-02-21
#> 14 1891390084      2 DO    FAHIMEH  SASAN   Foun… PEACH S… KBI SERVI… 2024-05-20
#> 15 1962116806      2 DO    FAHIMEH  SASAN   Foun… PEACH S… PEACH STA… 2024-05-20
#> 16 1982059275      2 NA    HANNAH   JOHNSON Dire… VIOS FE… NA         NA        
#> 17 1982296737      2 DO    FAHIMEH  SASAN   Foun… KINDBOD… NA         2021-02-03
#> 18 1992338701      2 NA    SHILPA   PATEL   Chie… GARDEN … KBI SERVI… 2020-02-20
#> # ℹ 3 more variables: enum_date <date>, last_update <date>, org_dba <chr>
#> 
#> $org$taxonomy
#> # A tibble: 30 × 7
#>           npi code       desc                          license  prim state group
#>         <int> <chr>      <chr>                         <chr>   <int> <chr> <chr>
#>  1 1013647569 207V00000X Obstetrics & Gynecology       NA          0 NA    1932…
#>  2 1013647569 207VE0102X Obstetrics & Gynecology, Rep… NA          1 NA    1932…
#>  3 1023473279 207VE0102X Obstetrics & Gynecology, Rep… 036139…     1 MO    1934…
#>  4 1083295638 261QA0006X Clinic/Center, Ambulatory Fe… NA          1 NA    NA   
#>  5 1083295638 261QF0050X Clinic/Center, Family Planni… NA          0 NA    NA   
#>  6 1174270805 207VE0102X Obstetrics & Gynecology, Rep… NA          1 NA    1932…
#>  7 1174270805 207VG0400X Obstetrics & Gynecology, Gyn… NA          0 NA    1932…
#>  8 1225701881 207VE0102X Obstetrics & Gynecology, Rep… NA          1 NA    1934…
#>  9 1235702796 207VE0102X Obstetrics & Gynecology, Rep… NA          1 NA    1934…
#> 10 1275117269 207V00000X Obstetrics & Gynecology       NA          0 NA    1932…
#> # ℹ 20 more rows
#> 
#> $org$location
#> # A tibble: 37 × 6
#>           npi address                          loc city         zip       state
#>         <int> <chr>                          <int> <chr>        <chr>     <chr>
#>  1 1013647569 2203 S PROMENADE BLVD STE 5185     0 ROGERS       727588722 AR   
#>  2 1013647569 333 S DESPLAINES ST STE 201        9 CHICAGO      606615514 IL   
#>  3 1023473279 347 N LINDBERGH BLVD               0 CREVE COEUR  631417811 MO   
#>  4 1023473279 621 S NEW BALLAS RD                9 SAINT LOUIS  631418232 MO   
#>  5 1083295638 100 COLORADO ST                    0 AUSTIN       787014147 TX   
#>  6 1083295638 333 S DESPLAINES ST STE 201        9 CHICAGO      606615514 IL   
#>  7 1174270805 1414 WALNUT ST                     0 PHILADELPHIA 191023824 PA   
#>  8 1174270805 333 S DESPLAINES ST STE 201        9 CHICAGO      606615514 IL   
#>  9 1225701881 26400 W 12 MILE RD STE 140         0 SOUTHFIELD   480341753 MI   
#> 10 1235702796 2501 NE 134TH ST STE 100           0 VANCOUVER    986863027 WA   
#> # ℹ 27 more rows
#> 
#> 
```
