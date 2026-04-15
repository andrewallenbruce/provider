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
dataset is based on information gathered from the Provider Enrollment,
Chain and Ownership System (PECOS).

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

  `<int>` 10-digit Individual National Provider Identifier

- enid:

  `<chr>` 15-digit Medicare Enrollment ID

- first, middle, last:

  `<chr>` Individual provider's name

- org_name:

  `<chr>` Organization name

- multi:

  `<lgl>` Provider has multiple NPIs

- state:

  `<chr>` Enrollment state, full or abbreviation

- specialty:

  `<chr>` Enrollment specialty description

- reason:

  `<chr>` reason for revocation

- count:

  `<lgl>` Return the dataset's total row count

- set:

  `<lgl>` Return the entire dataset

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)

## Examples

``` r
revocations(count = TRUE)
#> ℹ revocations has 7,465 rows.
revocations(state = "GA")
#> ✔ revocations returned 213 results.
#> # A tibble: 213 × 12
#>    org_name first    middle last       enid     npi multi state prov_desc reason
#>  * <chr>    <chr>    <chr>  <chr>      <chr>  <int> <int> <chr> <chr>     <chr> 
#>  1 NA       WALLACE  S      ANDERSON   I200… 1.88e9     0 GA    PRACTITI… 424.5…
#>  2 NA       LEO      G      FRANGIPANE I200… 1.07e9     0 GA    PRACTITI… 424.5…
#>  3 NA       ANTHONY  D      MILLS      I200… 1.27e9     0 GA    PRACTITI… 424.5…
#>  4 NA       JEFFREY  M.     GALLUPS    I200… 1.85e9     0 GA    PRACTITI… 424.5…
#>  5 NA       CURTIS   NA     CHEEKS     I200… 1.53e9     0 GA    PRACTITI… 424.5…
#>  6 NA       ZAVIER   C      ASH        I200… 1.77e9     0 GA    PRACTITI… 424.5…
#>  7 NA       SHAWN    E      TYWON      I200… 1.68e9     0 GA    PRACTITI… 424.5…
#>  8 NA       ANAND    P      LALAJI     I200… 1.65e9     0 GA    PRACTITI… 424.5…
#>  9 NA       TIFFANNI D      FORBES     I200… 1.21e9     0 GA    PRACTITI… 424.5…
#> 10 NA       STEPHEN  T      BASHUK     I200… 1.95e9     0 GA    PRACTITI… 424.5…
#> # ℹ 203 more rows
#> # ℹ 2 more variables: start_date <date>, end_date <date>
revocations(specialty = contains("CARDIO"), state = not("TX"))
#> ✔ revocations returned 46 results.
#> # A tibble: 46 × 12
#>    org_name first    middle last       enid     npi multi state prov_desc reason
#>  * <chr>    <chr>    <chr>  <chr>      <chr>  <int> <int> <chr> <chr>     <chr> 
#>  1 NA       RONALD   A      CARLISH    I200… 1.64e9     0 CA    PRACTITI… 424.5…
#>  2 NA       STEVE    E      NOZAD      I200… 1.96e9     0 NY    PRACTITI… 424.5…
#>  3 NA       RAED     A      JITAN      I200… 1.03e9     0 WV    PRACTITI… 424.5…
#>  4 NA       RAYMOND  NA     CATANIA    I200… 1.02e9     0 NJ    PRACTITI… 424.5…
#>  5 NA       ROBERT   ALDO   VACCARINO  I200… 1.92e9     0 NY    PRACTITI… 424.5…
#>  6 NA       STEVEN   B      HEFTER     I200… 1.61e9     0 AL    PRACTITI… 424.5…
#>  7 NA       LAKKARAJ NA     RAJASEKHAR I200… 1.08e9     0 OH    PRACTITI… 424.5…
#>  8 NA       BRYAN    F      PERRY      I200… 1.24e9     0 OK    PRACTITI… 424.5…
#>  9 NA       KLAUS    P      RENTROP    I200… 1.19e9     0 NY    PRACTITI… 424.5…
#> 10 NA       JOHN     MILES  MCCLURE    I200… 1.43e9     0 MI    PRACTITI… 424.5…
#> # ℹ 36 more rows
#> # ℹ 2 more variables: start_date <date>, end_date <date>
revocations(specialty = contains("CARDIO"), state = excludes("TX", "OH"))
#> ✔ revocations returned 43 results.
#> # A tibble: 43 × 12
#>    org_name first   middle last      enid       npi multi state prov_desc reason
#>  * <chr>    <chr>   <chr>  <chr>     <chr>    <int> <int> <chr> <chr>     <chr> 
#>  1 NA       RONALD  A      CARLISH   I20031… 1.64e9     0 CA    PRACTITI… 424.5…
#>  2 NA       STEVE   E      NOZAD     I20031… 1.96e9     0 NY    PRACTITI… 424.5…
#>  3 NA       RAED    A      JITAN     I20040… 1.03e9     0 WV    PRACTITI… 424.5…
#>  4 NA       RAYMOND NA     CATANIA   I20040… 1.02e9     0 NJ    PRACTITI… 424.5…
#>  5 NA       ROBERT  ALDO   VACCARINO I20040… 1.92e9     0 NY    PRACTITI… 424.5…
#>  6 NA       STEVEN  B      HEFTER    I20040… 1.61e9     0 AL    PRACTITI… 424.5…
#>  7 NA       BRYAN   F      PERRY     I20040… 1.24e9     0 OK    PRACTITI… 424.5…
#>  8 NA       KLAUS   P      RENTROP   I20050… 1.19e9     0 NY    PRACTITI… 424.5…
#>  9 NA       JOHN    MILES  MCCLURE   I20050… 1.43e9     0 MI    PRACTITI… 424.5…
#> 10 NA       FAZAL   R      PANEZAI   I20050… 1.71e9     0 NJ    PRACTITI… 424.5…
#> # ℹ 33 more rows
#> # ℹ 2 more variables: start_date <date>, end_date <date>
```
