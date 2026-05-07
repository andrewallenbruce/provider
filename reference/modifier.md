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
#> <provider::Modifier> chr "excludes"
#>  @ operator: chr "NOT+IN"
#>  @ value   : chr [1:3] "AL" "AK" "AZ"

ends("bar")
#> <provider::Modifier> chr "ends"
#>  @ operator: chr "ENDS WITH"
#>  @ value   : chr "bar"

starts("foo")
#> <provider::Modifier> chr "starts"
#>  @ operator: chr "STARTS WITH"
#>  @ value   : chr "foo"

contains("baz")
#> <provider::Modifier> chr "contains"
#>  @ operator: chr "CONTAINS"
#>  @ value   : chr "baz"

not("zzz")
#> <provider::Modifier> chr "not"
#>  @ operator: chr "<>"
#>  @ value   : chr "zzz"

less(1000)
#> <provider::Modifier> chr "less"
#>  @ operator: chr "<"
#>  @ value   : num 1000

less(0.125, equal = TRUE)
#> <provider::Modifier> chr "less"
#>  @ operator: chr "<="
#>  @ value   : num 0.125

greater(1000)
#> <provider::Modifier> chr "greater"
#>  @ operator: chr ">"
#>  @ value   : num 1000

greater(0.125, equal = TRUE)
#> <provider::Modifier> chr "greater"
#>  @ operator: chr ">="
#>  @ value   : num 0.125

between(0.125, 2)
#> <provider::Modifier> chr "between"
#>  @ operator: chr "BETWEEN"
#>  @ value   : num [1:2] 0.125 2

not_blank()
#> <provider::Modifier> chr "not"
#>  @ operator: chr "<>"
#>  @ value   : chr ""

is_blank()
#> <provider::Modifier> chr "equals"
#>  @ operator: chr "="
#>  @ value   : chr ""
```
