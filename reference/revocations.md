# Revoked Providers & Suppliers

Information on providers and suppliers currently revoked from the
Medicare program.

## Usage

``` r
revocations(
  npi = NULL,
  enid = NULL,
  first = NULL,
  middle = NULL,
  last = NULL,
  org_name = NULL,
  multi = NULL,
  state = NULL,
  prov_desc = NULL,
  reason = NULL,
  year_start = NULL,
  year_end = NULL,
  count = FALSE,
  set = FALSE
)
```

## Source

- [API: Revoked Medicare Providers and
  Suppliers](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revoked-medicare-providers-and-suppliers)

## Arguments

- npi:

  `<int>` National Provider Identifier

- enid:

  `<chr>` Medicare Enrollment ID

- first, middle, last:

  `<chr>` Individual provider name

- org_name:

  `<chr>` Organization name

- multi:

  `<lgl>` Provider has multiple NPIs

- state:

  `<chr>` Enrollment state abbreviation

- prov_desc:

  `<chr>` Provider type enrollment description

- reason:

  `<chr>` Reason for revocation

- year_start, year_end:

  `<int>` year of revocation/expiration

- count:

  `<lgl>` Return the total row count

- set:

  `<lgl>` Return the entire dataset

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)

## Details

The Revoked Medicare Providers and Suppliers dataset contains
information on providers and suppliers who are revoked and under a
current re-enrollment bar. This dataset includes provider and supplier
names, NPIs, revocation authorities pursuant to [42 CFR §
424.535](https://www.ecfr.gov/current/title-42/chapter-IV/subchapter-B/part-424/subpart-P/section-424.535),
revocation effective dates, and re-enrollment bar expiration dates. This
dataset is based on information gathered from the *Provider Enrollment,
Chain and Ownership System (PECOS)*.

### Reasons

- § 424.535 *Revocation of enrollment in the Medicare program.*

  1.  Noncompliance

      - Business Location Not Properly Licensed

      - Enrollment Requirements

      - Not Professionally Licensed

      - Provider/Supplier Type Requirements Not Met

        - DME Standards Not Met

        - IDTF Standards Not Met

  2.  Provider Or Supplier Conduct

      - Exclusion

      - Other

  3.  Felonies

  4.  False Or Misleading Information

  5.  On-Site Review

  6.  Grounds related to provider and supplier screening requirements

  7.  Misuse of billing number

  8.  Abuse Of Billing Privileges

      - Pattern Or Practice

  9.  Failure To Report

  10. Failure To Document

  11. Initial reserve operating funds

  12. Other Program Termination - Medicaid - Other Federal Health Care
      Program

  13. Prescribing Authority

  14. Improper Prescribing Practices

  15. False Claims Act (FCA)

  16. *Reserved*

  17. Debt Referred To Treasury

  18. Revoked Under Different Name, Numerical Identifier Or Business
      Identity

  19. Affiliation That Poses An Undue Risk

  20. Billing from non-compliant location

  21. Abusive ordering, certifying, referring, or prescribing of Part A
      or B services, items or drugs

  22. Patient Harm

  23. Violation Of Provider And Supplier Standards

Source: [Code of Federal
Regulations](https://www.ecfr.gov/current/title-42/chapter-IV/subchapter-B/part-424/subpart-P/section-424.535)

\(a\) Reasons for revocation. CMS may revoke a currently enrolled
provide

## Examples

``` r
revocations(count = TRUE)
#> revocations Totals
#> • Rows  : 7,465
#> • Pages : 2    
#> 

revocations(org_name = not_blank(), count = TRUE)
#> ✔ revocations returned 4,199 results.

revocations(org_name = starts("B"), count = TRUE)
#> ✔ revocations returned 223 results.

revocations(prov_desc = contains("CARDIO"), state = excludes(c("GA", "OH")))
#> ✔ revocations returned 45 results.
#> # A tibble: 45 × 12
#>    org_name first   middle last      enid       npi multi state prov_desc reason
#>    <chr>    <chr>   <chr>  <chr>     <chr>    <int> <int> <chr> <chr>     <chr> 
#>  1 NA       JUAN    Y      KURDI     I20031… 1.57e9     0 TX    PRACTITI… 424.5…
#>  2 NA       RONALD  A      CARLISH   I20031… 1.64e9     0 CA    PRACTITI… 424.5…
#>  3 NA       STEVE   E      NOZAD     I20031… 1.96e9     0 NY    PRACTITI… 424.5…
#>  4 NA       RAED    A      JITAN     I20040… 1.03e9     0 WV    PRACTITI… 424.5…
#>  5 NA       RAYMOND NA     CATANIA   I20040… 1.02e9     0 NJ    PRACTITI… 424.5…
#>  6 NA       ROBERT  ALDO   VACCARINO I20040… 1.92e9     0 NY    PRACTITI… 424.5…
#>  7 NA       STEVEN  B      HEFTER    I20040… 1.61e9     0 AL    PRACTITI… 424.5…
#>  8 NA       BRYAN   F      PERRY     I20040… 1.24e9     0 OK    PRACTITI… 424.5…
#>  9 NA       KLAUS   P      RENTROP   I20050… 1.19e9     0 NY    PRACTITI… 424.5…
#> 10 NA       JOHN    MILES  MCCLURE   I20050… 1.43e9     0 MI    PRACTITI… 424.5…
#> # ℹ 35 more rows
#> # ℹ 2 more variables: start_date <date>, end_date <date>
```
