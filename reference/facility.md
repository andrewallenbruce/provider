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
#> ✔ facility returned 48,592 results.
#> • HHA     : 11,508
#> • RHC     : 5,530 
#> • FQHC    : 11,063
#> • SNF     : 14,425
#> • Hospice : 6,066 

facility(state = c("GA", "FL"), count = TRUE)
#> ✔ facility returned 3,517 results.
#> • HHA     : 1,173
#> • RHC     : 220  
#> • FQHC    : 768  
#> • SNF     : 1,044
#> • Hospice : 312  

# facility(city = "Valdosta", state = "GA")
```
