# Clinicians Enrolled in Medicare

Access information about providers enrolled in Medicare, including the
medical school that they attended and the year they graduated

*Update Frequency:* **Monthly**

## Usage

``` r
clinicians(
  npi = NULL,
  pac = NULL,
  enid = NULL,
  first = NULL,
  middle = NULL,
  last = NULL,
  gender = NULL,
  credential = NULL,
  school = NULL,
  grad_year = NULL,
  specialty = NULL,
  facility_name = NULL,
  pac_org = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  offset = 0L,
  tidy = TRUE,
  na.rm = TRUE,
  ...
)
```

## Arguments

- npi:

  \< *integer* \> 10-digit Individual National Provider Identifier

- pac:

  \< *integer* \> 10-digit Individual PECOS Associate Control ID

- enid:

  \< *character* \> 15-digit Individual Medicare Enrollment ID

- first, middle, last:

  \< *character* \> Individual provider's name

- gender:

  \< *character* \> Individual provider's gender; `"F"` (Female) or
  `"M"` (Male)

- credential:

  Individual provider’s credential

- school:

  \< *character* \> Individual provider’s medical school

- grad_year:

  \< *integer* \> Individual provider’s graduation year

- specialty:

  \< *character* \> Individual provider’s primary medical specialty
  reported in the selected enrollment

- facility_name:

  \< *character* \> Name of facility associated with the individual
  provider

- pac_org:

  \< *integer* \> 10-digit Organizational PECOS Associate Control ID

- city:

  \< *character* \> Provider's city

- state:

  \< *character* \> Provider's state

- zip:

  \< *character* \> Provider's ZIP code

- offset:

  \< *integer* \> // **default:** `0L` API pagination

- tidy:

  \< *boolean* \> // **default:** `TRUE` Tidy output

- na.rm:

  \< *boolean* \> // **default:** `TRUE` Remove empty rows and columns

- ...:

  Empty

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
with the columns:

|                 |                                                       |
|-----------------|-------------------------------------------------------|
| **Field**       | **Description**                                       |
| `npi`           | 10-digit individual NPI                               |
| `pac`           | 10-digit individual PAC ID                            |
| `enid`          | 15-digit individual enrollment ID                     |
| `first`         | Provider's first name                                 |
| `middle`        | Provider's middle name                                |
| `last`          | Provider's last name                                  |
| `suffix`        | Provider's name suffix                                |
| `gender`        | Provider's gender                                     |
| `credential`    | Provider's credential                                 |
| `school`        | Provider's medical school                             |
| `grad_year`     | Provider's graduation year                            |
| `specialty`     | Provider's primary specialty                          |
| `specialty_sec` | Provider's secondary specialty                        |
| `facility_name` | Facility associated with provider                     |
| `pac_org`       | Facility's 10-digit PAC ID                            |
| `members`       | Number of providers associated with facility's PAC ID |
| `address`       | Provider's street address                             |
| `city`          | Provider's city                                       |
| `state`         | Provider's state                                      |
| `zip`           | Provider's zip code                                   |
| `phone`         | Provider's phone number                               |
| `telehealth`    | Indicates if provider offers telehealth services      |
| `assign_ind`    | Indicates if provider accepts Medicare assignment     |
| `assign_org`    | Indicates if facility accepts Medicare assignment     |

## Links

- [National Downloadable
  File](https://data.cms.gov/provider-data/dataset/mj5m-pzi6)

- [Provider Data Catalog (PDC) Data
  Dictionary](https://data.cms.gov/provider-data/sites/default/files/data_dictionaries/physician/DOC_Data_Dictionary.pdf)

## Examples

``` r
if (FALSE) { # interactive()
clinicians(enid = "I20081002000549") # enid not working

clinicians(school = "NEW YORK UNIVERSITY SCHOOL OF MEDICINE")
}
```
