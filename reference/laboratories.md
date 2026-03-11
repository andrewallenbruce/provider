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

  `<lgl>` Return only active providers

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
laboratories()
#> ! No Query → Returning first 10 rows.
#> # A tibble: 10 × 82
#>    name_1 name_2 ccn   xref  chow_n chow_date chow_prev pos   status add_1 add_2
#>    <chr>  <chr>  <chr> <chr> <chr>  <chr>     <chr>     <chr> <chr>  <chr> <chr>
#>  1 SHELB… NA     01D0… NA    0      NA        NA        N     NA     1000… NA   
#>  2 WOODL… NA     01D0… NA    0      NA        NA        N     NA     1910… NA   
#>  3 CULLM… NA     01D0… 01D0… 0      NA        NA        N     NA     1912… NA   
#>  4 ST VI… NA     01D0… NA    0      NA        NA        N     B      7063… ATTN…
#>  5 BAPTI… NA     01D0… NA    0      NA        NA        N     A      604 … NA   
#>  6 UAB H… NA     01D0… NA    0      NA        NA        N     NA     1201… NA   
#>  7 ASCEN… NA     01D0… NA    0      NA        NA        N     NA     810 … NA   
#>  8 AMER … NA     01D0… NA    0      NA        NA        N     NA     1501… NA   
#>  9 MCE-F… NA     01D0… NA    0      NA        NA        Y     A      9823… NA   
#> 10 JCDH-… NA     01D0… 01D0… 0      NA        NA        Y     A      2201… NA   
#> # ℹ 71 more variables: phone_1 <chr>, phone_2 <chr>, city <chr>, state <chr>,
#> #   region <chr>, zip <chr>, state_ssa <chr>, county_ssa <chr>,
#> #   fips_state <chr>, fips_county <chr>, state_reg <chr>, cbsa_cd <chr>,
#> #   cbsa_ind <chr>, eligible <chr>, term_pgm <chr>, term_clia <chr>,
#> #   apl_type <chr>, cert_type <chr>, fac_type <chr>, ownership <chr>,
#> #   cert_action <chr>, orig_date <chr>, apl_date <chr>, cert_date <chr>,
#> #   eff_date <chr>, mail_date <chr>, term_date <chr>, a2la_cred <chr>, …

provider:::cdc_labs
#> # A tibble: 6 × 4
#>   laboratory                                                   ccn   city  state
#>   <chr>                                                        <chr> <chr> <chr>
#> 1 Artic Envestigations Program Laboratory                      02D0… Anch… AK   
#> 2 Dengue Laboratory                                            40D0… San … PR   
#> 3 CDC/CGH/DGHA International Laboratory                        11D1… Atla… GA   
#> 4 Infectious Diseases Laboratory                               11D0… Atla… GA   
#> 5 National Center for Environmental Health, Division of Labor… 11D0… Atla… GA   
#> 6 Vector-Borne Diseases Laboratory                             06D0… Fort… CO   

laboratories(ccn = provider:::cdc_labs$ccn)
#> ✔ Query returned 6 results.
#> # A tibble: 6 × 82
#>   name_1  name_2 ccn   xref  chow_n chow_date chow_prev pos   status add_1 add_2
#>   <chr>   <chr>  <chr> <chr> <chr>  <chr>     <chr>     <chr> <chr>  <chr> <chr>
#> 1 CDC AR… CENTE… 02D0… NA    0      NA        NA        N     A      4055… NA   
#> 2 CENTER… DIVIS… 06D0… NA    0      NA        NA        Y     A      3156… NA   
#> 3 CDC/NC… NA     11D0… NA    0      NA        NA        N     A      4770… ATTN…
#> 4 CENTER… NA     11D0… NA    0      NA        NA        N     B      1600… NA   
#> 5 CDC/CG… ATTEN… 11D1… NA    0      NA        NA        N     NA     1600… NA   
#> 6 CENTER… DENGU… 40D0… NA    0      NA        NA        N     A      1324… NA   
#> # ℹ 71 more variables: phone_1 <chr>, phone_2 <chr>, city <chr>, state <chr>,
#> #   region <chr>, zip <chr>, state_ssa <chr>, county_ssa <chr>,
#> #   fips_state <chr>, fips_county <chr>, state_reg <chr>, cbsa_cd <chr>,
#> #   cbsa_ind <chr>, eligible <chr>, term_pgm <chr>, term_clia <chr>,
#> #   apl_type <chr>, cert_type <chr>, fac_type <chr>, ownership <chr>,
#> #   cert_action <chr>, orig_date <chr>, apl_date <chr>, cert_date <chr>,
#> #   eff_date <chr>, mail_date <chr>, term_date <chr>, a2la_cred <chr>, …

laboratories(
   cert = c("ppm"),
   city = not_equal("Valdosta"),
   state = "GA",
   active = TRUE
 )
#> ✔ Query returned 896 results.
#> # A tibble: 896 × 82
#>    name_1 name_2 ccn   xref  chow_n chow_date chow_prev pos   status add_1 add_2
#>    <chr>  <chr>  <chr> <chr> <chr>  <chr>     <chr>     <chr> <chr>  <chr> <chr>
#>  1 WELLS… NA     11D0… NA    0      NA        NA        Y     A      1791… NA   
#>  2 COBB … NA     11D0… NA    0      NA        NA        Y     A      1810… NA   
#>  3 WELLS… NA     11D0… NA    0      NA        NA        N     NA     1790… NA   
#>  4 WELLS… NA     11D0… NA    0      NA        NA        N     NA     1700… NA   
#>  5 ATLAN… NA     11D0… NA    0      NA        NA        N     NA     315 … NA   
#>  6 CONCE… NA     11D0… NA    0      NA        NA        Y     A      1045… NA   
#>  7 MEDCU… NA     11D0… NA    0      NA        NA        N     NA     5582… NA   
#>  8 SOUTH… NA     11D0… NA    0      NA        NA        Y     A      2855… NA   
#>  9 SNAPF… NA     11D0… NA    0      NA        NA        N     NA     5040… NA   
#> 10 GEORG… NA     11D0… NA    0      NA        NA        Y     A      55 W… NA   
#> # ℹ 886 more rows
#> # ℹ 71 more variables: phone_1 <chr>, phone_2 <chr>, city <chr>, state <chr>,
#> #   region <chr>, zip <chr>, state_ssa <chr>, county_ssa <chr>,
#> #   fips_state <chr>, fips_county <chr>, state_reg <chr>, cbsa_cd <chr>,
#> #   cbsa_ind <chr>, eligible <chr>, term_pgm <chr>, term_clia <chr>,
#> #   apl_type <chr>, cert_type <chr>, fac_type <chr>, ownership <chr>,
#> #   cert_action <chr>, orig_date <chr>, apl_date <chr>, cert_date <chr>, …
```
