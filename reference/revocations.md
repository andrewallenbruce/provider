# Revoked Providers & Suppliers

Information on providers and suppliers currently revoked from the
Medicare program.

### Details

The Revoked Medicare Providers and Suppliers dataset contains
information on providers and suppliers who are revoked and under a
current re-enrollment bar. This dataset includes provider and supplier
names, NPIs, revocation authorities pursuant to [42 CFR §
424.535](https://www.ecfr.gov/current/title-42/chapter-IV/subchapter-B/part-424/subpart-P/section-424.535),
revocation effective dates, and re-enrollment bar expiration dates. This
dataset is based on information gathered from the *Provider Enrollment,
Chain and Ownership System (PECOS)*.

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
  specialty = NULL,
  reason = NULL,
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

  `<chr>` Individual provider's name

- org_name:

  `<chr>` Organization name

- multi:

  `<lgl>` Provider has multiple NPIs

- state:

  `<chr>` Enrollment state abbreviation

- specialty:

  `<chr>` Enrollment specialty description

- reason:

  `<chr>` Reason for revocation

- count:

  `<lgl>` Return the total row count

- set:

  `<lgl>` Return the entire dataset

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)

## Examples

``` r
revocations(count = TRUE)
#> ℹ revocations has 7,465 rows.

revocations(
  count = TRUE,
  org_name = not_blank())
#> ✔ revocations returned 4,199 results.

revocations(org_name = starts("B"))
#> ✔ revocations returned 223 results.
#> # A tibble: 223 × 12
#>    org_name         first middle last  enid     npi multi state prov_desc reason
#>  * <chr>            <chr> <chr>  <chr> <chr>  <int> <int> <chr> <chr>     <chr> 
#>  1 B & F DRUGS INC  NA    NA     NA    O201… 1.52e9     0 AL    DME SUPP… 424.5…
#>  2 B & L MEDICAL S… NA    NA     NA    O201… 1.69e9     0 NJ    DME SUPP… 424.5…
#>  3 B AND D SUPPLIE… NA    NA     NA    O202… 1.74e9     0 FL    DME SUPP… 424.5…
#>  4 B M E S HUB CORP NA    NA     NA    O202… 1.29e9     0 FL    DME SUPP… 424.5…
#>  5 B&A PHYSICAL CA… NA    NA     NA    O202… 1.57e9     0 FL    PART B S… 424.5…
#>  6 B&C REHABILITAT… NA    NA     NA    O201… 1.03e9     0 FL    PART B S… 424.5…
#>  7 B-4 & AFTER SER… NA    NA     NA    O201… 1.81e9     0 NC    DME SUPP… 424.5…
#>  8 BAB GROUP INC    NA    NA     NA    O202… 1.27e9     0 NY    DME SUPP… 424.5…
#>  9 BABAR IQBAL MD … NA    NA     NA    O200… 1.85e9     0 CA    PART B S… 424.5…
#> 10 BABY'S ON BROAD… NA    NA     NA    O201… 1.54e9     0 MN    DME SUPP… 424.5…
#> # ℹ 213 more rows
#> # ℹ 2 more variables: start_date <date>, end_date <date>

revocations(
  specialty = contains("CARDIO"),
  state = excludes(c("GA", "OH")))
#> ✔ revocations returned 45 results.
#> # A tibble: 45 × 12
#>    org_name first   middle last      enid       npi multi state prov_desc reason
#>  * <chr>    <chr>   <chr>  <chr>     <chr>    <int> <int> <chr> <chr>     <chr> 
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
