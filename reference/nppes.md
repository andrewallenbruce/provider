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
nppes(c(1851713903, 1174270805, 1225701881, 1588817837, 1982059275, 1255782751, 1255877502, 1841008505, 1003826272))
#> $type_1
#> # A tibble: 15 × 27
#>           npi entity cred      enum_date  first  last  updated    sex   sub_type
#>         <int>  <int> <chr>     <date>     <chr>  <chr> <date>     <chr> <chr>   
#>  1 1851713903      1 MSW       2014-01-08 JOSEF… DANW… 2014-01-16 F     Sole Pr…
#>  2 1851713903      1 MSW       2014-01-08 JOSEF… DANW… 2014-01-16 F     Sole Pr…
#>  3 1588817837      1 RN        2008-10-30 JOSEP… DAPA… 2008-10-30 F     NA      
#>  4 1588817837      1 RN        2008-10-30 JOSEP… DAPA… 2008-10-30 F     NA      
#>  5 1255782751      1 MD        2016-06-26 JOSEP… DAVIS 2019-10-31 F     NA      
#>  6 1255782751      1 MD        2016-06-26 JOSEP… DAVIS 2019-10-31 F     NA      
#>  7 1255782751      1 MD        2016-06-26 JOSEP… DAVIS 2019-10-31 F     NA      
#>  8 1255877502      1 M.A. BCBA 2017-01-10 JOSEP… DE L… 2018-03-27 F     NA      
#>  9 1255877502      1 M.A. BCBA 2017-01-10 JOSEP… DE L… 2018-03-27 F     NA      
#> 10 1841008505      1 ALC, NCC  2024-12-26 JOSIE  DAVI… 2024-12-26 F     Sole Pr…
#> 11 1841008505      1 ALC, NCC  2024-12-26 JOSIE  DAVI… 2024-12-26 F     Sole Pr…
#> 12 1003826272      1 MD        2006-08-09 JO     DEAL  2024-05-07 F     NA      
#> 13 1003826272      1 MD        2006-08-09 JO     DEAL  2024-05-07 F     NA      
#> 14 1003826272      1 MD        2006-08-09 JO     DEAL  2024-05-07 F     NA      
#> 15 1003826272      1 MD        2006-08-09 JO     DEAL  2024-05-07 F     NA      
#> # ℹ 18 more variables: cert_date <date>, other_type <int>, other_name <chr>,
#> #   id_type <int>, id_code <chr>, id_issuer <chr>, id_state <chr>,
#> #   tax_code <chr>, tax_desc <chr>, tax_license <chr>, tax_prim <int>,
#> #   tax_state <chr>, tax_group <chr>, address <chr>, location <chr>,
#> #   city <chr>, zip <chr>, state <chr>
#> 
#> $type_2
#> # A tibble: 10 × 23
#>           npi entity cred  first last  cert_date  enum_date  updated    org_name
#>         <int>  <int> <chr> <chr> <chr> <date>     <date>     <date>     <chr>   
#>  1 1174270805      2 DO F… FAHI… SASAN 2024-05-20 2022-03-02 2024-05-20 PEACH S…
#>  2 1174270805      2 DO F… FAHI… SASAN 2024-05-20 2022-03-02 2024-05-20 PEACH S…
#>  3 1174270805      2 DO F… FAHI… SASAN 2024-05-20 2022-03-02 2024-05-20 PEACH S…
#>  4 1174270805      2 DO F… FAHI… SASAN 2024-05-20 2022-03-02 2024-05-20 PEACH S…
#>  5 1225701881      2 Dir … KATR… MARS… 2024-02-12 2021-07-29 2024-02-12 VIOS FE…
#>  6 1225701881      2 Dir … KATR… MARS… 2024-02-12 2021-07-29 2024-02-12 VIOS FE…
#>  7 1982059275      2 Dire… HANN… JOHN… NA         2016-04-25 2016-04-25 VIOS FE…
#>  8 1982059275      2 Dire… HANN… JOHN… NA         2016-04-25 2016-04-25 VIOS FE…
#>  9 1982059275      2 Dire… HANN… JOHN… NA         2016-04-25 2016-04-25 VIOS FE…
#> 10 1982059275      2 Dire… HANN… JOHN… NA         2016-04-25 2016-04-25 VIOS FE…
#> # ℹ 14 more variables: sub_type <chr>, other_type <int>, other_name <chr>,
#> #   tax_code <chr>, tax_desc <chr>, tax_license <chr>, tax_prime <int>,
#> #   tax_state <chr>, tax_group <chr>, address <chr>, location <chr>,
#> #   city <chr>, zip <chr>, state <chr>
#> 
```
