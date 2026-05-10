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
  prov_type = NULL,
  prov_desc = NULL,
  state = NULL,
  org_name = NULL,
  multi = NULL,
  count = FALSE,
  set = FALSE
)
```

## Arguments

- npi:

  `<int>` National Provider Identifier

- pac:

  `<chr>` PECOS Associate Control ID

- enid:

  `<chr>` Medicare Enrollment ID

- first, middle, last:

  `<chr>` Individual provider's name

- prov_type:

  `<chr>` Enrollment specialty code

- prov_desc:

  `<chr>` Enrollment specialty description

- state:

  `<chr>` Enrollment state, full or abbreviation

- org_name:

  `<chr>` Organizational provider's name

- multi:

  `<lgl>` Provider has multiple NPIs

- count:

  `<lgl>` Return the total row count

- set:

  `<lgl>` Return the entire dataset

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
#> providers Totals
#> • Rows  : 2,981,799
#> • Pages : 597      
#> 

providers(count = TRUE, org_name = not_blank())
#> ✔ providers returned 433,496 results.

providers()
#> providers Totals
#> • Rows  : 2,981,799
#> • Pages : 597      
#> 
#> ! No Query ❯ Returning first 10 rows.
#> 
#> # A tibble: 10 × 11
#>           npi multi pac       enid  prov_type prov_desc state first middle last 
#>         <int> <int> <chr>     <chr> <chr>     <chr>     <chr> <chr> <chr>  <chr>
#>  1 1497881189     0 12542439… I200… 14-01     PRACTITI… PR    ELVIA ARELIS AYALA
#>  2 1851357214     0 24663641… I200… 14-30     PRACTITI… KY    RHON… G      GRIS…
#>  3 1083766935     0 50926277… I200… 14-35     PRACTITI… NJ    TIMO… J      DIEC…
#>  4 1831165075     0 51936378… I200… 14-16     PRACTITI… PR    JORGE A      OSTO…
#>  5 1083835177     0 59916176… I200… 14-41     PRACTITI… NJ    ANNA  NA     MOY  
#>  6 1003976986     0 71138398… I200… 14-68     PRACTITI… PA    CHRI… J      ZIEG…
#>  7 1720297963     0 76188893… I200… 14-26     PRACTITI… NJ    DAMON D      DELS…
#>  8 1003879883     0 80229207… I200… 14-16     PRACTITI… PR    ANTO… NA     ALVA…
#>  9 1407802119     0 80229207… I200… 14-93     PRACTITI… PA    KADI… B      RAPP 
#> 10 1437155520     0 92340419… I200… 14-68     PRACTITI… MI    ARNO… NA     WEIN…
#> # ℹ 1 more variable: org_name <chr>

providers(org_name = starts("AB"), state = c("TX", "CA"))
#> ✔ providers returned 231 results.
#> # A tibble: 231 × 11
#>           npi multi pac       enid  prov_type prov_desc state first middle last 
#>         <int> <int> <chr>     <chr> <chr>     <chr>     <chr> <chr> <chr>  <chr>
#>  1 1316018310     0 00421157… O200… 00-18     PART A P… CA    NA    NA     NA   
#>  2 1336574466     0 00424482… O201… 12-70     PART B S… TX    NA    NA     NA   
#>  3 1538413174     0 00424550… O201… 12-70     PART B S… TX    NA    NA     NA   
#>  4 1962681304     0 01433064… O200… 12-70     PART B S… TX    NA    NA     NA   
#>  5 1215156021     0 02443146… O200… 00-08     PART A P… TX    NA    NA     NA   
#>  6 1790059848     0 02444991… O201… 12-70     PART B S… TX    NA    NA     NA   
#>  7 1548134257     0 02447206… O202… 12-70     PART B S… CA    NA    NA     NA   
#>  8 1477115830     0 03455796… O201… 12-70     PART B S… TX    NA    NA     NA   
#>  9 1760940563     0 04465922… O201… 12-70     PART B S… TX    NA    NA     NA   
#> 10 1255922944     0 04466595… O202… 12-70     PART B S… TX    NA    NA     NA   
#> # ℹ 221 more rows
#> # ℹ 1 more variable: org_name <chr>

providers(org_name = starts("U"), count = TRUE)
#> ✔ providers returned 5,830 results.
```
