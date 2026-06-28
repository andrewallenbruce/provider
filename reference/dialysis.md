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
#> ◼ dialysis | 7,557 rows | 6 pages
dialysis(org_name = "DaVita", state = "GA")
#> ✔ dialysis returned 139 results
#> ✔ Retrieving 1 page
#> # A tibble: 139 × 12
#>    ccn    fac_name     rating network status chain_name cert_date  address city 
#>    <chr>  <chr>         <int>   <int> <chr>  <chr>      <date>     <chr>   <chr>
#>  1 112505 DaVita Rome…      3       6 Profit DaVita     1976-09-01 20 Riv… ROME 
#>  2 112513 DaVita Athe…      1       6 Profit DaVita     1977-07-18 1747 L… Watk…
#>  3 112514 DaVita Brun…      3       6 Profit DaVita     1977-07-14 53 SCR… BRUN…
#>  4 112515 DaVita Oak …      2       6 Profit DaVita     1977-09-26 2704 N… VALD…
#>  5 112517 DaVita Jone…      3       6 Profit DaVita     1979-04-09 1595 S… Jone…
#>  6 112523 DaVita Sout…      1       6 Profit DaVita     1981-06-24 3620 M… ATLA…
#>  7 112526 DaVita Doug…      2       6 Profit DaVita     1982-10-04 3899 L… DOUG…
#>  8 112528 DaVita Amer…      1       6 Profit DaVita     1983-02-11 227 N … AMER…
#>  9 112532 DaVita Jesu…      3       6 Profit DaVita     1984-05-08 301 PE… JESUP
#> 10 112535 DaVita Doug…      2       6 Profit DaVita     1985-02-13 190 WE… DOUG…
#> # ℹ 129 more rows
#> # ℹ 3 more variables: state <chr>, zip <chr>, county <chr>
```
