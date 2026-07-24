# Medicare Spending Per Beneficiary - Hospital

The Medicare Spending Per Beneficiary (MSPB) Measure shows whether
Medicare spends more, less, or about the same for an episode of care
(episode) at a specific hospital compared to all hospitals nationally.
An MSPB episode includes Medicare Part A and Part B payments for
services provided by hospitals and other healthcare providers the 3 days
prior to, during, and 30 days following a patient's inpatient stay. This
measure evaluates hospitals' costs compared to the costs of the national
median (or midpoint) hospital. This measure takes into account important
factors like patient age and health status (risk adjustment) and
geographic payment differences (payment-standardization).

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

- [API: Medicare Spending Per Beneficiary -
  Hospital](https://data.cms.gov/provider-data/dataset/rrqw-56er)

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
spending(count = TRUE)
#> ◼ spending | 4,628 rows | 4 pages
spending(state = "GA")
#> ✔ spending returned 130 results
#> # A tibble: 130 × 8
#>    ccn    name                            score address city  state zip   county
#>    <chr>  <chr>                           <dbl> <chr>   <chr> <chr> <chr> <chr> 
#>  1 110001 HAMILTON MEDICAL CENTER          0.94 1200 M… DALT… GA    30720 WHITF…
#>  2 110002 UPSON REGIONAL MEDICAL CENTER    1.02 801 W … THOM… GA    30286 UPSON 
#>  3 110003 Memorial Satilla Health          0.99 1900 T… WAYC… GA    31501 WARE  
#>  4 110005 NORTHSIDE HOSPITAL FORSYTH       0.96 1200 N… CUMM… GA    30041 FORSY…
#>  5 110006 ST MARY'S HOSPITAL               0.99 1230 B… ATHE… GA    30606 CLARKE
#>  6 110007 PHOEBE PUTNEY MEMORIAL HOSPITAL  0.93 417 TH… ALBA… GA    31703 DOUGH…
#>  7 110008 NORTHSIDE HOSPITAL CHEROKEE      0.94 450 NO… CANT… GA    30115 CHERO…
#>  8 110010 EMORY UNIVERSITY HOSPITAL        0.94 1364 C… ATLA… GA    30322 DE KA…
#>  9 110011 TANNER MEDICAL CENTER - CARROL…  1.05 705 DI… CARR… GA    30117 CARRO…
#> 10 110015 TANNER MEDICAL CENTER VILLA RI…  1.01 601 DA… VILL… GA    30180 CARRO…
#> # ℹ 120 more rows
spending2(count = TRUE)
#> ◼ spending2 | 63,646 rows | 43 pages
spending2(name = starts("SGMC"), state = "GA")
#> ✔ spending2 returned 22 results
#> # A tibble: 22 × 11
#>    ccn    name      state claim_type period avg_hosp avg_state avg_natl pct_hosp
#>    <chr>  <chr>     <chr> <chr>      <chr>     <int>     <int>    <int>    <dbl>
#>  1 110122 SGMC HEA… GA    Home Heal… 1 to …       14        17       19     0.06
#>  2 110122 SGMC HEA… GA    Hospice    1 to …        1         1        1     0   
#>  3 110122 SGMC HEA… GA    Inpatient  1 to …       49        41       46     0.2 
#>  4 110122 SGMC HEA… GA    Outpatient 1 to …      147       160      208     0.6 
#>  5 110122 SGMC HEA… GA    Skilled N… 1 to …       13        13       17     0.05
#>  6 110122 SGMC HEA… GA    Durable M… 1 to …       15        13       12     0.06
#>  7 110122 SGMC HEA… GA    Carrier    1 to …      789       790      785     3.24
#>  8 110122 SGMC HEA… GA    Home Heal… Durin…        0         0        0     0   
#>  9 110122 SGMC HEA… GA    Hospice    Durin…        0         0        0     0   
#> 10 110122 SGMC HEA… GA    Inpatient  Durin…    10670     12372    12477    43.8 
#> # ℹ 12 more rows
#> # ℹ 2 more variables: pct_state <dbl>, pct_natl <dbl>
```
