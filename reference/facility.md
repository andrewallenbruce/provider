# Facilities

Facilities enrolled in Medicare.

## Usage

``` r
facility(
  fac_type = NULL,
  npi = NULL,
  ccn = NULL,
  pac = NULL,
  enid = NULL,
  org_name = NULL,
  org_dba = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  multi = NULL,
  status = NULL,
  org_type = NULL,
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

- npi:

  `<int>` National Provider Identifier

- ccn:

  `<int>` CMS Certification Number

- pac:

  `<chr>` PECOS Associate Control ID

- enid:

  `<chr>` Medicare Enrollment ID

- org_name:

  `<chr>` Legal business name

- org_dba:

  `<chr>` Doing-business-as name

- city, state, zip:

  `<chr>` Location city, state, zip

- multi:

  `<lgl>` Does facility have more than one NPI?

- status:

  `<enum>` Facility organization status

  - `P` = Proprietary

  - `N` = Non-Profit

  - `D` = Unknown

- org_type:

  `<enum>` Facility organization structure type

  - `corp` = Corporation

  - `other` = Other

  - `llc` = LLC

  - `part` = Partnership

  - `sole` = Sole Proprietor

- count:

  `<lgl>` Return the total row count

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
containing the search results.

## Examples

``` r
facility(count = TRUE)
#> ◼ facility | 48,592 rows | 13 pages
facility(city = "Valdosta", state = "GA")
#> ✔ facility returned 12 results
#> ✔ Retrieving 4 pages
#> # A tibble: 12 × 15
#>    fac_type ccn       npi pac   enid  multi org_name org_dba inc_date   org_type
#>    <chr>    <chr>   <int> <chr> <chr> <int> <chr>    <chr>   <date>     <chr>   
#>  1 HHA      117009 1.29e9 6002… O201…     0 PUBLIC … NA      1994-03-07 CORPORA…
#>  2 HHA      117058 1.11e9 3173… O201…     0 GHHS HE… GEORGI… NA         LLC     
#>  3 FQHC     111098 1.64e9 1951… O201…     0 SOUTH C… NORTHS… 1992-06-19 CORPORA…
#>  4 FQHC     C21012 1.47e9 1951… O202…     0 SOUTH C… SOUTH … 2024-02-01 CORPORA…
#>  5 SNF      115385 1.06e9 9032… O202…     0 PRUITTH… PRUITT… NA         LLC     
#>  6 SNF      115373 1.88e9 8022… O202…     0 PRUITTH… PRUITT… 2020-04-22 LLC     
#>  7 SNF      115377 1.77e9 1456… O202…     0 PRUITTH… PRUITT… 2020-04-22 LLC     
#>  8 SNF      115562 1.97e9 7416… O202…     0 PRUITTH… PRUITT… 2020-04-22 LLC     
#>  9 Hospice  111571 1.06e9 2264… O200…     0 PRUITTH… PRUITT… 1993-10-14 CORPORA…
#> 10 Hospice  111531 1.75e9 1355… O200…     0 SOUTH G… HOSPIC… 1986-07-11 CORPORA…
#> 11 Hospice  111587 1.97e9 1052… O200…     0 BETHANY… AFFINI… 2007-06-16 LLC     
#> 12 Hospice  111632 1.60e9 0042… O200…     0 GRACE H… HEART … NA         LLC     
#> # ℹ 5 more variables: status <chr>, address <chr>, city <chr>, state <chr>,
#> #   zip <chr>
```
