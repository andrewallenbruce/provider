# National Registry of Health Care Providers

`nppes()` allows the user to search the National Plan and Provider
Enumeration System (NPPES) NPI Registry, a free directory of all active
NPI records.

## Usage

``` r
nppes(
  npi = NULL,
  entype = NULL,
  first = NULL,
  last = NULL,
  organization = NULL,
  name_type = NULL,
  taxonomy_desc = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  country = NULL,
  limit = 1200L,
  skip = 0L,
  unnest = TRUE,
  tidy = TRUE,
  na.rm = TRUE,
  ...
)
```

## Arguments

- npi:

  `<chr>` Unique 10-digit National Provider Identifier number issued by
  CMS to US healthcare providers through NPPES.

- entype:

  `<chr>` Entity type; one of either `I` for Individual (NPI-1) or `O`
  for Organizational (NPI-2)

- first, last:

  `<chr>` **WC** Individual provider's first and/or last name

- organization:

  `<chr>` **WC** Organizational provider's name. Many types of names
  (LBN, DBA, Former LBN, Other Name) may match. As such, the results
  might contain a name different from the one entered.

- name_type:

  `<chr>` Type of individual the `first` and `last` name parameters
  refer to; one of either `AO` for Authorized Officials or `Provider`
  for Individual Providers.

- taxonomy_desc:

  `<chr>` Provider's taxonomy description, e.g. `Pharmacist`,
  `Pediatrics`

- city:

  `<chr>` City name. For military addresses, search for either `APO` or
  `FPO`.

- state:

  `<chr>` 2-character state abbreviation. If it is the only input, one
  other parameter besides `entype` and `country` is required.

- zip:

  `<chr>` **WC** 5- to 9-digit zip code, without a hyphen.

- country:

  `<chr>` 2-character country abbreviation. Can be the only input, as
  long as it *is not* `US`.

- limit:

  `<int>` Maximum number of results to return; **default** is `1200L`

- skip:

  `<int>` Number of results to skip after those initially returned by
  the API; **default** is `0L`

- unnest:

  `<lgl>` Unnest list columns; **default** is `TRUE`

- tidy:

  `<lgl>` Tidy output; **default** is `TRUE`

- na.rm:

  `<lgl>` Remove empty rows and columns; **default** is `TRUE`

- ...:

  Empty dots

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
provider (which is a legal entity). The NPI Final Rule refers to the
parts and locations as sub-parts. An organization health care provider
can get its sub-parts their own NPIs. If a sub-part conducts any HIPAA
standard transactions on its own (separately from its parent), it must
get its own NPI. Sub-part determination makes sure that entities within
a covered organization are uniquely identified in HIPAA standard
transactions they conduct with Medicare and other covered entities. For
example, a hospital offers acute care, laboratory, pharmacy, and
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

## Links

- [NPPES NPI Registry API
  Documentation](https://npiregistry.cms.hhs.gov/api-page)

- [NPPES NPI Registry API
  Demo](https://npiregistry.cms.hhs.gov/demo-api)

- [NPPES Available
  Countries](https://npiregistry.cms.hhs.gov/help-api/country)

## Trailing Wildcard Entries

Arguments that allow trailing wildcard entries are denoted in the
parameter description with **WC**. Wildcard entries require at least two
characters to be entered, e.g. `"jo*"`

## Update Frequency

**Weekly**

## Examples

``` r
if (FALSE) { # interactive()
nppes(npi = 1528060837)

nppes(city   = "CARROLLTON",
      state  = "GA",
      zip    = 301173889,
      entype = "I")
}
```
