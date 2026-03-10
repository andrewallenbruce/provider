# A variety of different query operators

Helpers for use in constructing conditions in queries.

## Usage

``` r
greater_than(x, or_equal = FALSE)

less_than(x, or_equal = FALSE)

between(x, negate = FALSE)

starts_with(x)

ends_with(x)

contains(x)

equal(x)

not_equal(x)

any_of(x)

none_of(x)
```

## Arguments

- x:

  input

- or_equal:

  `<lgl>` append `=` to `greater_than()`/`less_than()`

- negate:

  `<lgl>` prepend `NOT` to `between()`

## Value

An object of class `<modifier>`

## Details

Query modifiers are a small DSL for use in constructing query
conditions, in the
[JSON-API](https://www.drupal.org/docs/core-modules-and-themes/core-modules/jsonapi-module/filtering)
format.

## Examples

``` r
greater_than(1000)
#> <modifier>
#> Operator: >
#> Value: 1000
greater_than(0.125, or_equal = TRUE)
#> <modifier>
#> Operator: >=
#> Value: 0.125
less_than(1000)
#> <modifier>
#> Operator: <
#> Value: 1000
less_than(0.125, or_equal = TRUE)
#> <modifier>
#> Operator: <=
#> Value: 0.125
between(c(1000, 1100))
#> <modifier>
#> Operator: BETWEEN
#> Values: 1000 and 1100
between(c(0.125, 2), negate = TRUE)
#> <modifier>
#> Operator: NOT+BETWEEN
#> Values: 0.125 and 2
starts_with("foo")
#> <modifier>
#> Operator: STARTS_WITH
#> Value: foo
ends_with("bar")
#> <modifier>
#> Operator: ENDS_WITH
#> Value: bar
contains("baz")
#> <modifier>
#> Operator: CONTAINS
#> Value: baz
equal(1000)
#> <modifier>
#> Operator: =
#> Value: 1000
not_equal(1000)
#> <modifier>
#> Operator: <>
#> Value: 1000
any_of(state.abb[10:15])
#> <modifier>
#> Operator: IN
#> Values: GA, HI, ID, IL, IN, and IA
none_of(state.abb[1:5])
#> <modifier>
#> Operator: NOT+IN
#> Values: AL, AK, AZ, AR, and CA
```
