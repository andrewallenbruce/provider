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
#> ✔ Retrieving 1 page
#> Error in collapse::recode_char(x[["sub_group"]], sub_acute = "Acute",     sub_gen = "General", sub_spec = "Specialty", sub_adu = "ADH",     sub_child = "Children's", sub_ltc = "Long-Term", sub_psy = "Psychiatric",     sub_irf = "IRF", sub_stc = "Short-Term", sub_sba = "Swing-Bed Unit",     sub_psu = "Psychiatric Unit", sub_iru = "Rehab Unit", sub_oth = "Other",     default = NA_character_, set = TRUE): X needs to be character or a list

hospitals2(ccn = hospitals()$ccn)
#> ✔ Returning first 10 rows
#> Error in collapse::recode_char(x[["sub_group"]], sub_acute = "Acute",     sub_gen = "General", sub_spec = "Specialty", sub_adu = "ADH",     sub_child = "Children's", sub_ltc = "Long-Term", sub_psy = "Psychiatric",     sub_irf = "IRF", sub_stc = "Short-Term", sub_sba = "Swing-Bed Unit",     sub_psu = "Psychiatric Unit", sub_iru = "Rehab Unit", sub_oth = "Other",     default = NA_character_, set = TRUE): X needs to be character or a list

hospitals(ccn = hospitals2()$ccn)
#> ✔ Returning first 10 rows
#> ✔ hospitals returned 9 results
#> ✔ Retrieving 1 page
#> Error in collapse::recode_char(x[["sub_group"]], sub_acute = "Acute",     sub_gen = "General", sub_spec = "Specialty", sub_adu = "ADH",     sub_child = "Children's", sub_ltc = "Long-Term", sub_psy = "Psychiatric",     sub_irf = "IRF", sub_stc = "Short-Term", sub_sba = "Swing-Bed Unit",     sub_psu = "Psychiatric Unit", sub_iru = "Rehab Unit", sub_oth = "Other",     default = NA_character_, set = TRUE): X needs to be character or a list
```
