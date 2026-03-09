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
#>    npi       multi pac   enid  spec  specialty state last  first middle org_name
#>    <chr>     <chr> <chr> <chr> <chr> <chr>     <chr> <chr> <chr> <chr>  <chr>   
#>  1 10038798… N     8022… I200… 14-16 PRACTITI… PR    ALVA… ANTO… NA     NA      
#>  2 10039769… N     7113… I200… 14-68 PRACTITI… PA    ZIEG… CHRI… J      NA      
#>  3 14078021… N     8022… I200… 14-93 PRACTITI… PA    RAPP  KADI… B      NA      
#>  4 18311650… N     5193… I200… 14-16 PRACTITI… PR    OSTO… JORGE A      NA      
#>  5 18513572… N     2466… I200… 14-30 PRACTITI… KY    GRIS… RHON… G      NA      
#>  6 10837669… N     5092… I200… 14-35 PRACTITI… NJ    DIEC… TIMO… J      NA      
#>  7 10838351… N     5991… I200… 14-41 PRACTITI… NJ    MOY   ANNA  NA     NA      
#>  8 17202979… N     7618… I200… 14-26 PRACTITI… NJ    DELS… DAMON D      NA      
#>  9 14978811… N     1254… I200… 14-01 PRACTITI… PR    AYALA ELVIA ARELIS NA      
#> 10 14371555… N     9234… I200… 14-68 PRACTITI… MI    WEIN… ARNO… NA     NA      

providers(spec_code = "14")
#> ✖ Query returned 0 results.

providers(enid = "I20040309000221")
#> ✔ Query returned 1 result.
#> # A tibble: 1 × 11
#>   npi        multi pac   enid  spec  specialty state last  first middle org_name
#>   <chr>      <chr> <chr> <chr> <chr> <chr>     <chr> <chr> <chr> <chr>  <chr>   
#> 1 1417918293 N     3870… I200… 14-41 PRACTITI… FL    SHEI… STEV… D      NA      

providers(npi = 1417918293)
#> ✔ Query returned 1 result.
#> # A tibble: 1 × 11
#>   npi        multi pac   enid  spec  specialty state last  first middle org_name
#>   <chr>      <chr> <chr> <chr> <chr> <chr>     <chr> <chr> <chr> <chr>  <chr>   
#> 1 1417918293 N     3870… I200… 14-41 PRACTITI… FL    SHEI… STEV… D      NA      

providers(pac = 2860305554)
#> ✔ Query returned 1 result.
#> # A tibble: 1 × 11
#>   npi        multi pac   enid  spec  specialty state last  first middle org_name
#>   <chr>      <chr> <chr> <chr> <chr> <chr>     <chr> <chr> <chr> <chr>  <chr>   
#> 1 1134122260 N     2860… I200… 14-41 PRACTITI… TX    YEAM… ROBE… NA     NA      

providers(state = "AK")
#> ✔ Query returned 6,851 results.
#> ℹ Retrieving 2 pages...
#> # A tibble: 6,851 × 11
#>    npi       multi pac   enid  spec  specialty state last  first middle org_name
#>    <chr>     <chr> <chr> <chr> <chr> <chr>     <chr> <chr> <chr> <chr>  <chr>   
#>  1 11240812… N     6305… I200… 14-11 PRACTITI… AK    BARN… DAVID L      NA      
#>  2 17706487… N     8022… I200… 14-01 PRACTITI… AK    SKALA TIMO… W      NA      
#>  3 18211354… N     8820… I200… 14-48 PRACTITI… AK    HEIL… MATT  A      NA      
#>  4 19220956… N     1850… I200… 14-22 PRACTITI… AK    CLARK CHRI… D      NA      
#>  5 16997469… N     7214… I200… 14-25 PRACTITI… AK    JOHN… SHAWN P      NA      
#>  6 12452261… N     3476… I200… 14-30 PRACTITI… AK    INAM… CHAK… NA     NA      
#>  7 15886504… N     5193… I200… 14-30 PRACTITI… AK    MAUR… ERIK  J      NA      
#>  8 10433230… N     0244… I200… 14-65 PRACTITI… AK    BENN… LUCI… L      NA      
#>  9 11240811… N     4981… I200… 14-65 PRACTITI… AK    SZYM… STAC… G      NA      
#> 10 13967312… N     2769… I200… 14-30 PRACTITI… AK    KOTT… CHRI… NA     NA      
#> # ℹ 6,841 more rows
```
