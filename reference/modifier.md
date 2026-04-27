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

- x:

  input

- y:

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
list(
   `excludes(c("AL", "AK", "AZ"))` = excludes(c("AL", "AK", "AZ")),
   `ends("bar")` = ends("bar"),
   `starts("foo")` = starts("foo"),
   `less(1000)` = less(1000),
   `less(0.125, equal = TRUE)` = less(0.125, equal = TRUE),
   `greater(1000)` = greater(1000),
   `greater(0.125, equal = TRUE)` = greater(0.125, equal = TRUE),
   `between(0.125, 2)` = between(0.125, 2),
   `contains("baz")` = contains("baz"),
   `not("zzz")` = not("zzz"),
   `not_blank()` = not_blank(),
   `is_blank()` = is_blank()
 )
#> $`excludes(c("AL", "AK", "AZ"))`
#> ══ <modifier[3]> ═══
#> Operator: NOT+IN
#> Values: AL, AK, AZ
#> 
#> $`ends("bar")`
#> ══ <modifier[1]> ═══
#> Operator: ENDS WITH
#> Value: bar
#> 
#> $`starts("foo")`
#> ══ <modifier[1]> ═══
#> Operator: STARTS WITH
#> Value: foo
#> 
#> $`less(1000)`
#> ══ <modifier[1]> ═══
#> Operator: <
#> Value: 1000
#> 
#> $`less(0.125, equal = TRUE)`
#> ══ <modifier[1]> ═══
#> Operator: <=
#> Value: 0.125
#> 
#> $`greater(1000)`
#> ══ <modifier[1]> ═══
#> Operator: >
#> Value: 1000
#> 
#> $`greater(0.125, equal = TRUE)`
#> ══ <modifier[1]> ═══
#> Operator: >=
#> Value: 0.125
#> 
#> $`between(0.125, 2)`
#> ══ <modifier[2]> ═══
#> Operator: BETWEEN
#> Values: 0.125, 2
#> 
#> $`contains("baz")`
#> ══ <modifier[1]> ═══
#> Operator: CONTAINS
#> Value: baz
#> 
#> $`not("zzz")`
#> ══ <modifier[1]> ═══
#> Operator: <>
#> Value: zzz
#> 
#> $`not_blank()`
#> ══ <modifier[1]> ═══
#> Operator: <>
#> Value: ""
#> 
#> $`is_blank()`
#> ══ <modifier[1]> ═══
#> Operator: =
#> Value: ""
#> 
```
