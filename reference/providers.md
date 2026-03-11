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
  spec_code = NULL,
  spec_desc = NULL,
  state = NULL,
  org_name = NULL,
  multi = NULL
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

- spec_code:

  `<chr>` Enrollment specialty code

- spec_desc:

  `<chr>` Enrollment specialty description

- state:

  `<chr>` Enrollment state, full or abbreviation

- org_name:

  `<chr>` Organization name

- multi:

  `<chr>` Provider has multiple NPIs

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
with the columns:

|             |                                        |
|-------------|----------------------------------------|
| **Field**   | **Description**                        |
| `npi`       | 10-digit NPI                           |
| `pac`       | 10-digit PAC ID                        |
| `enid`      | 15-digit provider enrollment ID        |
| `spec_code` | Enrollment primary specialty type code |
| `spec_desc` | Enrollment specialty type description  |
| `first`     | Individual provider's first name       |
| `middle`    | Individual provider's middle name      |
| `last`      | Individual provider's last name        |
| `state`     | Enrollment state                       |
| `org_name`  | Organizational provider's name         |

## Links

- [Provider Enrollment
  API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/medicare-fee-for-service-public-provider-enrollment)

- [Provider Enrollment Data
  Dictionary](https://data.cms.gov/resources/medicare-fee-for-service-public-provider-enrollment-data-dictionary)

## Examples

``` r
providers()
#> ! No Query → Returning first 10 rows.
#> # A tibble: 10 × 11
#>    first     middle last  org_name state spec  specialty npi   multi pac   enid 
#>    <chr>     <chr>  <chr> <chr>    <chr> <chr> <chr>     <chr> <chr> <chr> <chr>
#>  1 ANTONIO   NA     ALVA… NA       PR    14-16 PRACTITI… 1003… N     8022… I200…
#>  2 CHRISTOP… J      ZIEG… NA       PA    14-68 PRACTITI… 1003… N     7113… I200…
#>  3 KADISHA   B      RAPP  NA       PA    14-93 PRACTITI… 1407… N     8022… I200…
#>  4 JORGE     A      OSTO… NA       PR    14-16 PRACTITI… 1831… N     5193… I200…
#>  5 RHONDA    G      GRIS… NA       KY    14-30 PRACTITI… 1851… N     2466… I200…
#>  6 TIMOTHY   J      DIEC… NA       NJ    14-35 PRACTITI… 1083… N     5092… I200…
#>  7 ANNA      NA     MOY   NA       NJ    14-41 PRACTITI… 1083… N     5991… I200…
#>  8 DAMON     D      DELS… NA       NJ    14-26 PRACTITI… 1720… N     7618… I200…
#>  9 ELVIA     ARELIS AYALA NA       PR    14-01 PRACTITI… 1497… N     1254… I200…
#> 10 ARNOLD    NA     WEIN… NA       MI    14-68 PRACTITI… 1437… N     9234… I200…

providers(spec_code = "14")
#> ✖ Query returned 0 results.

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
