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
  county = NULL,
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

- city, state, zip, county:

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
#> ✔ Retrieving 1 page
#> # A tibble: 244 × 11
#>    ccn   name  address city  state zip   county patients surveys response rating
#>    <chr> <chr> <chr>   <chr> <chr> <chr> <chr>     <int>   <int> <chr>     <int>
#>  1 11C0… ARC … 3215 S… BRUN… GA    31520 NA          192      42 22           94
#>  2 11C0… ATLA… 5730 G… ATLA… GA    30328 NA         2525     493 20           92
#>  3 11C0… MARI… 780 CA… MARI… GA    30060 NA          518     110 21           93
#>  4 11C0… EMOR… 1365 C… ATLA… GA    30322 NA         1954     396 20           96
#>  5 11C0… MEDI… 1429 O… MACON GA    31201 NA          553     181 33           95
#>  6 11C0… COLU… 915 RU… AUGU… GA    30904 NA          962     309 32           96
#>  7 11C0… GWIN… 2131 F… SNEL… GA    30078 NA          970     241 25           96
#>  8 11C0… SURG… 16 JOH… ROME  GA    30165 NA         2574     791 31           97
#>  9 11C0… NOVA… 3200 D… ATLA… GA    30327 NA          407      90 22           93
#> 10 11C0… THE … 11 JOH… ROME  GA    30165 NA          371     108 29           96
#> # ℹ 234 more rows
```
