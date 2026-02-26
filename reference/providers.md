# Provider Enrollment in Medicare

Access enrollment level data on individual and organizational providers
that are actively approved to bill Medicare.

## Usage

``` r
providers(
  npi = NULL,
  pac = NULL,
  enid = NULL,
  specialty_code = NULL,
  specialty_description = NULL,
  first = NULL,
  middle = NULL,
  last = NULL,
  organization = NULL,
  state = NULL,
  gender = NULL,
  tidy = TRUE,
  na.rm = TRUE,
  ...
)
```

## Arguments

- npi:

  \< *integer* \> 10-digit Individual National Provider Identifier

- pac:

  \< *integer* \> 10-digit PECOS Associate Control ID

- enid:

  \< *character* \> 15-digit Medicare Enrollment ID

- specialty_code:

  \< *character* \> Enrollment specialty code

- specialty_description:

  \< *character* \> Enrollment specialty description

- first, middle, last:

  \< *character* \> Individual provider's name

- organization:

  \< *character* \> Organizational provider's name

- state:

  \< *character* \> Enrollment state, full or abbreviation

- gender:

  \< *character* \> Individual provider's gender: `"F"` (Female), `"M"`
  (Male), `"9"` (Unknown/Organization)

- tidy:

  \< *boolean* \> // **default:** `TRUE` Tidy output

- na.rm:

  \< *boolean* \> // **default:** `TRUE` Remove empty rows and columns

- ...:

  Empty

## Value

[tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
with the columns:

|                         |                                        |
|-------------------------|----------------------------------------|
| **Field**               | **Description**                        |
| `npi`                   | 10-digit NPI                           |
| `pac`                   | 10-digit PAC ID                        |
| `enid`                  | 15-digit provider enrollment ID        |
| `specialty_code`        | Enrollment primary specialty type code |
| `specialty_description` | Enrollment specialty type description  |
| `first`                 | Individual provider's first name       |
| `middle`                | Individual provider's middle name      |
| `last`                  | Individual provider's last name        |
| `organization`          | Organizational provider's name         |
| `state`                 | Enrollment state                       |
| `gender`                | Individual provider's gender           |

## Links

- [Provider Enrollment
  API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/medicare-fee-for-service-public-provider-enrollment)

- [Provider Enrollment Data
  Dictionary](https://data.cms.gov/resources/medicare-fee-for-service-public-provider-enrollment-data-dictionary)

*Update Frequency:* **Quarterly**

## Examples

``` r
if (FALSE) { # interactive()
providers(enid = "I20040309000221")
providers(npi = 1417918293, specialty_code = "14-41")
providers(pac = 2860305554, gender = "9")
}
```
