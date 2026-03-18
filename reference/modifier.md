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
params(
   state = excludes(state.abb[1:5]),
   title = ends_with("bar"),
   name = starts_with("foo"),
   n = less_than(1000),
   avg = less_than(0.125, or_equal = TRUE),
   rank = greater_than(1000),
   score = greater_than(0.125, or_equal = TRUE),
   interval = between(0.125, 2),
   category = contains("baz"),
   type = not("standard")
 )
#> $state
#> <Modifier>
#> Operator: NOT+IN
#> Values: AL, AK, AZ, AR, CA
#> 
#> $title
#> <Modifier>
#> Operator: ENDS WITH
#> Value: bar
#> 
#> $name
#> <Modifier>
#> Operator: STARTS WITH
#> Value: foo
#> 
#> $n
#> <Modifier>
#> Operator: <
#> Value: 1000
#> 
#> $avg
#> <Modifier>
#> Operator: <=
#> Value: 0.125
#> 
#> $rank
#> <Modifier>
#> Operator: >
#> Value: 1000
#> 
#> $score
#> <Modifier>
#> Operator: >=
#> Value: 0.125
#> 
#> $interval
#> <Modifier>
#> Operator: BETWEEN
#> Values: 0.125, 2
#> 
#> $category
#> <Modifier>
#> Operator: CONTAINS
#> Value: baz
#> 
#> $type
#> <Modifier>
#> Operator: <>
#> Value: standard
#> 
```
