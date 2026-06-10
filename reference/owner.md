# Owners

Owners of facilities enrolled in Medicare.

## Usage

``` r
owner(
  fac_type = NULL,
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
  last = NULL,
  title = NULL,
  address = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  count = FALSE
)
```

## Source

Medicare

## Arguments

- fac_type:

  `<enum>` Facility type; if NULL (default), will search all:

  - `HHA` = Home Health Agency

  - `RHC` = Rural Health Clinic

  - `FQHC` = Federally Qualified Health Clinic

  - `SNF` = Skilled Nursing Facility

  - `Hospice` = Hospice

  - `Hospital` = Hospital

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

- first, last:

  `<chr>` Provider's name

- title:

  `<chr>` Provider's name

- address, city, state, zip:

  `<chr>` Provider's name

- count:

  `<lgl>` Return the total row count

## Examples

``` r
owner(city = "Valdosta", state = "GA")
#> ✔ owner returned 13 results
#> ✔ Retrieving 4 pages
#> # A tibble: 13 × 18
#>    fac_type org_enid    org_pac org_name pac   role  asc_date   own_name own_dba
#>  * <chr>    <chr>       <chr>   <chr>    <chr> <chr> <date>     <chr>    <chr>  
#>  1 HHA      O201204270… 317378… GHHS HE… 2860… 5%+ … 2011-06-23 LJP MED… NA     
#>  2 HHA      O201204270… 317378… GHHS HE… 2860… Ops/… 2011-06-23 LJP MED… NA     
#>  3 SNF      O201406120… 135533… HOSPITA… 1355… 5%+ … 2014-05-04 HOSPITA… SOUTH …
#>  4 SNF      O202403280… 105276… SOUTH G… 1052… 5%+ … 2023-11-01 SOUTH G… SGMC H…
#>  5 Hospice  O200602090… 135535… SOUTH G… 1355… 5%+ … 2006-07-07 SOUTH G… HOSPIC…
#>  6 Hospital O200803120… 135533… HOSPITA… 1355… 5%+ … 2014-07-25 HOSPITA… SOUTH …
#>  7 Hospital O200803130… 135533… HOSPITA… 1355… 5%+ … 2014-07-25 HOSPITA… SOUTH …
#>  8 Hospital O201405050… 135533… HOSPITA… 1355… 5%+ … 2014-05-01 HOSPITA… SOUTH …
#>  9 Hospital O201406130… 135533… HOSPITA… 1355… 5%+ … 2014-05-01 HOSPITA… SOUTH …
#> 10 Hospital O202401310… 105276… SOUTH G… 1052… 5%+ … 2023-11-01 SOUTH G… SGMC H…
#> 11 Hospital O202403220… 105276… SOUTH G… 1052… 5%+ … 2023-11-01 SOUTH G… SGMC H…
#> 12 Hospital O202404090… 105276… SOUTH G… 1052… 5%+ … 2023-11-01 SOUTH G… SGMC H…
#> 13 Hospital O202404100… 105276… SOUTH G… 1052… 5%+ … 2023-11-01 SOUTH G… SGMC H…
#> # ℹ 9 more variables: percent <dbl>, title <chr>, first <chr>, last <chr>,
#> #   address <chr>, city <chr>, state <chr>, zip <chr>, own_type <chr>
```
