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
#> Error in purrr::map_int(url, base_request, query = query): ℹ In index: 4.
#> Caused by error in `httr2::req_perform()`:
#> ! HTTP 429 Too Many Requests.
```
