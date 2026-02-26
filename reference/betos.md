# Restructured BETOS Classification for HCPCS

Group HCPCS codes into clinically meaningful categories based on the
original *Berenson-Eggers Type of Service* (BETOS) classification.

## Usage

``` r
betos(
  hcpcs = NULL,
  rbcs = NULL,
  category = NULL,
  subcategory = NULL,
  family = NULL,
  procedure = NULL,
  tidy = TRUE,
  ...
)
```

## Arguments

- hcpcs:

  \< *character* \> HCPCS or CPT code

- rbcs:

  \< *character* \> RBCS ID

- category:

  \< *character* \> RBCS Category Description, e.g.

  - Anesthesia

  - DME

  - E&M

  - Imaging

  - Other

  - Procedure

  - Test

  - Treatment

- subcategory:

  \< *character* \> RBCS Subcategory Description

- family:

  \< *character* \> RBCS Family Description

- procedure:

  \< *character* \> Whether the HCPCS code is a Major (`"M"`), Other
  (`"O"`), or Non-Procedure code (`"N"`).

- tidy:

  \< *boolean* \> // **default:** `TRUE` Tidy output

- ...:

  Empty

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
with the columns:

|                    |                                              |
|--------------------|----------------------------------------------|
| **Field**          | **Description**                              |
| `hcpcs`            | HCPCS or CPT code                            |
| `rbcs_id`          | RBCS Identifier                              |
| `category`         | RBCS Category                                |
| `subcategory`      | RBCS Subcategory                             |
| `family`           | RBCS Family                                  |
| `procedure`        | RBCS Major Procedure Indicator               |
| `hcpcs_start_date` | Date HCPCS Code was added                    |
| `hcpcs_end_date`   | Date HCPCS Code was no longer effective      |
| `rbcs_start_date`  | Earliest Date that the RBCS ID was effective |
| `rbcs_end_date`    | Latest Date that the RBCS ID can be applied  |

## From BETOS to RBCS

The Restructured BETOS Classification System (RBCS) is a taxonomy that
allows researchers to group Medicare Part B healthcare service codes
into clinically meaningful categories and subcategories.

Based on the original Berenson-Eggers Type of Service (BETOS)
classification created in the 1980s, it includes notable updates such as
Part B non-physician services and undergoes annual updates by a
technical expert panel of researchers and clinicians.

The general framework for grouping service codes into the new RBCS
taxonomy largely follows the same structure of BETOS. Like BETOS, the
RBCS groups HCPCS codes into categories, subcategories, and families –
with categories as the most aggregate level and families as the more
granular level.

All Medicare Part B service codes, including non-physician services, are
assigned to a 6-character RBCS taxonomy code.

## Links

- [Restructured BETOS Classification
  System](https://data.cms.gov/provider-summary-by-type-of-service/provider-service-classifications/restructured-betos-classification-system)

- [RBCS Data
  Dictionary](https://data.cms.gov/resources/restructured-betos-classification-system-data-dictionary)

## Update Frequency

Annually

## Examples

``` r
if (FALSE) { # interactive()
betos(hcpcs = "0001U")
betos(category = "Test")
betos(subcategory = "General Laboratory")
betos(family = "Immunoassay")
betos(procedure = "M")
betos(family = "No RBCS Family")
betos(rbcs = "TL001N")
}
```
