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
  chows = NULL,
  compliant = NULL,
  active = NULL,
  multi = NULL,
  campus = NULL,
  non_profit = NULL,
  eligible = NULL,
  temporary = NULL,
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

- chows:

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

- temporary:

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

clia(compliant = FALSE,
     active = TRUE,
     count = TRUE)
#> ✔ clia returned 2,578 results.

clia(facility_ccn = provider:::cdc_labs$ccn) |> str()
#> ✔ clia returned 6 results.
#> clia [6 × 26] (S3: clia/tbl_df/tbl/data.frame)
#>  $ fac_name : chr [1:6] "CENTERS FOR DISEASE CONTROL AND PREV" "DIVISION OF VECTOR-BORNE INFECTIOUS DISEASES" "CDC/NCEH/DIVISION OF LABORATORY SCIENCES" "CENTERS FOR DISEASE CONTROL AND PREVENTION I" ...
#>  $ fac_ccn  : chr [1:6] "02D0873639" "06D0880233" "11D0668290" "11D0668319" ...
#>  $ clia_ccn : chr [1:6] NA NA NA NA ...
#>  $ xrf_ccn  : chr [1:6] NA NA NA NA ...
#>  $ shr_ccn  : chr [1:6] NA NA NA NA ...
#>  $ chows    : int [1:6] 0 0 0 0 0 0
#>  $ address  : chr [1:6] "4055 TUDOR CENTRE DRIVE" "3156 RAMPART RD" "ATTN MIKE ROLLINS" "1600 CLIFTON ROAD NE, BUILDINGS 17,18 AND 23" ...
#>  $ city     : chr [1:6] "ANCHORAGE" "FORT COLLINS" "ATLANTA" "ATLANTA" ...
#>  $ state    : chr [1:6] "AK" "CO" "GA" "GA" ...
#>  $ zip      : chr [1:6] "99508" "80521" "30341" "30329" ...
#>  $ term     : chr [1:6] "Voluntary [Merger/Closure]" "Active" "Active" "Active" ...
#>  $ cert     : chr [1:6] "Compliance" "Compliance" "Accreditation" "Compliance" ...
#>  $ facility : chr [1:6] "Other" "Other" "Other" "Other" ...
#>  $ owner    : chr [1:6] "[GOE] Federal" "[GOE] Federal" "[GOE] Federal" "[GOE] Federal" ...
#>  $ action   : chr [1:6] "Recertify" "Recertify" "Recertify" "Recertify" ...
#>  $ cert_date: Date[1:6], format: "2023-11-09" "2024-06-06" ...
#>  $ eff_date : Date[1:6], format: "2024-08-15" "2024-12-09" ...
#>  $ term_date: Date[1:6], format: "2025-05-06" "2026-12-08" ...
#>  $ labs     : int [1:6] 0 1 0 1 0 1
#>  $ sites    : int [1:6] 0 0 0 2 0 0
#>  $ elig_ind : int [1:6] 1 1 1 1 0 1
#>  $ poc_ind  : int [1:6] 0 1 0 0 0 0
#>  $ cmp_ind  : int [1:6] 1 1 1 0 NA 1
#>  $ acr_org  : chr [1:6] NA NA "A2LA" NA ...
#>  $ acr_date : Date[1:6], format: NA NA ...
#>  $ multi    : chr [1:6] NA NA NA "NA, NA" ...

clia(certificate = c("accreditation", "registration"),
     city = "Valdosta",
     state = "GA") |>
     str()
