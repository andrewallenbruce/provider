# Inpatient Rehabilitation Facilities

Access information concerning individual providers' affiliations with
organizations/facilities.

## Usage

``` r
rehab(
  ccn = NULL,
  name = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  county = NULL,
  count = FALSE
)
```

## Source

- [API: Physician Facility
  Affiliations](https://data.cms.gov/provider-data/dataset/27ea-46a8)

## Arguments

- ccn:

  `<chr>` desc

- name:

  `<chr>` desc

- city, state, zip, county:

  `<chr>` desc

- count:

  `<lgl>` Return the total row count

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
containing the search results.

## Examples

``` r
rehab(count = TRUE)
#> ◼ rehab | 1,222 rows | 1 pages
rehab(state = "GA")
#> ✔ rehab returned 34 results
#> ✔ Retrieving 1 page
#> # A tibble: 34 × 9
#>    ccn    name              address city  state zip   county own_type cert_date 
#>    <chr>  <chr>             <chr>   <chr> <chr> <chr> <chr>  <chr>    <date>    
#>  1 113028 WELLSTAR ROOSEVE… 6135 R… WARM… GA    31830 Meriw… Governm… 2006-07-01
#>  2 113029 ATRIUM HEALTH NA… 3351 N… MACON GA    31210 Bibb   For pro… 2007-06-11
#>  3 113030 REHABILIATION HO… 1355 I… AUGU… GA    30901 Richm… For pro… 2013-04-26
#>  4 113031 EMORY REHABILITA… 1441 C… ATLA… GA    30322 DeKalb For pro… 2014-07-29
#>  5 113032 REHABILITATION H… 2101 E… NEWN… GA    30265 Coweta For pro… 2014-12-22
#>  6 113033 ENCOMPASS HEALTH… 6510 S… SAVA… GA    31404 Chath… For pro… 2015-04-23
#>  7 113034 ENCOMPASS HEALTH… 1165 S… CUMM… GA    30041 Forsy… For pro… 2021-06-29
#>  8 113035 REHABILITATION H… 2200 P… MCDO… GA    30253 Henry  For pro… 2021-11-17
#>  9 113036 REHABILITATION H… 8321 V… COLU… GA    31909 Musco… For pro… 2023-09-15
#> 10 113037 REHABILITATION H… 1968 P… ATLA… GA    30309 Fulton For pro… 2024-06-28
#> # ℹ 24 more rows
```
