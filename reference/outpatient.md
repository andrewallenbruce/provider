# Outpatient Hospitals Enrolled in Medicare

Outpatient Hospitals Enrolled in Medicare

## Usage

``` r
outpatient(
  year,
  ccn = NULL,
  organization = NULL,
  street = NULL,
  city = NULL,
  state = NULL,
  fips = NULL,
  zip = NULL,
  ruca = NULL,
  apc = NULL,
  tidy = TRUE,
  na.rm = TRUE,
  ...
)
```

## Arguments

- year:

  \< *integer* \> // **required** Year data was reported, in `YYYY`
  format. Run
  [`out_years()`](https://andrewallenbruce.github.io/provider/reference/years.md)
  to return a vector of the years currently available.

- ccn:

  \< *integer* \> 6-digit CMS Certification Number

- organization:

  \< *character* \> Organization's name

- street:

  \< *character* \> Street where provider is located

- city:

  \< *character* \> City where provider is located

- state:

  \< *character* \> State where provider is located

- fips:

  \< *character* \> Provider's state FIPS code

- zip:

  \< *character* \> Provider’s zip code

- ruca:

  \< *character* \> Provider’s RUCA code

- apc:

  \< *character* \> comprehensive ambulatory payment classification code

- tidy:

  \< *boolean* \> // **default:** `TRUE` Tidy output

- na.rm:

  \< *boolean* \> // **default:** `TRUE` Remove empty rows and columns

- ...:

  Empty

## Note

State/FIP values are restricted to 49 of the United States and the
District of Columbia where hospitals are subjected to Medicare's
Outpatient Prospective Payment System (OPPS). Maryland and US territory
hospitals are excluded.

## Examples

``` r
if (FALSE) { # interactive()
outpatient(year = 2021, ccn = "110122")

outpatient(year = 2021, state = "GA")

out_years() |>
map(\(x) outpatient(year = x,
                    ccn = "110122")) |>
                    list_rbind()
}
```
