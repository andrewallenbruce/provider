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

ends("bar")
#> <modifier[1]>
#> Error in loadNamespace(x): there is no package called ‘c’

starts("foo")
#> <modifier[1]>
#> Error in loadNamespace(x): there is no package called ‘c’

contains("baz")
#> <modifier[1]>
#> Error in loadNamespace(x): there is no package called ‘c’

not("zzz")
#> <modifier[1]>
#> Error in loadNamespace(x): there is no package called ‘c’

less(1000)
#> <modifier[1]>
#> Error in loadNamespace(x): there is no package called ‘c’

less(0.125, equal = TRUE)
#> <modifier[1]>
#> Error in loadNamespace(x): there is no package called ‘c’

greater(1000)
#> <modifier[1]>
#> Error in loadNamespace(x): there is no package called ‘c’

greater(0.125, equal = TRUE)
#> <modifier[1]>
#> Error in loadNamespace(x): there is no package called ‘c’

between(0.125, 2)
#> <modifier[2]>
#> Error in loadNamespace(x): there is no package called ‘c’

not_blank()
#> <modifier[1]>
#> Error in loadNamespace(x): there is no package called ‘c’

is_blank()
#> <modifier[1]>
#> Error in loadNamespace(x): there is no package called ‘c’
```
