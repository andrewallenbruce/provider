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
owner(city = "Valdosta", state = "GA", fac_type = "Hospital")
#> ✔ owner returned 8 results
#> # A tibble: 8 × 18
#>   name  type  pac   enid  own_pac own_org own_dba own_date   own_title own_first
#> * <chr> <chr> <chr> <chr> <chr>   <chr>   <chr>   <date>     <chr>     <chr>    
#> 1 HOSP… Hosp… 1355… O200… 135533… HOSPIT… SOUTH … 2014-07-25 NA        NA       
#> 2 HOSP… Hosp… 1355… O200… 135533… HOSPIT… SOUTH … 2014-07-25 NA        NA       
#> 3 HOSP… Hosp… 1355… O201… 135533… HOSPIT… SOUTH … 2014-05-01 NA        NA       
#> 4 HOSP… Hosp… 1355… O201… 135533… HOSPIT… SOUTH … 2014-05-01 NA        NA       
#> 5 SOUT… Hosp… 1052… O202… 105276… SOUTH … SGMC H… 2023-11-01 NA        NA       
#> 6 SOUT… Hosp… 1052… O202… 105276… SOUTH … SGMC H… 2023-11-01 NA        NA       
#> 7 SOUT… Hosp… 1052… O202… 105276… SOUTH … SGMC H… 2023-11-01 NA        NA       
#> 8 SOUT… Hosp… 1052… O202… 105276… SOUTH … SGMC H… 2023-11-01 NA        NA       
#> # ℹ 8 more variables: own_last <chr>, own_pct <dbl>, own_role <chr>,
#> #   address <chr>, city <chr>, state <chr>, zip <chr>, own_type <chr>
```
