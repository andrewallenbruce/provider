# Long-Term Care Hospitals

A list of long-term care hospitals with information such as address,
phone number, ownership data and more.

## Usage

``` r
long_term(
  ccn = NULL,
  name = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  county = NULL,
  own_type = NULL,
  beds = NULL,
  count = FALSE
)
```

## Source

- [API: Long-Term Care Hospital - General
  Information](https://data.cms.gov/provider-data/dataset/azum-44iv)

## Arguments

- ccn:

  `<chr>` The CMS Certification Number (CCN) is used to identify the
  facility listed

- name:

  `<chr>` Name of the facility

- city, state, zip, county:

  `<chr>` Facility’s city, state, zip, county

- own_type:

  Facility’s ownership type: For Profit, Non-profit, Government,
  Physician, Tribal

- beds:

  `<int>` The total number of beds in the facility

- count:

  `<lgl>` Return the total row count

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
containing the search results.

## Examples

``` r
long_term(count = TRUE)
#> ◼ long_term | 311 rows | 1 pages
long_term(state = "GA")
#> ✔ long_term returned 10 results
#> # A tibble: 10 × 10
#>    ccn    name        address city  state zip   county own_type cert_date   beds
#>    <chr>  <chr>       <chr>   <chr> <chr> <chr> <chr>  <chr>    <date>     <int>
#>  1 112000 WELLSTAR R… 6135 R… WARM… GA    31830 Meriw… Governm… 1974-07-01    32
#>  2 112003 SHEPHERD C… 2020 P… ATLA… GA    30309 Fulton Non-pro… 1984-04-01   152
#>  3 112004 SELECT SPE… 705 JU… ATLA… GA    30308 Fulton For pro… 1991-04-30    72
#>  4 112006 EMORY LONG… 450 NO… DECA… GA    30030 DeKalb Non-pro… 1996-11-15    76
#>  5 112007 WELLSTAR W… 2540 W… MARI… GA    30067 Cobb   Non-pro… 1997-07-01   115
#>  6 112011 SELECT SPE… 800 E … SAVA… GA    31405 Chath… Non-pro… 2003-05-01    40
#>  7 112012 COLUMBUS S… 616 19… COLU… GA    31901 Musco… For pro… 2004-01-01    30
#>  8 112013 SELECT SPE… 1537 W… AUGU… GA    30904 Richm… For pro… 2004-04-01    30
#>  9 112016 REGENCY HO… 535 CO… MACON GA    31217 Bibb   Non-pro… 2004-11-01    34
#> 10 112017 LANDMARK H… 775 SU… ATHE… GA    30606 Clarke For pro… 2009-02-01    42
```
