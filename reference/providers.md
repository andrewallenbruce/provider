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
#> ℹ Returning first 10 rows
#> ✔ Returning first 10 rows [59ms]
#> 
#> # A tibble: 10 × 11
#>    org_name      first middle last  state prov_type prov_desc    npi multi pac  
#>    <chr>         <chr> <chr>  <chr> <chr> <chr>     <chr>      <int> <int> <chr>
#>  1 NA            ARDA… NA     ENKE… MD    14-11     PRACTITI… 1.00e9     0 7517…
#>  2 NA            ARDA… NA     ENKE… DC    14-C6     PRACTITI… 1.00e9     0 7517…
#>  3 NA            ARDA… NA     ENKE… VA    14-11     PRACTITI… 1.00e9     0 7517…
#>  4 NA            ARDA… NA     ENKE… PA    14-11     PRACTITI… 1.00e9     0 7517…
#>  5 NA            THOM… L      CIBU… IL    14-22     PRACTITI… 1.00e9     0 4284…
#>  6 NA            RASH… NA     KHAL… OH    14-05     PRACTITI… 1.00e9     0 9931…
#>  7 NA            RASH… NA     KHAL… MI    14-05     PRACTITI… 1.00e9     0 9931…
#>  8 NA            RASH… NA     KHAL… TX    14-05     PRACTITI… 1.00e9     0 9931…
#>  9 KOPELMAN FAM… NA    NA     NA    MA    12-70     PART B S… 1.00e9     0 8224…
#> 10 TRI-STATE EY… NA    NA     NA    WV    12-70     PART B S… 1.00e9     0 1850…
#> # ℹ 1 more variable: enid <chr>

providers(org_name = starts("AB"), state = c("TX", "CA"))
#> ✔ providers returned 231 results.
#> # A tibble: 231 × 11
#>    org_name      first middle last  state prov_type prov_desc    npi multi pac  
#>    <chr>         <chr> <chr>  <chr> <chr> <chr>     <chr>      <int> <int> <chr>
#>  1 ABUL H SHIRA… NA    NA     NA    CA    12-70     PART B S… 1.00e9     0 0941…
#>  2 ABC MEDICAL … NA    NA     NA    CA    12-70     PART B S… 1.01e9     0 4486…
#>  3 ABC MEDICINE… NA    NA     NA    CA    12-A5     PART B S… 1.02e9     0 8921…
#>  4 ABC MEDICINE… NA    NA     NA    CA    30-A5     DME SUPP… 1.02e9     0 8921…
#>  5 ABRX PHARMAC… NA    NA     NA    CA    12-A5     PART B S… 1.02e9     0 1557…
#>  6 ABRI MD GROU… NA    NA     NA    CA    12-70     PART B S… 1.03e9     0 4082…
#>  7 ABBAS KASHAN… NA    NA     NA    CA    12-70     PART B S… 1.06e9     0 9830…
#>  8 ABSOLUTE COM… NA    NA     NA    CA    00-08     PART A P… 1.06e9     0 7416…
#>  9 ABDULLAH IBI… NA    NA     NA    CA    12-70     PART B S… 1.07e9     0 8820…
#> 10 ABSOLUTE CAR… NA    NA     NA    CA    00-06     PART A P… 1.08e9     0 5496…
#> # ℹ 221 more rows
#> # ℹ 1 more variable: enid <chr>

providers(org_name = starts("U"), count = TRUE)
#> ✔ providers returned 5,830 results.
```
