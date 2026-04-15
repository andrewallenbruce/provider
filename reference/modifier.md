# A variety of different query operators

Helpers for use in constructing conditions in queries.

## Usage

``` r
excludes(...)

contains(x)

not(x)

not_na(x)

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

  input

- x:

  input

- or_equal:

  `<lgl>` append `=`

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
   # !x %in% c("AL", "AK", "AZ")
   `ends_with("bar")` = ends_with("bar"),
   # endsWith(x, "bar")
   `starts_with("foo")` = starts_with("foo"),
   # startsWith(x, "foo")
   `less_than(1000)` = less_than(1000),
   # x < 1000
   `less_than(0.125, or_equal = TRUE)` = less_than(0.125, or_equal = TRUE),
   # x <= 1000
   `greater_than(1000)` = greater_than(1000),
   # x > 1000
   `greater_than(0.125, or_equal = TRUE)` = greater_than(0.125, or_equal = TRUE),
   # x >= 1000
   `between(0.125, 2)` = between(0.125, 2),
   # x > 0.125 & x < 2
   `contains("baz")` = contains("baz"),
   # grepl("baz", x)
   `not("zzz")` = not("zzz"),
   # x != "zzz"
   `not_na()` = not_na()
   # !is.na(x)
 )
#> $`excludes(c("AL", "AK", "AZ"))`
#> <Modifier>
#> Operator: NOT+IN
#> Values: AL, AK, AZ
#> 
#> $`ends_with("bar")`
#> <Modifier>
#> Operator: ENDS WITH
#> Value: bar
#> 
#> $`starts_with("foo")`
#> <Modifier>
#> Operator: STARTS WITH
#> Value: foo
#> 
#> $`less_than(1000)`
#> <Modifier>
#> Operator: <
#> Value: 1000
#> 
#> $`less_than(0.125, or_equal = TRUE)`
#> <Modifier>
#> Operator: <=
#> Value: 0.125
#> 
#> $`greater_than(1000)`
#> <Modifier>
#> Operator: >
#> Value: 1000
#> 
#> $`greater_than(0.125, or_equal = TRUE)`
#> <Modifier>
#> Operator: >=
#> Value: 0.125
#> 
#> $`between(0.125, 2)`
#> <Modifier>
#> Operator: BETWEEN
#> Values: 0.125, 2
#> 
#> $`contains("baz")`
#> <Modifier>
#> Operator: CONTAINS
#> Value: baz
#> 
#> $`not("zzz")`
#> <Modifier>
#> Operator: <>
#> Value: zzz
#> 
#> $`not_na()`
#> <Modifier>
#> Operator: <>
#> Value:
#> 
```
