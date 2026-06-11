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
#> ◼ pending summary | 12,502 rows | 4 pages

pending(first = starts("V"))
#> ✔ pending returned 173 results
#> ✔ Retrieving 2 pages
#> # A tibble: 173 × 4
#>    prov_type first     last                npi
#>    <chr>     <chr>     <chr>             <int>
#>  1 Physician VADIN     LALL DASS    1144512724
#>  2 Physician VAGHARSH  ANTANESIAN   1700451846
#>  3 Physician VAIDEHI   KOTHARI      1447190517
#>  4 Physician VAIDEHI   PATEL        1528761558
#>  5 Physician VAIDHEESH VARAGANTIWAR 1265399984
#>  6 Physician VALENTINA ROJAS-NIEVES 1548849540
#>  7 Physician VALENTINA SEDLACEK     1003590118
#>  8 Physician VALERIA   SILVA        1154292712
#>  9 Physician VALJEAN   BACOT-DAVIS  1407597651
#> 10 Physician VALYNN    ANTOINE      1811480510
#> # ℹ 163 more rows
```
