# Query Modifiers

Helpers for use in constructing conditions in queries.

## Usage

``` r
excludes(x)

contains(x)

starts(x)

ends(x)

not(x)

not_blank()

is_blank()

greater(x, equal = FALSE)

less(x, equal = FALSE)

between(x, y)
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
#> <Modifier> chr "excludes"
#>  @ operator: chr "NOT+IN"
#>  @ value   : chr [1:3] "AL" "AK" "AZ"

ends("bar")
#> <Modifier> chr "ends"
#>  @ operator: chr "ENDS WITH"
#>  @ value   : chr "bar"

starts("foo")
#> <Modifier> chr "starts"
#>  @ operator: chr "STARTS WITH"
#>  @ value   : chr "foo"

contains("baz")
#> <Modifier> chr "contains"
#>  @ operator: chr "CONTAINS"
#>  @ value   : chr "baz"

not("zzz")
#> <Modifier> chr "not"
#>  @ operator: chr "<>"
#>  @ value   : chr "zzz"

less(1000)
#> <Modifier> chr "less"
#>  @ operator: chr "<"
#>  @ value   : num 1000

less(0.125, equal = TRUE)
#> <Modifier> chr "less"
#>  @ operator: chr "<="
#>  @ value   : num 0.125

greater(1000)
#> <Modifier> chr "greater"
#>  @ operator: chr ">"
#>  @ value   : num 1000

greater(0.125, equal = TRUE)
#> <Modifier> chr "greater"
#>  @ operator: chr ">="
#>  @ value   : num 0.125

between(0.125, 2)
#> <Modifier> chr "between"
#>  @ operator: chr "BETWEEN"
#>  @ value   : num [1:2] 0.125 2

not_blank()
#> <Modifier> chr "not_blank"
#>  @ operator: chr "<>"
#>  @ value   : chr ""

is_blank()
#> <Modifier> chr "is_blank"
#>  @ operator: chr "="
#>  @ value   : chr ""
```
