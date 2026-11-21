# Dialysis Facilities

A list of all dialysis facilities registered with Medicare that includes
addresses and phone numbers, as well as services and quality of care
provided.

## Usage

``` r
dialysis(
  ccn = NULL,
  fac_name = NULL,
  org_name = NULL,
  rating = NULL,
  network = NULL,
  status = NULL,
  address = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  county = NULL,
  count = FALSE
)
```

## Source

- [API: Dialysis Facility - Listing by
  Facility](https://data.cms.gov/provider-data/dataset/23ew-n7w9)

## Arguments

- ccn:

  `<chr>` Facility CMS Certification Number

- fac_name:

  `<chr>` Facility name

- org_name:

  `<chr>` Name of the chain organization the facility is owned/managed
  by

- rating:

  `<int>` Facility's Quality of Care star rating; (1-5)

- network:

  `<int>` Numeric code for the network the facility participates in;
  (1-18)

- status:

  `<enum>` `Non-profit` or `Profit`

- address, city, state, zip, county:

  `<chr>` Facility's city, state, zip, county

- count:

  `<lgl>` Return the total row count

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
containing the search results.

## Examples

``` r
dialysis(count = TRUE)
#> ◼ dialysis | 7,471 rows | 5 pages
dialysis(org_name = "DaVita", state = "GA")
#> ✔ dialysis returned 139 results
#> # A tibble: 139 × 12
#>    ccn    name     rating network status org_name cert_date address  city  state
#>    <chr>  <chr>     <int>   <int> <chr>  <chr>    <date>    <chr>    <chr> <chr>
#>  1 112505 DaVita …      3       6 Profit DaVita   NA        20 Rive… ROME  GA   
#>  2 112513 DaVita …      1       6 Profit DaVita   NA        1747 LA… Watk… GA   
#>  3 112514 DaVita …      3       6 Profit DaVita   NA        53 SCRA… BRUN… GA   
#>  4 112515 DaVita …      2       6 Profit DaVita   NA        2704 N … VALD… GA   
#>  5 112517 DaVita …      3       6 Profit DaVita   NA        1595 St… Jone… GA   
#>  6 112523 DaVita …      1       6 Profit DaVita   NA        3620 MA… ATLA… GA   
#>  7 112526 DaVita …      2       6 Profit DaVita   NA        3899 LO… DOUG… GA   
#>  8 112528 DaVita …      1       6 Profit DaVita   NA        227 N L… AMER… GA   
#>  9 112532 DaVita …      3       6 Profit DaVita   NA        301 PEA… JESUP GA   
#> 10 112535 DaVita …      2       6 Profit DaVita   NA        190 WES… DOUG… GA   
#> # ℹ 129 more rows
#> # ℹ 2 more variables: zip <chr>, county <chr>
```
