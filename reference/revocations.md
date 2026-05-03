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

## Examples

``` r
revocations(count = TRUE)
#> ═ revocations Totals
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
#>    enid             npi first middle last  org_name multi state prov_desc reason
#>  * <chr>          <int> <chr> <chr>  <chr> <chr>    <int> <chr> <chr>     <chr> 
#>  1 I20031106000… 1.57e9 JUAN  Y      KURDI NA           0 TX    PRACTITI… 424.5…
#>  2 I20031120001… 1.64e9 RONA… A      CARL… NA           0 CA    PRACTITI… 424.5…
#>  3 I20031222000… 1.96e9 STEVE E      NOZAD NA           0 NY    PRACTITI… 424.5…
#>  4 I20040223000… 1.03e9 RAED  A      JITAN NA           0 WV    PRACTITI… 424.5…
#>  5 I20040224000… 1.02e9 RAYM… NA     CATA… NA           0 NJ    PRACTITI… 424.5…
#>  6 I20040320000… 1.92e9 ROBE… ALDO   VACC… NA           0 NY    PRACTITI… 424.5…
#>  7 I20040407001… 1.61e9 STEV… B      HEFT… NA           0 AL    PRACTITI… 424.5…
#>  8 I20040512001… 1.24e9 BRYAN F      PERRY NA           0 OK    PRACTITI… 424.5…
#>  9 I20050119001… 1.19e9 KLAUS P      RENT… NA           0 NY    PRACTITI… 424.5…
#> 10 I20050901000… 1.43e9 JOHN  MILES  MCCL… NA           0 MI    PRACTITI… 424.5…
#> # ℹ 35 more rows
#> # ℹ 2 more variables: start_date <date>, end_date <date>
```
