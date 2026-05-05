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
#> [1] 676051

clia(compliant = FALSE, active = TRUE, count = TRUE)
#> ✔ clia returned 2,578 results.
#> [1] 2578

clia(facility_ccn = provider:::cdc_labs$ccn)
#> ✔ clia returned 6 results.
#> # A tibble: 6 × 65
#>   fac_name fac_ccn clia_ccn xrf_ccn shr_ccn app_type cert_type fac_type own_type
#> * <chr>    <chr>   <chr>    <chr>   <chr>   <chr>    <chr>     <chr>    <chr>   
#> 1 CDC ARC… 02D087… NA       NA      NA      1        1         29       08      
#> 2 CENTERS… 06D088… NA       NA      NA      1        1         29       08      
#> 3 CDC/NCE… 11D066… NA       NA      NA      3        3         29       08      
#> 4 CENTERS… 11D066… NA       NA      NA      1        1         29       08      
#> 5 CDC/CGH… 11D106… NA       NA      NA      3        3         24       08      
#> 6 CENTERS… 40D086… NA       NA      NA      1        1         29       08      
#> # ℹ 56 more variables: act_type <chr>, cert_type <chr>, own_type <chr>,
#> #   fac_type <chr>, act_type <chr>, poc_ind <int>, elig_ind <int>,
#> #   a2la_ind <int>, aabb_ind <int>, aoa_ind <int>, ashi_ind <int>,
#> #   cap_ind <int>, cola_ind <int>, jcaho_ind <int>, multi_ind <int>,
#> #   hosp_ind <int>, non_ind <int>, tmp_ind <int>, a2la_cred <chr>,
#> #   aabb_cred <chr>, aoa_cred <chr>, ashi_cred <chr>, cap_cred <chr>,
#> #   cola_cred <chr>, jcaho_cred <chr>, chow_date <date>, orig_date <date>, …

clia(certificate = c("accreditation", "registration"), city = "Valdosta", state = "GA")
#> ✔ clia returned 18 results.
#> # A tibble: 18 × 65
#>    fac_name         fac_ccn clia_ccn xrf_ccn shr_ccn app_type cert_type fac_type
#>  * <chr>            <chr>   <chr>    <chr>   <chr>   <chr>    <chr>     <chr>   
#>  1 SGMC HEALTH      11D002… 110122   NA      NA      3        3         14      
#>  2 SGMC- SMITH NOR… 11D002… 110037   NA      NA      3        3         02      
#>  3 SMITH & DENNARD… 11D026… 2546236… NA      NA      3        9         21      
#>  4 QUEST DIAGNOSTI… 11D064… 11L0008… NA      NA      3        3         15      
#>  5 SOUTH GA MED CT… 11D068… 110122   NA      NA      3        3         29      
#>  6 NORTHSIDE MEDIC… 11D090… NA       NA      NA      3        3         21      
#>  7 SOUTH GEORGIA W… 11D091… NA       NA      NA      3        9         21      
#>  8 SOUTHERN PHYSIC… 11D096… NA       NA      NA      3        9         21      
#>  9 VALDOSTA CBOC    11D100… NA       NA      NA      3        3         06      
#> 10 ALLEGIANT SOLUT… 11D106… NA       NA      NA      3        3         15      
#> 11 CARE MEDICAL CE… 11D202… NA       NA      NA      3        3         29      
#> 12 GULF COAST DERM… 11D205… NA       NA      NA      1        9         21      
#> 13 BPC PLASMA, INC… 11D207… NA       NA      NA      3        3         29      
#> 14 SOUTH GEORGIA T… 11D210… NA       NA      NA      3        3         15      
#> 15 SGMC POINT OF C… 11D214… NA       NA      NA      3        3         14      
#> 16 SGMC FAMILY PRA… 11D214… NA       NA      NA      3        3         21      
#> 17 OCTAPHARMA PLAS… 11D219… NA       NA      NA      3        3         29      
#> 18 VEEDHATA OM LLC… 11D222… NA       NA      NA      3        3         15      
#> # ℹ 57 more variables: own_type <chr>, act_type <chr>, cert_type <chr>,
#> #   own_type <chr>, fac_type <chr>, act_type <chr>, poc_ind <int>,
#> #   elig_ind <int>, a2la_ind <int>, aabb_ind <int>, aoa_ind <int>,
#> #   ashi_ind <int>, cap_ind <int>, cola_ind <int>, jcaho_ind <int>,
#> #   multi_ind <int>, hosp_ind <int>, non_ind <int>, tmp_ind <int>,
#> #   a2la_cred <chr>, aabb_cred <chr>, aoa_cred <chr>, ashi_cred <chr>,
#> #   cap_cred <chr>, cola_cred <chr>, jcaho_cred <chr>, chow_date <date>, …

clia(accreditation = c("cap", "cola", "jcaho"))
#> ✔ clia returned 1 result.
#> # A tibble: 1 × 65
#>   fac_name fac_ccn clia_ccn xrf_ccn shr_ccn app_type cert_type fac_type own_type
#> * <chr>    <chr>   <chr>    <chr>   <chr>   <chr>    <chr>     <chr>    <chr>   
#> 1 LEXINGT… 42D066… 420073   NA      NA      3        3         14       06      
#> # ℹ 56 more variables: act_type <chr>, cert_type <chr>, own_type <chr>,
#> #   fac_type <chr>, act_type <chr>, poc_ind <int>, elig_ind <int>,
#> #   a2la_ind <int>, aabb_ind <int>, aoa_ind <int>, ashi_ind <int>,
#> #   cap_ind <int>, cola_ind <int>, jcaho_ind <int>, multi_ind <int>,
#> #   hosp_ind <int>, non_ind <int>, tmp_ind <int>, a2la_cred <chr>,
#> #   aabb_cred <chr>, aoa_cred <chr>, ashi_cred <chr>, cap_cred <chr>,
#> #   cola_cred <chr>, jcaho_cred <chr>, chow_date <date>, orig_date <date>, …
```
