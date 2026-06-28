# National Registry of Health Care Providers

Search the National Plan and Provider Enumeration System (NPPES) NPI
Registry, a free directory of all active NPI records.

## Usage

``` r
nppes(npi)

nppes2(
  npi = NULL,
  entity = NULL,
  specialty = NULL,
  ind_type = NULL,
  first = NULL,
  use_alias = NULL,
  last = NULL,
  org_name = NULL,
  add_type = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  country = NULL
)
```

## Arguments

- npi:

  `<int>` National Provider Identifier

- entity:

  `<chr>` Entity type; `1` (Individual) or `2` (Organization)

- specialty:

  `<chr>` Provider's specialty

- ind_type:

  `<chr>` Type of individual `first`/`last` refers to: `AO` (Authorized
  Official) or `Provider` (Individual Provider).

- first, last:

  `<chr>` **WC** Individual provider's name

- use_alias:

  `<lgl>` Use first name alias

- org_name:

  `<chr>` **WC** Organization's name

- add_type:

  `<enum>` Address type

- city:

  `<chr>` City; For military addresses, search `"APO"`/`"FPO"`.

- state:

  `<chr>` State abbreviation. If the only input, one other parameter
  besides `entity` or `country` is required.

- zip:

  `<chr>` **WC** 5-9 digit zip code, no hyphen.

- country:

  `<chr>` Country abbreviation. Can be the only input if it *is not*
  `"US"`.

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
containing the search results.

## **National Provider Identifier (NPI)**

Healthcare providers acquire their unique 10-digit NPIs to identify
themselves in a standard way throughout their industry. Once CMS
supplies an NPI, they publish the parts of the NPI record that have
public relevance, including the provider’s name, taxonomy and practice
address.

## **Entity/Enumeration Type**

Two categories of health care providers exist for NPI enumeration
purposes:

**Type 1**: Individual providers may get an NPI as *Entity Type 1*.

*Sole Proprietorship* A sole proprietor is one who does not conduct
business as a corporation and, thus, **is not** an incorporated
individual.

An **incorporated individual** is an individual provider who forms and
conducts business under a corporation. This provider may have a Type 1
NPI while the corporation has its own Type 2 NPI.

A solo practitioner is not necessarily a sole proprietor, and vice
versa. The following factors do not affect whether a sole proprietor is
a Type 1 entity:

     * Multiple office locations
     * Having employees
     * Having an EIN

**Type 2**: Organizational providers are eligible for *Entity Type 2*
NPIs.

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

**Authorized Official**  
An appointed official (e.g., chief executive officer, chief financial
officer, general partner, chairman of the board, or direct owner) to
whom the organization has granted the legal authority to enroll it in
the Medicare program, to make changes or updates to the organization's
status in the Medicare program, and to commit the organization to fully
abide by the statutes, regulations, and program instructions of the
Medicare program.

## References

- [NPPES NPI Registry API](https://npiregistry.cms.hhs.gov/api-page)

## Examples

``` r
nppes(
  c(1851713903, 1174270805, 1225701881,
    1588817837, 1982059275, 1255782751,
    1255877502, 1841008505, 1003826272))
#> $ind
#> $ind$base
#> # A tibble: 7 × 17
#>         npi entity first last  cred  sub_type id_code id_issuer id_state tx_code
#>       <int>  <int> <chr> <chr> <chr> <chr>    <chr>   <chr>     <chr>    <chr>  
#> 1    1.85e9      1 JOSE… DANW… MSW   Sole Pr… NA      NA        NA       225400…
#> 2    1.59e9      1 JOSE… DAPA… RN    NA       NA      NA        NA       163W00…
#> 3    1.26e9      1 JOSE… DAVIS MD    NA       NA      NA        NA       207Q00…
#> 4    1.26e9      1 JOSE… DE L… M.A.… NA       27-038… Californ… CA       103K00…
#> 5    1.84e9      1 JOSIE DAVI… ALC,… Sole Pr… NA      NA        NA       101YM0…
#> 6    1.00e9      1 JO    DEAL  MD    NA       000183… Medicaid  MS       207RI0…
#> 7    1.00e9      1 JO    DEAL  MD    NA       P01065… Railroad… MS       207RI0…
#> # ℹ 7 more variables: tx_lic <chr>, tx_prim <int>, tx_state <chr>,
#> #   tx_grp <chr>, enum_date <date>, last_update <date>, cert_date <date>
#> 
#> $ind$address
#> # A tibble: 10 × 6
#>           npi address                     loc_type  city        state zip      
#>         <int> <chr>                       <chr>     <chr>       <chr> <chr>    
#>  1 1851713903 18302 WESTLAWN ST           primary   HESPERIA    CA    923456923
#>  2 1588817837 2160 BOLTON ST              primary   BRONX       NY    104621364
#>  3 1255782751 2140 JUNCTION AVE           primary   STURGIS     SD    577852358
#>  4 1255782751 983075 NEBRASKA MEDICAL CTR secondary OMAHA       NE    681983075
#>  5 1255877502 1233 N NEPTUNE AVE          primary   WILMINGTON  CA    907443134
#>  6 1255877502 3752 ATLANTIC AVE           mailing   LONG BEACH  CA    908076667
#>  7 1841008505 574 AZALEA RD STE 105       primary   MOBILE      AL    366091517
#>  8 1841008505 6517 BUGGY WHIP CT          mailing   MOBILE      AL    366953100
#>  9 1003826272 766 LAKELAND DR # A         primary   JACKSON     MS    392164610
#> 10 1003826272 6255 W SUNSET BLVD FL 21    mailing   LOS ANGELES CA    900287422
#> 
#> 
#> $org
#> $org$base
#> # A tibble: 5 × 16
#>          npi entity org_name    org_par org_dba first last  cred  tx_code tx_lic
#>        <int>  <int> <chr>       <chr>   <chr>   <chr> <chr> <chr> <chr>   <chr> 
#> 1 1174270805      2 PEACH STAT… NA      KINDBO… FAHI… SASAN DO F… 207VE0… NA    
#> 2 1174270805      2 PEACH STAT… NA      KINDBO… FAHI… SASAN DO F… 207VG0… NA    
#> 3 1225701881      2 VIOS FERTI… NA      NA      KATR… MARS… Dir … 207VE0… NA    
#> 4 1982059275      2 VIOS FERTI… NA      NA      HANN… JOHN… Dire… 207VE0… 336.0…
#> 5 1982059275      2 VIOS FERTI… NA      NA      HANN… JOHN… Dire… 207VE0… 336.0…
#> # ℹ 6 more variables: tx_prim <int>, tx_state <chr>, tx_grp <chr>,
#> #   cert_date <date>, enum_date <date>, last_update <date>
#> 
#> $org$address
#> # A tibble: 5 × 6
#>          npi address                     loc_type city         state zip      
#>        <int> <chr>                       <chr>    <chr>        <chr> <chr>    
#> 1 1174270805 1414 WALNUT ST              primary  PHILADELPHIA PA    191023824
#> 2 1174270805 333 S DESPLAINES ST STE 201 mailing  CHICAGO      IL    606615514
#> 3 1225701881 26400 W 12 MILE RD STE 140  primary  SOUTHFIELD   MI    480341753
#> 4 1982059275 1455 N MILWAUKEE AVE        primary  CHICAGO      IL    606222015
#> 5 1982059275 2516 WAUKEGAN RD            mailing  GLENVIEW     IL    600251774
#> 
#> 
```
