# Medicare Spending Per Beneficiary - Hospital

Access information concerning individual providers' affiliations with
organizations/facilities.

Access information concerning individual providers' affiliations with
organizations/facilities.

## Usage

``` r
spending(
  ccn = NULL,
  name = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  county = NULL,
  score = NULL,
  count = FALSE
)

spending2(ccn = NULL, name = NULL, state = NULL, claim = NULL, count = FALSE)
```

## Source

- [API: Physician Facility
  Affiliations](https://data.cms.gov/provider-data/dataset/27ea-46a8)

&nbsp;

- [API: Physician Facility
  Affiliations](https://data.cms.gov/provider-data/dataset/27ea-46a8)

## Arguments

- ccn:

  `<chr>` desc

- name:

  `<chr>` desc

- city, state, zip, county:

  `<chr>` desc

- state:

  `<chr>` desc

- score:

  `<dbl>` desc

- count:

  `<lgl>` Return the total row count

- claim:

  `<chr>` desc

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
containing the search results.

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
containing the search results.

## Examples

``` r
spending2(count = TRUE)
#> ◼ spending2 | 63,646 rows | 43 pages
spending2(name = starts("SGMC"), state = "GA")
#> ✔ spending2 returned 22 results
#> ✔ Retrieving 1 page
#> # A tibble: 22 × 11
#>    ccn   name  state claim period avg_hosp avg_state avg_natl pct_hosp pct_state
#>    <chr> <chr> <chr> <chr> <chr>     <int>     <int>    <int>    <dbl>     <dbl>
#>  1 1101… SGMC… GA    Home… 1 to …       14        17       19     0.06      0.07
#>  2 1101… SGMC… GA    Hosp… 1 to …        1         1        1     0         0   
#>  3 1101… SGMC… GA    Inpa… 1 to …       49        41       46     0.2       0.15
#>  4 1101… SGMC… GA    Outp… 1 to …      147       160      208     0.6       0.61
#>  5 1101… SGMC… GA    Skil… 1 to …       13        13       17     0.05      0.05
#>  6 1101… SGMC… GA    Dura… 1 to …       15        13       12     0.06      0.05
#>  7 1101… SGMC… GA    Carr… 1 to …      789       790      785     3.24      2.99
#>  8 1101… SGMC… GA    Home… Durin…        0         0        0     0         0   
#>  9 1101… SGMC… GA    Hosp… Durin…        0         0        0     0         0   
#> 10 1101… SGMC… GA    Inpa… Durin…    10670     12372    12477    43.8      46.9 
#> # ℹ 12 more rows
#> # ℹ 1 more variable: pct_natl <dbl>
spending2(count = TRUE)
#> ◼ spending2 | 63,646 rows | 43 pages
spending2(state = "GA")
#> ✔ spending2 returned 2,002 results
#> ✔ Retrieving 2 pages
#> # A tibble: 2,002 × 11
#>    ccn   name  state claim period avg_hosp avg_state avg_natl pct_hosp pct_state
#>    <chr> <chr> <chr> <chr> <chr>     <int>     <int>    <int>    <dbl>     <dbl>
#>  1 1100… HAMI… GA    Home… 1 to …       22        17       19     0.1       0.07
#>  2 1100… HAMI… GA    Hosp… 1 to …        1         1        1     0         0   
#>  3 1100… HAMI… GA    Inpa… 1 to …       26        41       46     0.11      0.15
#>  4 1100… HAMI… GA    Outp… 1 to …       91       160      208     0.39      0.61
#>  5 1100… HAMI… GA    Skil… 1 to …       21        13       17     0.09      0.05
#>  6 1100… HAMI… GA    Dura… 1 to …       10        13       12     0.04      0.05
#>  7 1100… HAMI… GA    Carr… 1 to …      718       790      785     3.09      2.99
#>  8 1100… HAMI… GA    Home… Durin…        0         0        0     0         0   
#>  9 1100… HAMI… GA    Hosp… Durin…        0         0        0     0         0   
#> 10 1100… HAMI… GA    Inpa… Durin…    10650     12372    12477    45.8      46.9 
#> # ℹ 1,992 more rows
#> # ℹ 1 more variable: pct_natl <dbl>
```
