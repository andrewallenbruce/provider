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
#>    org_name first middle last  state prov_type prov_desc npi   multi pac   enid 
#>    <chr>    <chr> <chr>  <chr> <chr> <chr>     <chr>     <chr> <int> <chr> <chr>
#>  1 NA       ARDA… NA     ENKE… MD    14-11     PRACTITI… 1003…     0 7517… I200…
#>  2 NA       ARDA… NA     ENKE… DC    14-C6     PRACTITI… 1003…     0 7517… I201…
#>  3 NA       ARDA… NA     ENKE… VA    14-11     PRACTITI… 1003…     0 7517… I201…
#>  4 NA       ARDA… NA     ENKE… PA    14-11     PRACTITI… 1003…     0 7517… I202…
#>  5 NA       THOM… L      CIBU… IL    14-22     PRACTITI… 1003…     0 4284… I200…
#>  6 NA       RASH… NA     KHAL… OH    14-05     PRACTITI… 1003…     0 9931… I201…
#>  7 NA       RASH… NA     KHAL… MI    14-05     PRACTITI… 1003…     0 9931… I201…
#>  8 NA       RASH… NA     KHAL… TX    14-05     PRACTITI… 1003…     0 9931… I202…
#>  9 KOPELMA… NA    NA     NA    MA    12-70     PART B S… 1003…     0 8224… O200…
#> 10 TRI-STA… NA    NA     NA    WV    12-70     PART B S… 1003…     0 1850… O201…

providers(org_name = starts("AB"), state = c("TX", "CA"))
#> ✔ providers returned 231 results.
#> # A tibble: 231 × 11
#>    org_name first middle last  state prov_type prov_desc npi   multi pac   enid 
#>    <chr>    <chr> <chr>  <chr> <chr> <chr>     <chr>     <chr> <int> <chr> <chr>
#>  1 ABUL H … NA    NA     NA    CA    12-70     PART B S… 1003…     0 0941… O200…
#>  2 ABC MED… NA    NA     NA    CA    12-70     PART B S… 1013…     0 4486… O200…
#>  3 ABC MED… NA    NA     NA    CA    12-A5     PART B S… 1023…     0 8921… O201…
#>  4 ABC MED… NA    NA     NA    CA    30-A5     DME SUPP… 1023…     0 8921… O201…
#>  5 ABRX PH… NA    NA     NA    CA    12-A5     PART B S… 1023…     0 1557… O202…
#>  6 ABRI MD… NA    NA     NA    CA    12-70     PART B S… 1033…     0 4082… O202…
#>  7 ABBAS K… NA    NA     NA    CA    12-70     PART B S… 1063…     0 9830… O200…
#>  8 ABSOLUT… NA    NA     NA    CA    00-08     PART A P… 1063…     0 7416… O201…
#>  9 ABDULLA… NA    NA     NA    CA    12-70     PART B S… 1073…     0 8820… O202…
#> 10 ABSOLUT… NA    NA     NA    CA    00-06     PART A P… 1083…     0 5496… O201…
#> # ℹ 221 more rows

providers(org_name = starts("U"), count = TRUE)
#> ✔ providers returned 5,830 results.
```
