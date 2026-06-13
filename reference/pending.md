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

  `<chr>` `"Physician"` or `"Non-Physician"`

- npi:

  `<int>` National Provider Identifier

- first, last:

  `<chr>` Provider's name

- count:

  `<lgl>` Return the total row count

## Examples

``` r
pending(count = TRUE)
#> ◼ pending  | 12,879 rows | 4 pages

pending(first = starts("V"))
#> ✔ pending returned 183 results
#> ✔ Retrieving 2 pages
#> # A tibble: 183 × 4
#>    prov_type first     last                npi
#>    <chr>     <chr>     <chr>             <int>
#>  1 Physician VADIN     LALL DASS    1144512724
#>  2 Physician VAGHARSH  ANTANESIAN   1700451846
#>  3 Physician VAIDEHI   KOTHARI      1447190517
#>  4 Physician VAIDEHI   PATEL        1528761558
#>  5 Physician VAIDHEESH VARAGANTIWAR 1265399984
#>  6 Physician VALENTINA ROA FORSTER  1144178302
#>  7 Physician VALERIA   SILVA        1154292712
#>  8 Physician VALERIE   INGLESE      1437090404
#>  9 Physician VALYNN    ANTOINE      1811480510
#> 10 Physician VANE      BOLBOLIAN    1740053446
#> # ℹ 173 more rows
```
