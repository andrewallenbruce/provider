# Clinical Laboratories

Clinical laboratories including demographics and the type of testing
services the facility provides.

## Usage

``` r
laboratories(
  name = NULL,
  ccn = NULL,
  cert = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  active = FALSE
)
```

## Arguments

- name:

  `<chr>` Provider or clinical laboratory's name

- ccn:

  `<chr>` 10-character CLIA number

- cert:

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

  `<lgl>` Return only active providers#'

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
containing the search results.

## CLIA

CMS regulates all laboratory testing (except research) performed on
humans in the U.S. through the **Clinical Laboratory Improvement
Amendments (CLIA)**. In total, CLIA covers approximately 320,000
laboratory entities.

The *Division of Clinical Laboratory Improvement & Quality*, within the
*Quality, Safety & Oversight Group*, under the *Center for Clinical
Standards and Quality* (CCSQ) has the responsibility for implementing
the CLIA Program.

Although all clinical laboratories must be properly certified to receive
Medicare or Medicaid payments, CLIA has no direct Medicare or Medicaid
program responsibilities.

## Certification

The five CLIA certificate types, all of which are effective for a period
of two years, are as follows, in order of increasing complexity:

1.  **Waiver**: Issued to a laboratory to perform only waived tests;
    does not waive the lab from all CLIA requirements. Waived tests are
    laboratory tests that are simple to perform. Routine inspections are
    not conducted for waiver labs, although 2% are visited each year to
    ensure quality laboratory testing.

2.  **Provider-Performed Microscopy Procedures (PPM)**: Issued to a
    laboratory in which a physician, mid-level practitioner or dentist
    performs limited tests that require microscopic examination. PPM
    tests are considered moderate complexity. Waived tests can also be
    performed under this certificate type. There are no routine
    inspections conducted for PPM labs.

3.  **Registration**: Initially issued to a laboratory that has applied
    for a Certificate of Compliance or Accreditation, enabling the lab
    to conduct moderate/high complexity testing until the survey is
    performed and the laboratory is found to be in CLIA compliance.
    Includes PPM and waived testing.

4.  **Compliance**: Allows the laboratory to conduct moderate/high
    complexity testing and is issued after an inspection finds the lab
    to be in compliance with all applicable CLIA requirements. Includes
    PPM and waived testing.

5.  **Accreditation**: Exactly the same as the Certificate of
    Compliance, except that the laboratory must be accredited by one of
    the following CMS-approved accreditation organizations:

- [A2LA](https://a2la.org/): American Association for Laboratory
  Accreditation

- [AABB](https://www.aabb.org/): Association for the Advancement of
  Blood & Biotherapies

- [AOA](https://osteopathic.org/): American Osteopathic Association

- [ASHI-HLA](https://www.ashi-hla.org/): American Society for
  Histocompatibility & Immunogenetics

- [CAP](https://www.cap.org/): College of American Pathologists

- [COLA](https://www.cola.org/): Commission on Office Laboratory
  Accreditation

- [JCAHO](https://www.jointcommission.org/): The Joint Commission

## References

- [Provider of Services File - Clinical Laboratories
  API](https://data.cms.gov/provider-characteristics/hospitals-and-other-facilities/provider-of-services-file-clinical-laboratories)

- [CMS -
  CLIA](https://www.cms.gov/medicare/quality/clinical-laboratory-improvement-amendments)

- [FDA -
  CLIA](https://www.fda.gov/medical-devices/ivd-regulatory-assistance/public-databases)

- [CDC - CLIA](https://www.cdc.gov/clia/php/about/index.html)

- [CDC - CLIA
  Certificates](https://www.cdc.gov/labs/clia-certificates/index.html)

- [CMS - QCOR](https://qcor.cms.gov/main.jsp)

- [CLIA Certificate Fee
  Schedule](https://www.cms.gov/files/document/clia-certificate-fee-schedule-updated-06/7/2024.pdf)

- [CLIA Certification
  Guide](https://www.cms.gov/files/document/clia-cert-quick-start-guide.pdf)

## Examples

``` r
if (FALSE) { # interactive()
# Artic Envestigations Program Laboratory, Anchorage, AK
laboratories(ccn = "02D0873639")

# Dengue Laboratory, San Juan, PR
laboratories(ccn = "40D0869394")

# CDC/CGH/DGHA International Laboratory, Atlanta, GA
laboratories(ccn = "11D1061576")

# Infectious Diseases Laboratory, Atlanta, GA
laboratories(ccn = "11D0668319")

# National Center for Environmental Health, Division of Laboratory Science, Atlanta, GA
laboratories(ccn = "11D0668290")

# Vector-Borne Diseases Laboratory, Fort Collins, CO
laboratories(ccn = "06D0880233")

# Wiregrass Georgia Tech College Student Health Center, Valdosta, GA
laboratories(ccn = "11D2306220")

laboratories(ccn = "11D0265516")

laboratories(cert = "ppm", city = "Valdosta", state = "GA", active = TRUE)
}
```
