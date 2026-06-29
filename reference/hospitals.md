# Hospitals Enrolled in Medicare

Hospitals currently enrolled in Medicare. Data includes the hospital's
sub-group types, legal business name, doing-business-as name,
organization type and address.

A list of all hospitals that have been registered with Medicare. The
list includes addresses, phone numbers, hospital type, and overall
hospital rating.

## Usage

``` r
hospitals(
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
  count = FALSE
)

hospitals2(
  ccn = NULL,
  org_name = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  county = NULL,
  hosp_type = NULL,
  own_type = NULL,
  rating = NULL,
  count = FALSE
)
```

## Source

- [API: Hospital
  Enrollments](https://data.cms.gov/provider-characteristics/hospitals-and-other-facilities/hospital-enrollments)

&nbsp;

- [API: Hospital General
  Information](https://data.cms.gov/provider-data/dataset/27ea-46a8)

- [API: Data
  Dictionary](https://data.cms.gov/provider-data/dataset/xubh-q36u#data-dictionary)

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

  - `other` = Other

  - `llc` = LLC

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

- county:

  `<chr>` Location county

- hosp_type:

  `<enum>` Provider type:

  - `acute` = Acute Care

  - `cah` = Critical Access Hospital

  - `child` = Childrens' Hospital

  - `dod` = Acute Care - Department of Defense

  - `ltc` = Long-term

  - `psych` = Psychiatric

  - `reh` = Rural Emergency Hospital

  - `vha` = Acute Care - Veterans Administration

- own_type:

  `<enum>` Ownership type:

  - `private` = Voluntary non-profit - Private

  - `other` = Voluntary non-profit - Other

  - `church` = Voluntary non-profit - Church

  - `district` = Government - Hospital District or Authority

  - `local` = Government - Local

  - `federal` = Government - Federal

  - `state` = Government - State

  - `dod` = Department of Defense

  - `profit` = Proprietary

  - `physician` = Physician

  - `tribal` = Tribal

  - `vha` = Veterans Health Administration

- rating:

  `<int>` Hospital rating; 1-5 or "Not Available"

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
containing the search results.

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
containing the search results.

## Examples

``` r
hospitals(count = TRUE)
#> ◼ hospitals | 9,175 rows | 2 pages

hospitals(prov_type = "cah", state = "GA")
#> ✔ hospitals returned 65 results
#> ✔ Retrieving 1 page
#> ✔ hospitals2 returned 31 results
#> ✔ Retrieving 1 page
#> # A tibble: 65 × 18
#>    org_name    org_dba enid     npi multi ccn   pac   inc_date   org_type status
#>    <chr>       <chr>   <chr>  <int> <int> <chr> <chr> <date>     <chr>    <chr> 
#>  1 BROOKS COU… ARCHBO… O200… 1.58e9     0 11Z3… 1557… NA         Other: … Non-P…
#>  2 HOSPITAL A… ARCHBO… O200… 1.70e9     0 1113… 6002… NA         Other: … Gover…
#>  3 HOSPITAL A… ARCHBO… O200… 1.44e9     0 11Z3… 6002… NA         Other: … Non-P…
#>  4 PUTNAM GEN… PUTNAM… O200… 1.39e9     0 1113… 4688… 1968-03-01 Other: … Gover…
#>  5 PUTNAM GEN… PUTNAM… O200… 1.55e9     0 11Z3… 4688… 1968-03-01 Other: … For-P…
#>  6 THE HOSPIT… MILLER… O200… 1.11e9     0 1113… 0244… NA         Other: … Gover…
#>  7 THE HOSPIT… MILLER… O200… 1.29e9     0 11Z3… 0244… NA         Other: … Non-P…
#>  8 PROFESSION… MOUNTA… O200… 1.33e9     0 1113… 1052… 2004-12-17 LLC      Propr…
#>  9 HOSPITAL A… WILLS … O200… 1.62e9     0 1113… 8628… NA         Other: … Gover…
#> 10 HOSPITAL A… WILLS … O200… 1.48e9     0 11Z3… 8628… NA         Other: … Non-P…
#> # ℹ 55 more rows
#> # ℹ 8 more variables: address <chr>, city <chr>, state <chr>, zip <chr>,
#> #   loc_type <chr>, sub_group <chr>, rating <int>, county <chr>

hospitals(
  city = "Atlanta",
  state = "GA",
  subgroup = subgroups(acute = FALSE)
)
#> ✔ hospitals returned 12 results
#> ✔ Retrieving 1 page
#> ✔ hospitals2 returned 5 results
#> ✔ Retrieving 1 page
#> # A tibble: 12 × 18
#>    org_name    org_dba enid     npi multi ccn   pac   inc_date   org_type status
#>    <chr>       <chr>   <chr>  <int> <int> <chr> <chr> <date>     <chr>    <chr> 
#>  1 SCOTTISH R… CHILDR… O200… 1.92e9     0 1133… 4981… 1915-04-10 Corpora… Volun…
#>  2 PIEDMONT H… NA      O200… 1.96e9     0 1100… 8628… 1940-06-26 Corpora… Gover…
#>  3 EMORY UNIV… EMORY … O200… 1.44e9     1 11S0… 3173… 1994-03-04 Corpora… Non-P…
#>  4 EMORY UNIV… EMORY … O200… 1.36e9     1 11T0… 3173… 1994-03-04 Corpora… Non-P…
#>  5 ARTHUR M. … NA      O200… 1.69e9     0 1133… 2567… 1943-09-18 Corpora… Volun…
#>  6 GRADY MEMO… GRADY … O200… 1.63e9     0 11S0… 7517… 2007-12-21 Corpora… Non-P…
#>  7 UHS OF ANC… ANCHOR… O201… 1.02e9     1 1140… 4486… 2000-06-02 Partner… Gover…
#>  8 UHS OF PEA… PEACHF… O201… 1.09e9     0 1140… 9234… 2000-06-02 Partner… Propr…
#>  9 SHEPHERD C… NA      O201… 1.04e9     0 1120… 1052… 1975-04-21 Corpora… Non-P…
#> 10 ES REHABIL… EMORY … O201… 1.55e9     0 1130… 1254… 2013-10-15 LLC      For-P…
#> 11 SELECT SPE… SELECT… O201… 1.24e9     0 1120… 6305… NA         LLC      For-P…
#> 12 REHABILITA… REHABI… O202… 1.54e9     0 1130… 5698… 2020-10-16 LLC      For-P…
#> # ℹ 8 more variables: address <chr>, city <chr>, state <chr>, zip <chr>,
#> #   loc_type <chr>, sub_group <chr>, rating <int>, county <chr>
```
