# Clinical Laboratories

Clinical laboratories including demographics and the type of testing
services the facility provides.

## Usage

``` r
clia(
  name = NULL,
  ccn = NULL,
  certificate = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  status = NULL,
  active = FALSE,
  count = FALSE
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

- certificate:

  `<chr>` CLIA certificate type (see details):

  - `"wav"`: Waiver

  - `"ppm"`: Provider-Performed Microscopy (PPM)

  - `"reg"`: Registration

  - `"cmp"`: Compliance

  - `"acc"`: Accreditation

- city:

  `<chr>` City

- state:

  `<chr>` State

- zip:

  `<chr>` Zip code

- status:

  `<chr>` `"cmp"` (Compliant) or `"non"` (Non-Compliant)

- active:

  `<lgl>` Return only active providers

- count:

  `<lgl>` Return the dataset's total row count

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
#> ✔ `clia` returned 671,570 results.
clia(status = "cmp", count = TRUE)
#> ✔ `clia` returned 72,855 results.
clia(ccn = provider:::cdc_labs$ccn)
#> ✔ `clia` returned 6 results.
#> # A tibble: 6 × 82
#>   name_1   name_2 ccn   xref  chow_n chow_date chow_prv pos   status add_1 add_2
#>   <chr>    <chr>  <chr> <chr> <chr>  <chr>     <chr>    <chr> <chr>  <chr> <chr>
#> 1 CDC ARC… CENTE… 02D0… NA    0      NA        NA       N     A      4055… NA   
#> 2 CENTERS… DIVIS… 06D0… NA    0      NA        NA       Y     A      3156… NA   
#> 3 CDC/NCE… NA     11D0… NA    0      NA        NA       N     A      4770… ATTN…
#> 4 CENTERS… NA     11D0… NA    0      NA        NA       N     B      1600… NA   
#> 5 CDC/CGH… ATTEN… 11D1… NA    0      NA        NA       N     NA     1600… NA   
#> 6 CENTERS… DENGU… 40D0… NA    0      NA        NA       N     A      1324… NA   
#> # ℹ 71 more variables: phone_1 <chr>, phone_2 <chr>, city <chr>, state <chr>,
#> #   zip <chr>, region <chr>, region_st <chr>, ssa_st <chr>, ssa_cty <chr>,
#> #   fips_st <chr>, fips_cty <chr>, cbsa_1 <chr>, cbsa_2 <chr>, eligible <chr>,
#> #   term_pgm <chr>, term_clia <chr>, apl_type <chr>, cert_type <chr>,
#> #   fac_type <chr>, owner <chr>, cert_action <chr>, orig_date <chr>,
#> #   apl_date <chr>, cert_date <chr>, eff_date <chr>, mail_date <chr>,
#> #   term_date <chr>, a2la_cred <chr>, a2la_date <chr>, a2la_ind <chr>, …
clia(
  certificate = c("acc", "reg"),
  city = "Valdosta",
  state = "GA"
)
#> ✔ `clia` returned 18 results.
#> # A tibble: 18 × 82
#>    name_1  name_2 ccn   xref  chow_n chow_date chow_prv pos   status add_1 add_2
#>    <chr>   <chr>  <chr> <chr> <chr>  <chr>     <chr>    <chr> <chr>  <chr> <chr>
#>  1 SGMC H… NA     11D0… NA    0      NA        NA       N     A      2501… NA   
#>  2 SGMC- … NA     11D0… NA    0      NA        NA       N     A      4280… NA   
#>  3 SMITH … NA     11D0… NA    0      NA        NA       N     NA     2910… NA   
#>  4 QUEST … SOLST… 11D0… NA    0      NA        NA       N     A      341 … NA   
#>  5 SOUTH … NA     11D0… NA    0      NA        NA       N     NA     2501… NA   
#>  6 NORTHS… WILLI… 11D0… NA    0      NA        NA       N     NA     201 … NA   
#>  7 SOUTH … NA     11D0… NA    0      NA        NA       N     NA     201 … NA   
#>  8 SOUTHE… NA     11D0… NA    0      NA        NA       N     NA     2740… NA   
#>  9 VALDOS… NA     11D1… NA    0      NA        NA       N     NA     2841… NA   
#> 10 ALLEGI… NA     11D1… NA    0      NA        NA       N     NA     5101… NA   
#> 11 CARE M… NA     11D2… NA    0      NA        NA       N     NA     2804… NA   
#> 12 GULF C… NA     11D2… NA    0      NA        NA       N     NA     2804… NA   
#> 13 BPC PL… NA     11D2… NA    0      NA        NA       N     NA     311 … NA   
#> 14 SOUTH … NA     11D2… NA    0      NA        NA       N     NA     3312… NA   
#> 15 SGMC P… NA     11D2… NA    0      NA        NA       N     NA     2501… NA   
#> 16 SGMC F… NA     11D2… NA    0      NA        NA       N     NA     3386… NA   
#> 17 OCTAPH… NA     11D2… NA    0      NA        NA       N     NA     1713… NA   
#> 18 VEEDHA… NA     11D2… NA    0      NA        NA       N     NA     3386… NA   
#> # ℹ 71 more variables: phone_1 <chr>, phone_2 <chr>, city <chr>, state <chr>,
#> #   zip <chr>, region <chr>, region_st <chr>, ssa_st <chr>, ssa_cty <chr>,
#> #   fips_st <chr>, fips_cty <chr>, cbsa_1 <chr>, cbsa_2 <chr>, eligible <chr>,
#> #   term_pgm <chr>, term_clia <chr>, apl_type <chr>, cert_type <chr>,
#> #   fac_type <chr>, owner <chr>, cert_action <chr>, orig_date <chr>,
#> #   apl_date <chr>, cert_date <chr>, eff_date <chr>, mail_date <chr>,
#> #   term_date <chr>, a2la_cred <chr>, a2la_date <chr>, a2la_ind <chr>, …
```
