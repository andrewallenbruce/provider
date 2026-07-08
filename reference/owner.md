# Owners

Owners of facilities enrolled in Medicare.

## Usage

``` r
owner(
  fac_type = NULL,
  fac_enid = NULL,
  fac_pac = NULL,
  fac_name = NULL,
  own_pac = NULL,
  own_org = NULL,
  own_dba = NULL,
  own_pct = NULL,
  own_role = NULL,
  own_entity = NULL,
  own_first = NULL,
  own_last = NULL,
  own_title = NULL,
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

- own_pac:

  `<chr>` Provider's name

- own_org:

  `<chr>` Provider's name

- own_dba:

  `<chr>` Provider's name

- own_pct:

  `<dbl>` Provider's name

- own_role:

  `<chr>` Provider's name

- own_entity:

  `<enum>` Provider's name

- own_first, own_last:

  `<chr>` Provider's name

- own_title:

  `<chr>` Provider's name

- city, state, zip:

  `<chr>` Provider's name

- count:

  `<lgl>` Return the total row count

- enid:

  `<chr>` National Provider Identifier

- pac:

  `<chr>` Provider's name

- org_name:

  `<chr>` Provider's name

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
containing the search results.

## Examples

``` r
owner(count = TRUE)
#> ◼ owner | 526,704 rows | 109 pages
owner(city = "Valdosta", state = "GA")
#> ✔ owner returned 13 results
#> ✔ Retrieving 4 pages
#> # A tibble: 13 × 18
#>    name           type  pac   enid  own_pac own_org own_dba own_date   own_title
#>  * <chr>          <chr> <chr> <chr> <chr>   <chr>   <chr>   <date>     <chr>    
#>  1 GHHS HEALTHCA… HHA   3173… O201… 286065… LJP ME… NA      2011-06-23 NA       
#>  2 GHHS HEALTHCA… HHA   3173… O201… 286065… LJP ME… NA      2011-06-23 NA       
#>  3 HOSPITAL AUTH… SNF   1355… O201… 135533… HOSPIT… SOUTH … 2014-05-04 NA       
#>  4 SOUTH GEORGIA… SNF   1052… O202… 105276… SOUTH … SGMC H… 2023-11-01 NA       
#>  5 SOUTH GEORGIA… Hosp… 1355… O200… 135535… SOUTH … HOSPIC… 2006-07-07 NA       
#>  6 HOSPITAL AUTH… Hosp… 1355… O200… 135533… HOSPIT… SOUTH … 2014-07-25 NA       
#>  7 HOSPITAL AUTH… Hosp… 1355… O200… 135533… HOSPIT… SOUTH … 2014-07-25 NA       
#>  8 HOSPITAL AUTH… Hosp… 1355… O201… 135533… HOSPIT… SOUTH … 2014-05-01 NA       
#>  9 HOSPITAL AUTH… Hosp… 1355… O201… 135533… HOSPIT… SOUTH … 2014-05-01 NA       
#> 10 SOUTH GEORGIA… Hosp… 1052… O202… 105276… SOUTH … SGMC H… 2023-11-01 NA       
#> 11 SOUTH GEORGIA… Hosp… 1052… O202… 105276… SOUTH … SGMC H… 2023-11-01 NA       
#> 12 SOUTH GEORGIA… Hosp… 1052… O202… 105276… SOUTH … SGMC H… 2023-11-01 NA       
#> 13 SOUTH GEORGIA… Hosp… 1052… O202… 105276… SOUTH … SGMC H… 2023-11-01 NA       
#> # ℹ 9 more variables: own_first <chr>, own_last <chr>, own_pct <dbl>,
#> #   own_role <chr>, address <chr>, city <chr>, state <chr>, zip <chr>,
#> #   own_type <chr>
```
