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
dialysis(count = TRUE)
#> dialysis Totals
#> • Rows  : 7,557
#> • Pages : 6    
#> 
dialysis(count = TRUE, rating = 1:5)
#> ✔ dialysis returned 7,072 results.
dialysis(count = TRUE, org_name = "DaVita")
#> ✔ dialysis returned 2,800 results.
dialysis(rating = 1)
#> ✔ dialysis returned 823 results.
#> # A tibble: 823 × 12
#>    fac_ccn fac_name    rating network status chain_name cert_date  address city 
#>    <chr>   <chr>        <int>   <int> <chr>  <chr>      <date>     <chr>   <chr>
#>  1 012533  DaVita Wal…      1       8 Profit DaVita     1987-12-29 260 6t… JASP…
#>  2 012543  DaVita Dem…      1       8 Profit DaVita     1992-05-20 305 So… Demo…
#>  3 012545  DaVita Tus…      1       8 Profit DaVita     1992-08-11 805 OL… TUSC…
#>  4 012570  DaVita Nor…      1       8 Profit DaVita     1996-12-03 400 Mc… NORT…
#>  5 012576  DCI MONTGO…      1       8 Non-p… Dialysis … 1998-06-05 544 SO… MONT…
#>  6 012598  DCI PHENIX…      1       8 Profit Dialysis … 2000-02-09 1611 2… PHEN…
#>  7 012606  FMC CHASE        1       8 Profit Fresenius… 2002-09-19 1849 K… HUNT…
#>  8 012613  FMC DISCOV…      1       8 Profit Fresenius… 2004-03-17 1131 E… HUNT…
#>  9 012618  RRC NORTHR…      1       8 Profit Fresenius… 2006-10-25 4400 W… NORT…
#> 10 012641  DCI EVERGR…      1       8 Non-p… Dialysis … 2011-01-27 822 WI… EVER…
#> # ℹ 813 more rows
#> # ℹ 3 more variables: state <chr>, zip <chr>, county <chr>
```
