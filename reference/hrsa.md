# HRSA Facilities

Health Resources & Services Administration

## Usage

``` r
hrsa_items()

hrsa_layers()

hrsa_fields(facility)

hrsa_select(facility, ...)
```

## Source

[API:
HRSA](https://data.hrsa.gov/tools/web-services/registration#serviceInfo)

## Arguments

- facility:

  Facility type

- ...:

  arguments passed on to
  [`arcgislayers::arc_select()`](https://rdrr.io/pkg/arcgislayers/man/arc_select.html)

## Value

A list of endpoints.

## Details

Query modifiers are a small DSL for use in constructing query
conditions.

## Examples

``` r
if (FALSE) {
hrsa_items()
hrsa_layers()
hrsa_fields("snf_all")
}
```
