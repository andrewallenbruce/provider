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
#> # A tibble: 15 × 21
#>         npi entity first last  cred  sub_type sex   address location city  state
#>       <int>  <int> <chr> <chr> <chr> <chr>    <chr> <chr>   <chr>    <chr> <chr>
#>  1   1.85e9      1 JOSE… DANW… MSW   Sole Pr… F     18302 … mailing  HESP… CA   
#>  2   1.85e9      1 JOSE… DANW… MSW   Sole Pr… F     18302 … primary  HESP… CA   
#>  3   1.59e9      1 JOSE… DAPA… RN    NA       F     2160 B… mailing  BRONX NY   
#>  4   1.59e9      1 JOSE… DAPA… RN    NA       F     2160 B… primary  BRONX NY   
#>  5   1.26e9      1 JOSE… DAVIS MD    NA       F     2140 J… mailing  STUR… SD   
#>  6   1.26e9      1 JOSE… DAVIS MD    NA       F     2140 J… primary  STUR… SD   
#>  7   1.26e9      1 JOSE… DAVIS MD    NA       F     983075… seconda… OMAHA NE   
#>  8   1.26e9      1 JOSE… DE L… M.A.… NA       F     3752 A… mailing  LONG… CA   
#>  9   1.26e9      1 JOSE… DE L… M.A.… NA       F     1233 N… primary  WILM… CA   
#> 10   1.84e9      1 JOSIE DAVI… ALC,… Sole Pr… F     574 AZ… primary  MOBI… AL   
#> 11   1.84e9      1 JOSIE DAVI… ALC,… Sole Pr… F     6517 B… mailing  MOBI… AL   
#> 12   1.00e9      1 JO    DEAL  MD    NA       F     766 LA… primary  JACK… MS   
#> 13   1.00e9      1 JO    DEAL  MD    NA       F     6255 W… mailing  LOS … CA   
#> 14   1.00e9      1 JO    DEAL  MD    NA       F     766 LA… primary  JACK… MS   
#> 15   1.00e9      1 JO    DEAL  MD    NA       F     6255 W… mailing  LOS … CA   
#> # ℹ 10 more variables: zip <chr>, id_type <int>, id_code <chr>,
#> #   id_issuer <chr>, id_state <chr>, other_type <int>, other_name <chr>,
#> #   enum_date <date>, last_update <date>, cert_date <date>
#> 
#> $type_2
#> # A tibble: 10 × 17
#>           npi entity org_name  first last  cred  sub_type address location city 
#>         <int>  <int> <chr>     <chr> <chr> <chr> <chr>    <chr>   <chr>    <chr>
#>  1 1174270805      2 PEACH ST… FAHI… SASAN DO F… NA       1414 W… primary  PHIL…
#>  2 1174270805      2 PEACH ST… FAHI… SASAN DO F… NA       333 S … mailing  CHIC…
#>  3 1174270805      2 PEACH ST… FAHI… SASAN DO F… NA       1414 W… primary  PHIL…
#>  4 1174270805      2 PEACH ST… FAHI… SASAN DO F… NA       333 S … mailing  CHIC…
#>  5 1225701881      2 VIOS FER… KATR… MARS… Dir … NA       26400 … primary  SOUT…
#>  6 1225701881      2 VIOS FER… KATR… MARS… Dir … NA       26400 … mailing  SOUT…
#>  7 1982059275      2 VIOS FER… HANN… JOHN… Dire… NA       2516 W… mailing  GLEN…
#>  8 1982059275      2 VIOS FER… HANN… JOHN… Dire… NA       1455 N… primary  CHIC…
#>  9 1982059275      2 VIOS FER… HANN… JOHN… Dire… NA       2516 W… mailing  GLEN…
#> 10 1982059275      2 VIOS FER… HANN… JOHN… Dire… NA       1455 N… primary  CHIC…
#> # ℹ 7 more variables: state <chr>, zip <chr>, other_type <int>,
#> #   other_name <chr>, cert_date <date>, enum_date <date>, last_update <date>
#> 
```
