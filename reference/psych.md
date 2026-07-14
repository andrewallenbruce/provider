# Inpatient Psychiatric Facilities

This dataset includes provider-level data for quality measures included
under the IPFQR program, including HBIPS, SUB, TOB, Transition Record
(TR), Screening for Metabolic Disorders (SMD), FAPH, IMM, Readmissions
(READM), and Medication Continuation (MedCont, formerly known as
MedCoPsy). Psychiatric facilities that are eligible for the Inpatient
Psychiatric Facility Quality Reporting (IPFQR) program are required to
meet all program requirements, otherwise their Medicare payments may be
reduced.

## Usage

``` r
psych(
  ccn = NULL,
  name = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  county = NULL,
  rating = NULL,
  count = FALSE
)
```

## Source

- [API: Inpatient Psychiatric Facility Quality Measure Data - by
  Facility](https://data.cms.gov/provider-data/dataset/q9vs-r7wp)

## Arguments

- ccn:

  `<chr>` desc

- name:

  `<chr>` desc

- city, state, zip, county:

  `<chr>` desc

- count:

  `<lgl>` Return the total row count

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
containing the search results.

## Examples

``` r
psych(count = TRUE)
#> ◼ psych | 1,424 rows | 1 pages
psych(state = "GA")
#> Error in httr2::req_perform(httr2::request(flatten_pdc(S7::prop(x, "url"),     S7::prop(x, "query"), results = "false"))): HTTP 503 Service Unavailable.
```
