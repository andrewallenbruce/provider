# Clinical Laboratories

Clinical laboratories including demographics and the type of testing
services the facility provides.

## Usage

``` r
clia(
  name = NULL,
  ccn = NULL,
  parent = NULL,
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

- name:

  `<chr>` Provider or clinical laboratory's name

- ccn:

  `<chr>` 10-character CLIA number

- parent:

  `<chr>` 6-character CLIA number

- certificate:

  `<enum>` CLIA certificate type (see details):

  - `"waiver"` = Waiver

  - `"ppm"` = Provider-Performed Microscopy (PPM)

  - `"registration"` = Registration

  - `"compliance"` = Compliance

  - `"accreditation"` = Accreditation

- accreditation:

  `<enum>` CLIA accrediting organization (see details):

  - `"a2la"` = A2LA

  - `"aabb"` = AABB

  - `"aoa"` = AOA

  - `"ashi"` = ASHI-HLA

  - `"cap"` = CAP

  - `"cola"` = COLA

  - `"jcaho"` = JCAHO

- city:

  `<chr>` City

- state:

  `<chr>` State

- zip:

  `<chr>` Zip code

- compliant:

  `<lgl>` Compliant or Non-Compliant

- active:

  `<lgl>` Return only active providers

- count:

  `<lgl>` Return the dataset's total row count

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
#> ℹ clia has 671,570 rows.
clia(compliant = FALSE, count = TRUE)
#> ✔ clia returned 5,161 results.
clia(ccn = provider:::cdc_labs$ccn)
#> ✔ clia returned 6 results.
#> # A data frame: 6 × 82
#>   name_1  name_2 ccn   parent xref  chow_n chow_date chow_prv pos   status add_1
#> * <chr>   <chr>  <chr> <chr>  <chr> <chr>  <chr>     <chr>    <chr> <chr>  <chr>
#> 1 CDC AR… CENTE… 02D0… NA     NA    0      NA        NA       N     A      4055…
#> 2 CENTER… DIVIS… 06D0… NA     NA    0      NA        NA       Y     A      3156…
#> 3 CDC/NC… NA     11D0… NA     NA    0      NA        NA       N     A      4770…
#> 4 CENTER… NA     11D0… NA     NA    0      NA        NA       N     B      1600…
#> 5 CDC/CG… ATTEN… 11D1… NA     NA    0      NA        NA       N     NA     1600…
#> 6 CENTER… DENGU… 40D0… NA     NA    0      NA        NA       N     A      1324…
#> # ℹ 71 more variables: add_2 <chr>, phone_1 <chr>, phone_2 <chr>, city <chr>,
#> #   state <chr>, zip <chr>, region <chr>, region_st <chr>, ssa_st <chr>,
#> #   ssa_cty <chr>, fips_st <chr>, fips_cty <chr>, cbsa_1 <chr>, cbsa_2 <chr>,
#> #   eligible <chr>, term_pgm <chr>, term_clia <chr>, apl_type <chr>,
#> #   cert_type <chr>, fac_type <chr>, owner <chr>, cert_action <chr>,
#> #   orig_date <chr>, apl_date <chr>, cert_date <chr>, eff_date <chr>,
#> #   mail_date <chr>, term_date <chr>, a2la_cred <chr>, a2la_date <chr>, …
clia(certificate = c("accreditation", "registration"),
     city = "Valdosta",
     state = "GA")
#> ✔ clia returned 18 results.
#> # A data frame: 18 × 82
#>    name_1 name_2 ccn   parent xref  chow_n chow_date chow_prv pos   status add_1
#>  * <chr>  <chr>  <chr> <chr>  <chr> <chr>  <chr>     <chr>    <chr> <chr>  <chr>
#>  1 SGMC … NA     11D0… 110122 NA    0      NA        NA       N     A      2501…
#>  2 SGMC-… NA     11D0… 110037 NA    0      NA        NA       N     A      4280…
#>  3 SMITH… NA     11D0… 25462… NA    0      NA        NA       N     NA     2910…
#>  4 QUEST… SOLST… 11D0… 11L00… NA    0      NA        NA       N     A      341 …
#>  5 SOUTH… NA     11D0… 110122 NA    0      NA        NA       N     NA     2501…
#>  6 NORTH… WILLI… 11D0… NA     NA    0      NA        NA       N     NA     201 …
#>  7 SOUTH… NA     11D0… NA     NA    0      NA        NA       N     NA     201 …
#>  8 SOUTH… NA     11D0… NA     NA    0      NA        NA       N     NA     2740…
#>  9 VALDO… NA     11D1… NA     NA    0      NA        NA       N     NA     2841…
#> 10 ALLEG… NA     11D1… NA     NA    0      NA        NA       N     NA     5101…
#> 11 CARE … NA     11D2… NA     NA    0      NA        NA       N     NA     2804…
#> 12 GULF … NA     11D2… NA     NA    0      NA        NA       N     NA     2804…
#> 13 BPC P… NA     11D2… NA     NA    0      NA        NA       N     NA     311 …
#> 14 SOUTH… NA     11D2… NA     NA    0      NA        NA       N     NA     3312…
#> 15 SGMC … NA     11D2… NA     NA    0      NA        NA       N     NA     2501…
#> 16 SGMC … NA     11D2… NA     NA    0      NA        NA       N     NA     3386…
#> 17 OCTAP… NA     11D2… NA     NA    0      NA        NA       N     NA     1713…
#> 18 VEEDH… NA     11D2… NA     NA    0      NA        NA       N     NA     3386…
#> # ℹ 71 more variables: add_2 <chr>, phone_1 <chr>, phone_2 <chr>, city <chr>,
#> #   state <chr>, zip <chr>, region <chr>, region_st <chr>, ssa_st <chr>,
#> #   ssa_cty <chr>, fips_st <chr>, fips_cty <chr>, cbsa_1 <chr>, cbsa_2 <chr>,
#> #   eligible <chr>, term_pgm <chr>, term_clia <chr>, apl_type <chr>,
#> #   cert_type <chr>, fac_type <chr>, owner <chr>, cert_action <chr>,
#> #   orig_date <chr>, apl_date <chr>, cert_date <chr>, eff_date <chr>,
#> #   mail_date <chr>, term_date <chr>, a2la_cred <chr>, a2la_date <chr>, …
clia(accreditation = "jcaho", count = TRUE)
#> ✔ clia returned 2,765 results.
clia(accreditation = "a2la")
#> ✔ clia returned 11 results.
#> # A data frame: 11 × 82
#>    name_1 name_2 ccn   parent xref  chow_n chow_date chow_prv pos   status add_1
#>  * <chr>  <chr>  <chr> <chr>  <chr> <chr>  <chr>     <chr>    <chr> <chr>  <chr>
#>  1 ONCOL… NA     01D0… NA     NA    0      NA        NA       N     A      3601…
#>  2 EUROF… NA     03D2… NA     NA    0      NA        NA       N     NA     9052…
#>  3 CDC/N… NA     11D0… NA     NA    0      NA        NA       N     A      4770…
#>  4 ADVAN… NA     45D2… NA     NA    0      NA        NA       N     NA     1077…
#>  5 PROTE… NA     45D2… NA     NA    0      NA        NA       N     NA     4514…
#>  6 RAREC… NA     50D2… NA     NA    0      NA        NA       N     A      2601…
#>  7 LIFE … NA     99D2… NA     NA    0      NA        NA       N     NA     ROND…
#>  8 PROTE… NA     99D2… NA     NA    0      NA        NA       N     NA     MARS…
#>  9 RNA D… NA     99D2… NA     NA    0      NA        NA       N     NA     56 W…
#> 10 PATHA… NA     99D2… NA     NA    0      NA        NA       N     NA     500 …
#> 11 EARLY… NA     99D2… NA     NA    0      NA        NA       N     NA     4 ME…
#> # ℹ 71 more variables: add_2 <chr>, phone_1 <chr>, phone_2 <chr>, city <chr>,
#> #   state <chr>, zip <chr>, region <chr>, region_st <chr>, ssa_st <chr>,
#> #   ssa_cty <chr>, fips_st <chr>, fips_cty <chr>, cbsa_1 <chr>, cbsa_2 <chr>,
#> #   eligible <chr>, term_pgm <chr>, term_clia <chr>, apl_type <chr>,
#> #   cert_type <chr>, fac_type <chr>, owner <chr>, cert_action <chr>,
#> #   orig_date <chr>, apl_date <chr>, cert_date <chr>, eff_date <chr>,
#> #   mail_date <chr>, term_date <chr>, a2la_cred <chr>, a2la_date <chr>, …
```
