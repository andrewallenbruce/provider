# A variety of different query operators

Helpers for use in constructing conditions in queries.

## Usage

``` r
excludes(x)

between(x, y)

contains(x)

not(x)

not_blank()

is_blank()

greater(x, equal = FALSE)

less(x, equal = FALSE)

starts(x)

ends(x)
```

## Source

[JSON-API: Query
Parameters](https://jsonapi.org/format/#query-parameters)

## Arguments

- x, y:

  input

- equal:

  `<lgl>` append `=` to `less()` or `greater()`

## Value

An S7 `<Modifier>` object.

## Details

Query modifiers are a small DSL for use in constructing query
conditions, in the
[JSON-API](https://www.drupal.org/docs/core-modules-and-themes/core-modules/jsonapi-module/filtering)
format.

## Examples

``` r
excludes(c("AL", "AK", "AZ"))
#> <modifier[3]>
#> Alias: eval
#> Operator: NOT+IN
#> Values: AL, AK, AZ

ends("bar")
#> <modifier[1]>
#> Alias: eval
#> Operator: ENDS WITH
#> Value: bar

starts("foo")
#> <modifier[1]>
#> Alias: eval
#> Operator: STARTS WITH
#> Value: foo

contains("baz")
#> <modifier[1]>
#> Alias: eval
#> Operator: CONTAINS
#> Value: baz

not("zzz")
#> <modifier[1]>
#> Alias: eval
#> Operator: <>
#> Value: zzz

less(1000)
#> <modifier[1]>
#> Alias: eval
#> Operator: <
#> Value: 1000

less(0.125, equal = TRUE)
#> <modifier[1]>
#> Alias: eval
#> Operator: <=
#> Value: 0.125

greater(1000)
#> <modifier[1]>
#> Alias: eval
#> Operator: >
#> Value: 1000

greater(0.125, equal = TRUE)
#> <modifier[1]>
#> Alias: eval
#> Operator: >=
#> Value: 0.125

between(0.125, 2)
#> <modifier[2]>
#> Alias: eval
#> Operator: BETWEEN
#> Values: 0.125, 2

not_blank()
#> <modifier[1]>
#> Alias: not_blank
#> Operator: <>
#> Value: ""

is_blank()
#> <modifier[1]>
#> Alias: is_blank
#> Operator: =
#> Value: ""
```