#> ✔ clia returned 18 results.
#> clia [18 × 26] (S3: clia/tbl_df/tbl/data.frame)
#>  $ fac_name : chr [1:18] "SGMC HEALTH" "SGMC- SMITH NORTHVIEW CAMPUS" "SMITH & DENNARD MD PC" "SOLSTAS LAB PARTNERS" ...
#>  $ fac_ccn  : chr [1:18] "11D0022233" "11D0022241" "11D0265567" "11D0646134" ...
#>  $ clia_ccn : chr [1:18] "110122" "110037" "254623647A" "11L0008004" ...
#>  $ xrf_ccn  : chr [1:18] NA NA NA NA ...
#>  $ shr_ccn  : chr [1:18] NA NA NA NA ...
#>  $ chows    : int [1:18] 0 0 0 0 0 0 0 0 0 0 ...
#>  $ address  : chr [1:18] "2501 N PATTERSON STREET" "4280 NORTH VALDOSTA ROAD" "2910 N PATTERSON ST" "341 NORTHSIDE DRIVE" ...
#>  $ city     : chr [1:18] "VALDOSTA" "VALDOSTA" "VALDOSTA" "VALDOSTA" ...
#>  $ state    : chr [1:18] "GA" "GA" "GA" "GA" ...
#>  $ zip      : chr [1:18] "31602" "31602" "31602" "31602" ...
#>  $ term     : chr [1:18] "Active" "Active" "Accreditation Unconfirmed (CLIA)" "Accreditation Unconfirmed (CLIA)" ...
#>  $ cert     : chr [1:18] "Accreditation" "Accreditation" "Registration" "Accreditation" ...
#>  $ facility : chr [1:18] "Hospital" "ASC" "Physician" "Independent" ...
#>  $ owner    : chr [1:18] "[GOE] County" "[GOE] County" "Proprietary" "Proprietary" ...
#>  $ action   : chr [1:18] "Validate" "Validate" NA "Initial" ...
#>  $ cert_date: Date[1:18], format: "2003-12-09" "2012-02-08" ...
#>  $ eff_date : Date[1:18], format: "2025-02-28" "2025-12-07" ...
#>  $ term_date: Date[1:18], format: "2027-02-27" "2027-12-06" ...
#>  $ labs     : int [1:18] 1 1 0 2 0 0 0 0 15 4 ...
#>  $ sites    : int [1:18] 0 0 0 0 0 0 0 0 0 0 ...
#>  $ elig_ind : int [1:18] 1 1 0 1 0 0 0 0 0 0 ...
#>  $ poc_ind  : int [1:18] 0 0 0 0 0 0 0 0 0 0 ...
#>  $ cmp_ind  : int [1:18] 1 1 NA 1 NA NA NA NA NA NA ...
#>  $ acr_org  : chr [1:18] "JCAHO" "CAP" NA NA ...
#>  $ acr_date : Date[1:18], format: "2016-06-06" "2023-05-17" ...
#>  $ multi    : chr [1:18] NA NA NA NA ...

clia(accreditation = c("cap", "cola", "jcaho")) |> str()
#> ✔ clia returned 1 result.
#> clia [3 × 26] (S3: clia/tbl_df/tbl/data.frame)
#>  $ fac_name : chr [1:3] "LEXINGTON MEDICAL CENTER-LABORATORY" "LEXINGTON MEDICAL CENTER-LABORATORY" "LEXINGTON MEDICAL CENTER-LABORATORY"
#>  $ fac_ccn  : chr [1:3] "42D0665325" "42D0665325" "42D0665325"
#>  $ clia_ccn : chr [1:3] "420073" "420073" "420073"
#>  $ xrf_ccn  : chr [1:3] NA NA NA
#>  $ shr_ccn  : chr [1:3] NA NA NA
#>  $ chows    : int [1:3] 0 0 0
#>  $ address  : chr [1:3] "2720 SUNSET BOULEVARD" "2720 SUNSET BOULEVARD" "2720 SUNSET BOULEVARD"
#>  $ city     : chr [1:3] "WEST COLUMBIA" "WEST COLUMBIA" "WEST COLUMBIA"
#>  $ state    : chr [1:3] "SC" "SC" "SC"
#>  $ zip      : chr [1:3] "29169" "29169" "29169"
#>  $ term     : chr [1:3] "Active" "Active" "Active"
#>  $ cert     : chr [1:3] "Accreditation" "Accreditation" "Accreditation"
#>  $ facility : chr [1:3] "Hospital" "Hospital" "Hospital"
#>  $ owner    : chr [1:3] "[GOE] County" "[GOE] County" "[GOE] County"
#>  $ action   : chr [1:3] NA NA NA
#>  $ cert_date: Date[1:3], format: "1993-01-13" "1993-01-13" ...
#>  $ eff_date : Date[1:3], format: "2025-01-03" "2025-01-03" ...
#>  $ term_date: Date[1:3], format: "2027-01-02" "2027-01-02" ...
#>  $ labs     : int [1:3] 1 1 1
#>  $ sites    : int [1:3] 0 0 0
#>  $ elig_ind : int [1:3] 0 0 0
#>  $ poc_ind  : int [1:3] 0 0 0
#>  $ cmp_ind  : int [1:3] NA NA NA
#>  $ acr_org  : chr [1:3] "CAP" "COLA" "JCAHO"
#>  $ acr_date : Date[1:3], format: "2015-12-28" "2007-03-20" ...
#>  $ multi    : chr [1:3] NA NA NA
```
