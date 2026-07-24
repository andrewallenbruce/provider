# Provider Enrollment in Medicare

Enrollment data on individual and organizational providers that are
actively approved to bill Medicare.

## Usage

``` r
enrolled(
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
  count = FALSE,
  chains = FALSE
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

- chains:

  `<lgl>` Add search chains

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
enrolled(count = TRUE)
#> ◼ enrolled | 2,981,799 rows | 597 pages

enrolled(count = TRUE, org_name = not_blank())
#> ✔ enrolled returned 433,496 results

enrolled(org_name = starts("AB"), state = "GA")
#> ✔ enrolled returned 19 results
#> # A tibble: 19 × 10
#>           npi pac     enid  prov_type prov_desc org_name first last  state multi
#>         <int> <chr>   <chr> <chr>     <chr>     <chr>    <chr> <chr> <chr> <int>
#>  1 1033973854 317305… O202… 53-D1     MDPP SUP… ABUNDAN… NA    NA    GA        0
#>  2 1063481505 539586… O201… 30-56     DME SUPP… ABLE PR… NA    NA    GA        0
#>  3 1083151997 024451… O201… 12-70     PART B S… ABLE PE… NA    NA    GA        0
#>  4 1144436007 579994… O201… 12-70     PART B S… ABERTH … NA    NA    GA        0
#>  5 1164848396 519395… O201… 00-18     PART A P… ABERCOR… NA    NA    GA        0
#>  6 1477876589 923426… O201… 12-70     PART B S… ABSOLUT… NA    NA    GA        0
#>  7 1528837788 832531… O202… 12-70     PART B S… ABODE C… NA    NA    GA        0
#>  8 1548504319 206266… O201… 12-70     PART B S… ABBINGH… NA    NA    GA        0
#>  9 1578361689 004279… O202… 12-70     PART B S… ABUNDAN… NA    NA    GA        0
#> 10 1619644077 488008… O202… 30-54     DME SUPP… ABLETEC… NA    NA    GA        0
#> 11 1679032205 509205… O201… 12-70     PART B S… ABOVE &… NA    NA    GA        0
#> 12 1679875173 731537… O202… 12-70     PART B S… ABUNDAN… NA    NA    GA        0
#> 13 1750392130 387060… O201… 30-54     DME SUPP… ABSOLUT… NA    NA    GA        0
#> 14 1760579981 802208… O200… 12-70     PART B S… ABDUL B… NA    NA    GA        0
#> 15 1851894588 377984… O201… 12-70     PART B S… ABSOLUT… NA    NA    GA        0
#> 16 1942195300 963867… O202… 12-70     PART B S… ABOUT T… NA    NA    GA        0
#> 17 1942207154 307241… O202… 12-70     PART B S… ABERCRO… NA    NA    GA        0
#> 18 1952782799 670919… O201… 12-70     PART B S… ABIGAIL… NA    NA    GA        0
#> 19 1972750503 640603… O201… 12-70     PART B S… ABOVE P… NA    NA    GA        0
```
