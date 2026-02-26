# National Drug Code (NDC) Lookup

National Drug Code (NDC) Lookup

## Usage

``` r
ndc_lookup(ndc, ...)
```

## Arguments

- ndc:

  `<chr>` **required** 10- to 11-digit National Drug Code

- ...:

  Empty

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
with the columns:

|              |                                                 |
|--------------|-------------------------------------------------|
| **Field**    | **Description**                                 |
| `ndc`        | National Drug Code                              |
| `rxcui`      | RxNorm Identifier                               |
| `atc`        | ATC Identifier                                  |
| `status`     | Status (NDC)                                    |
| `brand_name` | Brand Name (RxCUI)                              |
| `drug_name`  | Drug Name (RxCUI)                               |
| `atc_first`  | ATC I: Anatomical, Pharmacological              |
| `atc_first`  | ATC II: Pharmacological, Therapeutic            |
| `atc_first`  | ATC III: Chemical, Pharmacological, Therapeutic |
| `atc_first`  | ATC IV: Chemical, Pharmacological, Therapeutic  |
| `subject`    | Medline Plus: Subject                           |
| `summary`    | Medline Plus: Summary                           |

## NDC

A National Drug Code (NDC) is a unique 10- or 11-digit, 3-segment
numeric identifier assigned to each medication listed under Section 510
of the US Federal Food, Drug, and Cosmetic Act.

## RxCUI

An RxCUI is a machine-readable code or identifier that points to the
common meaning shared by the various source names grouped and assigned
to a particular concept.

RxNorm provides normalized names for clinical drugs and links its names
to many of the drug vocabularies commonly used in pharmacy management
and drug interaction software, including those of First Databank,
Micromedex, Multum, and Gold Standard Drug Database. By providing links
between these vocabularies, RxNorm can mediate messages between systems
not using the same software and vocabulary.

## ATC

ATC classifies drugs at five different levels. Each level is a different
grouping of drugs. Groupings of active substances include the organ or
system on which the drug acts as well as therapeutic, pharmacological,
and chemical properties of the drug.

The Anatomical Therapeutic Chemical (ATC) classification was developed
as a modification and extension of the EphMRA classification system. In
the ATC classification system, the active substances are classified in a
hierarchy with five different levels.

The system has fourteen main anatomical/pharmacological groups or **1st
Levels**.

Each ATC main group is divided into **2nd Levels** which could be either
pharmacological or therapeutic groups.

The **3rd and 4th Levels** are chemical, pharmacological or therapeutic
subgroups and the **5th Level** is the chemical substance.

The 2nd, 3rd and 4th levels are often used to identify pharmacological
subgroups when that is considered more appropriate than therapeutic or
chemical subgroups.

## Links

- [ATCs](https://www.whocc.no/atc/structure_and_principles/)

- [RxNorm](https://www.nlm.nih.gov/research/umls/rxnorm/overview.html)

- [NDC-HCPCS Crosswalk](https://ndclist.com/ndc-hcpcs-crosswalk-lookup)

## Examples

``` r
if (FALSE) { # interactive()
ndc_lookup("0002-1433-80")

medline("0002-1433-80")

rxnorm("0002-1433-80")
}
```
