# Dialysis Facilities

A list of all dialysis facilities registered with Medicare that includes
addresses and phone numbers, as well as services and quality of care
provided.

## Usage

``` r
dialysis(
  fac_ccn = NULL,
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
  count = FALSE,
  set = FALSE
)
```

## Source

- [API: Dialysis Facility - Listing by
  Facility](https://data.cms.gov/provider-data/dataset/23ew-n7w9)

## Arguments

- fac_ccn:

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

- set:

  `<lgl>` Return the entire dataset

## Examples

``` r
dialysis(org_name = "DaVita")
#> ✔ dialysis returned 2,800 results
#> ✔ Retrieving 2 pages
#> # A tibble: 2,800 × 12
#>    fac_ccn fac_name    rating network status chain_name cert_date  address city 
#>    <chr>   <chr>        <int>   <int> <chr>  <chr>      <date>     <chr>   <chr>
#>  1 012501  DaVita Gad…      2       8 Profit DaVita     1976-09-01 409 SO… GADS…
#>  2 012502  DaVita Tus…      2       8 Profit DaVita     1977-10-21 220 15… TUSC…
#>  3 012505  DaVita PDI…      2       8 Profit DaVita     1977-12-14 1001 F… MONT…
#>  4 012506  DaVita Dot…      3       8 Profit DaVita     1977-11-28 216 GR… DOTH…
#>  5 012508  DaVita Bir…      2       8 Profit DaVita     1979-06-28 1105 E… BIRM…
#>  6 012517  DaVita Ath…      2       8 Profit DaVita     1983-01-21 15953 … ATHE…
#>  7 012523  DaVita Phe…      2       8 Profit DaVita     1985-09-23 4391 R… PHEN…
#>  8 012529  DaVita Flo…      4       8 Profit DaVita     1986-09-16 422 EA… FLOR…
#>  9 012533  DaVita Wal…      1       8 Profit DaVita     1987-12-29 260 6t… JASP…
#> 10 012535  DaVita PDI…      3       8 Profit DaVita     1990-01-26 600 Mc… PRAT…
#> # ℹ 2,790 more rows
#> # ℹ 3 more variables: state <chr>, zip <chr>, county <chr>
```
