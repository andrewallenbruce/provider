# Pending Medicare Enrollments

Providers with pending Medicare enrollment applications.

The *Pending Initial Logging and Tracking (L & T)* dataset provides a
list of pending applications for both Physicians and Non-Physicians that
have not been processed by CMS contractors.

## Usage

``` r
pending(prov_type = NULL, npi = NULL, first = NULL, last = NULL, count = FALSE)
```

## Source

Medicare Pending Initial Logging and Tracking:

- [API:
  Physicians](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/pending-initial-logging-and-tracking-physicians)

- [API:
  Non-Physicians](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/pending-initial-logging-and-tracking-non-physicians)

## Arguments

- prov_type:

  description

- npi:

  `<int>` National Provider Identifier

- first, last:

  `<chr>` Provider's name

- count:

  `<lgl>` Return the total row count

## Examples

``` r
pending(count = TRUE)
#> pending Totals
#> • Rows  : 12,236
#> • Pages : 4     

pending(first = starts("V"))
#> ✔ pending returned 165 results.
#> • Physician     : 74
#> • Non-Physician : 91
#> ✔ Retrieving 2 pages
#> # A tibble: 165 × 4
#>    prov_type first     last                npi
#>    <chr>     <chr>     <chr>             <int>
#>  1 Physician VADIN     LALL DASS    1144512724
#>  2 Physician VAGHARSH  ANTANESIAN   1700451846
#>  3 Physician VAIDEHI   KOTHARI      1447190517
#>  4 Physician VAIDHEESH VARAGANTIWAR 1265399984
#>  5 Physician VALENTINA SEDLACEK     1003590118
#>  6 Physician VALERIA   SILVA        1154292712
#>  7 Physician VALJEAN   BACOT-DAVIS  1407597651
#>  8 Physician VALYNN    ANTOINE      1811480510
#>  9 Physician VAMSI     REDDY MALLU  1750229845
#> 10 Physician VANESSA   DE BARROS    1487529939
#> # ℹ 155 more rows
```
