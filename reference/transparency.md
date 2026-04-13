# Hospital Transparency Enforcement

Information on enforcement actions as a result of CMS' assessment of a
hospital's compliance with the Hospital Price Transparency regulations.

### Overview

The **Hospital Price Transparency Enforcement Activities and Outcomes**
dataset contains information related to enforcement actions taken by CMS
following a compliance review of a hospital's obligation to establish,
update and make public a list of the hospital's standard charges for
items and services provided by the hospital, in accordance with
regulation (45 CFR 180).

This data set includes the name of each hospital or hospital location,
the hospital or hospital location address, the outcome or action
following a CMS compliance review and the date of the outcome or action
taken.

#### Actions:

- **Met Requirements:** The hospital was reviewed by CMS and no
  deficiencies were cited. This category includes hospitals that were
  found to be in compliance upon CMS' first review.

- **Administrative Closure:** Refers to the termination of compliance
  review activities due to reasons such as, but not limited to, a
  hospital has ceased operations, closed its physical location, is not
  subject to the HPT requirements, or has already been deemed to meet
  the requirements.

- **Warning Notice:** The hospital was reviewed by CMS and deficiencies
  were cited in a warning notice issued to the hospital.

- **CAP Request:** The hospital was reviewed by CMS and deficiencies
  were cited in a request for a corrective action plan (CAP) issued to
  the hospital.

- **Closure Notice:** CMS determined that the hospital corrected
  previously identified deficiencies and issued a closure notice to the
  hospital.

- **CMP Notice:** CMS issued a civil monetary penalty (CMP) to the
  hospital if the hospital failed to respond to CMS' request to submit a
  corrective action plan or comply with the requirements of a corrective
  action plan. CMP [notices are
  publicized](https://www.cms.gov/priorities/key-initiatives/hospital-price-transparency/enforcement-actions).

- **Appealed:** The hospital filed an appeal of CMS' decision to issue a
  civil monetary penalty.

## Usage

``` r
transparency(
  name = NULL,
  address = NULL,
  city = NULL,
  state = NULL,
  action = NULL,
  count = FALSE,
  set = FALSE
)
```

## Source

- [API: Hospital Price Transparency Enforcement Activities and
  Outcomes](https://data.cms.gov/provider-characteristics/hospitals-and-other-facilities/hospital-price-transparency-enforcement-activities-and-outcomes)

## Arguments

- name:

  `<chr>` Hospital name

- address:

  `<chr>` Hospital address

- city:

  `<chr>` Hospital city

- state:

  `<chr>` Hospital state

- action:

  `<enum>` Action taken by CMS following a Compliance Review (see
  Details)

  - `"met"`: Met Requirements

  - `"admin"`: Administrative Closure

  - `"warning"`: Warning Notice

  - `"cap"`: CAP Request

  - `"closure"`: Closure Notice

  - `"cmp"`: CMP Notice

  - `"appeal"` : Appealed

- count:

  `<lgl>` Return the dataset's total row count

- set:

  `<lgl>` Return the entire dataset

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)

## Examples

``` r
transparency(count = TRUE)
#> ℹ transparency has 10,726 rows.
transparency(count = TRUE, action = "warning")
#> ✔ transparency returned 2,695 results.
transparency(state = "GA", city = "Valdosta")
#> ✔ transparency returned 1 result.
#> # A data frame: 1 × 7
#>   id    name             address             city     state action   action_date
#> * <chr> <chr>            <chr>               <chr>    <chr> <chr>    <chr>      
#> 1 6131  Greenleaf Center 2209 Pineview Drive Valdosta GA    Met Req… 2025-08-01 
```
