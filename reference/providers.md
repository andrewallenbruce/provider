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

  `<lgl>` Provider has multiple NPIs

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
#> ✔ `providers()` returned 2,957,262 results.
providers(enid = "I20040309000221")
#> ✔ `providers()` returned 1 result.
#> # A tibble: 1 × 11
#>   org_name first  middle last    state spec  specialty   npi   multi pac   enid 
#>   <chr>    <chr>  <chr>  <chr>   <chr> <chr> <chr>       <chr> <chr> <chr> <chr>
#> 1 NA       STEVEN D      SHEINER FL    14-41 PRACTITION… 1417… N     3870… I200…
providers(npi = 1417918293)
#> ✔ `providers()` returned 1 result.
#> # A tibble: 1 × 11
#>   org_name first  middle last    state spec  specialty   npi   multi pac   enid 
#>   <chr>    <chr>  <chr>  <chr>   <chr> <chr> <chr>       <chr> <chr> <chr> <chr>
#> 1 NA       STEVEN D      SHEINER FL    14-41 PRACTITION… 1417… N     3870… I200…
providers(pac = 2860305554)
#> ✔ `providers()` returned 1 result.
#> # A tibble: 1 × 11
#>   org_name first  middle last   state spec  specialty    npi   multi pac   enid 
#>   <chr>    <chr>  <chr>  <chr>  <chr> <chr> <chr>        <chr> <chr> <chr> <chr>
#> 1 NA       ROBERT NA     YEAMAN TX    14-41 PRACTITIONE… 1134… N     2860… I200…
providers(state = "AK")
#> ✔ `providers()` returned 6,851 results.
#> ℹ Retrieving 2 pages...
#> # A tibble: 6,851 × 11
#>    org_name first     middle last  state spec  specialty npi   multi pac   enid 
#>    <chr>    <chr>     <chr>  <chr> <chr> <chr> <chr>     <chr> <chr> <chr> <chr>
#>  1 NA       DAVID     L      BARN… AK    14-11 PRACTITI… 1124… N     6305… I200…
#>  2 NA       TIMOTHY   W      SKALA AK    14-01 PRACTITI… 1770… N     8022… I200…
#>  3 NA       MATT      A      HEIL… AK    14-48 PRACTITI… 1821… N     8820… I200…
#>  4 NA       CHRISTINE D      CLARK AK    14-22 PRACTITI… 1922… N     1850… I200…
#>  5 NA       SHAWN     P      JOHN… AK    14-25 PRACTITI… 1699… N     7214… I200…
#>  6 NA       CHAKRI    NA     INAM… AK    14-30 PRACTITI… 1245… N     3476… I200…
#>  7 NA       ERIK      J      MAUR… AK    14-30 PRACTITI… 1588… N     5193… I200…
#>  8 NA       LUCILLE   L      BENN… AK    14-65 PRACTITI… 1043… N     0244… I200…
#>  9 NA       STACEY    G      SZYM… AK    14-65 PRACTITI… 1124… N     4981… I200…
#> 10 NA       CHRISTOP… NA     KOTT… AK    14-30 PRACTITI… 1396… N     2769… I200…
#> # ℹ 6,841 more rows
```
