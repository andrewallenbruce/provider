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
#>    fac_ccn network fac_name       rating address city  state zip   county status
#>  * <chr>     <int> <chr>           <int> <chr>   <chr> <chr> <chr> <chr>  <chr> 
#>  1 012306        8 CHILDRENS HOS…     NA 1600 7… BIRM… AL    35233 Jeffe… Non-p…
#>  2 012500        8 FMC CAPITOL C…      2 255 S … MONT… AL    36104 Montg… Profit
#>  3 012501        8 DaVita Gadsde…      2 409 SO… GADS… AL    35901 Etowah Profit
#>  4 012502        8 DaVita Tuscal…      2 220 15… TUSC… AL    35401 Tusca… Profit
#>  5 012505        8 DaVita PDI-Mo…      2 1001 F… MONT… AL    36106 Montg… Profit
#>  6 012506        8 DaVita Dothan…      3 216 GR… DOTH… AL    36305 Houst… Profit
#>  7 012507        8 FMC MOBILE          4 2620 O… MOBI… AL    36607 Mobile Profit
#>  8 012508        8 DaVita Birmin…      2 1105 E… BIRM… AL    35235 Jeffe… Profit
#>  9 012512        8 FMC SELMA           2 905 ME… SELMA AL    36701 Dallas Profit
#> 10 012513        8 BMA LANGDALE        5 8 MEDI… VALL… AL    36854 Chamb… Profit
#> # ℹ 2 more variables: chain_name <chr>, cert_date <date>

esrd(rating = 1)
#> ✔ esrd returned 823 results.
#> # A tibble: 823 × 12
#>    fac_ccn network fac_name       rating address city  state zip   county status
#>    <chr>     <int> <chr>           <int> <chr>   <chr> <chr> <chr> <chr>  <chr> 
#>  1 012533        8 DaVita Walker…      1 260 6t… JASP… AL    35504 Walker Profit
#>  2 012543        8 DaVita Demopo…      1 305 So… Demo… AL    36732 Maren… Profit
#>  3 012545        8 DaVita Tuscal…      1 805 OL… TUSC… AL    35401 Tusca… Profit
#>  4 012570        8 DaVita Northp…      1 Suite … NORT… AL    35476 Tusca… Profit
#>  5 012576        8 DCI MONTGOMERY      1 544 SO… MONT… AL    36104 Montg… Non-p…
#>  6 012598        8 DCI PHENIX CI…      1 1611 2… PHEN… AL    36867 Russe… Profit
#>  7 012606        8 FMC CHASE           1 1849 K… HUNT… AL    35810 Madis… Profit
#>  8 012613        8 FMC DISCOVERY       1 1131 E… HUNT… AL    35801 Madis… Profit
#>  9 012618        8 RRC NORTHRIDGE      1 Suite A NORT… AL    35473 Tusca… Profit
#> 10 012641        8 DCI EVERGREEN       1 822 WI… EVER… AL    36401 Conec… Non-p…
#> # ℹ 813 more rows
#> # ℹ 2 more variables: chain_name <chr>, cert_date <date>

esrd(network = 15:18)
#> ✔ esrd returned 1,404 results.
#> # A tibble: 1,404 × 12
#>    fac_ccn network fac_name       rating address city  state zip   county status
#>    <chr>     <int> <chr>           <int> <chr>   <chr> <chr> <chr> <chr>  <chr> 
#>  1 022500       16 USRC LAUREL S…      3 3950 L… ANCH… AK    99508 Ancho… Profit
#>  2 022502       16 USRC FAIRBANKS      3 1863 A… FAIR… AK    99701 Fairb… Profit
#>  3 022503       16 USRC GROUP WA…      3 3787 E… WASI… AK    99654 Matan… Profit
#>  4 022504       16 JUNEAU DIALYS…      5 9109 M… JUNE… AK    99801 Juneau Profit
#>  5 022506       16 USRC DIMOND         5 901 EA… ANCH… AK    99515 Ancho… Profit
#>  6 022508       16 USRC SOLDOTNA       5 289 N … SOLD… AK    99669 Kenai… Profit
#>  7 022509       16 USRC DENALI D…      5 360 BO… ANCH… AK    99504 Ancho… Profit
#>  8 032302       15 Valleywise Co…      3 2525 E… PHOE… AZ    85008 Maric… Non-p…
#>  9 032314       15 032314 PHOENI…     NA 1920 E… PHOE… AZ    85016 Maric… Non-p…
#> 10 032315       15 032315 GILA R…      3 565 W … SACA… AZ    85147 Pinal  Non-p…
#> # ℹ 1,394 more rows
#> # ℹ 2 more variables: chain_name <chr>, cert_date <date>
```
