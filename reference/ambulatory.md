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
#> ◼ ambulatory | 169,700 rows | 114 pages
ambulatory(state = "GA")
#> ✔ ambulatory returned 10,220 results
#> # A tibble: 10,220 × 12
#>    ccn    name  address city  state zip   county measure question answer percent
#>    <chr>  <chr> <chr>   <chr> <chr> <chr> <chr>  <chr>   <chr>    <chr>    <dbl>
#>  1 11C00… ARC … 3215 S… BRUN… GA    31520 GLYNN  A_COMP… Facilit… Facil…   NA   
#>  2 11C00… ARC … 3215 S… BRUN… GA    31520 GLYNN  A_COMP… Patient… Facil…    0.01
#>  3 11C00… ARC … 3215 S… BRUN… GA    31520 GLYNN  A_COMP… Patient… Facil…    0.98
#>  4 11C00… ARC … 3215 S… BRUN… GA    31520 GLYNN  A_COMP… Patient… Facil…    0.01
#>  5 11C00… ARC … 3215 S… BRUN… GA    31520 GLYNN  A_COMP… Communi… Commu…   NA   
#>  6 11C00… ARC … 3215 S… BRUN… GA    31520 GLYNN  A_COMP… Patient… Facil…    0.02
#>  7 11C00… ARC … 3215 S… BRUN… GA    31520 GLYNN  A_COMP… Patient… Facil…    0.93
#>  8 11C00… ARC … 3215 S… BRUN… GA    31520 GLYNN  A_COMP… Patient… Facil…    0.05
#>  9 11C00… ARC … 3215 S… BRUN… GA    31520 GLYNN  A_COMP… Prepari… Prepa…   NA   
#> 10 11C00… ARC … 3215 S… BRUN… GA    31520 GLYNN  A_COMP… Patient… Facil…    0.01
#> # ℹ 10,210 more rows
#> # ℹ 1 more variable: mean <dbl>
```
