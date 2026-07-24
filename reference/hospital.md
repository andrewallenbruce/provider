# Hospitals Enrolled in Medicare

Hospitals currently enrolled in Medicare. Data includes the hospital's
sub-group types, legal business name, doing-business-as name,
organization type and address.

## Usage

``` r
hospital(
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
  prov_type = NULL,
  loc_type = NULL,
  subgroup = subgroups(),
  count = FALSE,
  chains = FALSE
)
```

## Source

- [API: Hospital
  Enrollments](https://data.cms.gov/provider-characteristics/hospitals-and-other-facilities/hospital-enrollments)

## Arguments

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

  `<lgl>` Does hospital have more than one NPI?

- status:

  `<enum>` Organization status

  - `P` = Proprietary

  - `N` = Non-Profit

- org_type:

  `<enum>` Organization structure type

  - `corp` = Corporation

  - `llc` = LLC

  - `other` = Other

  - `part` = Partnership

  - `sole` = Sole Proprietor

- prov_type:

  `<enum>` Provider type:

  - `hospital` = Medicare Part A Hospital

  - `reh` = Rural Emergency Hospital

  - `cah` = Critical Access Hospital

- loc_type:

  `<enum>` Practice location type

  - `main` = Main/Primary Hospital Location

  - `psych` = Hospital Psychiatric Unit

  - `rehab` = Hospital Rehabilitation Unit

  - `swing` = Hospital Swing-Bed Unit

  - `ext` = Opt Extension Site

  - `other` = Other Hospital Practice Location

- subgroup:

  `<subgroups>` Hospital’s subgroup/unit. See
  [`subgroups()`](https://andrewallenbruce.github.io/provider/reference/subgroups.md).

- count:

  `<lgl>` Return the total row count

- chains:

  `<lgl>` Add search chains

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
containing the search results.

## Examples

``` r
hospital(count = TRUE)
#> ◼ hospital | 9,175 rows | 2 pages

hospital(prov_type = "cah", state = "GA")
#> ✔ hospital returned 65 results
#> # A tibble: 65 × 16
#>    org_name    org_dba ccn      npi pac   enid  multi inc_date   org_type status
#>    <chr>       <chr>   <chr>  <int> <chr> <chr> <int> <date>     <chr>    <chr> 
#>  1 BROOKS COU… ARCHBO… 11Z3… 1.58e9 1557… O200…     0 NA         Other: … Non-P…
#>  2 HOSPITAL A… ARCHBO… 1113… 1.70e9 6002… O200…     0 NA         Other: … Non-P…
#>  3 HOSPITAL A… ARCHBO… 11Z3… 1.44e9 6002… O200…     0 NA         Other: … Non-P…
#>  4 PUTNAM GEN… PUTNAM… 1113… 1.39e9 4688… O200…     0 1968-03-01 Other: … Non-P…
#>  5 PUTNAM GEN… PUTNAM… 11Z3… 1.55e9 4688… O200…     0 1968-03-01 Other: … For-P…
#>  6 THE HOSPIT… MILLER… 1113… 1.11e9 0244… O200…     0 NA         Other: … Non-P…
#>  7 THE HOSPIT… MILLER… 11Z3… 1.29e9 0244… O200…     0 NA         Other: … Non-P…
#>  8 PROFESSION… MOUNTA… 1113… 1.33e9 1052… O200…     0 2004-12-17 LLC      For-P…
#>  9 HOSPITAL A… WILLS … 1113… 1.62e9 8628… O200…     0 NA         Other: … Non-P…
#> 10 HOSPITAL A… WILLS … 11Z3… 1.48e9 8628… O200…     0 NA         Other: … Non-P…
#> # ℹ 55 more rows
#> # ℹ 6 more variables: loc_type <chr>, address <chr>, city <chr>, state <chr>,
#> #   zip <chr>, sub_group <chr>

hospital(
  city = "Atlanta",
  state = "GA",
  subgroup = subgroups(acute = FALSE)
)
#> ✔ hospital returned 12 results
#> # A tibble: 12 × 16
#>    org_name    org_dba ccn      npi pac   enid  multi inc_date   org_type status
#>  * <chr>       <chr>   <chr>  <int> <chr> <chr> <int> <date>     <chr>    <chr> 
#>  1 SCOTTISH R… CHILDR… 1133… 1.92e9 4981… O200…     0 1915-04-10 Corp     Non-P…
#>  2 PIEDMONT H… NA      1100… 1.96e9 8628… O200…     0 1940-06-26 Corp     Non-P…
#>  3 EMORY UNIV… EMORY … 11S0… 1.44e9 3173… O200…     1 1994-03-04 Corp     Non-P…
#>  4 EMORY UNIV… EMORY … 11T0… 1.36e9 3173… O200…     1 1994-03-04 Corp     Non-P…
#>  5 ARTHUR M. … NA      1133… 1.69e9 2567… O200…     0 1943-09-18 Corp     Non-P…
#>  6 GRADY MEMO… GRADY … 11S0… 1.63e9 7517… O200…     0 2007-12-21 Corp     Non-P…
#>  7 UHS OF ANC… ANCHOR… 1140… 1.02e9 4486… O201…     1 2000-06-02 Partner… For-P…
#>  8 UHS OF PEA… PEACHF… 1140… 1.09e9 9234… O201…     0 2000-06-02 Partner… For-P…
#>  9 SHEPHERD C… NA      1120… 1.04e9 1052… O201…     0 1975-04-21 Corp     Non-P…
#> 10 ES REHABIL… EMORY … 1130… 1.55e9 1254… O201…     0 2013-10-15 LLC      For-P…
#> 11 SELECT SPE… SELECT… 1120… 1.24e9 6305… O201…     0 NA         LLC      For-P…
#> 12 REHABILITA… REHABI… 1130… 1.54e9 5698… O202…     0 2020-10-16 LLC      For-P…
#> # ℹ 6 more variables: loc_type <chr>, address <chr>, city <chr>, state <chr>,
#> #   zip <chr>, sub_group <chr>

hospital(ccn = ends("F"))
#> ✔ hospital returned 1 result
#> # A tibble: 1 × 16
#>   org_name     org_dba ccn      npi pac   enid  multi inc_date org_type   status
#> * <chr>        <chr>   <chr>  <int> <chr> <chr> <int> <date>   <chr>      <chr> 
#> 1 BROOKE ARMY… NA      4506… 1.92e9 4587… O200…     0 NA       Other: DE… Non-P…
#> # ℹ 6 more variables: loc_type <chr>, address <chr>, city <chr>, state <chr>,
#> #   zip <chr>, sub_group <chr>
hospital(ccn = ends("E"))
#> ✔ hospital returned 2 results
#> # A tibble: 2 × 16
#>   org_name     org_dba ccn      npi pac   enid  multi inc_date org_type   status
#> * <chr>        <chr>   <chr>  <int> <chr> <chr> <int> <date>   <chr>      <chr> 
#> 1 DEPARTMENT … PATTON… 0512… 1.04e9 9638… O200…     0 NA       Other: ST… Non-P…
#> 2 DEPARTMENT … ATASCA… 0512… 1.17e9 9638… O200…     0 NA       Other: FE… Non-P…
#> # ℹ 6 more variables: loc_type <chr>, address <chr>, city <chr>, state <chr>,
#> #   zip <chr>, sub_group <chr>
```
