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

  `<enum>` Facility type; if NULL (default), will search all:

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
#> ✔ owner returned 526,704 results.
#> • HHA      : 101,100
#> • RHC      : 65,551 
#> • FQHC     : 148,919
#> • SNF      : 116,973
#> • Hospice  : 71,133 
#> • Hospital : 23,028 

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
#> ℹ Retrieving 4 pages...
#> Error in scv(y, 1L, y[1L], vind1 = TRUE): length(v) must be <= length(x)
```
