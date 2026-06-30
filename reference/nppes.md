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
#> # A tibble: 6 × 5
#>          npi order code                  license    state
#> *      <int> <int> <chr>                 <chr>      <chr>
#> 1 1003826272     1 207RI0200X            10460      MS   
#> 2 1255782751     1 207Q00000X            7744       NE   
#> 3 1255877502     1 103K00000X            1-17-29529 CA   
#> 4 1588817837     1 163W00000X            552550     NY   
#> 5 1841008505     1 101YM0800X:193400000X ALC04512   AL   
#> 6 1851713903     1 225400000X            NA         NA   
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
#>  1 1003826272 766 LAKELAND DR # A             1 JACKSON     392164610 MS   
#>  2 1003826272 6255 W SUNSET BLVD FL 21        3 LOS ANGELES 900287422 CA   
#>  3 1255782751 2140 JUNCTION AVE               1 STURGIS     577852358 SD   
#>  4 1255877502 1233 N NEPTUNE AVE              1 WILMINGTON  907443134 CA   
#>  5 1255877502 3752 ATLANTIC AVE               3 LONG BEACH  908076667 CA   
#>  6 1588817837 2160 BOLTON ST                  1 BRONX       104621364 NY   
#>  7 1841008505 574 AZALEA RD STE 105           1 MOBILE      366091517 AL   
#>  8 1841008505 6517 BUGGY WHIP CT              3 MOBILE      366953100 AL   
#>  9 1851713903 18302 WESTLAWN ST               1 HESPERIA    923456923 CA   
#> 10 1255782751 983075 NEBRASKA MEDICAL CTR     2 OMAHA       681983075 NE   
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
#> # A tibble: 30 × 5
#>           npi order code                  license   state
#>  *      <int> <int> <chr>                 <chr>     <chr>
#>  1 1013647569     1 207VE0102X:193200000X NA        NA   
#>  2 1013647569     2 207V00000X:193200000X NA        NA   
#>  3 1023473279     1 207VE0102X:193400000X 036139011 MO   
#>  4 1083295638     1 261QA0006X            NA        NA   
#>  5 1083295638     2 261QF0050X            NA        NA   
#>  6 1174270805     1 207VE0102X:193200000X NA        NA   
#>  7 1174270805     2 207VG0400X:193200000X NA        NA   
#>  8 1225701881     1 207VE0102X:193400000X NA        NA   
#>  9 1235702796     1 207VE0102X:193400000X NA        NA   
#> 10 1275117269     1 207VE0102X:193200000X NA        NA   
#> # ℹ 20 more rows
#> 
#> $org$location
#> # A tibble: 37 × 6
#>           npi address                          loc city         zip       state
#>         <int> <chr>                          <int> <chr>        <chr>     <chr>
#>  1 1013647569 2203 S PROMENADE BLVD STE 5185     1 ROGERS       727588722 AR   
#>  2 1013647569 333 S DESPLAINES ST STE 201        3 CHICAGO      606615514 IL   
#>  3 1023473279 347 N LINDBERGH BLVD               1 CREVE COEUR  631417811 MO   
#>  4 1023473279 621 S NEW BALLAS RD                3 SAINT LOUIS  631418232 MO   
#>  5 1083295638 100 COLORADO ST                    1 AUSTIN       787014147 TX   
#>  6 1083295638 333 S DESPLAINES ST STE 201        3 CHICAGO      606615514 IL   
#>  7 1174270805 1414 WALNUT ST                     1 PHILADELPHIA 191023824 PA   
#>  8 1174270805 333 S DESPLAINES ST STE 201        3 CHICAGO      606615514 IL   
#>  9 1225701881 26400 W 12 MILE RD STE 140         1 SOUTHFIELD   480341753 MI   
#> 10 1235702796 2501 NE 134TH ST STE 100           1 VANCOUVER    986863027 WA   
#> # ℹ 27 more rows
#> 
#> 
```
