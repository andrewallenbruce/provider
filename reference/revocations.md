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
  count = FALSE
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

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)

## Examples

``` r
revocations(count = TRUE)
#> ✔ `revocations()` returned 7,465 results.
revocations(state = "GA")
#> ✔ `revocations()` returned 213 results.
#> # A tibble: 213 × 12
#>    org_name first    middle last       enid   npi   multi state specialty reason
#>    <chr>    <chr>    <chr>  <chr>      <chr>  <chr> <chr> <chr> <chr>     <chr> 
#>  1 NA       WALLACE  S      ANDERSON   I2003… 1881… N     GA    PRACTITI… 424.5…
#>  2 NA       LEO      G      FRANGIPANE I2003… 1073… N     GA    PRACTITI… 424.5…
#>  3 NA       ANTHONY  D      MILLS      I2004… 1265… N     GA    PRACTITI… 424.5…
#>  4 NA       JEFFREY  M.     GALLUPS    I2004… 1851… N     GA    PRACTITI… 424.5…
#>  5 NA       CURTIS   NA     CHEEKS     I2004… 1528… N     GA    PRACTITI… 424.5…
#>  6 NA       ZAVIER   C      ASH        I2004… 1770… N     GA    PRACTITI… 424.5…
#>  7 NA       SHAWN    E      TYWON      I2004… 1679… N     GA    PRACTITI… 424.5…
#>  8 NA       ANAND    P      LALAJI     I2004… 1649… N     GA    PRACTITI… 424.5…
#>  9 NA       TIFFANNI D      FORBES     I2004… 1205… N     GA    PRACTITI… 424.5…
#> 10 NA       STEPHEN  T      BASHUK     I2004… 1952… N     GA    PRACTITI… 424.5…
#> # ℹ 203 more rows
#> # ℹ 2 more variables: start_date <chr>, end_date <chr>
revocations(specialty = contains("CARDIO"))
#> ✔ `revocations()` returned 0 results.
```
