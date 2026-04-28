# Dialysis Facilities

Access information concerning individual providers' affiliations with
organizations/facilities.

## Usage

``` r
esrd(
  ccn = NULL,
  facility_name = NULL,
  chain_name = NULL,
  stars = NULL,
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

- [API: Physician Facility
  Affiliations](https://data.cms.gov/provider-data/dataset/27ea-46a8)

## Arguments

- ccn:

  `<chr>` Individual National Provider Identifier

- facility_name:

  `<chr>` facility type

- chain_name:

  `<chr>` facility type

- stars:

  `<int>` 1 - 5

- network:

  `<int>` 1 - 18

- address, city, state, zip, county:

  `<chr>` Individual provider's name

- status:

  `<enum>` Non-profit or profit

- count:

  `<lgl>` Return the total row count

- set:

  `<lgl>` Return the entire dataset

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)

## Examples

``` r
esrd(count = TRUE)
#> ℹ esrd has 7,557 rows.
esrd()
#> ! esrd ❯ No Query
#> ℹ Returning first 10 rows...
#> # A tibble: 10 × 13
#>    ccn    facility_name   stars network status chain_name cert_date  city  state
#>  * <chr>  <chr>           <int>   <int> <chr>  <chr>      <date>     <chr> <chr>
#>  1 012306 CHILDRENS HOSP…    NA       8 Non-p… Independe… 1982-11-17 BIRM… AL   
#>  2 012500 FMC CAPITOL CI…     2       8 Profit Fresenius… 1976-09-01 MONT… AL   
#>  3 012501 DaVita Gadsden…     2       8 Profit DaVita     1976-09-01 GADS… AL   
#>  4 012502 DaVita Tuscalo…     2       8 Profit DaVita     1977-10-21 TUSC… AL   
#>  5 012505 DaVita PDI-Mon…     2       8 Profit DaVita     1977-12-14 MONT… AL   
#>  6 012506 DaVita Dothan …     3       8 Profit DaVita     1977-11-28 DOTH… AL   
#>  7 012507 FMC MOBILE          4       8 Profit Fresenius… 1979-01-04 MOBI… AL   
#>  8 012508 DaVita Birming…     2       8 Profit DaVita     1979-06-28 BIRM… AL   
#>  9 012512 FMC SELMA           2       8 Profit Fresenius… 1980-08-25 SELMA AL   
#> 10 012513 BMA LANGDALE        5       8 Profit Fresenius… 1981-02-12 VALL… AL   
#> # ℹ 4 more variables: zip <chr>, county <chr>, phone <chr>, address <chr>
esrd(stars = 1)
#> ✔ esrd returned 823 results.
#> # A tibble: 823 × 13
#>    ccn    facility_name   stars network status chain_name cert_date  city  state
#>  * <chr>  <chr>           <int>   <int> <chr>  <chr>      <date>     <chr> <chr>
#>  1 012533 DaVita Walker …     1       8 Profit DaVita     1987-12-29 JASP… AL   
#>  2 012543 DaVita Demopol…     1       8 Profit DaVita     1992-05-20 Demo… AL   
#>  3 012545 DaVita Tuscalo…     1       8 Profit DaVita     1992-08-11 TUSC… AL   
#>  4 012570 DaVita Northpo…     1       8 Profit DaVita     1996-12-03 NORT… AL   
#>  5 012576 DCI MONTGOMERY      1       8 Non-p… Dialysis … 1998-06-05 MONT… AL   
#>  6 012598 DCI PHENIX CITY     1       8 Profit Dialysis … 2000-02-09 PHEN… AL   
#>  7 012606 FMC CHASE           1       8 Profit Fresenius… 2002-09-19 HUNT… AL   
#>  8 012613 FMC DISCOVERY       1       8 Profit Fresenius… 2004-03-17 HUNT… AL   
#>  9 012618 RRC NORTHRIDGE      1       8 Profit Fresenius… 2006-10-25 NORT… AL   
#> 10 012641 DCI EVERGREEN       1       8 Non-p… Dialysis … 2011-01-27 EVER… AL   
#> # ℹ 813 more rows
#> # ℹ 4 more variables: zip <chr>, county <chr>, phone <chr>, address <chr>
esrd(network = 15:18)
#> ✔ esrd returned 1,404 results.
#> # A tibble: 1,404 × 13
#>    ccn    facility_name   stars network status chain_name cert_date  city  state
#>  * <chr>  <chr>           <int>   <int> <chr>  <chr>      <date>     <chr> <chr>
#>  1 022500 USRC LAUREL ST…     3      16 Profit US Renal … 1976-09-01 ANCH… AK   
#>  2 022502 USRC FAIRBANKS      3      16 Profit Fresenius… 1985-06-27 FAIR… AK   
#>  3 022503 USRC GROUP WAS…     3      16 Profit Fresenius… 2004-03-29 WASI… AK   
#>  4 022504 JUNEAU DIALYSI…     5      16 Profit Fresenius… 2004-03-26 JUNE… AK   
#>  5 022506 USRC DIMOND         5      16 Profit US Renal … 2009-05-07 ANCH… AK   
#>  6 022508 USRC SOLDOTNA       5      16 Profit Fresenius… 2009-12-08 SOLD… AK   
#>  7 022509 USRC DENALI DI…     5      16 Profit US Renal … 2012-11-29 ANCH… AK   
#>  8 032302 Valleywise Com…     3      15 Non-p… Independe… 1997-10-07 PHOE… AZ   
#>  9 032314 032314 PHOENIX…    NA      15 Non-p… Independe… 2001-10-22 PHOE… AZ   
#> 10 032315 032315 GILA RI…     3      15 Non-p… Independe… 2006-01-04 SACA… AZ   
#> # ℹ 1,394 more rows
#> # ℹ 4 more variables: zip <chr>, county <chr>, phone <chr>, address <chr>
```
