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

## Examples

``` r
facility(count = TRUE)
#> facility Totals
#> • Rows  : 48,592
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
#> • FQHC    : 2
#> • SNF     : 4
#> • Hospice : 4
#> ℹ Retrieving 4 pages
#> Error in "\"id\" %in% names(args)": ! Could not evaluate cli `{}` expression: `x@pages`.
#> Caused by error in `eval(expr, envir = envir)`:
#> ! object 'x' not found
#> ✖ Retrieving 4 pages [1.2s]
#> 
```
