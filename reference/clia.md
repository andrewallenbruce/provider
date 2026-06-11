# Clinical Laboratories

Clinical laboratories including demographics and the type of testing
services the facility provides.

## Usage

``` r
clia(
  fac_name = NULL,
  fac_ccn = NULL,
  clia_ccn = NULL,
  cert_type = NULL,
  acr_org = NULL,
  multi = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  chows = NULL,
  active = NULL,
  eligible = NULL,
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

- fac_name:

  `<chr>` Provider/Laboratory name

- fac_ccn:

  `<chr>` 10-digit CMS Certification Number

- clia_ccn:

  `<chr>` 6-digit CMS Certification Number

- cert_type:

  `<enum>` CLIA certificate type (see Details):

  - `"wav"` = Waiver

  - `"ppm"` = Provider-Performed Microscopy (PPM)

  - `"reg"` = Registration

  - `"cmp"` = Compliance

  - `"acr"` = Accreditation

- acr_org:

  `<enum>` CLIA accrediting organization (see Details):

  - `"a2la"` = American Association for Laboratory Accreditation

  - `"aabb"` = Association for the Advancement of Blood & Biotherapies

  - `"aoa"` = American Osteopathic Association

  - `"ashi"` = American Society for Histocompatibility & Immunogenetics

  - `"cap"` = College of American Pathologists

  - `"cola"` = Commission on Office Laboratory Accreditation

  - `"jcaho"` = The Joint Commission

- multi:

  `<enum>` Single site CLIA multiple-site exceptions:

  - `"applied"` = Applied for to cover multiple testing locations

  - `"campus"` = Hospital with several labs on single hospital campus

  - `"non"` = Multiple sites with non-profit, federal, state or local
    government status (limited public health testing)

  - `"temp"` = Lab with multiple temporary testing sites

- city, state, zip:

  `<chr>` Lab city, state, zip

- chows:

  `<int>` Number of times there has been a Change of Ownership.

- active:

  `<lgl>` Return only active labs

- eligible:

  `<lgl>` Indicates lab is eligible to participate in Medicare/Medicaid.

- count:

  `<lgl>` Return the total row count

- set:

  `<lgl>` Return the entire dataset

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)

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
clia(cert_type = c("acr", "reg"), city = "Valdosta", state = "GA")
#> ✔ clia returned 18 results
#> ✔ Retrieving 1 page
#> # A tibble: 18 × 21
#>    fac_name   fac_ccn clia_ccn chows  labs sites address city  state zip   term 
#>  * <chr>      <chr>   <chr>    <int> <int> <int> <chr>   <chr> <chr> <chr> <chr>
#>  1 SGMC HEAL… 11D002… 110122       0     1     0 2501 N… VALD… GA    31602 Acti…
#>  2 SGMC- SMI… 11D002… 110037       0     1     0 4280 N… VALD… GA    31602 Acti…
#>  3 SMITH & D… 11D026… 2546236…     0     0     0 2910 N… VALD… GA    31602 Unco…
#>  4 QUEST DIA… 11D064… 11L0008…     0     2     0 341 NO… VALD… GA    31602 Unco…
#>  5 SOUTH GA … 11D068… 110122       0     0     0 2501 N… VALD… GA    31602 Acti…
#>  6 NORTHSIDE… 11D090… NA           0     0     0 201 PE… VALD… GA    31602 Vol …
#>  7 SOUTH GEO… 11D091… NA           0     0     0 201 PE… VALD… GA    31602 Unco…
#>  8 SOUTHERN … 11D096… NA           0     0     0 2740 M… VALD… GA    31604 Nonp…
#>  9 VALDOSTA … 11D100… NA           0    15     0 2841 N… VALD… GA    31602 Acti…
#> 10 ALLEGIANT… 11D106… NA           0     4     0 5101 N… VALD… GA    31605 Vol …
#> 11 CARE MEDI… 11D202… NA           0     1     0 2804-C… VALD… GA    31602 Acti…
#> 12 GULF COAS… 11D205… NA           0     0     0 2804 N… VALD… GA    31602 Vol …
#> 13 BPC PLASM… 11D207… NA           0     1     0 311 N … VALD… GA    31601 Acti…
#> 14 SOUTH GEO… 11D210… NA           0     2     0 3312 N… VALD… GA    31605 Acti…
#> 15 SGMC POIN… 11D214… NA           0     2     0 2501 N… VALD… GA    31602 Vol …
#> 16 SGMC FAMI… 11D214… NA           0     2     0 3386 G… VALD… GA    31605 Vol …
#> 17 OCTAPHARM… 11D219… NA           0     0     0 1713 N… VALD… GA    31601 Acti…
#> 18 VEEDHATA … 11D222… NA           0     3     0 3386 G… VALD… GA    31605 Acti…
#> # ℹ 10 more variables: cert_type <chr>, fac_type <chr>, owner <chr>,
#> #   action <chr>, cert_date <date>, eff_date <date>, term_date <date>,
#> #   eligible <int>, multi <chr>, acr_org <chr>

clia(acr_org = c("cap", "cola", "jcaho"))
#> ✔ clia returned 1 result
#> ✔ Retrieving 1 page
#> # A tibble: 1 × 21
#>   fac_name    fac_ccn clia_ccn chows  labs sites address city  state zip   term 
#> * <chr>       <chr>   <chr>    <int> <int> <int> <chr>   <chr> <chr> <chr> <chr>
#> 1 LEXINGTON … 42D066… 420073       0     1     0 2720 S… WEST… SC    29169 Acti…
#> # ℹ 10 more variables: cert_type <chr>, fac_type <chr>, owner <chr>,
#> #   action <chr>, cert_date <date>, eff_date <date>, term_date <date>,
#> #   eligible <int>, multi <chr>, acr_org <chr>
```
