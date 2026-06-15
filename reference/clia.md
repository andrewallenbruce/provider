# Clinical Laboratories

Clinical laboratories including demographics and the type of testing
services the facility provides.

## Usage

``` r
clia(
  fac_name = NULL,
  fac_ccn = NULL,
  clia_ccn = NULL,
  cert_type = NULL,
  acr_org = NULL,
  multi = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  chows = NULL,
  active = NULL,
  eligible = NULL,
  count = FALSE,
  set = FALSE
)
```

## Source

- [API: Provider of Services File - Clinical
  Laboratories](https://data.cms.gov/provider-characteristics/hospitals-and-other-facilities/provider-of-services-file-clinical-laboratories)

- [CMS:
  CLIA](https://www.cms.gov/medicare/quality/clinical-laboratory-improvement-amendments)

- [CDC: CLIA](https://www.cdc.gov/clia/php/about/index.html)

- [CMS: QCOR](https://qcor.cms.gov/main.jsp)

- [CLIA:
  Certificates](https://www.cdc.gov/labs/clia-certificates/index.html)

- [CLIA: Certificate Fee
  Schedule](https://www.cms.gov/files/document/clia-certificate-fee-schedule-updated-06/7/2024.pdf)

- [CLIA: Certification
  Guide](https://www.cms.gov/files/document/clia-cert-quick-start-guide.pdf)

## Arguments

- fac_name:

  `<chr>` Provider/Laboratory name

- fac_ccn:

  `<chr>` 10-digit CMS Certification Number

- clia_ccn:

  `<chr>` 6-digit CMS Certification Number

- cert_type:

  `<enum>` CLIA certificate type (see Details):

  - `"wav"` = Waiver

  - `"ppm"` = Provider-Performed Microscopy (PPM)

  - `"reg"` = Registration

  - `"cmp"` = Compliance

  - `"acr"` = Accreditation

- acr_org:

  `<enum>` CLIA accrediting organization (see Details):

  - `"a2la"` = American Association for Laboratory Accreditation

  - `"aabb"` = Association for the Advancement of Blood & Biotherapies

  - `"aoa"` = American Osteopathic Association

  - `"ashi"` = American Society for Histocompatibility & Immunogenetics

  - `"cap"` = College of American Pathologists

  - `"cola"` = Commission on Office Laboratory Accreditation

  - `"jcaho"` = The Joint Commission

- multi:

  `<enum>` Single site CLIA multiple-site exceptions:

  - `"applied"` = Applied for to cover multiple testing locations

  - `"campus"` = Hospital with several labs on single hospital campus

  - `"non"` = Multiple sites with non-profit, federal, state or local
    government status (limited public health testing)

  - `"temp"` = Lab with multiple temporary testing sites

- city, state, zip:

  `<chr>` Lab city, state, zip

- chows:

  `<int>` Number of times there has been a Change of Ownership.

- active:

  `<lgl>` Return only active labs

- eligible:

  `<lgl>` Indicates lab is eligible to participate in Medicare/Medicaid.

- count:

  `<lgl>` Return the total row count

- set:

  `<lgl>` Return the entire dataset

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)

## CLIA

CMS regulates all laboratory testing (except research) performed on
humans in the U.S. through the **Clinical Laboratory Improvement
Amendments**. In total, **CLIA** covers approximately 320,000 laboratory
entities.

Although all clinical laboratories must be properly certified to receive
Medicare or Medicaid payments, CLIA has no direct Medicare or Medicaid
program responsibilities.

### Certification

There are five CLIA certificate types, all of which are effective for a
period of two years. They are as follows, in order of increasing
complexity:

1.  **Waiver**: Laboratory can only perform waived tests, those that are
    simple to perform. Although routine inspections are not conducted,
    2% are visited annually to ensure quality. Does not waive the lab
    from all CLIA requirements.

2.  **Provider-Performed Microscopy (PPM)**: In addition to waived
    tests, a physician, mid-level practitioner or dentist can perform
    limited tests of moderate complexity requiring microscopic
    examination. No routine inspections are conducted.

3.  **Registration**: Laboratory has applied for a **Compliance** or
    **Accreditation** certificate, enabling it to conduct moderate/high
    complexity testing until the survey is completed. Includes PPM and
    waived testing.

4.  **Compliance**: Allows the laboratory to conduct moderate/high
    complexity testing and is issued after an inspection finds the lab
    to be in compliance with all applicable CLIA requirements. Includes
    PPM and waived testing.

5.  **Accreditation**: Exactly the same as **Compliance**, except that
    the laboratory is accredited by one of the CMS-approved
    organizations:

    - [A2LA: American Association for Laboratory
      Accreditation](https://a2la.org/)

    - [AABB: Association for the Advancement of Blood &
      Biotherapies](https://www.aabb.org/)

    - [AOA: American Osteopathic Association](https://osteopathic.org/)

    - [ASHI-HLA: American Society for Histocompatibility &
      Immunogenetics](https://www.ashi-hla.org/)

    - [CAP: College of American Pathologists](https://www.cap.org/)

    - [COLA: Commission on Office Laboratory
      Accreditation](https://www.cola.org/)

    - [JCAHO: The Joint Commission](https://www.jointcommission.org/)

## Examples

``` r
clia(cert_type = c("acr", "reg"), city = "Valdosta", state = "GA")
#> ✔ clia returned 18 results
#> ✔ Retrieving 1 page
#> Error in ckmatch(cols, nam): Unknown columns: npi

clia(acr_org = c("cap", "cola", "jcaho"))
#> ✔ clia returned 1 result
#> ✔ Retrieving 1 page
#> Error in ckmatch(cols, nam): Unknown columns: npi
```
