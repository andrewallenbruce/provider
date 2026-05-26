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
#>    org_name      first middle last  state prov_type prov_desc    npi multi pac  
#>    <chr>         <chr> <chr>  <chr> <chr> <chr>     <chr>      <int> <int> <chr>
#>  1 TRI-STATE EY… NA    NA     NA    WV    12-70     PART B S… 1.00e9     0 1850…
#>  2 NA            THOM… L      CIBU… IL    14-22     PRACTITI… 1.00e9     0 4284…
#>  3 NA            ARDA… NA     ENKE… MD    14-11     PRACTITI… 1.00e9     0 7517…
#>  4 NA            ARDA… NA     ENKE… DC    14-C6     PRACTITI… 1.00e9     0 7517…
#>  5 NA            ARDA… NA     ENKE… VA    14-11     PRACTITI… 1.00e9     0 7517…
#>  6 NA            ARDA… NA     ENKE… PA    14-11     PRACTITI… 1.00e9     0 7517…
#>  7 KOPELMAN FAM… NA    NA     NA    MA    12-70     PART B S… 1.00e9     0 8224…
#>  8 NA            RASH… NA     KHAL… OH    14-05     PRACTITI… 1.00e9     0 9931…
#>  9 NA            RASH… NA     KHAL… MI    14-05     PRACTITI… 1.00e9     0 9931…
#> 10 NA            RASH… NA     KHAL… TX    14-05     PRACTITI… 1.00e9     0 9931…
#> # ℹ 1 more variable: enid <chr>

providers(org_name = starts("AB"), state = c("TX", "CA"))
#> ✔ providers returned 231 results.
#> # A tibble: 231 × 11
#>    org_name      first middle last  state prov_type prov_desc    npi multi pac  
#>    <chr>         <chr> <chr>  <chr> <chr> <chr>     <chr>      <int> <int> <chr>
#>  1 ABILITY HOME… NA    NA     NA    CA    00-18     PART A P… 1.32e9     0 0042…
#>  2 ABSOLUTE LIF… NA    NA     NA    TX    12-70     PART B S… 1.34e9     0 0042…
#>  3 ABILENE CHIR… NA    NA     NA    TX    12-70     PART B S… 1.54e9     0 0042…
#>  4 ABILENE DERM… NA    NA     NA    TX    12-70     PART B S… 1.96e9     0 0143…
#>  5 ABC HOSPICE,… NA    NA     NA    TX    00-08     PART A P… 1.22e9     0 0244…
#>  6 ABDUL S THAN… NA    NA     NA    TX    12-70     PART B S… 1.79e9     0 0244…
#>  7 ABHISHEK BHA… NA    NA     NA    CA    12-70     PART B S… 1.55e9     0 0244…
#>  8 ABC SLEEP PL… NA    NA     NA    TX    12-70     PART B S… 1.48e9     0 0345…
#>  9 ABOVE AVERAG… NA    NA     NA    TX    12-70     PART B S… 1.76e9     0 0446…
#> 10 ABADA PLLC    NA    NA     NA    TX    12-70     PART B S… 1.26e9     0 0446…
#> # ℹ 221 more rows
#> # ℹ 1 more variable: enid <chr>

providers(org_name = starts("U"), count = TRUE)
#> ✔ providers returned 5,830 results.
```
