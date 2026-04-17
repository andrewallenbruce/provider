# A variety of different query operators

Helpers for use in constructing conditions in queries.

## Usage

``` r
excludes(...)

between(...)

contains(x)

not(x)

not_na()

na()

greater_than(x, equal = FALSE)

less_than(x, equal = FALSE)

starts_with(x)

ends_with(x)
```

## Source

[JSON-API: Query
Parameters](https://jsonapi.org/format/#query-parameters)

## Arguments

- ...:

  input

- x:

  input

- equal:

  `<lgl>` append `=` to `less_than()` or `greater_than()`

## Value

An S7 `<Modifier>` object.

## Details

Query modifiers are a small DSL for use in constructing query
conditions, in the
[JSON-API](https://www.drupal.org/docs/core-modules-and-themes/core-modules/jsonapi-module/filtering)
format.

## Examples

``` r
list(
   `excludes("AL", "AK", "AZ")` = excludes("AL", "AK", "AZ"),
   `ends_with("bar")` = ends_with("bar"),
   `starts_with("foo")` = starts_with("foo"),
   `less_than(1000)` = less_than(1000),
   `less_than(0.125, equal = TRUE)` = less_than(0.125, equal = TRUE),
   `greater_than(1000)` = greater_than(1000),
   `greater_than(0.125, equal = TRUE)` = greater_than(0.125, equal = TRUE),
   `between(0.125, 2)` = between(0.125, 2),
   `contains("baz")` = contains("baz"),
   `not("zzz")` = not("zzz"),
   `not_na()` = not_na(),
   `na()` = na()
 )
#> $`excludes("AL", "AK", "AZ")`
#> <modifier>
#> Operator: NOT+IN
#> Values: AL, AK, AZ
#> 
#> $`ends_with("bar")`
#> <modifier>
#> Operator: ENDS WITH
#> Value: bar
#> 
#> $`starts_with("foo")`
#> <modifier>
#> Operator: STARTS WITH
#> Value: foo
#> 
#> $`less_than(1000)`
#> <modifier>
#> Operator: <
#> Value: 1000
#> 
#> $`less_than(0.125, equal = TRUE)`
#> <modifier>
#> Operator: <=
#> Value: 0.125
#> 
#> $`greater_than(1000)`
#> <modifier>
#> Operator: >
#> Value: 1000
#> 
#> $`greater_than(0.125, equal = TRUE)`
#> <modifier>
#> Operator: >=
#> Value: 0.125
#> 
#> $`between(0.125, 2)`
#> <modifier>
#> Operator: BETWEEN
#> Values: 0.125, 2
#> 
#> $`contains("baz")`
#> <modifier>
#> Operator: CONTAINS
#> Value: baz
#> 
#> $`not("zzz")`
#> <modifier>
#> Operator: <>
#> Value: zzz
#> 
#> $`not_na()`
#> <modifier>
#> Operator: <>
#> Value: ""
#> 
#> $`na()`
#> <modifier>
#> Operator: =
#> Value: ""
#> 
```
