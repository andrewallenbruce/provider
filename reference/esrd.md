# Dialysis Facilities

A list of all dialysis facilities registered with Medicare that includes
addresses and phone numbers, as well as services and quality of care
provided.

## Usage

``` r
esrd(
  ccn = NULL,
  facility_name = NULL,
  chain_name = NULL,
  rating = NULL,
  network = NULL,
  address = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  county = NULL,
  status = NULL,
  count = FALSE,
  set = FALSE
)
```

## Source

- [API: Dialysis Facility - Listing by
  Facility](https://data.cms.gov/provider-data/dataset/23ew-n7w9)

## Arguments

- ccn:

  `<chr>` Facility CMS Certification Number

- facility_name:

  `<chr>` Facility name

- chain_name:

  `<chr>` Name of the chain organization the facility is owned/managed
  by

- rating:

  `<int>` Facility's Quality of Care star rating (1 - 5)

- network:

  `<int>` Numeric code for the network the facility participates in (1 -
  18)

- address, city, state, zip, county:

  `<chr>` Facility's city, state, zip, county

- status:

  `<enum>` `Non-profit` or `profit`

- count:

  `<lgl>` Return the total row count

- set:

  `<lgl>` Return the entire dataset

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)

## Examples

``` r
esrd(count = TRUE)
#> esrd Totals
#> • Rows  : 7,557
#> • Pages : 6    
#> 

esrd()
#> esrd Totals
#> • Rows  : 7,557
#> • Pages : 6    
#> 
#> ! No Query ❯ Returning first 10 rows.
#> 
#> # A tibble: 10 × 12
#>    ccn   facility_name rating network status chain_name cert_date  address city 
#>  * <chr> <chr>          <int>   <int> <chr>  <chr>      <date>     <chr>   <chr>
#>  1 0123… CHILDRENS HO…     NA       8 Non-p… Independe… 1982-11-17 1600 7… BIRM…
#>  2 0125… FMC CAPITOL …      2       8 Profit Fresenius… 1976-09-01 255 S … MONT…
#>  3 0125… DaVita Gadsd…      2       8 Profit DaVita     1976-09-01 409 SO… GADS…
#>  4 0125… DaVita Tusca…      2       8 Profit DaVita     1977-10-21 220 15… TUSC…
#>  5 0125… DaVita PDI-M…      2       8 Profit DaVita     1977-12-14 1001 F… MONT…
#>  6 0125… DaVita Dotha…      3       8 Profit DaVita     1977-11-28 216 GR… DOTH…
#>  7 0125… FMC MOBILE         4       8 Profit Fresenius… 1979-01-04 2620 O… MOBI…
#>  8 0125… DaVita Birmi…      2       8 Profit DaVita     1979-06-28 1105 E… BIRM…
#>  9 0125… FMC SELMA          2       8 Profit Fresenius… 1980-08-25 905 ME… SELMA
#> 10 0125… BMA LANGDALE       5       8 Profit Fresenius… 1981-02-12 8 MEDI… VALL…
#> # ℹ 3 more variables: state <chr>, zip <chr>, county <chr>

esrd(rating = 1)
#> ✔ esrd returned 823 results.
#> # A tibble: 823 × 12
#>    ccn   facility_name rating network status chain_name cert_date  address city 
#>    <chr> <chr>          <int>   <int> <chr>  <chr>      <date>     <chr>   <chr>
#>  1 0125… DaVita Walke…      1       8 Profit DaVita     1987-12-29 260 6t… JASP…
#>  2 0125… DaVita Demop…      1       8 Profit DaVita     1992-05-20 305 So… Demo…
#>  3 0125… DaVita Tusca…      1       8 Profit DaVita     1992-08-11 805 OL… TUSC…
#>  4 0125… DaVita North…      1       8 Profit DaVita     1996-12-03 Suite … NORT…
#>  5 0125… DCI MONTGOME…      1       8 Non-p… Dialysis … 1998-06-05 544 SO… MONT…
#>  6 0125… DCI PHENIX C…      1       8 Profit Dialysis … 2000-02-09 1611 2… PHEN…
#>  7 0126… FMC CHASE          1       8 Profit Fresenius… 2002-09-19 1849 K… HUNT…
#>  8 0126… FMC DISCOVERY      1       8 Profit Fresenius… 2004-03-17 1131 E… HUNT…
#>  9 0126… RRC NORTHRID…      1       8 Profit Fresenius… 2006-10-25 Suite A NORT…
#> 10 0126… DCI EVERGREEN      1       8 Non-p… Dialysis … 2011-01-27 822 WI… EVER…
#> # ℹ 813 more rows
#> # ℹ 3 more variables: state <chr>, zip <chr>, county <chr>

esrd(network = 15:18)
#> ✔ esrd returned 1,404 results.
#> # A tibble: 1,404 × 12
#>    ccn   facility_name rating network status chain_name cert_date  address city 
#>    <chr> <chr>          <int>   <int> <chr>  <chr>      <date>     <chr>   <chr>
#>  1 0225… USRC LAUREL …      3      16 Profit US Renal … 1976-09-01 3950 L… ANCH…
#>  2 0225… USRC FAIRBAN…      3      16 Profit Fresenius… 1985-06-27 1863 A… FAIR…
#>  3 0225… USRC GROUP W…      3      16 Profit Fresenius… 2004-03-29 3787 E… WASI…
#>  4 0225… JUNEAU DIALY…      5      16 Profit Fresenius… 2004-03-26 9109 M… JUNE…
#>  5 0225… USRC DIMOND        5      16 Profit US Renal … 2009-05-07 901 EA… ANCH…
#>  6 0225… USRC SOLDOTNA      5      16 Profit Fresenius… 2009-12-08 289 N … SOLD…
#>  7 0225… USRC DENALI …      5      16 Profit US Renal … 2012-11-29 360 BO… ANCH…
#>  8 0323… Valleywise C…      3      15 Non-p… Independe… 1997-10-07 2525 E… PHOE…
#>  9 0323… 032314 PHOEN…     NA      15 Non-p… Independe… 2001-10-22 1920 E… PHOE…
#> 10 0323… 032315 GILA …      3      15 Non-p… Independe… 2006-01-04 565 W … SACA…
#> # ℹ 1,394 more rows
#> # ℹ 3 more variables: state <chr>, zip <chr>, county <chr>
```
