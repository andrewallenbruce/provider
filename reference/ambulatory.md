# Ambulatory Surgical Centers

A list of ambulatory surgical center ratings for the Outpatient and
Ambulatory Surgery Consumer Assessment of Healthcare Providers and
Systems (OAS CAHPS) survey. The OAS CAHPS survey collects information
about patients' experiences of care in hospital outpatient departments
(HOPDs) and ambulatory surgical centers (ASCs). The data are updated and
reported each quarter with data from the most recently completed quarter
replacing the oldest quarter of data.

## Usage

``` r
ambulatory(
  ccn = NULL,
  name = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  rating = NULL,
  count = FALSE
)
```

## Source

- [API: OAS CAHPS Survey for Ambulatory Surgical Centers -
  Facility](https://data.cms.gov/provider-data/dataset/48nr-hqxx)

## Arguments

- ccn:

  `<chr>` desc

- name:

  `<chr>` desc

- city, state, zip:

  `<chr>` desc

- rating:

  `<int>` desc

- count:

  `<lgl>` Return the total row count

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
containing the search results.

## Examples

``` r
ambulatory(count = TRUE)
#> ◼ ambulatory | 4,633 rows | 4 pages
ambulatory(state = "GA")
#> ✔ ambulatory returned 244 results
#> # A tibble: 244 × 7
#>    ccn        name                              address city  state zip   rating
#>    <chr>      <chr>                             <chr>   <chr> <chr> <chr>  <int>
#>  1 11C0001002 ARC OF GEORGIA LLC                3215 S… BRUN… GA    31520     94
#>  2 11C0001003 ATLANTA SURGERY CENTER LTD        5730 G… ATLA… GA    30328     92
#>  3 11C0001004 MARIETTA OUTPATIENT SURGERY LTD   780 CA… MARI… GA    30060     93
#>  4 11C0001006 EMORY HEALTHCARE                  1365 C… ATLA… GA    30322     96
#>  5 11C0001008 MEDICAL EYE ASSOCIATES INC        1429 O… MACON GA    31201     95
#>  6 11C0001009 COLUMBIA SURGICARE OF AUGUSTA LTD 915 RU… AUGU… GA    30904     96
#>  7 11C0001012 GWINNETT CENTER FOR OUTPATIENT S… 2131 F… SNEL… GA    30078     96
#>  8 11C0001015 SURGERY CENTER OF ROME LP         16 JOH… ROME  GA    30165     97
#>  9 11C0001017 NOVAMED MANAGEMENT SERVICES LLC   3200 D… ATLA… GA    30327     93
#> 10 11C0001027 THE ROME ENDOSCOPY CENTER         11 JOH… ROME  GA    30165     96
#> # ℹ 234 more rows
```
