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
  middle = NULL,
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

  `<enum>` Facility type

  - `hha` = Home Health Agency

  - `rhc` = Rural Health Clinic

  - `fqhc` = Federally Qualified Health Clinic

  - `snf` = Skilled Nursing Facility

  - `hospice` = Hospice

  - `hospital` = Hospital

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

## Examples

``` r
owner(count = TRUE)
#> owner Totals
#> • Rows  : 526,704
#> • Pages : 109    
#> 

owner(state = c("GA", "FL"), count = TRUE)
#> ✔ owner returned 8,462 results.
#> • HHA      : 1,799
#> • RHC      : 136  
#> • FQHC     : 254  
#> • SNF      : 4,175
#> • Hospice  : 1,961
#> • Hospital : 137  

owner(city = "Valdosta", state = "GA")
#> ✔ owner returned 13 results.
#> • HHA      : 2
#> • RHC      : 0
#> • FQHC     : 0
#> • SNF      : 2
#> • Hospice  : 1
#> • Hospital : 8
#> ℹ Retrieving 6 pages...
#> # A tibble: 13 × 19
#>    fac_type org_enid    org_pac org_name pac   role  asc_date   own_name own_dba
#>    <chr>    <chr>       <chr>   <chr>    <chr> <chr> <date>     <chr>    <chr>  
#>  1 Hospital O202401310… 105276… SOUTH G… 1052… 5% O… 2023-11-01 SOUTH G… SGMC H…
#>  2 Hospital O202403220… 105276… SOUTH G… 1052… 5% O… 2023-11-01 SOUTH G… SGMC H…
#>  3 SNF      O202403280… 105276… SOUTH G… 1052… 5% O… 2023-11-01 SOUTH G… SGMC H…
#>  4 Hospital O202404090… 105276… SOUTH G… 1052… 5% O… 2023-11-01 SOUTH G… SGMC H…
#>  5 Hospital O202404100… 105276… SOUTH G… 1052… 5% O… 2023-11-01 SOUTH G… SGMC H…
#>  6 Hospital O200803120… 135533… HOSPITA… 1355… 5% O… 2014-07-25 HOSPITA… SOUTH …
#>  7 Hospital O200803130… 135533… HOSPITA… 1355… 5% O… 2014-07-25 HOSPITA… SOUTH …
#>  8 Hospital O201405050… 135533… HOSPITA… 1355… 5% O… 2014-05-01 HOSPITA… SOUTH …
#>  9 SNF      O201406120… 135533… HOSPITA… 1355… 5% O… 2014-05-04 HOSPITA… SOUTH …
#> 10 Hospital O201406130… 135533… HOSPITA… 1355… 5% O… 2014-05-01 HOSPITA… SOUTH …
#> 11 Hospice  O200602090… 135535… SOUTH G… 1355… 5% O… 2006-07-07 SOUTH G… HOSPIC…
#> 12 HHA      O201204270… 317378… GHHS HE… 2860… 5% O… 2011-06-23 LJP MED… NA     
#> 13 HHA      O201204270… 317378… GHHS HE… 2860… OPER… 2011-06-23 LJP MED… NA     
#> # ℹ 10 more variables: percent <dbl>, title <chr>, first <chr>, middle <chr>,
#> #   last <chr>, address <chr>, city <chr>, state <chr>, zip <chr>,
#> #   own_type <chr>
```
