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

  - `hha` = Home Health Agency

  - `rhc` = Rural Health Clinic

  - `fqhc` = Federally Qualified Health Clinic

  - `snf` = Skilled Nursing Facility

  - `hospice` = Hospice

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

## Examples

``` r
facility(count = TRUE)
#> facility Totals
#> • Rows  : 48,593
#> • Pages : 13    
#> 

facility(state = c("GA", "FL"), count = TRUE)
#> ✔ facility returned 3,517 results.
#> • HHA     : 1,173
#> • RHC     : 220  
#> • FQHC    : 768  
#> • SNF     : 1,044
#> • Hospice : 312  

facility(city = "Valdosta", state = "GA")
#> ✔ facility returned 12 results.
#> • HHA     : 2
#> • RHC     : 0
#> • FQHC    : 2
#> • SNF     : 4
#> • Hospice : 4
#> ℹ Retrieving 5 pages...
#> # A tibble: 12 × 15
#>    fac_type enid      npi multi ccn   pac   org_name org_dba inc_date   org_type
#>    <chr>    <chr>   <int> <int> <chr> <chr> <chr>    <chr>   <date>     <chr>   
#>  1 Hospice  O2005… 1.06e9     0 1115… 2264… PRUITTH… PRUITT… 1993-10-14 CORPORA…
#>  2 Hospice  O2006… 1.75e9     0 1115… 1355… SOUTH G… HOSPIC… 1986-07-11 CORPORA…
#>  3 Hospice  O2007… 1.97e9     0 1115… 1052… BETHANY… AFFINI… 2007-06-16 LLC     
#>  4 Hospice  O2008… 1.60e9     0 1116… 0042… GRACE H… HEART … NA         LLC     
#>  5 HHA      O2012… 1.29e9     0 1170… 6002… PUBLIC … NA      1994-03-07 CORPORA…
#>  6 HHA      O2012… 1.11e9     0 1170… 3173… GHHS HE… GEORGI… NA         LLC     
#>  7 FQHC     O2018… 1.64e9     0 1110… 1951… SOUTH C… NORTHS… 1992-06-19 CORPORA…
#>  8 SNF      O2020… 1.06e9     0 1153… 9032… PRUITTH… PRUITT… NA         LLC     
#>  9 SNF      O2021… 1.88e9     0 1153… 8022… PRUITTH… PRUITT… 2020-04-22 LLC     
#> 10 SNF      O2021… 1.77e9     0 1153… 1456… PRUITTH… PRUITT… 2020-04-22 LLC     
#> 11 SNF      O2021… 1.97e9     0 1155… 7416… PRUITTH… PRUITT… 2020-04-22 LLC     
#> 12 FQHC     O2024… 1.47e9     0 C210… 1951… SOUTH C… SOUTH … 2024-02-01 CORPORA…
#> # ℹ 5 more variables: status <chr>, address <chr>, city <chr>, state <chr>,
#> #   zip <chr>
```
