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

- [CMS
  CLIA](https://www.cms.gov/medicare/quality/clinical-laboratory-improvement-amendments)

- [CDC CLIA](https://www.cdc.gov/clia/php/about/index.html)

- [CMS QCOR](https://qcor.cms.gov/main.jsp)

- [CLIA
  Certificates](https://www.cdc.gov/labs/clia-certificates/index.html)

- [CLIA Certificate Fee
  Schedule](https://www.cms.gov/files/document/clia-certificate-fee-schedule-updated-06/7/2024.pdf)

- [CLIA Certification
  Guide](https://www.cms.gov/files/document/clia-cert-quick-start-guide.pdf)

## Examples

``` r
# Artic Envestigations Program Laboratory, Anchorage, AK
laboratories(ccn = "02D0873639")
#> ✔ Query returned 1 result.
#> # A tibble: 1 × 103
#>   prv_cat prv_type chow_count chow_date city    pos   status county_ssa xref_ccn
#>   <chr>   <chr>    <chr>      <chr>     <chr>   <chr> <chr>  <chr>      <chr>   
#> 1 22      01       0          NA        ANCHOR… N     A      020        NA      
#> # ℹ 94 more variables: cert_date <chr>, eligible_ind <chr>, name <chr>,
#> #   mac_curr <chr>, vend <chr>, orig_date <chr>, chow_prev_date <chr>,
#> #   mac_prev <chr>, ccn <chr>, region <chr>, skeleton <chr>, state <chr>,
#> #   state_ssa <chr>, state_reg <chr>, add_1 <chr>, phone_1 <chr>,
#> #   term_cd <chr>, term_date <chr>, cert_action <chr>, ownership <chr>,
#> #   zip <chr>, fips_state <chr>, fips_county <chr>, cbsa_ind <chr>,
#> #   cbsa_cd <chr>, add_2 <chr>, aff_1 <chr>, aff_2 <chr>, aff_3 <chr>, …

# Dengue Laboratory, San Juan, PR
laboratories(ccn = "40D0869394")
#> ✔ Query returned 1 result.
#> # A tibble: 1 × 103
#>   prv_cat prv_type chow_count chow_date city    pos   status county_ssa xref_ccn
#>   <chr>   <chr>    <chr>      <chr>     <chr>   <chr> <chr>  <chr>      <chr>   
#> 1 22      01       0          NA        SAN JU… N     A      640        NA      
#> # ℹ 94 more variables: cert_date <chr>, eligible_ind <chr>, name <chr>,
#> #   mac_curr <chr>, vend <chr>, orig_date <chr>, chow_prev_date <chr>,
#> #   mac_prev <chr>, ccn <chr>, region <chr>, skeleton <chr>, state <chr>,
#> #   state_ssa <chr>, state_reg <chr>, add_1 <chr>, phone_1 <chr>,
#> #   term_cd <chr>, term_date <chr>, cert_action <chr>, ownership <chr>,
#> #   zip <chr>, fips_state <chr>, fips_county <chr>, cbsa_ind <chr>,
#> #   cbsa_cd <chr>, add_2 <chr>, aff_1 <chr>, aff_2 <chr>, aff_3 <chr>, …

# CDC/CGH/DGHA International Laboratory, Atlanta, GA
laboratories(ccn = "11D1061576")
#> ✔ Query returned 1 result.
#> # A tibble: 1 × 103
#>   prv_cat prv_type chow_count chow_date city    pos   status county_ssa xref_ccn
#>   <chr>   <chr>    <chr>      <chr>     <chr>   <chr> <chr>  <chr>      <chr>   
#> 1 22      01       0          NA        ATLANTA N     NA     370        NA      
#> # ℹ 94 more variables: cert_date <chr>, eligible_ind <chr>, name <chr>,
#> #   mac_curr <chr>, vend <chr>, orig_date <chr>, chow_prev_date <chr>,
#> #   mac_prev <chr>, ccn <chr>, region <chr>, skeleton <chr>, state <chr>,
#> #   state_ssa <chr>, state_reg <chr>, add_1 <chr>, phone_1 <chr>,
#> #   term_cd <chr>, term_date <chr>, cert_action <chr>, ownership <chr>,
#> #   zip <chr>, fips_state <chr>, fips_county <chr>, cbsa_ind <chr>,
#> #   cbsa_cd <chr>, add_2 <chr>, aff_1 <chr>, aff_2 <chr>, aff_3 <chr>, …

# Infectious Diseases Laboratory, Atlanta, GA
laboratories(ccn = "11D0668319")
#> ✔ Query returned 1 result.
#> # A tibble: 1 × 103
#>   prv_cat prv_type chow_count chow_date city    pos   status county_ssa xref_ccn
#>   <chr>   <chr>    <chr>      <chr>     <chr>   <chr> <chr>  <chr>      <chr>   
#> 1 22      01       0          NA        ATLANTA N     B      370        NA      
#> # ℹ 94 more variables: cert_date <chr>, eligible_ind <chr>, name <chr>,
#> #   mac_curr <chr>, vend <chr>, orig_date <chr>, chow_prev_date <chr>,
#> #   mac_prev <chr>, ccn <chr>, region <chr>, skeleton <chr>, state <chr>,
#> #   state_ssa <chr>, state_reg <chr>, add_1 <chr>, phone_1 <chr>,
#> #   term_cd <chr>, term_date <chr>, cert_action <chr>, ownership <chr>,
#> #   zip <chr>, fips_state <chr>, fips_county <chr>, cbsa_ind <chr>,
#> #   cbsa_cd <chr>, add_2 <chr>, aff_1 <chr>, aff_2 <chr>, aff_3 <chr>, …

# National Center for Environmental Health, Division of Laboratory Science, Atlanta, GA
laboratories(ccn = "11D0668290")
#> ✔ Query returned 1 result.
#> # A tibble: 1 × 103
#>   prv_cat prv_type chow_count chow_date city    pos   status county_ssa xref_ccn
#>   <chr>   <chr>    <chr>      <chr>     <chr>   <chr> <chr>  <chr>      <chr>   
#> 1 22      01       0          NA        ATLANTA N     A      370        NA      
#> # ℹ 94 more variables: cert_date <chr>, eligible_ind <chr>, name <chr>,
#> #   mac_curr <chr>, vend <chr>, orig_date <chr>, chow_prev_date <chr>,
#> #   mac_prev <chr>, ccn <chr>, region <chr>, skeleton <chr>, state <chr>,
#> #   state_ssa <chr>, state_reg <chr>, add_1 <chr>, phone_1 <chr>,
#> #   term_cd <chr>, term_date <chr>, cert_action <chr>, ownership <chr>,
#> #   zip <chr>, fips_state <chr>, fips_county <chr>, cbsa_ind <chr>,
#> #   cbsa_cd <chr>, add_2 <chr>, aff_1 <chr>, aff_2 <chr>, aff_3 <chr>, …

# Vector-Borne Diseases Laboratory, Fort Collins, CO
laboratories(ccn = "06D0880233")
#> ✔ Query returned 1 result.
#> # A tibble: 1 × 103
#>   prv_cat prv_type chow_count chow_date city    pos   status county_ssa xref_ccn
#>   <chr>   <chr>    <chr>      <chr>     <chr>   <chr> <chr>  <chr>      <chr>   
#> 1 22      01       0          NA        FORT C… Y     A      340        NA      
#> # ℹ 94 more variables: cert_date <chr>, eligible_ind <chr>, name <chr>,
#> #   mac_curr <chr>, vend <chr>, orig_date <chr>, chow_prev_date <chr>,
#> #   mac_prev <chr>, ccn <chr>, region <chr>, skeleton <chr>, state <chr>,
#> #   state_ssa <chr>, state_reg <chr>, add_1 <chr>, phone_1 <chr>,
#> #   term_cd <chr>, term_date <chr>, cert_action <chr>, ownership <chr>,
#> #   zip <chr>, fips_state <chr>, fips_county <chr>, cbsa_ind <chr>,
#> #   cbsa_cd <chr>, add_2 <chr>, aff_1 <chr>, aff_2 <chr>, aff_3 <chr>, …

# Wiregrass Georgia Tech College Student Health Center, Valdosta, GA
laboratories(ccn = "11D2306220")
#> ✔ Query returned 1 result.
#> # A tibble: 1 × 103
#>   prv_cat prv_type chow_count chow_date city    pos   status county_ssa xref_ccn
#>   <chr>   <chr>    <chr>      <chr>     <chr>   <chr> <chr>  <chr>      <chr>   
#> 1 22      01       0          NA        VALDOS… N     NA     700        NA      
#> # ℹ 94 more variables: cert_date <chr>, eligible_ind <chr>, name <chr>,
#> #   mac_curr <chr>, vend <chr>, orig_date <chr>, chow_prev_date <chr>,
#> #   mac_prev <chr>, ccn <chr>, region <chr>, skeleton <chr>, state <chr>,
#> #   state_ssa <chr>, state_reg <chr>, add_1 <chr>, phone_1 <chr>,
#> #   term_cd <chr>, term_date <chr>, cert_action <chr>, ownership <chr>,
#> #   zip <chr>, fips_state <chr>, fips_county <chr>, cbsa_ind <chr>,
#> #   cbsa_cd <chr>, add_2 <chr>, aff_1 <chr>, aff_2 <chr>, aff_3 <chr>, …

laboratories(ccn = "11D0265516")
#> ✔ Query returned 1 result.
#> # A tibble: 1 × 103
#>   prv_cat prv_type chow_count chow_date city    pos   status county_ssa xref_ccn
#>   <chr>   <chr>    <chr>      <chr>     <chr>   <chr> <chr>  <chr>      <chr>   
#> 1 22      01       0          NA        VALDOS… Y     A      700        NA      
#> # ℹ 94 more variables: cert_date <chr>, eligible_ind <chr>, name <chr>,
#> #   mac_curr <chr>, vend <chr>, orig_date <chr>, chow_prev_date <chr>,
#> #   mac_prev <chr>, ccn <chr>, region <chr>, skeleton <chr>, state <chr>,
#> #   state_ssa <chr>, state_reg <chr>, add_1 <chr>, phone_1 <chr>,
#> #   term_cd <chr>, term_date <chr>, cert_action <chr>, ownership <chr>,
#> #   zip <chr>, fips_state <chr>, fips_county <chr>, cbsa_ind <chr>,
#> #   cbsa_cd <chr>, add_2 <chr>, aff_1 <chr>, aff_2 <chr>, aff_3 <chr>, …

laboratories(cert = "ppm", city = "Valdosta", state = "GA", active = TRUE)
#> ✔ Query returned 3 results.
#> # A tibble: 3 × 103
#>   prv_cat prv_type chow_count chow_date city    pos   status county_ssa xref_ccn
#>   <chr>   <chr>    <chr>      <chr>     <chr>   <chr> <chr>  <chr>      <chr>   
#> 1 22      01       0          NA        VALDOS… N     NA     700        NA      
#> 2 22      01       0          NA        VALDOS… N     NA     700        NA      
#> 3 22      01       0          NA        VALDOS… N     A      700        NA      
#> # ℹ 94 more variables: cert_date <chr>, eligible_ind <chr>, name <chr>,
#> #   mac_curr <chr>, vend <chr>, orig_date <chr>, chow_prev_date <chr>,
#> #   mac_prev <chr>, ccn <chr>, region <chr>, skeleton <chr>, state <chr>,
#> #   state_ssa <chr>, state_reg <chr>, add_1 <chr>, phone_1 <chr>,
#> #   term_cd <chr>, term_date <chr>, cert_action <chr>, ownership <chr>,
#> #   zip <chr>, fips_state <chr>, fips_county <chr>, cbsa_ind <chr>,
#> #   cbsa_cd <chr>, add_2 <chr>, aff_1 <chr>, aff_2 <chr>, aff_3 <chr>, …
```
