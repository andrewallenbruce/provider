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
#> ═ clia Totals
#> • Rows  : 676,051
#> • Pages : 136    
#> 

clia(compliant = FALSE, active = TRUE, count = TRUE)
#> ✔ clia returned 2,578 results.

clia(facility_ccn = provider:::cdc_labs$ccn)
#> ✔ clia returned 6 results.
#> # A tibble: 6 × 104
#>   PRVDR_CTGRY_SBTYP_CD PRVDR_CTGRY_CD chown chow_date city     poc_ind compliant
#> * <chr>                <chr>          <int> <date>    <chr>      <int> <chr>    
#> 1 01                   22                 0 NA        ANCHORA…       0 A        
#> 2 01                   22                 0 NA        FORT CO…       1 A        
#> 3 01                   22                 0 NA        ATLANTA        0 A        
#> 4 01                   22                 0 NA        ATLANTA        0 B        
#> 5 01                   22                 0 NA        ATLANTA        0 NA       
#> 6 01                   22                 0 NA        SAN JUAN       0 A        
#> # ℹ 97 more variables: SSA_CNTY_CD <chr>, xref_ccn <chr>, cert_date <date>,
#> #   elig_ind <int>, mac <chr>, MDCD_VNDR_NUM <chr>, orig_date <date>,
#> #   CHOW_PRIOR_DT <chr>, INTRMDRY_CARR_PRIOR_CD <chr>, facility_ccn <chr>,
#> #   RGN_CD <chr>, SKLTN_REC_SW <chr>, state <chr>, SSA_STATE_CD <chr>,
#> #   STATE_RGN_CD <chr>, term_pgm <chr>, term_date <date>, act_type <chr>,
#> #   own_type <chr>, zip <chr>, FIPS_STATE_CD <chr>, FIPS_CNTY_CD <chr>,
#> #   CBSA_URBN_RRL_IND <chr>, CBSA_CD <chr>, …

clia(certificate = c("accreditation", "registration"), city = "Valdosta", state = "GA")
#> ✔ clia returned 18 results.
#> # A tibble: 18 × 104
#>    PRVDR_CTGRY_SBTYP_CD PRVDR_CTGRY_CD chown chow_date city    poc_ind compliant
#>  * <chr>                <chr>          <int> <date>    <chr>     <int> <chr>    
#>  1 01                   22                 0 NA        VALDOS…       0 A        
#>  2 01                   22                 0 NA        VALDOS…       0 A        
#>  3 01                   22                 0 NA        VALDOS…       0 NA       
#>  4 01                   22                 0 NA        VALDOS…       0 A        
#>  5 01                   22                 0 NA        VALDOS…       0 NA       
#>  6 01                   22                 0 NA        VALDOS…       0 NA       
#>  7 01                   22                 0 NA        VALDOS…       0 NA       
#>  8 01                   22                 0 NA        VALDOS…       0 NA       
#>  9 01                   22                 0 NA        VALDOS…       0 NA       
#> 10 01                   22                 0 NA        VALDOS…       0 NA       
#> 11 01                   22                 0 NA        VALDOS…       0 A        
#> 12 01                   22                 0 NA        VALDOS…       0 NA       
#> 13 01                   22                 0 NA        VALDOS…       0 A        
#> 14 01                   22                 0 NA        VALDOS…       0 NA       
#> 15 01                   22                 0 NA        VALDOS…       0 NA       
#> 16 01                   22                 0 NA        VALDOS…       0 NA       
#> 17 01                   22                 0 NA        VALDOS…       0 NA       
#> 18 01                   22                 0 NA        VALDOS…       0 NA       
#> # ℹ 97 more variables: SSA_CNTY_CD <chr>, xref_ccn <chr>, cert_date <date>,
#> #   elig_ind <int>, mac <chr>, MDCD_VNDR_NUM <chr>, orig_date <date>,
#> #   CHOW_PRIOR_DT <chr>, INTRMDRY_CARR_PRIOR_CD <chr>, facility_ccn <chr>,
#> #   RGN_CD <chr>, SKLTN_REC_SW <chr>, state <chr>, SSA_STATE_CD <chr>,
#> #   STATE_RGN_CD <chr>, term_pgm <chr>, term_date <date>, act_type <chr>,
#> #   own_type <chr>, zip <chr>, FIPS_STATE_CD <chr>, FIPS_CNTY_CD <chr>,
#> #   CBSA_URBN_RRL_IND <chr>, CBSA_CD <chr>, …

clia(accreditation = c("cap", "cola", "jcaho"))
#> ✔ clia returned 1 result.
#> # A tibble: 1 × 104
#>   PRVDR_CTGRY_SBTYP_CD PRVDR_CTGRY_CD chown chow_date city     poc_ind compliant
#> * <chr>                <chr>          <int> <date>    <chr>      <int> <chr>    
#> 1 01                   22                 0 NA        WEST CO…       0 NA       
#> # ℹ 97 more variables: SSA_CNTY_CD <chr>, xref_ccn <chr>, cert_date <date>,
#> #   elig_ind <int>, mac <chr>, MDCD_VNDR_NUM <chr>, orig_date <date>,
#> #   CHOW_PRIOR_DT <chr>, INTRMDRY_CARR_PRIOR_CD <chr>, facility_ccn <chr>,
#> #   RGN_CD <chr>, SKLTN_REC_SW <chr>, state <chr>, SSA_STATE_CD <chr>,
#> #   STATE_RGN_CD <chr>, term_pgm <chr>, term_date <date>, act_type <chr>,
#> #   own_type <chr>, zip <chr>, FIPS_STATE_CD <chr>, FIPS_CNTY_CD <chr>,
#> #   CBSA_URBN_RRL_IND <chr>, CBSA_CD <chr>, …
```
