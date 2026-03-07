# Provider Enrollment in Medicare

Access enrollment level data on individual and organizational providers
that are actively approved to bill Medicare.

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
providers(enid = "I20040309000221")
#> ✔ Query returned 1 result.
#> # A tibble: 1 × 11
#>   npi       multi pac   enid  spec_code spec_desc state last  first middle org  
#>   <chr>     <chr> <chr> <chr> <chr>     <chr>     <chr> <chr> <chr> <chr>  <chr>
#> 1 14179182… N     3870… I200… 14-41     PRACTITI… FL    SHEI… STEV… D      NA   

providers(npi = 1417918293)
#> ✔ Query returned 1 result.
#> # A tibble: 1 × 11
#>   npi       multi pac   enid  spec_code spec_desc state last  first middle org  
#>   <chr>     <chr> <chr> <chr> <chr>     <chr>     <chr> <chr> <chr> <chr>  <chr>
#> 1 14179182… N     3870… I200… 14-41     PRACTITI… FL    SHEI… STEV… D      NA   

providers(pac = 2860305554)
#> ✔ Query returned 1 result.
#> # A tibble: 1 × 11
#>   npi       multi pac   enid  spec_code spec_desc state last  first middle org  
#>   <chr>     <chr> <chr> <chr> <chr>     <chr>     <chr> <chr> <chr> <chr>  <chr>
#> 1 11341222… N     2860… I200… 14-41     PRACTITI… TX    YEAM… ROBE… NA     NA   

# providers(state = "AK")
# providers(spec_code = "14-41")
```
