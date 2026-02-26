# Pending Medicare Enrollment Applications

Search for providers with pending Medicare enrollment applications.

## Usage

``` r
pending(
  type = c("P", "N"),
  npi = NULL,
  first = NULL,
  last = NULL,
  tidy = TRUE,
  ...
)
```

## Arguments

- type:

  \< `character` \> // **default:** `"P"`

  Physician (`P`) or Non-physician (`N`)

- npi:

  \< `integer` \>

  10-digit National Provider Identifier

- first, last:

  \< `character` \>

  Provider's name

- tidy:

  \< `boolean` \> // **default:** `TRUE`

  Tidy output

- ...:

  Empty

## Value

A
[`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html)
with the columns:

|           |                         |
|-----------|-------------------------|
| **Field** | **Description**         |
| `npi`     | 10-digit individual NPI |
| `first`   | Provider's first name   |
| `last`    | Provider's last name    |
| `type`    | Type of Provider        |

## Update Frequency

**QUARTERLY**

## References

- [Medicare Pending Initial Logging and Tracking Physicians
  API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/pending-initial-logging-and-tracking-physicians)

- [Medicare Pending Initial Logging and Tracking Non-Physicians
  API](https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/pending-initial-logging-and-tracking-non-physicians)

## Examples

``` r
if (FALSE) { # interactive()

pending(type = "P", first = "John")

pending(type = "N", last = "Smith")
}
```
