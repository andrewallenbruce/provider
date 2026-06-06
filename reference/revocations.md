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
#> Error in httr2::req_perform(httr2::req_retry(httr2::request(url), retry_on_failure = TRUE,     max_tries = 2)): HTTP 429 Too Many Requests.

revocations(org_name = not_blank(), count = TRUE)
#> Error in httr2::req_perform(httr2::req_retry(httr2::request(url), retry_on_failure = TRUE,     max_tries = 2)): HTTP 429 Too Many Requests.

revocations(org_name = starts("B"), count = TRUE)
#> Error in httr2::req_perform(httr2::req_retry(httr2::request(url), retry_on_failure = TRUE,     max_tries = 2)): HTTP 429 Too Many Requests.

revocations(prov_desc = contains("CARDIO"), state = excludes(c("GA", "OH")))
#> Error in httr2::req_perform(httr2::req_retry(httr2::request(url), retry_on_failure = TRUE,     max_tries = 2)): HTTP 429 Too Many Requests.
```
