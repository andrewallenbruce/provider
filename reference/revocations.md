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
#> ✔ Query returned 7,465 results.
revocations(state = "GA")
#> ✔ Query returned 213 results.
#> # A tibble: 213 × 12
#>    enid           npi   first middle last  org_name multi state specialty reason
#>    <chr>          <chr> <chr> <chr>  <chr> <chr>    <chr> <chr> <chr>     <chr> 
#>  1 I200312190001… 1881… WALL… S      ANDE… NA       N     GA    PRACTITI… 424.5…
#>  2 I200312260000… 1073… LEO   G      FRAN… NA       N     GA    PRACTITI… 424.5…
#>  3 I200402100005… 1265… ANTH… D      MILLS NA       N     GA    PRACTITI… 424.5…
#>  4 I200402240001… 1851… JEFF… M.     GALL… NA       N     GA    PRACTITI… 424.5…
#>  5 I200404020006… 1528… CURT… NA     CHEE… NA       N     GA    PRACTITI… 424.5…
#>  6 I200404130008… 1770… ZAVI… C      ASH   NA       N     GA    PRACTITI… 424.5…
#>  7 I200404300007… 1679… SHAWN E      TYWON NA       N     GA    PRACTITI… 424.5…
#>  8 I200408090002… 1649… ANAND P      LALA… NA       N     GA    PRACTITI… 424.5…
#>  9 I200409010000… 1205… TIFF… D      FORB… NA       N     GA    PRACTITI… 424.5…
#> 10 I200409100000… 1952… STEP… T      BASH… NA       N     GA    PRACTITI… 424.5…
#> # ℹ 203 more rows
#> # ℹ 2 more variables: date_start <chr>, date_end <chr>
revocations(specialty = contains("CARDIO"))
#> ✔ Query returned 48 results.
#> # A tibble: 48 × 12
#>    enid           npi   first middle last  org_name multi state specialty reason
#>    <chr>          <chr> <chr> <chr>  <chr> <chr>    <chr> <chr> <chr>     <chr> 
#>  1 I200311060004… 1568… JUAN  Y      KURDI NA       N     TX    PRACTITI… 424.5…
#>  2 I200311200010… 1639… RONA… A      CARL… NA       N     CA    PRACTITI… 424.5…
#>  3 I200312220001… 1962… STEVE E      NOZAD NA       N     NY    PRACTITI… 424.5…
#>  4 I200402230005… 1033… RAED  A      JITAN NA       N     WV    PRACTITI… 424.5…
#>  5 I200402240001… 1023… RAYM… NA     CATA… NA       N     NJ    PRACTITI… 424.5…
#>  6 I200403200003… 1922… ROBE… ALDO   VACC… NA       N     NY    PRACTITI… 424.5…
#>  7 I200404070011… 1609… STEV… B      HEFT… NA       N     AL    PRACTITI… 424.5…
#>  8 I200405030004… 1083… LAKK… NA     RAJA… NA       N     OH    PRACTITI… 424.5…
#>  9 I200405120014… 1235… BRYAN F      PERRY NA       N     OK    PRACTITI… 424.5…
#> 10 I200501190011… 1194… KLAUS P      RENT… NA       N     NY    PRACTITI… 424.5…
#> # ℹ 38 more rows
#> # ℹ 2 more variables: date_start <chr>, date_end <chr>
```
