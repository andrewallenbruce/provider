# Revoked Providers & Suppliers

Information on providers and suppliers currently revoked from the
Medicare program.

## Usage

``` r
revocations(
  npi = NULL,
  enid = NULL,
  first = NULL,
  last = NULL,
  org_name = NULL,
  multi = NULL,
  state = NULL,
  prov_desc = NULL,
  reason = NULL,
  start_year = NULL,
  end_year = NULL,
  count = FALSE
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

- first, last:

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

- start_year, end_year:

  `<int>` year of revocation/expiration

- count:

  `<lgl>` Return the total row count

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
containing the search results.

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

## Examples

``` r
revocations(count = TRUE)
#> ◼ revocations | 7,059 rows | 2 pages

revocations(org_name = not_blank(), count = TRUE)
#> ✔ revocations returned 3,876 results

revocations(prov_desc = contains("CARDIO"), state = excludes(c("GA", "OH")))
#> ✔ revocations returned 45 results
#> ✔ Retrieving 1 page
#> # A tibble: 45 × 11
#>    org   first   last      enid      npi multi state prov_desc reason start_date
#>    <chr> <chr>   <chr>     <chr>   <int> <int> <chr> <chr>     <chr>  <date>    
#>  1 NA    JUAN    KURDI     I2003… 1.57e9     0 TX    PRACTITI… 424.5… 2023-09-28
#>  2 NA    RONALD  CARLISH   I2003… 1.64e9     0 CA    PRACTITI… 424.5… 2022-12-13
#>  3 NA    STEVE   NOZAD     I2003… 1.96e9     0 NY    PRACTITI… 424.5… 2020-10-30
#>  4 NA    RAED    JITAN     I2004… 1.03e9     0 WV    PRACTITI… 424.5… 2020-02-14
#>  5 NA    RAYMOND CATANIA   I2004… 1.02e9     0 NJ    PRACTITI… 424.5… 2021-03-08
#>  6 NA    ROBERT  VACCARINO I2004… 1.92e9     0 NY    PRACTITI… 424.5… 2023-08-20
#>  7 NA    STEVEN  HEFTER    I2004… 1.61e9     0 AL    PRACTITI… 424.5… 2017-12-01
#>  8 NA    BRYAN   PERRY     I2004… 1.24e9     0 OK    PRACTITI… 424.5… 2020-05-21
#>  9 NA    KLAUS   RENTROP   I2005… 1.19e9     0 NY    PRACTITI… 424.5… 2023-09-15
#> 10 NA    JOHN    MCCLURE   I2005… 1.43e9     0 MI    PRACTITI… 424.5… 2022-11-02
#> # ℹ 35 more rows
#> # ℹ 1 more variable: end_date <date>
```
