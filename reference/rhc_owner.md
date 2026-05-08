# Rural Health Clinic Owners

Providers with pending Medicare enrollment applications.

## Usage

``` r
rhc_owner(
  org_enid = NULL,
  org_pac = NULL,
  org_name = NULL,
  pac = NULL,
  owner = NULL,
  dba = NULL,
  percent = NULL,
  role = NULL,
  entity = NULL,
  first = NULL,
  middle = NULL,
  last = NULL,
  title = NULL,
  address = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  count = FALSE,
  set = FALSE
)
```

## Arguments

- org_enid:

  `<chr>` National Provider Identifier

- org_pac:

  `<chr>` Provider's name

- org_name:

  `<chr>` Provider's name

- pac:

  `<chr>` Provider's name

- owner:

  `<chr>` Provider's name

- dba:

  `<chr>` Provider's name

- percent:

  `<chr>` Provider's name

- role:

  `<chr>` Provider's name

- entity:

  `<chr>` Provider's name

- first, middle, last:

  `<chr>` Provider's name

- title:

  `<chr>` Provider's name

- address, city, state, zip:

  `<chr>` Provider's name

- count:

  `<lgl>` Return the total row count

- set:

  `<lgl>` Return the entire dataset

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)

## Examples

``` r
rhc_owner(count = TRUE)
#> rhc_owner Totals
#> • Rows  : 65,551
#> • Pages : 14    
#> 

rhc_owner(state = c("GA", "FL"))
#> ✔ rhc_owner returned 136 results.
#> # A tibble: 136 × 19
#>    org_enid   org_pac org_name pac   role  asc_date   owner dba   percent entity
#>    <chr>      <chr>   <chr>    <chr> <chr> <date>     <chr> <chr>   <dbl> <chr> 
#>  1 O20130617… 024422… THE HOS… 0244… 5% O… 2013-02-04 THE … MILL…      NA O     
#>  2 O20130604… 337579… THE MED… 0345… 5% O… 2011-11-01 NAVI… NA        100 O     
#>  3 O20170208… 892138… LIFEBRI… 0345… 5% O… 2016-10-12 LIFE… NA        100 O     
#>  4 O20170208… 892138… LIFEBRI… 0345… OPER… 2016-10-12 LIFE… NA         NA O     
#>  5 O20181113… 892138… LIFEBRI… 0345… 5% O… 2017-01-31 LIFE… NA        100 O     
#>  6 O20171013… 347645… BAPTIST… 0547… 5% O… 2024-10-01 ORLA… ORLA…       0 O     
#>  7 O20171013… 347645… BAPTIST… 0547… OPER… 2024-10-01 ORLA… ORLA…      NA O     
#>  8 O20030404… 872999… TMC HAR… 0547… 5% O… 2003-02-01 TMC/… TANN…      NA O     
#>  9 O20150311… 084019… CHATUGE… 0840… OPER… 2014-09-12 CHAT… HAYE…     100 O     
#> 10 O20191011… 185043… MERIWET… 0840… 5% O… 2009-10-30 PINN… NA          5 O     
#> # ℹ 126 more rows
#> # ℹ 9 more variables: title <chr>, first <chr>, middle <chr>, last <chr>,
#> #   address <chr>, city <chr>, state <chr>, zip <chr>, owner_type <chr>
```
