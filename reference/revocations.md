# Revocations of Medicare Enrollments

Eligibility to order and refer within Medicare

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

## References

- [API: Medicare Order and
  Referring](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/order-and-referring)

- [CMS: Ordering &
  Certifying](https://www.cms.gov/medicare/enrollment-renewal/providers-suppliers/chain-ownership-system-pecos/ordering-certifying)

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
#> ✔ `revocations()` returned 48 results.
#> # A tibble: 48 × 12
#>    org_name first    middle last       enid   npi   multi state specialty reason
#>    <chr>    <chr>    <chr>  <chr>      <chr>  <chr> <chr> <chr> <chr>     <chr> 
#>  1 NA       JUAN     Y      KURDI      I2003… 1568… N     TX    PRACTITI… 424.5…
#>  2 NA       RONALD   A      CARLISH    I2003… 1639… N     CA    PRACTITI… 424.5…
#>  3 NA       STEVE    E      NOZAD      I2003… 1962… N     NY    PRACTITI… 424.5…
#>  4 NA       RAED     A      JITAN      I2004… 1033… N     WV    PRACTITI… 424.5…
#>  5 NA       RAYMOND  NA     CATANIA    I2004… 1023… N     NJ    PRACTITI… 424.5…
#>  6 NA       ROBERT   ALDO   VACCARINO  I2004… 1922… N     NY    PRACTITI… 424.5…
#>  7 NA       STEVEN   B      HEFTER     I2004… 1609… N     AL    PRACTITI… 424.5…
#>  8 NA       LAKKARAJ NA     RAJASEKHAR I2004… 1083… N     OH    PRACTITI… 424.5…
#>  9 NA       BRYAN    F      PERRY      I2004… 1235… N     OK    PRACTITI… 424.5…
#> 10 NA       KLAUS    P      RENTROP    I2005… 1194… N     NY    PRACTITI… 424.5…
#> # ℹ 38 more rows
#> # ℹ 2 more variables: start_date <chr>, end_date <chr>
```
