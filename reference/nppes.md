# National Registry of Health Care Providers

Search the National Plan and Provider Enumeration System (NPPES) NPI
Registry, a free directory of all active NPI records.

Trailing Wildcard Entries

Arguments that allow trailing wildcard entries are denoted in the
parameter description with `<WC>`. Wildcard entries require at least two
characters to be entered, e.g. `"jo*"`

## Usage

``` r
nppes(
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

wildcard(x)
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

- x:

  `<chr>` input

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)

A `<wildcard>` object

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
a Type 1 entity: + Multiple office locations + Having employees + Having
an EIN

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
# nppes(npi = 1528060837)
wildcard("Jo")
#> [1] "Jo*"
#> attr(,"class")
#> [1] "wildcard"
```
