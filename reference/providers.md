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
  last = NULL,
  prov_type = NULL,
  prov_desc = NULL,
  state = NULL,
  org_name = NULL,
  multi = NULL,
  count = FALSE
)
```

## Arguments

- npi:

  `<int>` National Provider Identifier

- pac:

  `<chr>` PECOS Associate Control ID

- enid:

  `<chr>` Medicare Enrollment ID

- first, last:

  `<chr>` Individual provider's name

- prov_type, prov_desc:

  `<chr>` Enrollment specialty code/description

- state:

  `<chr>` Enrollment state, full or abbreviation

- org_name:

  `<chr>` Organizational provider's name

- multi:

  `<lgl>` Provider has multiple NPIs

- count:

  `<lgl>` Return the total row count

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
containing the search results.

## References

- [API: Medicare Provider Supplier
  Enrollment](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/medicare-fee-for-service-public-provider-enrollment)

- [Provider Enrollment Data
  Dictionary](https://data.cms.gov/resources/medicare-fee-for-service-public-provider-enrollment-data-dictionary)

## Examples

``` r
providers(count = TRUE)
#> ◼ providers | 2,981,799 rows | 597 pages

providers(count = TRUE, org_name = not_blank())
#> ✔ providers returned 433,496 results

providers(org_name = starts("AB"), state = "GA")
#> ✔ providers returned 19 results
#> ✔ Retrieving 1 page
#> ✔ nppes returned 19/19 results
#> # A tibble: 19 × 11
#>          npi pac   enid  prov_type taxonomy prov_desc org_name first last  state
#>  *     <int> <chr> <chr> <chr>     <chr>    <chr>     <chr>    <chr> <chr> <chr>
#>  1    1.03e9 3173… O202… 53-D1     261QC15… MDPP SUP… ABUNDAN… NA    NA    GA   
#>  2    1.06e9 5395… O201… 30-56     224P000… DME SUPP… ABLE PR… NA    NA    GA   
#>  3    1.08e9 0244… O201… 12-70     261QP20… PART B S… ABLE PE… NA    NA    GA   
#>  4    1.14e9 5799… O201… 12-70     103TB02… PART B S… ABERTH … NA    NA    GA   
#>  5    1.16e9 5193… O201… 00-18     3140000… PART A P… ABERCOR… NA    NA    GA   
#>  6    1.48e9 9234… O201… 12-70     111N000… PART B S… ABSOLUT… NA    NA    GA   
#>  7    1.53e9 8325… O202… 12-70     363L000… PART B S… ABODE C… NA    NA    GA   
#>  8    1.55e9 2062… O201… 12-70     1744000… PART B S… ABBINGH… NA    NA    GA   
#>  9    1.58e9 0042… O202… 12-70     101YM08… PART B S… ABUNDAN… NA    NA    GA   
#> 10    1.62e9 4880… O202… 30-54     332B000… DME SUPP… ABLETEC… NA    NA    GA   
#> 11    1.68e9 5092… O201… 12-70     261QP23… PART B S… ABOVE &… NA    NA    GA   
#> 12    1.68e9 7315… O202… 12-70     207V000… PART B S… ABUNDAN… NA    NA    GA   
#> 13    1.75e9 3870… O201… 30-54     332B000… DME SUPP… ABSOLUT… NA    NA    GA   
#> 14    1.76e9 8022… O200… 12-70     207R000… PART B S… ABDUL B… NA    NA    GA   
#> 15    1.85e9 3779… O201… 12-70     363LF00… PART B S… ABSOLUT… NA    NA    GA   
#> 16    1.94e9 9638… O202… 12-70     363LP23… PART B S… ABOUT T… NA    NA    GA   
#> 17    1.94e9 3072… O202… 12-70     2085R02… PART B S… ABERCRO… NA    NA    GA   
#> 18    1.95e9 6709… O201… 12-70     1041C07… PART B S… ABIGAIL… NA    NA    GA   
#> 19    1.97e9 6406… O201… 12-70     261QP20… PART B S… ABOVE P… NA    NA    GA   
#> # ℹ 1 more variable: multi <int>
```
