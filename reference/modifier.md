# A variety of different query operators

Helpers for use in constructing conditions in queries.

## Usage

``` r
excludes(...)

contains(x)

not(x)

between(...)

greater_than(x, or_equal = FALSE)

less_than(x, or_equal = FALSE)

starts_with(x)

ends_with(x)
```

## Source

[JSON-API: Query
Parameters](https://jsonapi.org/format/#query-parameters)

## Arguments

- ...:

  parameter input

- x:

  parameter input

- or_equal:

  `<lgl>` append `=` to `greater_than()`/`less_than()`

## Value

An S7 `<Modifier>` object.

## Details

Query modifiers are a small DSL for use in constructing query
conditions, in the
[JSON-API](https://www.drupal.org/docs/core-modules-and-themes/core-modules/jsonapi-module/filtering)
format.

## Examples

``` r
params()
#> list()
x <- excludes(state.abb[1:5])
x
#> <Modifier>
#> Operator: NOT+IN
#> Values: AL, AK, AZ, AR, CA
operator(x)
#> Error in operator(x): could not find function "operator"
value(x)
#> Error in value(x): could not find function "value"
contains("baz")
#> <Modifier>
#> Operator: CONTAINS
#> Value: baz
not(1000)
#> <Modifier>
#> Operator: <>
#> Value: 1000
between(0.125, 2)
#> <Modifier>
#> Operator: BETWEEN
#> Values: 0.125, 2
greater_than(1000)
#> <Modifier>
#> Operator: >
#> Value: 1000
greater_than(0.125, or_equal = TRUE)
#> <Modifier>
#> Operator: >=
#> Value: 0.125
less_than(1000)
#> <Modifier>
#> Operator: <
#> Value: 1000
less_than(0.125, or_equal = TRUE)
#> <Modifier>
#> Operator: <=
#> Value: 0.125
starts_with("foo")
#> <Modifier>
#> Operator: STARTS WITH
#> Value: foo
ends_with("bar")
#> <Modifier>
#> Operator: ENDS WITH
#> Value: bar
```
