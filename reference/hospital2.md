# Hospital General Information

A list of all hospitals that have been registered with Medicare. The
list includes addresses, phone numbers, hospital type, and overall
hospital rating.

## Usage

``` r
hospital2(
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

- [API: Hospital General
  Information](https://data.cms.gov/provider-data/dataset/27ea-46a8)

- [API: Data
  Dictionary](https://data.cms.gov/provider-data/dataset/xubh-q36u#data-dictionary)

## Arguments

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

- count:

  `<lgl>` Return the total row count

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
containing the search results.
