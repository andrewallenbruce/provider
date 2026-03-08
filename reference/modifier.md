# Query Modifiers

Helpers for use in constructing conditions in queries.

## Usage

``` r
new_modifier(operator, value)

is_modifier(x)

greater_than(x, or_equal = FALSE)

less_than(x, or_equal = FALSE)

between(x, y, negate = FALSE)

starts_with(x)

ends_with(x)

contains(x)

equals(x, negate = FALSE)

any_of(x, negate = FALSE)
```

## Arguments

- operator:

  input

- value:

  input

- x, y:

  input

- or_equal:

  `<lgl>` append `=`

- negate:

  `<lgl>` prepend `NOT`

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
#> Values: 1000
greater_than(0.125, or_equal = TRUE)
#> <modifier>
#> Operator: >=
#> Values: 0.125
less_than(1000)
#> <modifier>
#> Operator: <
#> Values: 1000
less_than(0.125, or_equal = TRUE)
#> <modifier>
#> Operator: <=
#> Values: 0.125
between(1000, 1100)
#> <modifier>
#> Operator: BETWEEN
#> Values: 1000 and 1100
between(0.125, 2, negate = TRUE)
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
equals(1000)
#> <modifier>
#> Operator: =
#> Values: 1000
equals(1000, negate = TRUE)
#> <modifier>
#> Operator: <>
#> Values: 1000
any_of(state.abb[10:15])
#> <modifier>
#> Operator: IN
#> Values: GA, HI, ID, IL, IN, and IA
any_of(state.abb[10:15], negate = TRUE)
#> <modifier>
#> Operator: NOT+IN
#> Values: GA, HI, ID, IL, IN, and IA
```
