# Dialysis Facilities

A list of all dialysis facilities registered with Medicare that includes
addresses and phone numbers, as well as services and quality of care
provided.

## Usage

``` r
dialysis(
  ccn = NULL,
  fac_name = NULL,
  org_name = NULL,
  rating = NULL,
  network = NULL,
  status = NULL,
  address = NULL,
  city = NULL,
  state = NULL,
  zip = NULL,
  county = NULL,
  count = FALSE
)
```

## Source

- [API: Dialysis Facility - Listing by
  Facility](https://data.cms.gov/provider-data/dataset/23ew-n7w9)

## Arguments

- ccn:

  `<chr>` Facility CMS Certification Number

- fac_name:

  `<chr>` Facility name

- org_name:

  `<chr>` Name of the chain organization the facility is owned/managed
  by

- rating:

  `<int>` Facility's Quality of Care star rating; (1-5)

- network:

  `<int>` Numeric code for the network the facility participates in;
  (1-18)

- status:

  `<enum>` `Non-profit` or `Profit`

- address, city, state, zip, county:

  `<chr>` Facility's city, state, zip, county

- count:

  `<lgl>` Return the total row count

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble-package.html)
containing the search results.

## Examples

``` r
dialysis(count = TRUE)
#> Error in httr2::req_perform(httr2::request(flatten_pdc(S7::prop(x, "url"),     S7::prop(x, "query"), results = "false"))): HTTP 503 Service Unavailable.
dialysis(org_name = "DaVita", state = "GA")
#> Error in httr2::req_perform(httr2::request(flatten_pdc(S7::prop(x, "url"),     S7::prop(x, "query"), results = "false"))): HTTP 503 Service Unavailable.
```
