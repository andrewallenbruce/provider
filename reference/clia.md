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
  chow = NULL,
  compliant = NULL,
  active = NULL,
  multi = NULL,
  campus = NULL,
  non_profit = NULL,
  eligible = NULL,
  temp_site = NULL,
  poc = NULL,
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

- chow:

  `<int>` Number of times there has been a Change of Ownership.

- compliant:

  `<lgl>` Provider compliance status at time of certification survey.

- active:

  `<lgl>` Return only active labs

- multi:

  `<lgl>` Indicates lab has applied for a single site CLIA to cover
  multiple testing locations.

- campus:

  `<lgl>` Indicates single site CLIA is for hospital with several labs
  on a single hospital campus.

- non_profit:

  `<lgl>` Indicates single site CLIA is for multiple sites with
  non-profit, federal, state or local government status and engaged in
  limited public health testing.

- eligible:

  `<lgl>` Indicates lab is eligible to participate in Medicare/Medicaid.

- temp_site:

  `<lgl>` Indicates single site CLIA is for lab with multiple temporary
  testing sites.

- poc:

  `<lgl>` Indicates provider is in compliance with Plan of Correction.

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
#> clia Totals
#> • Rows  : 676,051
#> • Pages : 136    
#> 

clia(compliant = FALSE, active = TRUE, count = TRUE)
#> ✔ clia returned 2,578 results.

clia(facility_ccn = provider:::cdc_labs$ccn)
#> ✔ clia returned 6 results.
#> # A tibble: 6 × 30
#>   fac_1    fac_ccn clia_ccn xrf_ccn shr_ccn chow_cnt compliant add_1 city  state
#> * <chr>    <chr>   <chr>    <chr>   <chr>      <int> <chr>     <chr> <chr> <chr>
#> 1 CENTERS… 02D087… NA       NA      NA             0 A         4055… ANCH… AK   
#> 2 DIVISIO… 06D088… NA       NA      NA             0 A         3156… FORT… CO   
#> 3 CDC/NCE… 11D066… NA       NA      NA             0 A         ATTN… ATLA… GA   
#> 4 CENTERS… 11D066… NA       NA      NA             0 B         1600… ATLA… GA   
#> 5 ATTENTI… 11D106… NA       NA      NA             0 NA        1600… ATLA… GA   
#> 6 DENGUE … 40D086… NA       NA      NA             0 A         1324… SAN … PR   
#> # ℹ 20 more variables: zip <chr>, term_type <chr>, cert_type <chr>,
#> #   fac_type <chr>, own_type <chr>, act_type <chr>, orig_date <date>,
#> #   cert_date <date>, eff_date <date>, term_date <date>, alab_cnt <int>,
#> #   site_cnt <int>, multi_ind <int>, hosp_ind <int>, non_ind <int>,
#> #   tmp_ind <int>, poc_ind <int>, elig_ind <int>, acr_org <chr>,
#> #   acr_date <date>

clia(certificate = c("accreditation", "registration"), city = "Valdosta", state = "GA")
#> ✔ clia returned 18 results.
#> # A tibble: 18 × 30
#>    fac_1   fac_ccn clia_ccn xrf_ccn shr_ccn chow_cnt compliant add_1 city  state
#>  * <chr>   <chr>   <chr>    <chr>   <chr>      <int> <chr>     <chr> <chr> <chr>
#>  1 SGMC H… 11D002… 110122   NA      NA             0 A         2501… VALD… GA   
#>  2 SGMC- … 11D002… 110037   NA      NA             0 A         4280… VALD… GA   
#>  3 SMITH … 11D026… 2546236… NA      NA             0 NA        2910… VALD… GA   
#>  4 SOLSTA… 11D064… 11L0008… NA      NA             0 A         341 … VALD… GA   
#>  5 SOUTH … 11D068… 110122   NA      NA             0 NA        2501… VALD… GA   
#>  6 WILLIA… 11D090… NA       NA      NA             0 NA        201 … VALD… GA   
#>  7 SOUTH … 11D091… NA       NA      NA             0 NA        201 … VALD… GA   
#>  8 SOUTHE… 11D096… NA       NA      NA             0 NA        2740… VALD… GA   
#>  9 VALDOS… 11D100… NA       NA      NA             0 NA        2841… VALD… GA   
#> 10 ALLEGI… 11D106… NA       NA      NA             0 NA        5101… VALD… GA   
#> 11 CARE M… 11D202… NA       NA      NA             0 A         2804… VALD… GA   
#> 12 GULF C… 11D205… NA       NA      NA             0 NA        2804… VALD… GA   
#> 13 BPC PL… 11D207… NA       NA      NA             0 A         311 … VALD… GA   
#> 14 SOUTH … 11D210… NA       NA      NA             0 NA        3312… VALD… GA   
#> 15 SGMC P… 11D214… NA       NA      NA             0 NA        2501… VALD… GA   
#> 16 SGMC F… 11D214… NA       NA      NA             0 NA        3386… VALD… GA   
#> 17 OCTAPH… 11D219… NA       NA      NA             0 NA        1713… VALD… GA   
#> 18 VEEDHA… 11D222… NA       NA      NA             0 NA        3386… VALD… GA   
#> # ℹ 20 more variables: zip <chr>, term_type <chr>, cert_type <chr>,
#> #   fac_type <chr>, own_type <chr>, act_type <chr>, orig_date <date>,
#> #   cert_date <date>, eff_date <date>, term_date <date>, alab_cnt <int>,
#> #   site_cnt <int>, multi_ind <int>, hosp_ind <int>, non_ind <int>,
#> #   tmp_ind <int>, poc_ind <int>, elig_ind <int>, acr_org <chr>,
#> #   acr_date <date>

clia(accreditation = c("cap", "cola", "jcaho"))
#> ✔ clia returned 1 result.
#> # A tibble: 3 × 30
#>   fac_1    fac_ccn clia_ccn xrf_ccn shr_ccn chow_cnt compliant add_1 city  state
#>   <chr>    <chr>   <chr>    <chr>   <chr>      <int> <chr>     <chr> <chr> <chr>
#> 1 LEXINGT… 42D066… 420073   NA      NA             0 NA        2720… WEST… SC   
#> 2 LEXINGT… 42D066… 420073   NA      NA             0 NA        2720… WEST… SC   
#> 3 LEXINGT… 42D066… 420073   NA      NA             0 NA        2720… WEST… SC   
#> # ℹ 20 more variables: zip <chr>, term_type <chr>, cert_type <chr>,
#> #   fac_type <chr>, own_type <chr>, act_type <chr>, orig_date <date>,
#> #   cert_date <date>, eff_date <date>, term_date <date>, alab_cnt <int>,
#> #   site_cnt <int>, multi_ind <int>, hosp_ind <int>, non_ind <int>,
#> #   tmp_ind <int>, poc_ind <int>, elig_ind <int>, acr_org <chr>,
#> #   acr_date <date>
```
