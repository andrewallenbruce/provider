# Clinical Laboratories

Clinical laboratories including demographics and the type of testing
services the facility provides.

## Usage

``` r
clia(
  facility_name = NULL,
  facility_ccn = NULL,
  parent_ccn = NULL,
  certificate = NULL,
  accreditation = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  compliant = NULL,
  active = NULL,
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

- facility_name:

  `<chr>` Provider/Laboratory name

- facility_ccn:

  `<chr>` 10-digit CMS Certification Number

- parent_ccn:

  `<chr>` 6-digit CMS Certification Number

- certificate:

  `<enum>` CLIA certificate type (see Details):

  - `"waiver"` = Waiver

  - `"ppm"` = Provider-Performed Microscopy (PPM)

  - `"registration"` = Registration

  - `"compliance"` = Compliance

  - `"accreditation"` = Accreditation

- accreditation:

  `<enum>` CLIA accrediting organization (see Details):

  - `"a2la"` = A2LA

  - `"aabb"` = AABB

  - `"aoa"` = AOA

  - `"ashi"` = ASHI-HLA

  - `"cap"` = CAP

  - `"cola"` = COLA

  - `"jcaho"` = JCAHO

- city, state, zip:

  `<chr>` Lab city, state, zip

- compliant:

  `<lgl>` Return only compliant or non-compliant labs

- active:

  `<lgl>` Return only active labs

- count:

  `<lgl>` Return the total row count

- set:

  `<lgl>` Return the entire dataset

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
containing the search results.

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
clia(count = TRUE)
#> ℹ clia has 676,051 rows.

clia(compliant = FALSE, active = TRUE, count = TRUE)
#> ✔ clia returned 2,578 results.

clia(facility_ccn = provider:::cdc_labs$ccn)
#> ✔ clia returned 6 results.
#> # A tibble: 6 × 61
#>   facility_ccn parent_ccn xref_ccn shared_ccn mac   chown chow_date poc_ind
#> * <chr>        <chr>      <chr>    <chr>      <chr> <chr> <date>      <int>
#> 1 02D0873639   NA         NA       NA         NA    0     NA              0
#> 2 06D0880233   NA         NA       NA         NA    0     NA              1
#> 3 11D0668290   NA         NA       NA         NA    0     NA              0
#> 4 11D0668319   NA         NA       NA         NA    0     NA              0
#> 5 11D1061576   NA         NA       NA         NA    0     NA              0
#> 6 40D0869394   NA         NA       NA         NA    0     NA              0
#> # ℹ 53 more variables: compliant <chr>, city <chr>, state <chr>, zip <chr>,
#> #   elig_ind <int>, term_pgm <chr>, term_clia <chr>, app_type <chr>,
#> #   cert_type <chr>, fac_type <chr>, own_type <chr>, act_type <chr>,
#> #   orig_date <date>, app_date <date>, cert_date <date>, eff_date <date>,
#> #   mail_date <date>, term_date <date>, a2la_date <date>, a2la_ind <int>,
#> #   aabb_date <date>, aabb_ind <int>, aoa_date <date>, aoa_ind <int>,
#> #   ashi_date <date>, ashi_ind <int>, cap_date <date>, cap_ind <int>, …

clia(certificate = c("accreditation", "registration"), city = "Valdosta", state = "GA")
#> ✔ clia returned 18 results.
#> # A tibble: 18 × 61
#>    facility_ccn parent_ccn xref_ccn shared_ccn mac   chown chow_date poc_ind
#>  * <chr>        <chr>      <chr>    <chr>      <chr> <chr> <date>      <int>
#>  1 11D0022233   110122     NA       NA         NA    0     NA              0
#>  2 11D0022241   110037     NA       NA         NA    0     NA              0
#>  3 11D0265567   254623647A NA       NA         NA    0     NA              0
#>  4 11D0646134   11L0008004 NA       NA         NA    0     NA              0
#>  5 11D0680179   110122     NA       NA         NA    0     NA              0
#>  6 11D0902131   NA         NA       NA         NA    0     NA              0
#>  7 11D0914178   NA         NA       NA         NA    0     NA              0
#>  8 11D0960358   NA         NA       NA         NA    0     NA              0
#>  9 11D1001568   NA         NA       NA         NA    0     NA              0
#> 10 11D1065138   NA         NA       NA         NA    0     NA              0
#> 11 11D2027917   NA         NA       NA         NA    0     NA              0
#> 12 11D2053438   NA         NA       NA         NA    0     NA              0
#> 13 11D2079448   NA         NA       NA         NA    0     NA              0
#> 14 11D2101175   NA         NA       NA         NA    0     NA              0
#> 15 11D2144796   NA         NA       NA         NA    0     NA              0
#> 16 11D2144934   NA         NA       NA         NA    0     NA              0
#> 17 11D2193538   NA         NA       NA         NA    0     NA              0
#> 18 11D2223235   NA         NA       NA         NA    0     NA              0
#> # ℹ 53 more variables: compliant <chr>, city <chr>, state <chr>, zip <chr>,
#> #   elig_ind <int>, term_pgm <chr>, term_clia <chr>, app_type <chr>,
#> #   cert_type <chr>, fac_type <chr>, own_type <chr>, act_type <chr>,
#> #   orig_date <date>, app_date <date>, cert_date <date>, eff_date <date>,
#> #   mail_date <date>, term_date <date>, a2la_date <date>, a2la_ind <int>,
#> #   aabb_date <date>, aabb_ind <int>, aoa_date <date>, aoa_ind <int>,
#> #   ashi_date <date>, ashi_ind <int>, cap_date <date>, cap_ind <int>, …

clia(accreditation = c("cap", "cola", "jcaho"))
#> ✔ clia returned 1 result.
#> # A tibble: 1 × 61
#>   facility_ccn parent_ccn xref_ccn shared_ccn mac   chown chow_date poc_ind
#> * <chr>        <chr>      <chr>    <chr>      <chr> <chr> <date>      <int>
#> 1 42D0665325   420073     NA       NA         NA    0     NA              0
#> # ℹ 53 more variables: compliant <chr>, city <chr>, state <chr>, zip <chr>,
#> #   elig_ind <int>, term_pgm <chr>, term_clia <chr>, app_type <chr>,
#> #   cert_type <chr>, fac_type <chr>, own_type <chr>, act_type <chr>,
#> #   orig_date <date>, app_date <date>, cert_date <date>, eff_date <date>,
#> #   mail_date <date>, term_date <date>, a2la_date <date>, a2la_ind <int>,
#> #   aabb_date <date>, aabb_ind <int>, aoa_date <date>, aoa_ind <int>,
#> #   ashi_date <date>, ashi_ind <int>, cap_date <date>, cap_ind <int>, …
```
