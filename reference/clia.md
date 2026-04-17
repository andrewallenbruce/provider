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
#> # A tibble: 6 × 82
#>   fac_name_1    fac_name_2 facility_ccn parent_ccn related_ccn xref  chown chowd
#> * <chr>         <chr>      <chr>        <chr>      <chr>       <chr> <chr> <chr>
#> 1 CDC ARCTIC I… CENTERS F… 02D0873639   NA         NA          NA    0     NA   
#> 2 CENTERS FOR … DIVISION … 06D0880233   NA         NA          NA    0     NA   
#> 3 CDC/NCEH/DIV… NA         11D0668290   NA         NA          NA    0     NA   
#> 4 CENTERS FOR … NA         11D0668319   NA         NA          NA    0     NA   
#> 5 CDC/CGH/DGHA… ATTENTION… 11D1061576   NA         NA          NA    0     NA   
#> 6 CENTERS FOR … DENGUE BR… 40D0869394   NA         NA          NA    0     NA   
#> # ℹ 74 more variables: chowd_2 <chr>, poc <chr>, compliant <chr>, add_1 <chr>,
#> #   add_2 <chr>, phone_1 <chr>, phone_2 <chr>, city <chr>, state <chr>,
#> #   zip <chr>, reg_cd <chr>, reg_st <chr>, ssa_st <chr>, ssa_cty <chr>,
#> #   fips_st <chr>, fips_cty <chr>, cbsa_1 <chr>, cbsa_2 <chr>, elig <chr>,
#> #   term_pgm <chr>, term_clia <chr>, app_type <chr>, cert_type <chr>,
#> #   fac_type <chr>, owner <chr>, action <chr>, orig_date <chr>, app_date <chr>,
#> #   cert_date <chr>, eff_date <chr>, mail_date <chr>, term_date <chr>, …

clia(certificate = c("accreditation", "registration"), city = "Valdosta", state = "GA")
#> ✔ clia returned 18 results.
#> # A tibble: 18 × 82
#>    fac_name_1   fac_name_2 facility_ccn parent_ccn related_ccn xref  chown chowd
#>  * <chr>        <chr>      <chr>        <chr>      <chr>       <chr> <chr> <chr>
#>  1 SGMC HEALTH  NA         11D0022233   110122     NA          NA    0     NA   
#>  2 SGMC- SMITH… NA         11D0022241   110037     NA          NA    0     NA   
#>  3 SMITH & DEN… NA         11D0265567   254623647A NA          NA    0     NA   
#>  4 QUEST DIAGN… SOLSTAS L… 11D0646134   11L0008004 NA          NA    0     NA   
#>  5 SOUTH GA ME… NA         11D0680179   110122     NA          NA    0     NA   
#>  6 NORTHSIDE M… WILLIAM C… 11D0902131   NA         NA          NA    0     NA   
#>  7 SOUTH GEORG… NA         11D0914178   NA         NA          NA    0     NA   
#>  8 SOUTHERN PH… NA         11D0960358   NA         NA          NA    0     NA   
#>  9 VALDOSTA CB… NA         11D1001568   NA         NA          NA    0     NA   
#> 10 ALLEGIANT S… NA         11D1065138   NA         NA          NA    0     NA   
#> 11 CARE MEDICA… NA         11D2027917   NA         NA          NA    0     NA   
#> 12 GULF COAST … NA         11D2053438   NA         NA          NA    0     NA   
#> 13 BPC PLASMA,… NA         11D2079448   NA         NA          NA    0     NA   
#> 14 SOUTH GEORG… NA         11D2101175   NA         NA          NA    0     NA   
#> 15 SGMC POINT … NA         11D2144796   NA         NA          NA    0     NA   
#> 16 SGMC FAMILY… NA         11D2144934   NA         NA          NA    0     NA   
#> 17 OCTAPHARMA … NA         11D2193538   NA         NA          NA    0     NA   
#> 18 VEEDHATA OM… NA         11D2223235   NA         NA          NA    0     NA   
#> # ℹ 74 more variables: chowd_2 <chr>, poc <chr>, compliant <chr>, add_1 <chr>,
#> #   add_2 <chr>, phone_1 <chr>, phone_2 <chr>, city <chr>, state <chr>,
#> #   zip <chr>, reg_cd <chr>, reg_st <chr>, ssa_st <chr>, ssa_cty <chr>,
#> #   fips_st <chr>, fips_cty <chr>, cbsa_1 <chr>, cbsa_2 <chr>, elig <chr>,
#> #   term_pgm <chr>, term_clia <chr>, app_type <chr>, cert_type <chr>,
#> #   fac_type <chr>, owner <chr>, action <chr>, orig_date <chr>, app_date <chr>,
#> #   cert_date <chr>, eff_date <chr>, mail_date <chr>, term_date <chr>, …

clia(accreditation = c("cap", "cola", "jcaho"))
#> ✔ clia returned 1 result.
#> # A tibble: 1 × 82
#>   fac_name_1    fac_name_2 facility_ccn parent_ccn related_ccn xref  chown chowd
#> * <chr>         <chr>      <chr>        <chr>      <chr>       <chr> <chr> <chr>
#> 1 LEXINGTON ME… NA         42D0665325   420073     NA          NA    0     NA   
#> # ℹ 74 more variables: chowd_2 <chr>, poc <chr>, compliant <chr>, add_1 <chr>,
#> #   add_2 <chr>, phone_1 <chr>, phone_2 <chr>, city <chr>, state <chr>,
#> #   zip <chr>, reg_cd <chr>, reg_st <chr>, ssa_st <chr>, ssa_cty <chr>,
#> #   fips_st <chr>, fips_cty <chr>, cbsa_1 <chr>, cbsa_2 <chr>, elig <chr>,
#> #   term_pgm <chr>, term_clia <chr>, app_type <chr>, cert_type <chr>,
#> #   fac_type <chr>, owner <chr>, action <chr>, orig_date <chr>, app_date <chr>,
#> #   cert_date <chr>, eff_date <chr>, mail_date <chr>, term_date <chr>, …
```
