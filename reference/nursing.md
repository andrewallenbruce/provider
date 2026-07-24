# Nursing Homes

General information on currently active nursing homes, including number
of certified beds, quality measure scores, staffing and other
information used in the Five-Star Rating System. Data are presented as
one row per nursing home.

## Usage

``` r
nursing(
  ccn = NULL,
  name = NULL,
  org_dba = NULL,
  org_name = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  county = NULL,
  beds = NULL,
  rating = NULL,
  count = FALSE
)
```

## Source

- [API: Nursing Home Provider
  Information](https://data.cms.gov/provider-data/dataset/4pq5-n9py)

## Arguments

- ccn:

  `<chr>` CMS Certification Number

- name:

  `<chr>` Provider Name

- org_dba:

  `<chr>` Legal Business Name

- org_name:

  `<chr>` Unique name identifying a group of nursing homes that share at
  least one individual or organizational owner, officer, or entity with
  operational/managerial control

- city, state, zip, county:

  `<chr>` desc

- beds:

  `<int>` Number of Federally Certified Beds

- rating:

  `<int>` Overall Rating (1-5)

- count:

  `<lgl>` Return the total row count

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
containing the search results.

## Examples

``` r
nursing(count = TRUE)
#> ◼ nursing | 14,695 rows | 10 pages
nursing(state = "GA")
#> ✔ nursing returned 356 results
#> # A tibble: 356 × 23
#>    ccn    name       address city  state zip   county own_type prov_type org_dba
#>    <chr>  <chr>      <chr>   <chr> <chr> <chr> <chr>  <chr>    <chr>     <chr>  
#>  1 115002 A.G. RHOD… 1819 C… ATLA… GA    30329 De Ka… Non pro… Medicare… A. G. …
#>  2 115004 MAGNOLIA … 2001 S… AMER… GA    31709 Sumter Non pro… Medicare… MAGNOL…
#>  3 115005 PARK PLAC… 1865 B… MONR… GA    30655 Walton For pro… Medicare… MONROE…
#>  4 115012 HARBORVIE… 2787 N… DECA… GA    30033 De Ka… For pro… Medicare… HARBOR…
#>  5 115020 BELL MINO… 2200 O… GAIN… GA    30507 Hall   For pro… Medicare… HAMILT…
#>  6 115022 WILLIAM B… 3150 H… ATLA… GA    30327 Fulton Non pro… Medicare… THE WI…
#>  7 115025 GLENWOOD … 4115 G… DECA… GA    30032 De Ka… For pro… Medicare… GLENWO…
#>  8 115039 MILLER NU… 206 GR… COLQ… GA    39837 Miller Governm… Medicare… THE HO…
#>  9 115040 CENTER FO… 110 PA… ROSS… GA    30741 Catoo… For pro… Medicare… PARKSI…
#> 10 115044 AZALEA HE… 1600 A… AUGU… GA    30904 Richm… For pro… Medicare… AZALEA…
#> # ℹ 346 more rows
#> # ℹ 13 more variables: org_name <chr>, cert_date <date>, facilities <int>,
#> #   rating <int>, org_rating <dbl>, beds <int>, avg_res <dbl>, fines <int>,
#> #   denials <int>, fine_amt <dbl>, penalties <int>, lat <dbl>, lon <dbl>
```
