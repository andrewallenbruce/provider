# A variety of different query operators

Helpers for use in constructing conditions in queries.

## Usage

``` r
excludes(...)

between(...)

contains(x)

not(x)

not_blank()

is_blank()

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
   `not_blank()` = not_blank(),
   `is_blank()` = is_blank()
 )
#> $`excludes("AL", "AK", "AZ")`
#> ══ <modifier[3]> ═════
#> Operator: NOT+IN
#> Values: AL, AK, AZ
#> 
#> $`ends_with("bar")`
#> ══ <modifier[1]> ═════
#> Operator: ENDS WITH
#> Value: bar
#> 
#> $`starts_with("foo")`
#> ══ <modifier[1]> ═════
#> Operator: STARTS WITH
#> Value: foo
#> 
#> $`less_than(1000)`
#> ══ <modifier[1]> ═════
#> Operator: <
#> Value: 1000
#> 
#> $`less_than(0.125, equal = TRUE)`
#> ══ <modifier[1]> ═════
#> Operator: <=
#> Value: 0.125
#> 
#> $`greater_than(1000)`
#> ══ <modifier[1]> ═════
#> Operator: >
#> Value: 1000
#> 
#> $`greater_than(0.125, equal = TRUE)`
#> ══ <modifier[1]> ═════
#> Operator: >=
#> Value: 0.125
#> 
#> $`between(0.125, 2)`
#> ══ <modifier[2]> ═════
#> Operator: BETWEEN
#> Values: 0.125, 2
#> 
#> $`contains("baz")`
#> ══ <modifier[1]> ═════
#> Operator: CONTAINS
#> Value: baz
#> 
#> $`not("zzz")`
#> ══ <modifier[1]> ═════
#> Operator: <>
#> Value: zzz
#> 
#> $`not_blank()`
#> ══ <modifier[1]> ═════
#> Operator: <>
#> Value: ""
#> 
#> $`is_blank()`
#> ══ <modifier[1]> ═════
#> Operator: =
#> Value: ""
#> 
```
