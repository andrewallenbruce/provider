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
#> Error in nppes_other(x, ind): `middle` is not a column in `x`.

nppes(npi = order_refer(first = "Jennifer", last = "Smith")$npi)
#> ✔ order_refer returned 135 results
#> ✔ Retrieving 1 page
#> $ind
#> $ind$basic
#> # A tibble: 134 × 11
#>           npi entity cred  first   last  sex   sole  other cert_date  enum_date 
#>         <int>  <int> <chr> <chr>   <chr> <chr> <chr> <chr> <date>     <date>    
#>  1 1013227818      1 LCSW  JENNIF… SMITH F     NO    JENN… 2023-09-26 2010-10-14
#>  2 1013239268      1 LMFT  JENNIF… SMITH F     YES   JENN… 2023-11-22 2010-02-15
#>  3 1013467240      1 PA-C  JENNIF… SMITH F     NO    NA    NA         2016-10-12
#>  4 1013988013      1 DO    JENNIF… SMITH F     NO    NA    2021-05-12 2006-01-28
#>  5 1023408291      1 NA    JENNIF… SMITH F     NO    NA    2026-01-20 2015-01-27
#>  6 1033486725      1 NA    JENNIF… SMITH F     NO    NA    2025-09-17 2011-11-22
#>  7 1033553219      1 M.S.  JENNIF… SMITH F     YES   NA    NA         2013-04-18
#>  8 1053340471      1 PA    JENNIF… SMITH F     NO    NA    NA         2006-06-30
#>  9 1053842450      1 D.O.  JENNIF… SMITH F     NO    NA    2022-07-27 2017-03-27
#> 10 1063080125      1 NP    JENNIF… SMITH F     NO    NA    2020-12-17 2021-06-15
#> # ℹ 124 more rows
#> # ℹ 1 more variable: last_update <date>
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
```
