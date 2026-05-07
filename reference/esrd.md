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
#>    ccn    facility_name  rating network status chain_name cert_date  add_1 city 
#>  * <chr>  <chr>           <int>   <int> <chr>  <chr>      <date>     <chr> <chr>
#>  1 012306 CHILDRENS HOS…     NA       8 Non-p… Independe… 1982-11-17 1600… BIRM…
#>  2 012500 FMC CAPITOL C…      2       8 Profit Fresenius… 1976-09-01 255 … MONT…
#>  3 012501 DaVita Gadsde…      2       8 Profit DaVita     1976-09-01 409 … GADS…
#>  4 012502 DaVita Tuscal…      2       8 Profit DaVita     1977-10-21 220 … TUSC…
#>  5 012505 DaVita PDI-Mo…      2       8 Profit DaVita     1977-12-14 1001… MONT…
#>  6 012506 DaVita Dothan…      3       8 Profit DaVita     1977-11-28 216 … DOTH…
#>  7 012507 FMC MOBILE          4       8 Profit Fresenius… 1979-01-04 2620… MOBI…
#>  8 012508 DaVita Birmin…      2       8 Profit DaVita     1979-06-28 1105… BIRM…
#>  9 012512 FMC SELMA           2       8 Profit Fresenius… 1980-08-25 905 … SELMA
#> 10 012513 BMA LANGDALE        5       8 Profit Fresenius… 1981-02-12 8 ME… VALL…
#> # ℹ 3 more variables: state <chr>, zip <chr>, county <chr>

esrd(rating = 1)
#> ✔ esrd returned 823 results.
#> # A tibble: 823 × 12
#>    ccn    facility_name  rating network status chain_name cert_date  add_1 city 
#>    <chr>  <chr>           <int>   <int> <chr>  <chr>      <date>     <chr> <chr>
#>  1 012533 DaVita Walker…      1       8 Profit DaVita     1987-12-29 260 … JASP…
#>  2 012543 DaVita Demopo…      1       8 Profit DaVita     1992-05-20 305 … Demo…
#>  3 012545 DaVita Tuscal…      1       8 Profit DaVita     1992-08-11 805 … TUSC…
#>  4 012570 DaVita Northp…      1       8 Profit DaVita     1996-12-03 Suit… NORT…
#>  5 012576 DCI MONTGOMERY      1       8 Non-p… Dialysis … 1998-06-05 544 … MONT…
#>  6 012598 DCI PHENIX CI…      1       8 Profit Dialysis … 2000-02-09 1611… PHEN…
#>  7 012606 FMC CHASE           1       8 Profit Fresenius… 2002-09-19 1849… HUNT…
#>  8 012613 FMC DISCOVERY       1       8 Profit Fresenius… 2004-03-17 1131… HUNT…
#>  9 012618 RRC NORTHRIDGE      1       8 Profit Fresenius… 2006-10-25 Suit… NORT…
#> 10 012641 DCI EVERGREEN       1       8 Non-p… Dialysis … 2011-01-27 822 … EVER…
#> # ℹ 813 more rows
#> # ℹ 3 more variables: state <chr>, zip <chr>, county <chr>

esrd(network = 15:18)
#> ✔ esrd returned 1,404 results.
#> # A tibble: 1,404 × 12
#>    ccn    facility_name  rating network status chain_name cert_date  add_1 city 
#>    <chr>  <chr>           <int>   <int> <chr>  <chr>      <date>     <chr> <chr>
#>  1 022500 USRC LAUREL S…      3      16 Profit US Renal … 1976-09-01 3950… ANCH…
#>  2 022502 USRC FAIRBANKS      3      16 Profit Fresenius… 1985-06-27 1863… FAIR…
#>  3 022503 USRC GROUP WA…      3      16 Profit Fresenius… 2004-03-29 3787… WASI…
#>  4 022504 JUNEAU DIALYS…      5      16 Profit Fresenius… 2004-03-26 9109… JUNE…
#>  5 022506 USRC DIMOND         5      16 Profit US Renal … 2009-05-07 901 … ANCH…
#>  6 022508 USRC SOLDOTNA       5      16 Profit Fresenius… 2009-12-08 289 … SOLD…
#>  7 022509 USRC DENALI D…      5      16 Profit US Renal … 2012-11-29 360 … ANCH…
#>  8 032302 Valleywise Co…      3      15 Non-p… Independe… 1997-10-07 2525… PHOE…
#>  9 032314 032314 PHOENI…     NA      15 Non-p… Independe… 2001-10-22 1920… PHOE…
#> 10 032315 032315 GILA R…      3      15 Non-p… Independe… 2006-01-04 565 … SACA…
#> # ℹ 1,394 more rows
#> # ℹ 3 more variables: state <chr>, zip <chr>, county <chr>
```
