# Provider Enrollment in Medicare

Enrollment data on individual and organizational providers that are
actively approved to bill Medicare.

## Usage

``` r
providers(
  npi = NULL,
  pac = NULL,
  enid = NULL,
  first = NULL,
  middle = NULL,
  last = NULL,
  spec = NULL,
  specialty = NULL,
  state = NULL,
  org_name = NULL,
  multi = NULL,
  count = FALSE
)
```

## Arguments

- npi:

  `<int>` 10-digit Individual National Provider Identifier

- pac:

  `<chr>` 10-digit PECOS Associate Control ID

- enid:

  `<chr>` 15-digit Medicare Enrollment ID

- first, middle, last:

  `<chr>` Individual provider's name

- spec:

  `<chr>` Enrollment specialty code

- specialty:

  `<chr>` Enrollment specialty description

- state:

  `<chr>` Enrollment state, full or abbreviation

- org_name:

  `<chr>` Organization name

- multi:

  `<chr>` Provider has multiple NPIs

- count:

  `<lgl>` Return the dataset's total row count

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)

## References

- [API: Medicare Provider Supplier
  Enrollment](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/medicare-fee-for-service-public-provider-enrollment)

- [Provider Enrollment Data
  Dictionary](https://data.cms.gov/resources/medicare-fee-for-service-public-provider-enrollment-data-dictionary)

## Examples

``` r
providers(count = TRUE)
#> ✔ Query returned 2,957,262 results.
providers(enid = "I20040309000221")
#> ✔ Query returned 1 result.
#> # A tibble: 1 × 11
#>   first  middle last    org_name state spec  specialty   npi   multi pac   enid 
#>   <chr>  <chr>  <chr>   <chr>    <chr> <chr> <chr>       <chr> <chr> <chr> <chr>
#> 1 STEVEN D      SHEINER NA       FL    14-41 PRACTITION… 1417… N     3870… I200…
providers(npi = 1417918293)
#> ✔ Query returned 1 result.
#> # A tibble: 1 × 11
#>   first  middle last    org_name state spec  specialty   npi   multi pac   enid 
#>   <chr>  <chr>  <chr>   <chr>    <chr> <chr> <chr>       <chr> <chr> <chr> <chr>
#> 1 STEVEN D      SHEINER NA       FL    14-41 PRACTITION… 1417… N     3870… I200…
providers(pac = 2860305554)
#> ✔ Query returned 1 result.
#> # A tibble: 1 × 11
#>   first  middle last   org_name state spec  specialty    npi   multi pac   enid 
#>   <chr>  <chr>  <chr>  <chr>    <chr> <chr> <chr>        <chr> <chr> <chr> <chr>
#> 1 ROBERT NA     YEAMAN NA       TX    14-41 PRACTITIONE… 1134… N     2860… I200…
providers(state = "AK")
#> ✔ Query returned 6,851 results.
#> ℹ Retrieving 2 pages...
#> # A tibble: 6,851 × 11
#>    first     middle last  org_name state spec  specialty npi   multi pac   enid 
#>    <chr>     <chr>  <chr> <chr>    <chr> <chr> <chr>     <chr> <chr> <chr> <chr>
#>  1 DAVID     L      BARN… NA       AK    14-11 PRACTITI… 1124… N     6305… I200…
#>  2 TIMOTHY   W      SKALA NA       AK    14-01 PRACTITI… 1770… N     8022… I200…
#>  3 MATT      A      HEIL… NA       AK    14-48 PRACTITI… 1821… N     8820… I200…
#>  4 CHRISTINE D      CLARK NA       AK    14-22 PRACTITI… 1922… N     1850… I200…
#>  5 SHAWN     P      JOHN… NA       AK    14-25 PRACTITI… 1699… N     7214… I200…
#>  6 CHAKRI    NA     INAM… NA       AK    14-30 PRACTITI… 1245… N     3476… I200…
#>  7 ERIK      J      MAUR… NA       AK    14-30 PRACTITI… 1588… N     5193… I200…
#>  8 LUCILLE   L      BENN… NA       AK    14-65 PRACTITI… 1043… N     0244… I200…
#>  9 STACEY    G      SZYM… NA       AK    14-65 PRACTITI… 1124… N     4981… I200…
#> 10 CHRISTOP… NA     KOTT… NA       AK    14-30 PRACTITI… 1396… N     2769… I200…
#> # ℹ 6,841 more rows
```
