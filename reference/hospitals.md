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
  count = FALSE,
  set = FALSE
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
  count = FALSE,
  set = FALSE
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

  `<chr>` Medicare Enrollment ID, Enrollment state

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

- set:

  `<lgl>` Return the entire dataset

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

## Examples

``` r
hospitals(prov_type = "reh", count = TRUE)
#> ✔ hospitals returned 48 results

hospitals2(hosp_type = "reh", count = TRUE)
#> ✔ hospitals2 returned 41 results

x <- subgroups(acute = FALSE, psych = TRUE)

hospitals(city = "Atlanta", state = "GA", subgroup = x)
#> ✔ hospitals returned 2 results
#> # A tibble: 2 × 16
#>   org_name     org_dba enid     npi multi ccn   pac   inc_date   org_type status
#> * <chr>        <chr>   <chr>  <int> <int> <chr> <chr> <date>     <chr>    <chr> 
#> 1 UHS OF ANCH… ANCHOR… O201… 1.02e9     1 1140… 4486… 2000-06-02 Partner… For-P…
#> 2 UHS OF PEAC… PEACHF… O201… 1.09e9     0 1140… 9234… 2000-06-02 Partner… For-P…
#> # ℹ 6 more variables: address <chr>, city <chr>, state <chr>, zip <chr>,
#> #   loc_type <chr>, sub_group <chr>

hospitals2(ccn = hospitals()$ccn)
#> ✔ Returning first 10 rows
#> ✔ hospitals2 returned 9 results
#> # A tibble: 9 × 10
#>   ccn    org_name       prov_type status rating address city  state zip   county
#>   <chr>  <chr>          <chr>     <chr>   <int> <chr>   <chr> <chr> <chr> <chr> 
#> 1 030107 ARIZONA SPINE… Acute Ca… Physi…     NA 4620 E… MESA  AZ    85206 MARIC…
#> 2 040004 WASHINGTON RE… Acute Ca… Volun…      4 3215 N… FAYE… AR    72703 WASHI…
#> 3 160117 FINLEY HOSPIT… Acute Ca… Volun…      3 350 NO… DUBU… IA    52001 DUBUQ…
#> 4 200024 CENTRAL MAINE… Acute Ca… Volun…      4 300 MA… LEWI… ME    04240 ANDRO…
#> 5 220012 CAPE COD HOSP… Acute Ca… Volun…      2 27 PAR… HYAN… MA    02601 BARNS…
#> 6 220062 ADCARE HOSPIT… Acute Ca… Propr…     NA 107 LI… WORC… MA    01605 WORCE…
#> 7 330246 ST CHARLES HO… Acute Ca… Volun…      5 200 BE… PORT… NY    11777 SUFFO…
#> 8 351318 CARRINGTON HE… Critical… Volun…     NA PO BOX… CARR… ND    58421 FOSTER
#> 9 440058 SOUTHERN TENN… Acute Ca… Propr…      3 185 HO… WINC… TN    37398 FRANK…

hospitals(ccn = hospitals2()$ccn)
#> ✔ Returning first 10 rows
#> ✔ hospitals returned 9 results
#> # A tibble: 9 × 16
#>   org_name     org_dba enid     npi multi ccn   pac   inc_date   org_type status
#> * <chr>        <chr>   <chr>  <int> <int> <chr> <chr> <date>     <chr>    <chr> 
#> 1 HOUSTON COU… SOUTHE… O200… 1.16e9     0 0100… 9436… 1957-09-01 Corpora… Non-P…
#> 2 HH HEALTH S… MARSHA… O201… 1.41e9     0 0100… 8527… 2018-08-20 Other: … Non-P…
#> 3 RCHP - FLOR… NORTH … O201… 1.48e9     0 0100… 8123… 2010-04-28 LLC      For-P…
#> 4 MIZELL MEMO… NA      O200… 1.01e9     0 0100… 6507… 1945-11-26 Corpora… Non-P…
#> 5 ST. VINCENT… ST. VI… O200… 1.84e9     0 0100… 8921… 1968-07-22 Corpora… Non-P…
#> 6 HH HEALTH S… DEKALB… O202… 1.77e9     0 0100… 6709… NA         LLC      For-P…
#> 7 BBH SBMC, L… BAPTIS… O201… 1.81e9     0 0100… 7810… 2015-06-19 LLC      For-P…
#> 8 HH HEALTH S… HELEN … O201… 1.51e9     0 0100… 1759… 2014-11-14 LLC      Non-P…
#> 9 DALE MEDICA… NA      O200… 1.94e9     0 0100… 3476… 2007-03-20 Other: … Non-P…
#> # ℹ 6 more variables: address <chr>, city <chr>, state <chr>, zip <chr>,
#> #   loc_type <chr>, sub_group <chr>
```
