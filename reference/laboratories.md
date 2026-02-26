# Clinical Laboratories

Access information on clinical laboratories including demographics and
the type of testing services the facility provides.

## Usage

``` r
laboratories(
  name = NULL,
  clia = NULL,
  certificate = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  active = FALSE,
  tidy = TRUE,
  na.rm = TRUE,
  pivot = TRUE,
  ...
)
```

## Arguments

- name:

  `<chr>` Provider or clinical laboratory's name

- clia:

  `<chr>` 10-character CLIA number

- certificate:

  `<chr>` CLIA certificate type:

  - `"waiver"`

  - `"ppm"`

  - `"registration"`

  - `"compliance"`

  - `"accreditation"`

- city:

  `<chr>` City

- state:

  `<chr>` State

- zip:

  `<chr>` Zip code

- active:

  `<lgl>` // **default:** `FALSE` Return only active providers

- tidy:

  `<lgl>` // **default:** `TRUE` Tidy output

- na.rm:

  `<lgl>` // **default:** `TRUE` Remove empty rows and columns

- pivot:

  `<lgl>` // **default:** `TRUE` Pivot output

- ...:

  Empty

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
containing the search results.

## Clinical Laboratory Improvement Amendments (CLIA)

CMS regulates all laboratory testing (except research) performed on
humans in the U.S. through the Clinical Laboratory Improvement
Amendments (CLIA). In total, CLIA covers approximately 320,000
laboratory entities.

The Division of Clinical Laboratory Improvement & Quality, within the
Quality, Safety & Oversight Group, under the Center for Clinical
Standards and Quality (CCSQ) has the responsibility for implementing the
CLIA Program.

Although all clinical laboratories must be properly certified to receive
Medicare or Medicaid payments, CLIA has no direct Medicare or Medicaid
program responsibilities.

## CLIA Certificates

There are five CLIA certificate types all of which are effective for a
period of two years. They are as follows, in order of increasing
complexity:

1.  Certificate of **Waiver**: Issued to a laboratory to perform only
    waived tests; does not waive the lab from all CLIA requirements.
    Waived tests are laboratory tests that are simple to perform.
    Routine inspections are not conducted for waiver labs, although 2%
    are visited each year to ensure quality laboratory testing.

2.  Certificate for **Provider-Performed Microscopy Procedures** (PPM):
    Issued to a laboratory in which a physician, midlevel practitioner
    or dentist performs limited tests that require microscopic
    examination. PPM tests are considered moderate complexity. Waived
    tests can also be performed under this certificate type. There are
    no routine inspections conducted for PPM labs.

3.  Certificate of **Registration**: Initially issued to a laboratory
    that has applied for a Certificate of Compliance or Accreditation,
    enabling the lab to conduct moderate/high complexity testing until
    the survey is performed and the laboratory is found to be in CLIA
    compliance. Includes PPM and waived testing.

4.  Certificate of **Compliance**: Allows the laboratory to conduct
    moderate/high complexity testing and is issued after an inspection
    finds the lab to be in compliance with all applicable CLIA
    requirements. Includes PPM and waived testing.

5.  Certificate of **Accreditation**: Exactly the same as the
    Certificate of Compliance, except that the laboratory must be
    accredited by one of the following CMS-approved accreditation
    organizations:

- [American Association for Laboratory Accreditation](https://a2la.org/)
  (A2LA)

- [Association for the Advancement of Blood &
  Biotherapies](https://www.aabb.org/) (AABB)

- [American Osteopathic Association](https://osteopathic.org/) (AOA)

- [American Society for Histocompatibility and
  Immunogenetics](https://www.ashi-hla.org/) (ASHI)

- [College of American Pathologists](https://www.cap.org/) (CAP)

- [Commission on Office Laboratory Accreditation](https://www.cola.org/)
  (COLA)

- [The Joint Commission](https://www.jointcommission.org/) (JCAHO)

## Resources

- [Provider of Services File - Clinical
  Laboratories](https://data.cms.gov/provider-characteristics/hospitals-and-other-facilities/provider-of-services-file-clinical-laboratories)

- [CMS.gov
  CLIA](https://www.cms.gov/medicare/quality/clinical-laboratory-improvement-amendments)

- [CDC.gov CLIA](https://www.cdc.gov/clia/php/about/index.html)

- [FDA CLIA
  Databases](https://www.fda.gov/medical-devices/ivd-regulatory-assistance/public-databases)

- [CDC.gov CLIA
  Certificates](https://www.cdc.gov/labs/clia-certificates/index.html)

- [CMS QCOR - S&C's Quality, Certification and Oversight
  Reports](https://qcor.cms.gov/main.jsp)

*Update Frequency:* **Quarterly**

## Examples

``` r
if (FALSE) { # interactive()
# Artic Envestigations Program Laboratory, Anchorage, AK
laboratories(clia = "02D0873639")

# Dengue Laboratory, San Juan, PR
laboratories(clia = "40D0869394")

# CDC/CGH/DGHA International Laboratory, Atlanta, GA
laboratories(clia = "11D1061576")

# Infectious Diseases Laboratory, Atlanta, GA
laboratories(clia = "11D0668319")

# National Center for Environmental Health, Division of Laboratory Science, Atlanta, GA
laboratories(clia = "11D0668290")

# Vector-Borne Diseases Laboratory, Fort Collins, CO
laboratories(clia = "06D0880233")

# Wiregrass Georgia Tech College Student Health Center, Valdosta, GA
laboratories(clia = "11D2306220")

laboratories(clia = "11D0265516")

laboratories(certificate = "ppm", city = "Valdosta", state = "GA", active = TRUE)
}
```
