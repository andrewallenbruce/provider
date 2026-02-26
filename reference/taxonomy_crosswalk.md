# Taxonomy Code // Medicare Specialty

Allows you to search the types of providers and suppliers eligible for
Medicare programs by taxonomy code or Medicare specialty type code.

### Taxonomy Codes

The **Healthcare Provider Taxonomy Code Set** is a hierarchical HIPAA
standard code set designed to categorize the type, classification, and
specialization of health care providers. It consists of two sections:

1.  Individuals and Groups of Individuals

2.  Non-Individuals

When applying for an NPI, a provider must report the taxonomy that most
closely describes their type/classification/specialization. In some
situations, a provider may need to report more than one taxonomy but
must indicate one of them as the primary. The codes selected may not be
the same as categorizations used by Medicare for enrollment.

Links:

- [Provider and Supplier Taxonomy
  Crosswalk](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/medicare-provider-and-supplier-taxonomy-crosswalk)

- [Taxonomy Crosswalk
  Methodology](https://data.cms.gov/resources/medicare-provider-and-supplier-taxonomy-crosswalk-methodology)

- [Find Your Taxonomy
  Code](https://www.cms.gov/medicare/enrollment-renewal/providers-suppliers/health-care-taxonomy)

*Update Frequency:* **Weekly**

## Usage

``` r
taxonomy_crosswalk(
  taxonomy_code = NULL,
  taxonomy_description = NULL,
  specialty_code = NULL,
  specialty_description = NULL,
  keyword_search = NULL,
  tidy = TRUE,
  ...
)
```

## Arguments

- taxonomy_code:

  \< *character* \> 10-digit taxonomy code

- taxonomy_description:

  \< *character* \> Provider's taxonomy description

- specialty_code:

  \< *character* \> Medicare specialty code

- specialty_description:

  \< *character* \> Medicare provider/supplier type

- keyword_search:

  \< *character* \> Search term to use for quick full-text search.

- tidy:

  \< *boolean* \> // **default:** `TRUE` Tidy output

- ...:

  Empty

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
with the columns:

|                         |                                                    |
|-------------------------|----------------------------------------------------|
| **Field**               | **Description**                                    |
| `specialty_code`        | Code that corresponds to the Medicare specialty    |
| `specialty_description` | Description of the Medicare provider/Supplier Type |
| `taxonomy_code`         | Provider's taxonomy code                           |
| `taxonomy_description`  | Description of the taxonomy code                   |

## Examples

``` r
if (FALSE) { # interactive()
taxonomy_crosswalk(keyword_search = "B4")
taxonomy_crosswalk(keyword_search = "Histocompatibility")
taxonomy_crosswalk(specialty_description = "Rehabilitation Agency")
taxonomy_crosswalk(taxonomy_code = "2086S0102X")
}
```
